
' Rewritten by Dave Camp - January 2024

SuperStrict

?Win32

Import BRL.Max2D 
Import BRL.TextStream
Import SRS.D3D11Graphics

Incbin "max2D.vs"
Incbin "max2D.ps"

' Gpu state
Global _GpuResources:TD3D11Max2DResources
Global _GpuState:TGpuState

'Max2D state
Const OneOver255# = 1.0 / 255.0

Global DEV_DEBUG:Int = False
Global _driver:TD3D11Max2DDriver
Global _max2DGraphics:TMax2DGraphics
Global _ix#,_iy#,_jx#,_jy#
Global _linewidth#
Global _width#,_height# 
Global _currblend:Int
Global _useSolidPixelShader:Int
Global _currentRenderImageFrame:TD3D11RenderImageFrame

' Incbin'ed shader source code
Global _GpuShaderSources:TGpuShaderSources = New TGpuShaderSources

Function SAFE_RELEASE(Iface:IUnknown_ Var)
	If Iface Iface.Release_
	Iface = Null
EndFunction

Function PointerToInt(Pointer:Byte Ptr, Array:Int Ptr)
?x86
	Array[0] = Int(Pointer)
?x64
	Array[0] = Long(Pointer) & $ffffffff
	Array[1] = (Long(Pointer) & $ffffffff00000000:Long) Shr 32
?
EndFunction

Type TGpuShaderSources
	Field VertexShaderSource:String = LoadText("incbin::max2D.vs")
	Field PixelShaderSource:String = LoadText("incbin::max2D.ps")
EndType

Type TD3D11Max2DResources
	Field D3D11GraphicsResource:TD3D11GraphicsGpuResources
	Field ShaderSources:TGpuShaderSources = _GpuShaderSources
	
	Field Device:ID3D11Device
	Field DeviceContext:ID3D11DeviceContext

	Field DepthStencilState:ID3D11DepthStencilState
	Field RasterizerState:ID3D11RasterizerState
	
	Field LinearSamplerState:ID3D11SamplerState
	Field PointSamplerState:ID3D11SamplerState
	Field WrapSamplerState:ID3D11SamplerState
	
	Field AlphaBlendState:ID3D11BlendState
	Field SolidBlendState:ID3D11BlendState
	Field LightBlendState:ID3D11BlendState
	Field ShadeBlendState:ID3D11BlendState
	Field MaskBlendState:ID3D11BlendState
	
	Field InputLayout:ID3D11InputLayout
	Field VertexShader:ID3D11VertexShader
	
	Field TexturePixelShader:ID3D11PixelShader
	Field ColourPixelShader:ID3D11PixelShader
	Field PixmapPixelShader:ID3D11PixelShader
	Field SolidPixelShader:ID3D11PixelShader
	Field OvalPixelShader:ID3D11PIxelShader
	
	Method Create:TD3D11Max2DResources(D3DDevice:ID3D11Device, D3DDeviceContext:ID3D11DeviceContext)
		Device = D3DDevice
		DeviceContext = D3DDeviceContext
		
		If Not CreateDepthStencilState() Return Null
		If Not CreateRasterizerState() Return Null

		If Not CreateSamplerState("linear sampler", D3D11_FILTER_MIN_MAG_MIP_LINEAR, D3D11_TEXTURE_ADDRESS_CLAMP, LinearSamplerState) Return Null
		If Not CreateSamplerState("point sampler", D3D11_FILTER_MIN_MAG_MIP_POINT, D3D11_TEXTURE_ADDRESS_CLAMP, PointSamplerState) Return Null
		If Not CreateSamplerState("wrap sampler", D3D11_FILTER_MIN_MAG_MIP_LINEAR, D3D11_TEXTURE_ADDRESS_WRAP, WrapSamplerState) Return Null

		If Not CreateBlendState("mask blend", False, D3D11_BLEND_ONE, D3D11_BLEND_ZERO, D3D11_BLEND_ONE, D3D11_BLEND_ZERO, Varptr MaskBlendState) Return Null
		If Not CreateBlendState("alpha blend", True, D3D11_BLEND_SRC_ALPHA, D3D11_BLEND_INV_SRC_ALPHA, D3D11_BLEND_SRC_ALPHA, D3D11_BLEND_INV_SRC_ALPHA, Varptr AlphaBlendState) Return Null
		If Not CreateBlendState("light blend", True, D3D11_BLEND_SRC_ALPHA, D3D11_BLEND_ONE, D3D11_BLEND_ONE, D3D11_BLEND_ZERO, Varptr LightBlendState) Return Null
		If Not CreateBlendState("shade blend", True, D3D11_BLEND_ZERO, D3D11_BLEND_SRC_COLOR, D3D11_BLEND_ONE, D3D11_BLEND_ZERO, Varptr ShadeBlendState) Return Null
		If Not CreateBlendState("solid blend", False, D3D11_BLEND_ONE, D3D11_BLEND_ZERO, D3D11_BLEND_ONE, D3D11_BLEND_ZERO, Varptr SolidBlendState) Return Null

		If Not CreateVertexShaderAndInputLayout() Return Null
		If Not CreatePixelShader("TexturePixelShader", Varptr TexturePixelShader) Return Null
		If Not CreatePixelShader("ColorPixelShader", Varptr ColourPixelShader) Return Null
		If Not CreatePixelShader("PixmapPixelShader", Varptr PixmapPixelShader) Return Null
		If Not CreatePixelShader("SolidPixelShader", Varptr SolidPixelShader) Return Null
		If Not CreatePixelShader("OvalPixelShader", Varptr OvalPixelShader) Return Null

		Return Self
	EndMethod
	
	Method CreateBuffer:Int(Buffer:ID3D11Buffer Ptr, ByteWidth:Int, Usage:Int, BindFlags:Int, CPUAccessFlags:Int, Data:Byte Ptr, Name:String)
		Local SubResourceData:D3D11_SUBRESOURCE_DATA
	
		Local Desc:D3D11_BUFFER_DESC = New D3D11_BUFFER_DESC
		Desc.ByteWidth = ByteWidth
		Desc.Usage = Usage
		Desc.BindFlags = BindFlags
		Desc.CPUAccessFlags = CPUAccessFlags
	
		Local Hr:Int
		If Data
			SubResourceData = New D3D11_SUBRESOURCE_DATA
			SubResourceData.pSysMem = Data
			
			Hr = Device.CreateBuffer(Desc, SubResourceData, Buffer)
		Else
			Hr = Device.CreateBuffer(Desc, Null, Buffer)
		EndIf
		
		If Hr < 0
			Throw("Cannot create buffer for '" + Name + "'")
			Return False
		EndIf
		
		Return True
	EndMethod
	
	Method CreateDepthStencilState:Int()
		If Not Device Return False
		If Not DeviceContext Return False
		
		Local DepthStencilDesc:D3D11_DEPTH_STENCIL_DESC = New D3D11_DEPTH_STENCIL_DESC
		DepthStencilDesc.DepthEnable = False
		DepthStencilDesc.StencilEnable = False
		
		If Device.CreateDepthStencilState(DepthStencilDesc, Varptr DepthStencilState) < 0
			Throw("Cannot create depth stencil state")
			Return False
		EndIf
		
		Return True
	EndMethod
	
	Method CreateRasterizerState:Int()
		If Not Device Return False
		If Not DeviceContext Return False
		
		Local RasterizerDesc:D3D11_RASTERIZER_DESC = New D3D11_RASTERIZER_DESC
		RasterizerDesc.Fillmode = D3D11_FILL_SOLID
		RasterizerDesc.CullMode = D3D11_CULL_NONE
		RasterizerDesc.ScissorEnable = True
		RasterizerDesc.DepthClipEnable = True
	
		If Device.CreateRasterizerState(RasterizerDesc, Varptr RasterizerState) < 0
			Throw("Cannot create rasterizer state")
			Return False
		EndIf
		
		Return True
	EndMethod
	
	Method CreateSamplerState:Int(Name:String, Filter:Int, AddressMode:Int, Sampler:ID3D11SamplerState Var)
		Local SamplerDesc:D3D11_SAMPLER_DESC = New D3D11_SAMPLER_DESC
		SamplerDesc.Filter = Filter
		SamplerDesc.AddressU = AddressMode
		SamplerDesc.AddressV = AddressMode
		SamplerDesc.AddressW = AddressMode
		SamplerDesc.MipLODBias = 0.0
		SamplerDesc.MaxAnisotropy = 1
		SamplerDesc.ComparisonFunc = D3D11_COMPARISON_GREATER_EQUAL
		SamplerDesc.BorderColor0 = 0.0
		SamplerDesc.BorderColor1 = 0.0
		SamplerDesc.BorderColor2 = 0.0
		SamplerDesc.BorderColor3 = 0.0
		SamplerDesc.MinLOD = 0.0
		SamplerDesc.MaxLOD = D3D11_FLOAT32_MAX

		If Device.CreateSamplerState(SamplerDesc, Varptr Sampler) < 0
			Throw("Cannot create '" + Name + "' state")
			Return False
		EndIf

		Return True
	EndMethod
	
	Method CreateBlendState:Int(Name:String, BlendEnable:Int, SrcBlend:Int, DestBlend:Int, SrcBlendAlpha:Int, DestBlendAlpha:Int, BlendState:ID3D11BlendState Ptr)
		Local BlendDesc:D3D11_BLEND_DESC = New D3D11_BLEND_DESC

		BlendDesc.IndependentBlendEnable = True
		BlendDesc.RenderTarget0_BlendEnable = BlendEnable
		BlendDesc.RenderTarget0_SrcBlend = SrcBlend
		BlendDesc.RenderTarget0_DestBlend = DestBlend
		BlendDesc.RenderTarget0_BlendOp = D3D11_BLEND_OP_ADD
		BlendDesc.RenderTarget0_SrcBlendAlpha = SrcBlendAlpha
		BlendDesc.RenderTarget0_DestBlendAlpha = DestBlendAlpha
		BlendDesc.RenderTarget0_BlendOpAlpha = D3D11_BLEND_OP_ADD
		BlendDesc.RenderTarget0_RenderTargetWriteMask = D3D11_COLOR_WRITE_ENABLE_ALL
		
		If Device.CreateBlendState(BlendDesc, BlendState) < 0
			Throw("Could not create '" + Name + "' blend state")
			Return False
		EndIf
		
		Return True
	EndMethod
	
	Method CreateVertexShaderAndInputLayout:Int()
		If Not Device Return False
		If Not DeviceContext Return False

		Local ByteCode:ID3DBlob = CompileShader(ShaderSources.VertexShaderSource, "StandardVertexShader", "vs_5_0")
		If Not ByteCode
			Throw("Cannot compile vertex shader")
			Return False
		EndIf
			
		If Device.CreateVertexShader(ByteCode.GetBufferPointer(), ByteCode.GetBufferSize(), Null, Varptr VertexShader) < 0
			Throw("Cannot create max2d vertex shader - compiled ok")
			ByteCode.Release_()
			Return False
		EndIf

?win32x86
		Local InputLayoutDesc:Int[] = [	0,0,DXGI_FORMAT_R32G32_FLOAT,0,D3D11_APPEND_ALIGNED_ELEMENT,D3D11_INPUT_PER_VERTEX_DATA,0,..
										0,0,DXGI_FORMAT_R32G32_FLOAT,0,D3D11_APPEND_ALIGNED_ELEMENT,D3D11_INPUT_PER_VERTEX_DATA,0]
?win32x64
		Local InputLayoutDesc:Int[] = [	0,0,0,DXGI_FORMAT_R32G32_FLOAT,0,D3D11_APPEND_ALIGNED_ELEMENT,D3D11_INPUT_PER_VERTEX_DATA,0,..
										0,0,0,DXGI_FORMAT_R32G32_FLOAT,0,D3D11_APPEND_ALIGNED_ELEMENT,D3D11_INPUT_PER_VERTEX_DATA,0]
?
		
		Local Position:Byte Ptr = "POSITION".ToCString()
		Local TexCoord:Byte Ptr = "TEXCOORD".TOCString()

?win32x86
		PointerToInt(Position, Varptr InputLayoutDesc[0])
		PointerToInt(TexCoord, Varptr InputLayoutDesc[7])
?win32x64
		PointerToInt(Position, Varptr InputLayoutDesc[0])
		PointerToInt(TexCoord, Varptr InputLayoutDesc[8])
?

		Local Hr:Int = Device.CreateInputLayout(InputLayoutDesc, 2, ByteCode.GetBufferPointer(), ByteCode.GetBuffersize(), Varptr InputLayout)
		MemFree(Position)
		MemFree(TexCoord)

		If Hr < 0
			Throw("Cannot create shader input layout")
			ByteCode.Release_()
			Return False
		EndIf
		
		ByteCode.Release_()
		
		Return True
	EndMethod
	
	Method CreatePixelShader:Int(EntryPoint:String, Shader:ID3D11PixelShader Ptr)
		If Not Device..
			Return False
		
		Local ByteCode:ID3DBlob = CompileShader(ShaderSources.PixelShaderSource, EntryPoint, "ps_5_0")
		If Not ByteCode
			Throw("Cannot compile pixel shader for " + EntryPoint)
			Return False
		EndIf
		
		If Device.CreatePixelShader(ByteCode.GetBufferPointer(), ByteCode.GetBufferSize(), Null, Shader) < 0
			Throw("Cannot create max2d pixel shader at " + EntryPoint + " - compiled ok")
			ByteCode.Release_()
			Return False
		EndIf
		
		ByteCode.Release_()
		Return True
	EndMethod

	Method CompileShader:ID3DBlob(Source:String, EntryPoint:String, ShaderType:String)
		Local ByteCode:ID3DBlob
		Local ErrorMsg:ID3DBlob
		
		Local flags:Int = D3D11_SHADER_OPTIMIZATION_LEVEL3
?Debug
		If DEV_DEBUG..
			flags :| D3DCOMPILE_DEBUG
?
		Local Hr:Int = D3DCompile(Source, Source.Length, Null, Null, Null, EntryPoint, ShaderType, flags, 0, ByteCode, ErrorMsg)
										
		If ErrorMsg
			WriteStdout String.fromCString(ErrorMsg.GetBufferPointer())
			ErrorMsg.Release_()
		EndIf
		
		If Hr < 0
			Throw("Cannot compile max2d pixel shader function '" + EntryPoint + "'")
			Return Null
		EndIf
		
		Return ByteCode
	EndMethod
EndType

Type TGpuState
	Const FLUSH_STATE_NOTHING:Int					= $00000000
	Const FLUSH_STATE_RENDER_TARGET_VIEW:Int		= $00000001
	Const FLUSH_STATE_SHADER_RESOURCE_VIEW:Int		= $00000002
	Const FLUSH_STATE_PIXEL_SHADER:Int				= $00000004
	Const FLUSH_STATE_VERTEX_BUFFER:Int				= $00000008
	Const FLUSH_STATE_INDEX_BUFFER:Int				= $00000010
	Const FLUSH_STATE_MATRIX_BUFFER:Int				= $00000020
	Const FLUSH_STATE_SCISSOR_RECT:Int				= $00000040
	Const FLUSH_STATE_SAMPLER:Int					= $00000080
	Const FLUSH_STATE_BLEND:Int						= $00000100
	Const FLUSH_STATE_TOPOLOGY:Int					= $00000200
	Const FLUSH_STATE_PSCOLOUR_DATA:Int				= $00000400
	Const FLUSH_STATE_PSFLAGS_DATA:Int				= $00000800
	Const FLUSH_STATE_PSBUFFERS:Int					= $00001000
	Const FLUSH_STATE_MATRIX_DATA:Int				= $00002000
	Const FLUSH_STATE_VERTEX_DATA:Int				= $10000000
	Const FLUSH_STATE_INDEX_DATA:Int				= $20000000
	Const FLUSH_STATE_DRAW:Int						= $40000000
	Const FLUSH_STATE_DRAW_INDEXED:Int				= $80000000
	Const FLUSH_STATE_START_UP:Int					= $0000FFFF
	
	Const MAX_FRAMES_IN_FLIGHT:Int = 3
	
	Field FlushState:Int = FLUSH_STATE_NOTHING
	
	Field Device:ID3D11Device
	Field DeviceContext:ID3D11DeviceContext
	
	Field Viewport:D3D11_VIEWPORT
	Field RenderTargetView:ID3D11RenderTargetView
	Field ShaderResourceView:ID3D11ShaderResourceView
	Field SamplerState:ID3D11SamplerState
	Field BlendState:ID3D11BlendState

	Field PrimitiveTopology:Int = D3D11_PRIMITIVE_TOPOLOGY_TRIANGLESTRIP
	Field VertexShader:ID3D11VertexShader
	Field PixelShader:ID3D11PixelShader
	
	Field MatrixBuffer:ID3D11Buffer
	Field MatrixBuffers:ID3D11Buffer[MAX_FRAMES_IN_FLIGHT]

	Field PSColourBuffer:ID3D11Buffer
	Field PSFlagsBuffer:ID3D11Buffer
	Field PSConstantBuffers:ID3D11Buffer[MAX_FRAMES_IN_FLIGHT * 2]
	
	Const MaximumIndiceCount:Int = 2048
	Const IndexBufferSize:Int = MaximumIndiceCount * 4		' 8Kb
	Field IndexBuffer:ID3D11Buffer
	Field IndexBuffers:ID3D11Buffer[MAX_FRAMES_IN_FLIGHT]
	Field IndexArray:Int[MaximumIndiceCount]
	Field IndexArrayIndex:Int
	Field IndexCount:Int
	
	Const MaximumVertexCount:Int = 4096
	Const VertexBufferSize:Int = MaximumVertexCount * 4		' 16Kb
	Field VertexBuffer:ID3D11Buffer
	Field VertexBuffers:ID3D11Buffer[MAX_FRAMES_IN_FLIGHT]
	Field VertexArray:Float[MaximumVertexCount]
	Field VertexArrayIndex:Int

	Field VertexStartLocation:Int
	Field VertexCount:Int
	
	Field FrameIndex:Int
	
	Field ScissorArray:Int[4]
	Field FlagsArray:Int[4]
	Field MatrixArray:Float[16]
	
	Field ColourArray:Float[] = [1.0, 1.0, 1.0, 1.0]
	Field ClsColourArray:Float[] = [0.0, 0.0, 0.0, 1.0]
	
	Method Create:TGpuState(D3DDevice:ID3D11Device, D3DDeviceContext:ID3D11DeviceContext, BackBuffer:ID3D11RenderTargetView)
		Device = D3DDevice
		DeviceContext = D3DDeviceContext

		For Local i:Int = 0 Until IndexBuffers.Length
			If Not _gpuResources.CreateBuffer(Varptr IndexBuffers[i], IndexBufferSize, D3D11_USAGE_DYNAMIC, D3D11_BIND_INDEX_BUFFER, D3D11_CPU_ACCESS_WRITE, Null, "Vertex shader index buffer[" + i + "]")..
				Return Null
		Next
	
		For Local i:Int = 0 Until VertexBuffers.Length
			If Not _gpuResources.CreateBuffer(Varptr VertexBuffers[i], VertexBufferSize, D3D11_USAGE_DYNAMIC, D3D11_BIND_VERTEX_BUFFER, D3D11_CPU_ACCESS_WRITE, Null, "Vertex shader vertex buffer[" + i + "]")..
				Return Null
		Next
		
		For Local i:Int = 0 Until PSConstantBuffers.Length
			If Not _gpuResources.CreateBuffer(Varptr PSConstantBuffers[i], 16, D3D11_USAGE_DYNAMIC, D3D11_BIND_CONSTANT_BUFFER, D3D11_CPU_ACCESS_WRITE, Null, "Pixel shader constant buffer[" + i + "]")..
				Return Null
		Next
		
		For Local i:Int = 0 Until MatrixBuffers.Length
			If Not _gpuResources.CreateBuffer(Varptr MatrixBuffers[i], 64, D3D11_USAGE_DYNAMIC, D3D11_BIND_CONSTANT_BUFFER, D3D11_CPU_ACCESS_WRITE, Null, "Matrix projection buffer")..
				Return Null
		Next
		
		' All state will be set in the first flush
		PSColourBuffer = PSConstantBuffers[0]
		PSFlagsBuffer = PSConstantBuffers[1]
		VertexBuffer = VertexBuffers[0]
		IndexBuffer = IndexBuffers[0]
		MatrixBuffer = MatrixBuffers[0]
		
		PixelShader = _gpuResources.TexturePixelShader
		
		' Set initial default state
		SetScissorRect(0, 0, GraphicsWidth(), GraphicsHeight())
		RenderTargetView = BackBuffer
		
		Viewport = New D3D11_VIEWPORT
		Viewport.TopLeftX = 0.0
		Viewport.TopLeftY = 0.0
		Viewport.MinDepth = 0.0
		Viewport.MaxDepth = 1.0
		' Viewport width and height is set in the initial Flush()
		
		' This state is static and gets updated but not set to other instances
		DeviceContext.IASetInputLayout(_gpuResources.InputLayout)
		DeviceContext.VSSetShader(_gpuResources.VertexShader, Null, 0)
		DeviceContext.RSSetState(_gpuResources.RasterizerState)
		DeviceContext.OMSetDepthStencilState(_gpuResources.DepthStencilState, 0)

		FlushState = FLUSH_STATE_START_UP

		Return Self
	EndMethod
	
	Method ClearRenderTarget()
		If FlushState & FLUSH_STATE_RENDER_TARGET_VIEW..
			FlushRenderTarget()

		DeviceContext.ClearRenderTargetView(RenderTargetView, ClsColourArray)
	EndMethod
	
	Method Draw()
		FlushState :| FLUSH_STATE_DRAW
	EndMethod
	
	Method DrawIndexed()
		FlushState :| FLUSH_STATE_DRAW_INDEXED
	EndMethod
		
	Method UpdateVertexData:Int(VertexData:Float[], VertexDataLength:Int, AllowDegenerates:Int)
		' The VertexData array does not always have every element used hence the VertexDataLength parameter

		Local CreateDegenerates:Int = False

		If VertexArrayIndex > 0 And AllowDegenerates..
			CreateDegenerates = True

		' Is there room for 2 degenerate vertices? If not then flush
		If VertexArrayIndex + VertexDataLength + 8 > MaximumVertexCount
			Flush()
			CreateDegenerates = False
		EndIf

		Local VertexStartIndex:Int = VertexArrayIndex
		Local ArrayPtr:Byte Ptr = VertexArray
		ArrayPtr :+ VertexArrayIndex * 4
		
		' Int copy proves to be faster than float copy in the general case
		Local DstPtr:Int Ptr = Int Ptr (ArrayPtr)
		Local SrcPtr:Int Ptr

		If CreateDegenerates
			SrcPtr = Int Ptr (ArrayPtr - 16)
			
			' Copy previous vertex
			DstPtr[0] = SrcPtr[0]
			DstPtr[1] = SrcPtr[1]
			DstPtr[2] = SrcPtr[2]
			DstPtr[3] = SrcPtr[3]

			SrcPtr = Int Ptr (Byte Ptr VertexData)
				
			DstPtr[4] = SrcPtr[0]
			DstPtr[5] = SrcPtr[1]
			DstPtr[6] = SrcPtr[2]
			DstPtr[7] = SrcPtr[3]
			
			ArrayPtr :+ 32
			VertexArrayIndex :+ 8
			VertexStartIndex :+ 8
			VertexCount :+ 2
		EndIf
		
		' Copy in new vertices
		SrcPtr = Int Ptr (Varptr VertexData[0])
		DstPtr = Int Ptr ArrayPtr
		
		Local VertexDataCount:Int = VertexDataLength
		While VertexDataCount
			DstPtr[0] = SrcPtr[0]
			DstPtr :+ 1
			SrcPtr :+ 1
			VertexDataCount :- 1
		Wend
		
		VertexArrayIndex :+ VertexDataLength
		VertexCount :+ (VertexDataLength / 4)
		
		FlushState :| FLUSH_STATE_VERTEX_DATA
		
		Return VertexStartIndex
	EndMethod
	
	Method UpdateIndexedData(VertexData:Float[], IndexData:Int[])
		If IndexArrayIndex + IndexData.Length * 4 + 8 > MaximumIndiceCount..
			Flush()
		
		Local VertexStartIndex:Int = UpdateVertexData(VertexData, VertexData.Length, True) / 4

		For Local i:Int = 0 Until IndexData.Length
			IndexArray[IndexArrayIndex + i] = IndexData[i] + VertexStartIndex
		Next
		
		IndexArrayIndex :+ IndexData.Length
		IndexCount :+ IndexData.Length
		
		FlushState :| FLUSH_STATE_INDEX_DATA
	EndMethod

	Method DisableAlphaTest()
		If FlagsArray[0] = 0..
			Return

		FlagsArray[0] = 0
		FlushState :| FLUSH_STATE_PSFLAGS_DATA
	EndMethod
	
	Method EnableAlphaTest()
		If FlagsArray[0] = 1..
			Return

		FlagsArray[0] = 1
		FlushState :| FLUSH_STATE_PSFLAGS_DATA
	EndMethod
	
	Method Flush()
		If FlushState = FLUSH_STATE_NOTHING..
			Return

		If FlushState & FLUSH_STATE_TOPOLOGY..
			DeviceContext.IASetPrimitiveTopology(PrimitiveTopology)
	
		If FlushState & FLUSH_STATE_VERTEX_BUFFER
			Local Strides:Int = 16, Offsets:Int = 0
			DeviceContext.IASetVertexBuffers(0, 1, Varptr VertexBuffer, Varptr Strides, Varptr Offsets)
		EndIf
		
		If FlushState & FLUSH_STATE_INDEX_BUFFER..
			DeviceContext.IASetIndexBuffer(IndexBuffer, DXGI_FORMAT_R32_UINT, 0)
		
		If FlushState & FLUSH_STATE_MATRIX_BUFFER..
			DeviceContext.VSSetConstantBuffers(0, 1, Varptr MatrixBuffer)

		If FlushState & FLUSH_STATE_PIXEL_SHADER..
			DeviceContext.PSSetShader(PixelShader, Null, 0)
		
		If FlushState & FLUSH_STATE_SHADER_RESOURCE_VIEW..
			DeviceContext.PSSetShaderResources(0, 1, Varptr ShaderResourceView)
		
		If FlushState & FLUSH_STATE_SAMPLER..
			DeviceContext.PSSetSamplers(0, 1, Varptr SamplerState)
		
		If FlushState & FLUSH_STATE_PSBUFFERS..
			DeviceContext.PSSetConstantBuffers(0, 2, Varptr PSConstantBuffers[FrameIndex * 2])
		
		If FlushState & FLUSH_STATE_SCISSOR_RECT..
			DeviceContext.RSSetScissorRects(1, ScissorArray)
				
		If FlushState & FLUSH_STATE_BLEND..
			DeviceContext.OMSetBlendState(BlendState, Null, $ffffffff)
		
		If FlushState & FLUSH_STATE_RENDER_TARGET_VIEW..
			FlushRenderTarget()
	
		If FlushState & FLUSH_STATE_PSCOLOUR_DATA..
			MapBuffer(PSColourBuffer, 0, D3D11_MAP_WRITE_DISCARD, 0, ColourArray, SizeOf(ColourArray))
		
		If FlushState & FLUSH_STATE_PSFLAGS_DATA..
			MapBuffer(PSFlagsBuffer, 0, D3D11_MAP_WRITE_DISCARD, 0, FlagsArray, SizeOf(FlagsArray))
		
		If FlushState & FLUSH_STATE_MATRIX_DATA..
			MapBuffer(MatrixBuffer, 0, D3D11_MAP_WRITE_DISCARD, 0, MatrixArray, SizeOf(MatrixArray))

		If FlushState & FLUSH_STATE_VERTEX_DATA
			Local MapType:Int = D3D11_MAP_WRITE_DISCARD
			Local Map:D3D11_MAPPED_SUBRESOURCE = New D3D11_MAPPED_SUBRESOURCE
			If DeviceContext.Map(VertexBuffer, 0, MapType, 0, Map) = 0
				Local VertexPtr:Byte Ptr = VertexArray
				
				MemCopy(Map.pData, VertexPtr, Size_T(VertexArrayIndex * 4))
				DeviceContext.Unmap(VertexBuffer, 0)
			EndIf
		EndIf
		
		If FlushState & FLUSH_STATE_INDEX_DATA
			Local MapType:Int = D3D11_MAP_WRITE_DISCARD
			Local Map:D3D11_MAPPED_SUBRESOURCE = New D3D11_MAPPED_SUBRESOURCE
			If DeviceContext.Map(IndexBuffer, 0, MapType, 0, Map) = 0
				Local IndexPtr:Byte Ptr = IndexArray
				
				MemCopy(Map.pData, IndexPtr, Size_T(IndexCount * 4))
				DeviceContext.Unmap(IndexBuffer, 0)
			EndIf
		EndIf

		If FlushState & FLUSH_STATE_DRAW
			DeviceContext.Draw(VertexCount, VertexStartLocation)
			
			VertexArrayIndex = 0
			VertexCount = 0
		EndIf
			
		If FlushState & FLUSH_STATE_DRAW_INDEXED
			DeviceContext.DrawIndexed(IndexCount, 0, VertexStartLocation)

			VertexArrayIndex = 0
			VertexCount = 0

			IndexArrayIndex = 0
			IndexCount = 0
		EndIf

		FlushState = FLUSH_STATE_NOTHING
	EndMethod
	
	Method FlushRenderTarget()
		If FlushState & FLUSH_STATE_RENDER_TARGET_VIEW
			Local Resource:ID3D11Resource
			Local Texture:ID3D11Texture2D

			RenderTargetView.GetResource(Varptr Resource)
			If Resource
				Resource.QueryInterface(IID_ID3D11Texture2D, Texture)
				
				If Texture
					Global Desc:D3D11_TEXTURE2D_DESC = New D3D11_TEXTURE2D_DESC
					Texture.GetDesc(Desc)
				
					Viewport.width = Desc.width
					Viewport.height = Desc.height

					DeviceContext.RSSetViewports(1, Viewport)
					Texture.Release_()
				EndIf
				
				Resource.Release_()
			EndIf
			
			DeviceContext.OMSetRenderTargets(1, Varptr RenderTargetView, Null)
		EndIf
	EndMethod
	
	Method EndFrame()
		' set the vertex buffer and constant buffers for the next frame
		FrameIndex :+ 1
		FrameIndex :Mod MAX_FRAMES_IN_FLIGHT

		VertexBuffer = _GpuState.VertexBuffers[FrameIndex]
		IndexBuffer = _GpuState.IndexBuffers[FrameIndex]
		FlushState :| FLUSH_STATE_VERTEX_BUFFER
		FlushState :| FLUSH_STATE_INDEX_BUFFER
		
		MatrixBuffer = _GpuState.MatrixBuffers[FrameIndex]
		FlushState :| FLUSH_STATE_MATRIX_BUFFER
		FlushState :| FLUSH_STATE_MATRIX_DATA
		
		PSColourBuffer = _GpuState.PSConstantBuffers[FrameIndex * 2]
		PSFlagsBuffer = _GpuState.PSConstantBuffers[FrameIndex * 2 + 1]
		FlushState :| FLUSH_STATE_PSCOLOUR_DATA
		FlushState :| FLUSH_STATE_PSFLAGS_DATA
		FlushState :| FLUSH_STATE_PSBUFFERS
	EndMethod
	
	Method SetRenderTargetView(RenderTarget:ID3D11RenderTargetView, ShaderResource:ID3D11ShaderResourceView)
		If RenderTargetView = RenderTarget..
			Return

		Flush()

		FlushState :| FLUSH_STATE_RENDER_TARGET_VIEW
		RenderTargetView = RenderTarget

		If ShaderResource And ShaderResource = ShaderResourceView
			ShaderResourceView = Null
			FlushState :| FLUSH_STATE_SHADER_RESOURCE_VIEW
		EndIf
	EndMethod

	Method SetTexture(RenderTarget:ID3D11RenderTargetView, ShaderResource:ID3D11ShaderResourceView)
		Local CreateDegenerates:Int = False
		Local ShouldFlush:Int = False

		If RenderTarget = RenderTargetView
			RenderTargetView = Null
			FlushState :| FLUSH_STATE_RENDER_TARGET_VIEW
			ShouldFlush = True
		EndIf

		If ShaderResourceView <> ShaderResource..
			ShouldFlush = True
			
		If ShouldFlush..
			Flush()
			
		ShaderResourceView = ShaderResource
		FlushState :| FLUSH_STATE_SHADER_RESOURCE_VIEW
	EndMethod
	
	Method SetPrimitiveTopology(Topology:Int)
		If PrimitiveTopology = Topology..
			Return
		
		Flush()
		
		PrimitiveTopology = Topology
		FlushState :| FLUSH_STATE_TOPOLOGY
	EndMethod
 
	Method SetPixelShader(Shader:ID3D11PixelShader)
		If PixelShader = Shader..
			Return
			
		Flush()
			
		PixelShader = Shader
		FlushState :| FLUSH_STATE_PIXEL_SHADER
	EndMethod
	
	Method SetSamplerState(Sampler:ID3D11SamplerState)
		If SamplerState = Sampler..
			Return

		Flush()

		SamplerState = Sampler
		FlushState :| FLUSH_STATE_SAMPLER
	EndMethod
	
	Method SetBlendState(Blend:ID3D11BlendState)
		If BlendState = Blend..
			Return
		
		Flush()
		
		BlendState = Blend
		FlushState :| FLUSH_STATE_BLEND
	EndMethod
	
	Method SetScissorRect(x:Int, y:Int, width:Int, height:Int)
		If ScissorArray[0] = x And ScissorArray[1] = y And ScissorArray[2] = x + width And ScissorArray[3] = y + height..
			Return
		
		Flush()
		
		ScissorArray[0] = x; ScissorArray[1] = y
		ScissorArray[2] = x + width; ScissorArray[3] = y + height
		
		FlushState :| FLUSH_STATE_SCISSOR_RECT
	EndMethod
	
	Method SetClsColour(Red:Float, Green:Float, Blue:Float, Alpha:Float)
		If Red = ClsColourArray[0] And Green = ClsColourArray[1] And Blue = ClsColourArray[2] And Alpha = ClsColourArray[3]..
			Return
		
		ClsColourArray[0] = Red
		ClsColourArray[1] = Green
		ClsColourArray[2] = Blue
		ClsColourArray[3] = Alpha
	EndMethod
	
	Method SetColour(Red:Float, Green:Float, Blue:Float)
		If Red = ColourArray[0] And Green = ColourArray[1] And Blue = ColourArray[2]..
			Return
			
		Flush()
		
		ColourArray[0] = Red
		ColourArray[1] = Green
		ColourArray[2] = Blue
		
		FlushState :| FLUSH_STATE_PSCOLOUR_DATA
	EndMethod
	
	Method SetAlpha(Alpha:Float)
		If Alpha = ColourArray[3]..
			Return

		Flush()

		Alpha = Max(Min(Alpha, 1), 0)
		ColourArray[3] = Alpha
		
		FlushState :| FLUSH_STATE_PSCOLOUR_DATA
	EndMethod
	
	Method SetMatrixBuffer(Projection:Float[])
		Flush()
		
		For Local i:Int = 0 Until 16
			MatrixArray[i] = Projection[i]
		Next

		FlushState :| FLUSH_STATE_MATRIX_DATA
	EndMethod
	
	Method MapBuffer:Int(Buffer:ID3D11Buffer Var, SubresourceIndex:Int, MapType:Int, MapFlags:Int, Data:Byte Ptr, Size:Size_T, Name$="")
		If Not Buffer..
			Return False

		Local Map:D3D11_MAPPED_SUBRESOURCE = New D3D11_MAPPED_SUBRESOURCE
	
		If DeviceContext.Map(Buffer, SubresourceIndex, MapType, MapFlags, Map) < 0
			Throw("Cannot map buffer '" + Name + "'")
			Return False
		Else
			MemCopy(Map.pData, Data, Size)
			DeviceContext.UnMap(Buffer, SubresourceIndex)
		EndIf

		Return True
	EndMethod
EndType

Public

Type TD3D11RenderImageFrame Extends TD3D11ImageFrame
	Field _width:Float
	Field _height:Float
	
	Method Create:TD3D11RenderImageFrame(width:UInt, height:UInt, flags:Int)
		If flags & FILTEREDIMAGE
			_sampler = _gpuResources.LinearSamplerState
		Else
			_sampler = _gpuResources.PointSamplerState
		EndIf
		
		Local TextureDesc:D3D11_TEXTURE2D_DESC = New D3D11_TEXTURE2D_DESC
		TextureDesc.width = width
		TextureDesc.height = height
		TextureDesc.MipLevels = 1
		TextureDesc.ArraySize = 1
		TextureDesc.format = DXGI_FORMAT_R8G8B8A8_UNORM
		TextureDesc.SampleDesc_Count = 1
		TextureDesc.SampleDesc_Quality = 0
		TextureDesc.Usage = D3D11_USAGE_DEFAULT
		TextureDesc.BindFlags = D3D11_BIND_SHADER_RESOURCE | D3D11_BIND_RENDER_TARGET
		
		If _gpuResources.Device.CreateTexture2D(TextureDesc, Null, Varptr _tex2D) < 0
			Throw "Failed to create render image texture"
			Return Null
		EndIf
		
		If _gpuResources.Device.CreateShaderResourceView(_tex2D, Null, Varptr _srv) < 0
			Throw "Failed to create a shader resource view for render image~n"
			Return Null
		EndIf
		
		If _gpuResources.Device.CreateRenderTargetView(_tex2D, Null, Varptr _rtv) < 0
			Throw "Cannot use texture as a Render Texture~n"
			Return Null
		EndIf

		_uscale = 1.0 / width
		_vscale = 1.0 / height
		_width = width
		_height = height

		Return Self
	EndMethod
	
	Method ToPixmap:TPixmap(d3ddev:ID3D11Device, d3ddevcon:ID3D11DeviceContext)
		Local TextureDesc:D3D11_TEXTURE2D_DESC = New D3D11_TEXTURE2D_DESC
		_tex2D.GetDesc(TextureDesc)
		
		Local pixmap:TPixmap = CreatePixmap(TextureDesc.width, TextureDesc.height, PF_RGBA8888)

		' create a temp resource
		TextureDesc.Usage = D3D11_USAGE_STAGING
		TextureDesc.BindFlags = 0
		TextureDesc.CPUAccessFlags = D3D11_CPU_ACCESS_READ
		TextureDesc.MiscFlags = 0

		Local StagingTexture:ID3D11Texture2D
		d3ddev.CreateTexture2D(TextureDesc, Null, StagingTexture)
		d3ddevcon.CopyResource(StagingTexture, _tex2D)

		Local map:D3D11_MAPPED_SUBRESOURCE = New D3D11_MAPPED_SUBRESOURCE
		d3ddevcon.Map(StagingTexture, 0, D3D11_MAP_READ, 0, map)
		
		For Local y:Int = 0 Until pixmap.height
			Local dst:Byte Ptr = pixmap.pixels + y * pixmap.pitch
			Local src:Byte Ptr = map.pData + y * map.RowPitch
			MemCopy(dst, src, Size_T(pixmap.pitch))
		Next
		
		d3ddevcon.UnMap(StagingTexture, 0)
		StagingTexture.Release_()
		
		Return pixmap
	EndMethod
EndType

Type TD3D11ImageFrame Extends TImageFrame 
	Field _tex2D:ID3D11Texture2D
	Field _srv:ID3D11ShaderResourceView
	Field _rtv:ID3D11RenderTargetView
	Field _sampler:ID3D11SamplerState
	Field _uscale:Float, _vscale:Float
	Field _seq:Int
	Field _vertices:Float[16]
		
	Method Create:TImageFrame(pixmap:TPixmap, flags:Int)
		Local width#=pixmap.width
		Local height#=pixmap.height
		Local mipmapped:Int = (flags&MIPMAPPEDIMAGE=MIPMAPPEDIMAGE)
		Local mipindex:Int

		' x86 PtrIntCount = 1, x64 PtrIntCount = 2
		Local PtrIntCount:Int = SizeOf(pixmap.pixels) / 4
		Local resData:Int[2 + PtrIntCount]

		If pixmap.format<>PF_RGBA8888
			pixmap = pixmap.Convert( PF_RGBA8888 )
		EndIf
 
		Local mips:TList = New TList
		While pixmap.width > 0 And pixmap.height > 0
			PointerToInt(pixmap.pixels, Varptr resData[mipIndex])
			resData[mipindex + PtrIntCount] = pixmap.pitch
			resData[mipindex + PtrIntCount + 1] = pixmap.capacity
			
			If Not mipmapped Exit
			
			If pixmap.width>1 And pixmap.height>1
				pixmap=ResizePixmap(pixmap,pixmap.width/2,pixmap.height/2)
			Else
				If pixmap.width>1 And pixmap.height = 1
					pixmap=ResizePixmap(pixmap,pixmap.width/2,pixmap.height)
				Else
					pixmap=ResizePixmap(pixmap,pixmap.width,pixmap.height/2)
				EndIf
			EndIf
			resData = resData[..resData.Length+3]
			mipindex :+ 3
			mips.addlast(pixmap)
		Wend
		
		_uscale=1.0 / width
		_vscale=1.0 / height

		'create texture
		Local desc:D3D11_TEXTURE2D_DESC = New D3D11_TEXTURE2D_DESC
		desc.width = width
		desc.height = height
		desc.ArraySize = 1
		desc.format = DXGI_FORMAT_R8G8B8A8_UNORM
		desc.SampleDesc_Count = 1
		desc.SampleDesc_Quality = 0
		desc.Usage = D3D11_USAGE_DEFAULT
		
		' For a full mip-chain MipLevels = 0, else for no mips just 1 level.
		desc.MipLevels = (flags&MIPMAPPEDIMAGE = 0)
		
		Local bind:Int = D3D11_BIND_SHADER_RESOURCE
		
		desc.BindFlags = bind
		desc.CPUAccessFlags = 0

		If _GpuResources.Device.CreateTexture2D(desc, resData, Varptr _tex2D) < 0
			Throw("Cannot create texture~n")
			Return Null
		EndIf
		
		'Setup for shader
		Local srdesc:D3D11_SHADER_RESOURCE_VIEW_DESC = New D3D11_SHADER_RESOURCE_VIEW_DESC

		srdesc.format = desc.format
		srdesc.ViewDimension = D3D11_SRV_DIMENSION_TEXTURE2D
		srdesc.Texture_MostDetailedMip = 0
		srdesc.Texture_MipLevels = -1 * (mipmapped + (flags & MIPMAPPEDIMAGE = 0))

		If _GpuResources.Device.CreateShaderResourceView(_tex2D, srdesc, Varptr _srv) < 0
			Throw("Cannot create ShaderResourceView for TImage texture")
			Return Null
		EndIf
	
		_seq=GraphicsSeq
		
		If flags & FILTEREDIMAGE
			_sampler = _gpuResources.LinearSamplerState
		Else
			_sampler = _gpuResources.PointSamplerState
		EndIf

		Return Self
	EndMethod
	
	Method Destroy()
		SAFE_RELEASE(_tex2D)
		SAFE_RELEASE(_srv)
		SAFE_RELEASE(_rtv)
	EndMethod

	Method Draw(x0:Float, y0:Float, x1:Float, y1:Float, tx:Float, ty:Float, sx:Float, sy:Float, sw:Float, sh:Float)
		_driver.AdjustScreenRotationScale(tx, ty)

		Local u0:Float = sx * _uscale
		Local v0:Float = sy * _vscale
		Local u1:Float = (sx + sw) * _uscale
		Local v1:Float = (sy + sh) * _vscale

		_vertices[0] = x0 * _ix + y0 * _iy + tx
		_vertices[1] = x0 * _jx + y0 * _jy + ty
		_vertices[2] = u0
		_vertices[3] = v0

		_vertices[4] = x1 * _ix + y0 * _iy + tx
		_vertices[5] = x1 * _jx + y0 * _jy + ty
		_vertices[6] = u1
		_vertices[7] = v0

		_vertices[8] = x0 * _ix + y1 * _iy + tx
		_vertices[9] = x0 * _jx + y1 * _jy + ty
		_vertices[10] = u0
		_vertices[11] = v1
		
		_vertices[12] = x1 * _ix + y1 * _iy + tx
		_vertices[13] = x1 * _jx + y1 * _jy + ty
		_vertices[14] = u1
		_vertices[15] = v1

		Local PixelShader:ID3D11PixelShader = _gpuResources.TexturePixelShader
		If _useSolidPixelShader..
			PixelShader = _gpuResources.SolidPixelShader

		_GpuState.SetPixelShader(PixelShader)
		_GpuState.SetSamplerState(_sampler)
		_GpuState.SetPrimitiveTopology(D3D11_PRIMITIVE_TOPOLOGY_TRIANGLESTRIP)
		_GpuState.SetTexture(_rtv, _srv)
		_GpuState.UpdateVertexData(_vertices, 16, True)
		_GpuState.Draw()
		
		_driver.ResetScreenRotationScale()
	EndMethod
	
	Method UpdateFromPixmap(Pixmap:TPixmap)
		If Not _tex2D
			Throw("Trying to update an invalid texture.")
			Return
		EndIf
		
		Local desc:D3D11_TEXTURE2D_DESC = New D3D11_TEXTURE2D_DESC
		If _tex2D.GetDesc(desc) < 0
			Throw("Could not get texture description.")
			Return
		EndIf

		If pixmap.format <> PF_RGBA8888..
			pixmap = pixmap.Convert(PF_RGBA8888)

		Local box:Int[6]
		Local mipLevel:Int = 0
		While pixmap.width > 0 And pixmap.height > 0
			box[0] = 0; box[1] = 0; box[2] = 0
			box[3] = pixmap.width; box[4] = pixmap.height; box[5] = 1
			
			_GpuResources.DeviceContext.UpdateSubResource(_tex2d, mipLevel, Box, pixmap.pixels, pixmap.pitch, pixmap.capacity)
			
			If desc.mipLevels < 2..
				Exit
			
			If pixmap.width > 1 And pixmap.height > 1
				pixmap = ResizePixmap(pixmap,pixmap.width / 2, pixmap.height / 2)
			Else
				If pixmap.width > 1 And pixmap.height = 1
					pixmap = ResizePixmap(pixmap, pixmap.width / 2, pixmap.height)
				Else
					pixmap = ResizePixmap(pixmap, pixmap.width, pixmap.height / 2)
				EndIf
			EndIf
			
			mipLevel :+ 1
		Wend
	EndMethod
EndType

Function D3D11UpdateImageFromPixmap:TImage(Image:TImage, Pixmap:TPixmap)
	If Image.width <> Pixmap.width And Image.height <> Pixmap.height
		Throw "Image and Pixmap are different sizes."
		Return Null
	EndIf
	
	Local ImageFrame:TD3D11ImageFrame = TD3D11ImageFrame(Image.frames[0])
	If Not ImageFrame
		Image.frames[0] = image.Frame(0)
	Else
		ImageFrame.UpdateFromPixmap(Pixmap)
	EndIf
	
	Return Image
EndFunction

Type TD3D11Max2DDriver Extends TMax2DDriver
	'Screen rotation
	Field tform_scr_rot#, tform_scr_zoom#
	Field tform_scr_ix#,tform_scr_iy#,tform_scr_jx#,tform_scr_jy#
	Field stored_scr_rot#,stored_scale_x#,stored_scale_y#
	Field focus_x#,focus_y#
	Field backbuffer:TD3D11RenderImageFrame
	
	Method AdjustScreenRotationScale(tx:Float Var, ty:Float Var)
		stored_scr_rot = _max2DGraphics.tform_rot
		stored_scale_x = _max2DGraphics.tform_scale_x
		stored_scale_y = _max2DGraphics.tform_scale_y
	
		SetRotation stored_scr_rot-_driver.tform_scr_rot
		SetScale stored_scale_x*tform_scr_zoom,stored_scale_y*tform_scr_zoom
	
		TransformPoint tx,ty
		tx :+ focus_x
		ty :+ focus_y
	EndMethod

	Method ResetScreenRotationScale()
		SetRotation stored_scr_rot
		SetScale stored_scale_x,stored_scale_y
	EndMethod
	
	Method SetScreenRotation( rot# )
		tform_scr_rot=rot
		UpdateTransform
	End Method

	Method SetZoom( zoom# )
		tform_scr_zoom=zoom
		UpdateTransform
	End Method
	
	Method SetFocus( x#, y# )
		focus_x=x
		focus_y=y
	End Method

	Method UpdateTransform()
		Local s#=Sin(-tform_scr_rot)
		Local c#=Cos(-tform_scr_rot)
		tform_scr_ix= c*tform_scr_zoom
		tform_scr_iy=-s*tform_scr_zoom
		tform_scr_jx= s*tform_scr_zoom
		tform_scr_jy= c*tform_scr_zoom
	End Method
	
	Method TransformPoint( x# Var, y# Var )
		Local tmp_x#=x
		x=x*tform_scr_ix+y*tform_scr_iy
		y=tmp_x*tform_scr_jx+y*tform_scr_jy
	End Method
	'End of Screen rotation
	
	Method ToString$()
		Local Feature$
		Local FeatureLevel:Int
		
		'If _d3d11dev FeatureLevel = _d3d11dev.GetFeatureLevel()
		FeatureLevel = _Graphics.GetFeatureLevel()
	
		Select FeatureLevel
			Case D3D_FEATURE_LEVEL_11_0
				Feature = "Using DirectX 11.0"
			Case D3D_FEATURE_LEVEL_11_1
				Feature = "Using DirectX 11.1"
				
			Case 0
				Feature = " Graphics Not Initialised"
		EndSelect
		
		Return "DirectX11 - "+Feature
	EndMethod
	
	'TMaxGraphicsDriver
	Method GraphicsModes:TGraphicsMode[]()
		Return D3D11GraphicsDriver().GraphicsModes()
	EndMethod
	
	Method GraphicsAdapters:TGraphicsAdapter[]()
		Return D3D11GraphicsDriver().GraphicsAdapters()
	EndMethod
	
	Method AttachGraphics:TGraphics(hwnd:Byte Ptr, flags:Long)
		Local g:TD3D11Graphics = D3D11GraphicsDriver().AttachGraphics( hwnd,flags )
		If g Return TMax2DGraphics.Create( g ,Self )
	EndMethod
	
	Method CreateGraphics:TGraphics(width:Int, height:Int, depth:Int, hertz:Int, flags:Long, x:Int, y:Int )
		Local g:TD3D11Graphics = D3D11GraphicsDriver().CreateGraphics(width,height,depth,hertz,flags,x ,y)
		If Not g Return Null
		Return TMax2DGraphics.Create(g,Self)
	EndMethod
	
	Method SetGraphics(g:TGraphics)
		If Not g
			TMax2DGraphics.ClearCurrent()
			D3D11GraphicsDriver().SetGraphics(Null)
	
			Return
		EndIf

		_max2DGraphics = TMax2DGraphics(g)
		Assert _max2DGraphics
		
		Local D3D11Graphics:TD3D11Graphics = TD3D11Graphics(_max2DGraphics._backendgraphics)
		Assert D3D11Graphics

		D3D11GraphicsDriver().SetGraphics(D3D11Graphics)
		Local Device:ID3D11Device = D3D11Graphics.GetDirect3DDevice()
		Local DeviceContext:ID3D11DeviceContext = D3D11Graphics.GetDirect3DDeviceContext()
		_GpuResources = New TD3D11Max2DResources.Create(Device, DeviceContext)
		Assert _GpuResources

		_GpuState = New TGpuState.Create(Device, DeviceContext, D3D11Graphics.GetBackBufferRenderTargetView())
		Assert _GpuState

		backbuffer = New TD3D11RenderImageFrame
		backbuffer._rtv = D3D11Graphics.GetBackBufferRenderTargetView()
		backbuffer._sampler = _gpuResources.LinearSamplerState
		backbuffer._width = GraphicsWidth()
		backbuffer._height = GraphicsHeight()

		_max2DGraphics.MakeCurrent()
		_driver = TD3D11Max2DDriver(_max2DDriver)
		
		_width = GraphicsWidth()
		_height = GraphicsHeight()
	EndMethod
	
	Method Flip:Int(sync:Int) Override
		_gpuState.Flush()
		_gpuState.EndFrame()

		D3D11GraphicsDriver().Flip( sync )
	EndMethod

	'TMax2DDriver
	Method CreateFrameFromPixmap:TImageFrame(pixmap:TPixmap, flags:Int)
		Return New TD3D11ImageFrame.Create(pixmap,flags)
	EndMethod
		
	Method SetBlend(blend:Int)
		If _currblend = blend Return

		Select blend
			Case SOLIDBLEND
				_gpuState.SetBlendState(_gpuResources.SolidBlendState)
				_gpuState.DisableAlphaTest()

			Case ALPHABLEND
				_gpuState.SetBlendState(_gpuResources.AlphaBlendState)
				_gpuState.DisableAlphaTest()
				
			Case SHADEBLEND
				_gpuState.SetBlendState(_gpuResources.ShadeBlendState)
				_gpuState.DisableAlphaTest()
				
			Case LIGHTBLEND
				_gpuState.SetBlendState(_gpuResources.LightBlendState)
				_gpuState.DisableAlphaTest()
				
			Case MASKBLEND
				_gpuState.SetBlendState(_gpuResources.MaskBlendState)
				_gpuState.EnableAlphaTest()

			EndSelect		

		_currblend = blend
	EndMethod
	
	Method SetAlpha(Alpha:Float)
		_gpuState.SetAlpha(Alpha)	 
	EndMethod

	Method SetColor(Red:Int, Green:Int, Blue:Int) Override
		Red = Max(Min(Red, 255), 0)
		Green = Max(Min(Green, 255), 0)
		Blue = Max(Min(Blue, 255), 0)

		_gpuState.SetColour(OneOver255 * Red, OneOver255 * Green, OneOver255 * Blue)
	EndMethod

	Method SetClsColor(Red:Int, Green:Int, Blue:Int, Alpha:Float) Override
		Red = Max(Min(Red, 255), 0)
		Green = Max(Min(Green, 255), 0)
		Blue = Max(Min(Blue, 255), 0)
		Alpha = Max(Min(Alpha * 255, 255), 0)

		_gpuState.SetClsColour(OneOver255 * Red, OneOver255 * Green, OneOver255 * Blue, OneOver255 * Alpha)
	EndMethod

	Method SetViewport(x:Int, y:Int, width:Int, height:Int)
		_gpuState.SetScissorRect(x, y, width, height)
	EndMethod

	Method SetTransform( xx#,xy#,yx#,yy# )
		_ix = xx
		_iy = xy
		_jx = yx
		_jy = yy
	EndMethod

	Method SetLineWidth( width# )
		_linewidth=width
	EndMethod

	Method Cls()
		_gpuState.ClearRenderTarget()
	EndMethod

	Method Plot(x:Float, y:Float)
		Global Vertices:Float[4]
		TransformPoint x,y
		x :+ focus_x
		y :+ focus_y

		Vertices[0] = x + 0.5
		Vertices[1] = y + 0.5

		_GpuState.SetPixelShader(_GpuResources.ColourPixelShader)
		_GpuState.SetPrimitiveTopology(D3D11_PRIMITIVE_TOPOLOGY_POINTLIST)
		_GpuState.UpdateVertexData(Vertices, 4, False)
		_GpuState.Draw()
	EndMethod

	Method DrawLine(x0:Float, y0:Float, x1:Float, y1:Float, tx:Float, ty:Float)
		Global Vertices:Float[16]

		TransformPoint x0, y0
		TransformPoint x1, y1
		TransformPoint tx, ty
		tx :+ focus_x
		ty :+ focus_y
		
		Local LineStartX:Float = x0 * _ix + y0 * _iy + tx
		Local LineStartY:Float = x0 * _jx + y0 * _jy + ty
		Local LineEndX:Float = x1 * _ix + y1 * _iy + tx
		Local LineEndY:Float = x1 * _jx + y1 * _jy + ty
		
		If _lineWidth <= 1
			Vertices[0] = LineStartX + 0.5
			Vertices[1] = LineStartY + 0.5
			Vertices[4] = LineEndX + 0.5
			Vertices[5] = LineEndY + 0.5

			_GpuState.SetPixelShader(_gpuResources.ColourPixelShader)
			_GpuState.SetPrimitiveTopology(D3D11_PRIMITIVE_TOPOLOGY_LINELIST)
			_GpuState.UpdateVertexData(Vertices, 8, False)
			_GpuState.Draw()
			Return
		EndIf

		Local LineWidth:Float = _lineWidth
		If Abs(LineEndY - LineStartY) > Abs(LineEndX - LineStartX)
			Vertices[0] = LineStartX  - LineWidth
			Vertices[1] = LineStartY
			Vertices[4] = LineStartX + LineWidth
			Vertices[5] =  LineStartY
			Vertices[8] = LineEndX - LineWidth
			Vertices[9] = LineEndY
			Vertices[12] = LineEndX + LineWidth
			Vertices[13] = LineEndY
		Else
			Vertices[0] = LineStartX
			Vertices[1] = LineStartY - LineWidth
			Vertices[4] = LineStartX
			Vertices[5] = LineStartY + LineWidth
			Vertices[8] = LineEndX
			Vertices[9] = LineEndY - LineWidth
			Vertices[12] = LineEndX
			Vertices[13] = LineEndY + LineWidth
		EndIf

		_GpuState.SetPixelShader(_gpuResources.ColourPixelShader)
		_GpuState.SetPrimitiveTopology(D3D11_PRIMITIVE_TOPOLOGY_TRIANGLESTRIP)
		_GpuState.UpdateVertexData(Vertices, 16, True)
		_GpuState.Draw()
	EndMethod

	Method DrawRect( x0#,y0#,x1#,y1#,tx#,ty# )
		Global VertexData:Float[16]
		
		AdjustScreenRotationScale(tx, ty)
		
		VertexData[0] = x0 * _ix + y0 * _iy + tx
		VertexData[1] = x0 * _jx + y0 * _jy + ty
		VertexData[4] = x1 * _ix + y0 * _iy + tx
		VertexData[5] = x1 * _jx + y0 * _jy + ty
		VertexData[8] = x0 * _ix + y1 * _iy + tx
		VertexData[9] = x0 * _jx + y1 * _jy + ty
		VertexData[12] = x1*_ix + y1*_iy + tx
		VertexData[13] = x1*_jx + y1*_jy + ty
		
		_GpuState.SetPixelShader(_GpuResources.ColourPixelShader)
		_GpuState.SetPrimitiveTopology(D3D11_PRIMITIVE_TOPOLOGY_TRIANGLESTRIP)
		_GpuState.UpdateVertexData(VertexData, 16, True)
		_GpuState.Draw()
		
		ResetScreenRotationScale()
	EndMethod

	Method DrawOval(x0#,y0#,x1#,y1#,tx#,ty#)
		Global VertexData:Float[] =..
		[0.0, 0.0, 0.0, 0.0,..
		 0.0, 0.0, 1.0, 0.0,..
		 0.0, 0.0, 0.0, 1.0,..
		 0.0, 0.0, 1.0, 1.0]
		
		AdjustScreenRotationScale(tx, ty)
		
		VertexData[0] = x0 * _ix + y0 * _iy + tx
		VertexData[1] = x0 * _jx + y0 * _jy + ty
		VertexData[4] = x1 * _ix + y0 * _iy + tx
		VertexData[5] = x1 * _jx + y0 * _jy + ty
		VertexData[8] = x0 * _ix + y1 * _iy + tx
		VertexData[9] = x0 * _jx + y1 * _jy + ty
		VertexData[12] = x1*_ix + y1*_iy + tx
		VertexData[13] = x1*_jx + y1*_jy + ty
		
		_GpuState.SetPixelShader(_GpuResources.OvalPixelShader)
		_GpuState.SetPrimitiveTopology(D3D11_PRIMITIVE_TOPOLOGY_TRIANGLESTRIP)
		_GpuState.UpdateVertexData(VertexData, 16, True)
		_GpuState.Draw()
		
		ResetScreenRotationScale()
	EndMethod

	Method DrawPoly(Inverts:Float[], handlex:Float, handley:Float, tx:Float, ty:Float, indices:Int[] ) Override
		Const MaxVertexIndex:Int = 128
		Global Vertices:Float[MaxVertexIndex * 12]

		AdjustScreenRotationScale(tx, ty)

		If inverts.Length < 6 Or (inverts.Length & 1)..
			Return
			
		Local NoOfInVertices:Int = inverts.Length / 2
		Local NumPolys:Int = NoOfInVertices - 2
						
		Local v0X:Float = InVerts[0] + handleX
		Local v0y:Float = InVerts[1] + handleY

		_GpuState.SetPixelShader(_GpuResources.ColourPixelShader)
		_GpuState.SetPrimitiveTopology(D3D11_PRIMITIVE_TOPOLOGY_TRIANGLELIST)
		
		Local i:Int = 1
		Local VertexIndex:Int
		Repeat
			If VertexIndex > MaxVertexIndex
				_GpuState.UpdateVertexData(Vertices, NumPolys * 3 * 4, False)
				_GpuState.Draw()
				VertexIndex = 0
			EndIf

			Local v1x:Float = InVerts[i * 2 + 0] + handleX
			Local v1y:Float = InVerts[i * 2 + 1] + handleY
			Local v2x:Float = InVerts[i * 2 + 2] + handleX
			Local v2y:Float = InVerts[i * 2 + 3] + handleY
			
			Vertices[VertexIndex * 12 + 0] = v0x * _ix + v0y * _iy + tx
			Vertices[VertexIndex * 12 + 1] = v0x * _jx + v0y * _jy + ty
			
			Vertices[VertexIndex * 12 + 4] = v1x * _ix + v1y * _iy + tx
			Vertices[VertexIndex * 12 + 5] = v1x * _jx + v1y * _jy + ty
			
			Vertices[VertexIndex * 12 + 8] = v2x * _ix + v2y * _iy + tx
			Vertices[VertexIndex * 12 + 9] = v2x * _jx + v2y * _jy + ty

			i :+ 1
			VertexIndex :+ 1
		Until VertexIndex = NumPolys

		_GpuState.UpdateVertexData(Vertices, NumPolys * 12, False)
		_GpuState.Draw()
		
		ResetScreenRotationScale
	EndMethod

	Method DrawPixmap(pixmap:TPixmap, x0:Int, y0:Int)
		Local Texture:ID3D11Texture2D
		Local TextureDesc:D3D11_TEXTURE2D_DESC = New D3D11_TEXTURE2D_DESC
		
		If pixmap.format <> PF_RGBA8888..
			pixmap = ConvertPixmap(pixmap, PF_RGBA8888)
		
		TextureDesc.width = pixmap.width
		TextureDesc.height = pixmap.height
		TextureDesc.MipLevels = 1
		TextureDesc.ArraySize = 1
		TextureDesc.format = DXGI_FORMAT_R8G8B8A8_UNORM
		TextureDesc.SampleDesc_Count = 1
		TextureDesc.SampleDesc_Quality = 0
		TextureDesc.Usage = D3D11_USAGE_IMMUTABLE
		TextureDesc.BindFlags = D3D11_BIND_SHADER_RESOURCE
		TextureDesc.CPUAccessFlags = 0
		TextureDesc.MiscFlags = 0
		
		Local InitialData:Int[3]
		InitialData[0] = Int(pixmap.pixels)
		InitialData[1] = pixmap.pitch
		InitialData[2] = pixmap.pitch * pixmap.height
		
		If _GpuResources.Device.CreateTexture2D(TextureDesc, InitialData, Varptr Texture) < 0
			Throw("Could not create texture for DrawPixmap")
			Return
		EndIf
		
		Local ShaderResourceViewDesc:D3D11_SHADER_RESOURCE_VIEW_DESC = New D3D11_SHADER_RESOURCE_VIEW_DESC		
		ShaderResourceViewDesc.format = DXGI_FORMAT_R8G8B8A8_UNORM
		ShaderResourceViewDesc.ViewDimension = D3D11_SRV_DIMENSION_TEXTURE2D
		ShaderResourceViewDesc.Texture_MostDetailedMip = 0
		ShaderResourceViewDesc.Texture_MipLevels = 1
		
		Local ShaderResourceView:ID3D11ShaderResourceView
		If _GpuResources.Device.CreateShaderResourceView(Texture, ShaderResourceViewDesc, Varptr ShaderResourceView) < 0
			SAFE_RELEASE(Texture)
			Throw("Cannot create shader resource view for pixmap texture")
			Return
		EndIf

		Local Vertices:Float[] = [Float(x0),                Float(y0),                   0.0, 0.0,..
                                  Float(x0 + pixmap.width), Float(y0),                   1.0, 0.0,..
                                  Float(x0),                Float(y0 + pixmap.height),   0.0, 1.0,..
                                  Float(x0 + pixmap.width), Float(y0 + pixmap.height),   1.0, 1.0]

		_GpuState.SetTexture(Null, ShaderResourceView)
		_GpuState.SetPixelShader(_GpuResources.PixmapPixelShader)
		_GpuState.SetPrimitiveTopology(D3D11_PRIMITIVE_TOPOLOGY_TRIANGLESTRIP)
		_GpuState.UpdateVertexData(Vertices, 16, True)
		_GpuState.Draw()
		_GpuState.Flush()

		SAFE_RELEASE(Texture)
		SAFE_RELEASE(ShaderResourceView)
	EndMethod

	Method GrabPixmap:TPixmap(x:Int, y:Int, width:Int, height:Int)
		_GpuState.Flush()

		Local RenderTargetView:ID3D11RenderTargetView
		Local Texture:ID3D11Texture2D
		Local StagingTexture:ID3D11Texture2D
		
		'Get back buffer
		_GpuResources.DeviceContext.OMGetRenderTargets(1, Varptr RenderTargetView, Null)
		If Not RenderTargetView
			Throw("Could not get render target for GrabPixmap")
			Return Null
		EndIf

		Local Resource:ID3D11Resource
		RenderTargetView.GetResource(Varptr Resource)
		If Not Resource
			SAFE_RELEASE(RenderTargetView)
			Throw("Could not get texture resource from render target view for GrabPixmap")
			Return Null
		EndIf
		
		If Resource.QueryInterface(IID_ID3D11Texture2D, Texture) < 0
			SAFE_RELEASE(RenderTargetView)
			SAFE_RELEASE(Resource)
			Throw("Could not query for texture from resource for GrabPixmap")
			Return Null
		EndIf
		SAFE_RELEASE(Resource)
		
		Local TextureDesc:D3D11_TEXTURE2D_DESC = New D3D11_TEXTURE2D_DESC
		Texture.GetDesc(TextureDesc)
		
		' Get details of the original texure and use them to create a staging texture
		TextureDesc.Usage = D3D11_USAGE_STAGING
		TextureDesc.BindFlags = 0
		TextureDesc.CPUAccessFlags = D3D11_CPU_ACCESS_READ
		TextureDesc.MiscFlags = 0
		
		'copy backbuffer
		If _GpuResources.Device.CreateTexture2D(TextureDesc, Null, Varptr StagingTexture) < 0
			SAFE_RELEASE(RenderTargetView)
			SAFE_RELEASE(Texture)
			Throw("Could not create staging texture for GrabPixmap")
			Return Null
		EndIf
		
		_GpuResources.DeviceContext.CopyResource(StagingTexture, Texture)
		
		'now copy into pixmap
		Local Map:D3D11_MAPPED_SUBRESOURCE = New D3D11_MAPPED_SUBRESOURCE
		If _GpuResources.DeviceContext.Map(StagingTexture, 0, D3D11_MAP_READ, 0, Map) < 0
			SAFE_RELEASE(RenderTargetView)
			SAFE_RELEASE(Texture)
			SAFE_RELEASE(StagingTexture)
			Throw("Could not map staging texture for GrabPixmap")
			Return Null
		EndIf	

		Local pixmap:TPixmap = CreatePixmap(width, height, PF_RGBA8888)
		For Local h:Int = 0 Until pixmap.height
			Local Dst:Byte Ptr = pixmap.pixels + h * pixmap.pitch
			Local Src:Byte Ptr = Map.pData + (x Shl 2 + (y * Map.RowPitch)) + h * Map.RowPitch
			MemCopy(Dst, Src, Size_T(pixmap.pitch))
		Next
		
		_GpuResources.DeviceContext.UnMap(StagingTexture, 0)
		SAFE_RELEASE(Texture)
		SAFE_RELEASE(StagingTexture)
		SAFE_RELEASE(RenderTargetView)
		
		Return pixmap
	EndMethod
	
	Method SetResolution(width:Float, height:Float )
		Global Projection:Float[] =..
		[ 0.0, 0.0,       0.0,       -1.0,..
		  0.0, 0.0,       0.0,        1.0,..
		  0.0, 0.0,       0.0,        0.0,..
		  0.0, 0.0,       0.0,        1.0]

 		Projection[0] =  2.0 / width
		Projection[5] = -2.0 / height

		_gpuState.SetMatrixBuffer(Projection)
	EndMethod
	
	Method Create:TD3D11Max2DDriver()
		If Not D3D11GraphicsDriver() Return Null
			'Init screen rotation
			tform_scr_rot=0
			tform_scr_zoom=1
			UpdateTransform
		Return Self
	EndMethod
	
	' Render Image --------------------	
	Method CreateRenderImageFrame:TImageFrame(width:UInt, height:UInt, flags:Int) Override
		Local RenderImage:TD3D11RenderImageFrame = New TD3D11RenderImageFrame.Create(width, height, flags)
		Return RenderImage
	EndMethod
	
	Method SetRenderImageFrame(RenderImageFrame:TImageFrame) Override
		If RenderImageFrame = _CurrentRenderImageFrame..
			Return
	
		Local D3D11RenderImageFrame:TD3D11RenderImageFrame = TD3D11RenderImageFrame(RenderImageFrame)
		_gpuState.SetRenderTargetView(D3D11RenderImageFrame._rtv, D3D11RenderImageFrame._srv)
		_CurrentRenderImageFrame = D3D11RenderImageFrame

		SetResolution(D3D11RenderImageFrame._width, D3D11RenderImageFrame._height)
	EndMethod
	
	Method SetBackbuffer()
		_gpuState.SetRenderTargetView(BackBuffer._rtv, BackBuffer._srv)
		SetResolution(BackBuffer._width, BackBuffer._height)
	EndMethod		
EndType

Function D3D11Max2DDriver:TD3D11Max2DDriver()
	Global _done:Int
	If Not _done
		_driver = New TD3D11Max2DDriver.Create()
		If _driver..
			_done = True
	EndIf
	Return _driver
End Function

Function VerifyD3D11Max2DDriver:Int()
	If GetGraphicsDriver().ToString()[0..9] = "DirectX11" Return True
EndFunction

'----------- Extra Max2D functionality -----------
Function SetScreenRotationD3D11(rot:Float)
	If Not VerifyD3D11Max2DDriver() Return
	_driver.SetScreenRotation(rot)
End Function

Function SetScreenZoomD3D11(zoom:Float)
	If Not VerifyD3D11Max2DDriver() Return
	_driver.SetZoom zoom
End Function

Function SetScreenFocusD3D11(x:Float, y:Float)
	If Not VerifyD3D11Max2DDriver() Return
	_driver.SetFocus x,y
End Function
? 'WIN32

