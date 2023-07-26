SuperStrict

Import Pub.Win32

Import Srs.Dxgi
Import "d3dcommon_brl.bmx"
Import "d3d11.bmx"

Extern"win32"

Type ID3D11DeviceChild Extends IUnknown
	Method GetDevice(Device:ID3D11Device Ptr)
	Method GetPrivateData:Int(Guid:Byte Ptr, pDataSize:Int Ptr, pData:Byte Ptr)
	Method SetPrivateData:Int(Guid:Byte Ptr, DataSize:Int, pData:Byte Ptr)
	Method SetPrivateDataInterface:Int(Guid:Byte Ptr, pData:IUnknown)
EndType

Type ID3D11DepthStencilState Extends ID3D11DeviceChild
	Method GetDesc(pDesc:Byte Ptr)
EndType

Type ID3D11BlendState Extends ID3D11DeviceChild
	Method GetDesc(pDesc:Byte Ptr)
EndType

Type ID3D11RasterizerState Extends ID3D11DeviceChild
	Method GetDesc(pDesc:Byte Ptr)
EndType

Type ID3D11Resource Extends ID3D11DeviceChild
	Method GetType(pResourceDimension:Int Ptr)
	Method SetEvictionPriority(EvictionPriority:Int)
	Method GetEvictionPriority:Int()
EndType

Type ID3D11Buffer Extends ID3D11Resource
	Method GetDesc(pDesc:Byte Ptr)
EndType

Type ID3D11Texture1D Extends ID3D11Resource
	Method GetDesc(pDesc:Byte Ptr)
EndType

Type ID3D11Texture2D Extends ID3D11Resource	
	Method GetDesc(pDesc:Byte Ptr)
EndType

Type ID3D11Texture3D Extends ID3D11Resource
	Method GetDesc(pDesc:Byte Ptr)
EndType

Type ID3D11View Extends ID3D11DeviceChild
	Method GetResource(ppResource:ID3D11Resource Ptr)
EndType

Type ID3D11ShaderResourceView Extends ID3D11View
	Method GetDesc(pDesc:Byte Ptr)
EndType

Type ID3D11RenderTargetView Extends ID3D11View
	Method GetDesc(pDesc:Byte Ptr)
EndType

Type ID3D11DepthStencilView Extends ID3D11View
	Method GetDesc(pDesc:Byte Ptr)
EndType

Type ID3D11UnorderedAccessView Extends ID3D11View
	Method GetDesc(pDesc:Byte Ptr)
EndType

Type ID3D11VertexShader Extends ID3D11DeviceChild
EndType

Type ID3D11HullShader Extends ID3D11DeviceChild
EndType

Type ID3D11DomainShader Extends ID3D11DeviceChild
EndType

Type ID3D11GeometryShader Extends ID3D11DeviceChild
EndType

Type ID3D11PixelShader Extends ID3D11DeviceChild
EndType

Type ID3D11ComputeShader Extends ID3D11DeviceChild
EndType

Type ID3D11InputLayout Extends ID3D11DeviceChild
EndType

Type ID3D11SamplerState Extends ID3D11DeviceChild
	Method GetDesc(pDesc:Byte Ptr)
EndType

Type ID3D11Asynchronous Extends ID3D11DeviceChild
	Method GetDataSize:Int()
EndType

Type ID3D11Query Extends ID3D11Asynchronous
	Method GetDesc(pDesc:Byte Ptr)
EndType

Type ID3D11Predicate Extends ID3D11Query
EndType

Type ID3D11Counter Extends ID3D11Asynchronous
	Method GetDesc(pDesc:Byte Ptr)
EndType

Type ID3D11ClassInstance Extends ID3D11DeviceChild
	Method GetClassLinkage(ppLinkage:ID3D11ClassLinkage Ptr)
	Method GetDesc(pDesc:Byte Ptr)
	Method GetInstanceName(pInstanceName:Byte Ptr, pBufferLength:Int Ptr)
	Method GetTypeName(pTypeName:Byte Ptr, pBufferLength:Int Ptr)
EndType

Type ID3D11ClassLinkage Extends ID3D11DeviceChild
	Method GetClassInstance:Int(pClassInstanceName:Byte Ptr, InstanceIndex:Int, ppInstance:ID3D11ClassInstance Ptr)
	Method CreateClassInstance:Int(pszClassTypeName:Byte Ptr, ConstantBufferOffset:Int, ConstantVectorOffset:Int, TextureOffset:Int, SamplerOffset:Int, ppInstsance:ID3D11ClassInstance Ptr)
EndType

Type ID3D11CommandList Extends ID3D11DeviceChild
	Method GetContextFlags:Int()
EndType

Type ID3D11DeviceContext Extends ID3D11DeviceChild
	Method VSSetConstantBuffers(StartSlot:Int, NumBuffers:Int, ppConstantBuffers:ID3D11Buffer Ptr)
	Method PSSetShaderResources(StartSlot:Int, NumViews:Int, ppShaderResourceViews:Byte Ptr)
	Method PSSetShader(pPixelShader:ID3D11PixelShader, ppClassInstances:Byte Ptr, NumClassInstances:Int)
	Method PSSetSamplers(StartSlot:Int, NumSamplers:Int, ppSamplers:Byte Ptr)
	Method VSSetShader(pVertexShader:ID3D11VertexShader, ppClassInstances:Byte Ptr, NumClassInstances:Int)
	Method DrawIndexed(IndexCount:Int, StartIndexLocation:Int, BaseVertexLocation:Int)
	Method Draw(VertexCount:Int, StartVertexLocation:Int)
	Method Map:Int(pResource:ID3D11Resource, Subresource:Int, MapType:Int, MapFlags:Int, pMappedResource:Byte Ptr)
	Method UnMap(pResource:ID3D11Resource, Subresource:Int)
	Method PSSetConstantBuffers(StartSlot:Int, NumBuffers:Int, ppConstantBuffers:ID3D11Buffer Ptr)
	Method IASetInputLayout(pInputLayout:ID3D11InputLayout)
	Method IASetVertexBuffers(StartSlot:Int, NumBuffers:Int, ppVertexBuffers:ID3D11Buffer Ptr, pStrides:Int Ptr,pOffsets:Int Ptr)
	Method IASetIndexBuffer(pIndexBuffer:ID3D11Buffer, Format:Int, Offset:Int)
	Method DrawIndexedInstanced(IndexCountPerInstance:Int, InstanceCount:Int, StartIndexLocation:Int, BaseVertexLocation:Int, StartInstanceLocation:Int)
	Method DrawInstanced(VertexCountPerInstance:Int, InstanceCount:Int, StartVertexLocation:Int, StartInstanceLocation:Int)
	Method GSSetConstantBuffers(StartSlot:Int, NumBuffers:Int, ppConstantBuffers:ID3D11Buffer Ptr)
	Method GSSetShader(pShader:ID3D11GeometryShader Ptr, ppClassInstance:ID3D11ClasSInstance Ptr,NumClassInstances:Int)
	Method IASetPrimitiveTopology(Topology:Int)
	Method VSSetShaderResources(StartSlot:Int, NumViews:Int, ppShaderResourceViews:ID3D11ShaderResourceView Ptr)
	Method VSSetSamplers(StartSlot:Int, NumSamplers:Int, ppSampelers:ID3D11SamplerState Ptr)
	Method Begin(pAsync:ID3D11Asynchronous)
	Method End_(pAsync:ID3D11Asynchronous)
	Method GetData:Int(pAsync:ID3D11Asynchronous, pData:Byte Ptr, DataSize:Int, GetDataFlags:Int)
	Method SetPredication(pPredicate:ID3D11Predicate, PredicateValue:Int)
	Method GSSetShaderResources(StartSlot:Int, NumViews:Int, ppShaderResourceViews:ID3D11ShaderResourceView Ptr)
	Method GSSetSamplers(StartSlot:Int, NumSamplers:Int, ppSamplers:ID3D11SamplerState Ptr)
	Method OMSetRenderTargets(NumViews:Int, ppRenderTargetViews:ID3D11RenderTargetView Ptr, pDepthStencilView:ID3D11DepthStencilView)
	Method OMSetRenderTargetsAndUnorderedAccessViews(NumViews:Int, ppRenderTargetViews:ID3D11RenderTargetView Ptr, pDepthStencilView:ID3D11DepthStencilView, UAVStartSlot:Int, NumUAVs:Int, ppUnorderedAccessViews:ID3D11UnorderedAccessView Ptr, UAVInitialCounts:Int Ptr)
	Method OMSetBlendState(pBlendState:ID3D11BlendState, BlendFactor:Byte Ptr, SampleMask:Int)
	Method OMSetDepthStencilState(pDepthStencilState:ID3D11DepthStencilState, StencilRef:Int)
	Method SOSetTargets(NumBuffers:Int, ppSOTargets:ID3D11Buffer Ptr, pOffsets:Int Ptr)
	Method DrawAuto()
	Method DrawIndexedInstancedIndirect(pBufferForArgs:ID3D11Buffer, AlignedByteOffsetForArgs:Int)
	Method DrawInstancedIndirect(pBufferForArgs:ID3D11Buffer, AlignedByteOffsetForArgs:Int)
	Method Dispatch(ThreadGroupCountX:Int, ThreadGroupCountY:Int, ThreadCountZ:Int)
	Method DispatchIndirect(pBufferForArgs:ID3D11Buffer, AlignedOffsetForArgs:Int)
	Method RSSetState(pRasterizerState:ID3D11RasterizerState)
	Method RSSetViewports(NumViewports:Int, pViewports:Byte Ptr)
	Method RSSetScissorRects(NumRects:Int, pRects:Byte Ptr)
	Method CopySubresourceRegion(pDstResource:ID3D11Resource, DstSubresource:Int, DstX:Int, DstY:Int, DstZ:Int, pSrcResource:ID3D11Resource, SrcSubresource:Int, pSrcBox:Byte Ptr)
	Method CopyResource(pDstResource:ID3D11Resource, pSrcResource:ID3D11Resource)
	Method UpdateSubresource(pDstResource:ID3D11Resource, DstSubresource:Int, pDstBox:Byte Ptr, pSrcData:Byte Ptr, SrcRowPitch:Int, SrcDepthPitch:Int)
	Method CopyStructureCount(pDstBuffer:ID3D11Buffer, DstAlignedByteOffset:Int, pSrcView:ID3D11UnorderedAccessView)
	Method ClearRenderTargetView(pRenderTargetView:ID3D11RenderTargetView, ColorRGBA:Byte Ptr)
	Method ClearUnorderedAccessViewUint(pUnorderedAccessView:ID3D11UnorderedAccessView, Values:Int Ptr)
	Method ClearUnorderedAccessViewFloat(pUnorderedAccessView:ID3D11UnorderedAccessView, Values:Float Ptr)
	Method ClearDepthStencilView(pDepthStencilView:ID3D11DepthStencilView, ClearFlags:Int, Depth:Float, Stencil:Int)
	Method GenerateMips(pShaderResouceView:ID3D11ShaderResourceView)
	Method SetResourceMinLOD(pResource:ID3D11Resource, MinLOD:Float)
	Method GetResourceMinLOD:Float(pResource:ID3D11Resource)
	Method ResolveSubresource(pDstResource:ID3D11Resource, DstSubresource:Int, pSrcResource:ID3D11Resource, SrcSubresource:Int, Format:Int)
	Method ExecuteCommandList(pCommandList:ID3D11CommandList, RestoreContextState:Int)
	Method HSSetShaderResources(StartSlot:Int, NumViews:Int, ppShaderResourceViews:ID3D11ShaderResourceView Ptr)
	Method HSSetShader(pShader:ID3D11HullShader, ppClassInstances:ID3D11ClassInstance Ptr,NumClassInstances:Int)
	Method HSSetSamplers(StartsSlot:Int, NumSamplers:Int, ppSamplers:ID3D11SamplerState Ptr)
	Method HSSetConstantBuffers(StartSlot:Int, NumBuffers:Int, ppConstantBuffers:ID3D11Buffer Ptr)
	Method DSSetShaderResources(StartSlot:Int, NumViews:Int, ppShaderResourceViews:ID3D11ShaderResourceView Ptr)
	Method DSSetShader(pShader:ID3D11DomainShader, ppClassInstances:ID3D11ClassInstance Ptr, NumClassInstances:Int)
	Method DSSetSamplers(StartsSlot:Int, NumSamplers:Int, ppSamplers:ID3D11SamplerState Ptr)
	Method DSSetConstantBuffers(StartSlot:Int, NumBuffers:Int, ppConstantBuffers:ID3D11Buffer Ptr)
	Method CSSetShaderResources(StartSlot:Int, NumViews:Int, ppShaderResourceViews:ID3D11ShaderResourceView Ptr)
	Method CSSetUnorderedAccessViews(StartSlot:Int, NumUAVs:Int, ppUnorderedAccessViews:ID3D11UnorderedAccessView Ptr, pUAVInitialCounts:Int Ptr)
	Method CSSetShader(pComputeShader:ID3D11ComputeShader, ppClassInstances:ID3D11ClassInstance Ptr, NumClassInstance:Int)
	Method CSSetSamplers(StartsSlot:Int, NumSamplers:Int, ppSamplers:ID3D11SamplerState Ptr)
	Method CSSetConstantBuffers(StartSlot:Int, NumBuffers:Int, ppConstantBuffers:ID3D11Buffer Ptr)
	Method VSGetConstantBuffers(StartSlot:Int, NumBuffers:Int, ppConstantBuffers:ID3D11Buffer Ptr)
	Method PSGetShaderResources(StartSlot:Int, NumBuffers:Int, ppShaderResourceViews:ID3D11ShaderResourceView Ptr)
	Method PSGetShader(ppPixelShader:ID3D11PixelShader Ptr, ppClassInstances:ID3D11ClassInstance Ptr, pNumClassInstances:Int Ptr)
	Method PSGetSamplers(StartSlot:Int, NumSamplers:Int, ppSamplers:ID3D11SamplerState Ptr)
	Method VSGetShader(ppVertexShader:ID3D11VertexShader Ptr, ppClassInstances:ID3D11ClassInstance Ptr, pNumClassInstances:Int Ptr)
	Method PSGetConstantBuffers(StartSlot:Int, NumBuffers:Int, ppConstantBuffers:ID3D11Buffer Ptr)
	Method IAGetInputLayout(ppInputLayout:ID3D11InputLayout Ptr)
	Method IAGetVertexBuffers(StartSlot:Int, NumBuffers:Int, ppVertexBuffers:ID3D11Buffer Ptr, pStrides:Int Ptr, pOffsets:Int Ptr)
	Method IAGetIndexBuffer(pIndexBuffer:ID3D11Buffer Ptr, Format:Int Ptr, Offset:Int Ptr)
	Method GSGetConstantBuffers(StartSlot:Int, NumBuffers:Int, ppConstantBufferS:ID3D11Buffer Ptr)
	Method GSGetShader(ppGeometryShader:ID3D11GeometryShader Ptr, ppClassInstances:ID3D11ClassInstance Ptr, pNumClassInsstances:Int Ptr)
	Method IAGetPrimitiveTopology(pTopology:Int Ptr)
	Method VSGetShaderResources(StartSlot:Int, NumBuffers:Int, ppShaderResourceViews:ID3D11ShaderResourceView Ptr)
	Method VSGetSamplers(StartSlot:Int, NumSamplers:Int, ppSamplers:ID3D11SamplerState Ptr)
	Method GetPredication(ppPredicate:ID3D11Predicate Ptr, pPredicateValue:Int Ptr)
	Method GSGetShaderResources(StartSlot:Int, NumBuffers:Int, ppShaderResourceViews:ID3D11ShaderResourceView Ptr)
	Method GSGetSamplers(StartSlot:Int, NumSamplers:Int, ppSamplers:ID3D11SamplerState Ptr)
	Method OMGetRenderTargets(NumViews:Int, ppRenderTargetViews:ID3D11RenderTargetView Ptr, ppDepthStencilView:ID3D11DepthStencilView Ptr)
	Method OMGetRenderTargetsAndUnorderedAccessViews(NumViews:Int, ppRenderTargetViews:ID3D11RenderTargetView Ptr, ppDepthStencilView:ID3D11DepthStencilView Ptr, UAVStartSlot:Int, NumUAVs:Int, ppUnorderedAccessViews:ID3D11UnorderedAccessView Ptr)
	Method OMGetBlendState(ppBlendState:ID3D11BlendState Ptr, BlendFactor:Int Ptr, pSampleMask:Int Ptr)
	Method OMGetDepthStencilState(ppDepthStencilState:ID3D11DepthStencilState Ptr, pStencilRef:Int Ptr)
	Method SOGetTargets(NumBuffers:Int, ppSOTargets:ID3D11Buffer Ptr)
	Method RSGetState(ppRasterizerState:ID3D11RasterizerState Ptr)
	Method RSGetViewports(pNumViewports:Int Ptr, pViewports:Byte Ptr)
	Method RSGetScissorRects(pNumRects:Int Ptr, pRects:Byte Ptr)
	Method HSGetShaderResources(StartSlot:Int, NumViews:Int, ppShaderResourceViews:ID3D11ShaderResourceView Ptr)
	Method HSGetShader(ppHullShader:ID3D11HullShader Ptr, ppClassInstances:ID3D11ClassInstance Ptr, pNumClassInstance:Int Ptr)
	Method HSGetSamplers(StartSlot:Int, NumSamplers:Int, ppSamplers:ID3D11SamplerState Ptr)
	Method HSGetConstantBuffers(StartSlot:Int, NumBuffers:Int, ppConstantBuffers:ID3D11Buffer Ptr)
	Method DSGetShaderResources(StartSlot:Int, NumBuffers:Int, ppShaderResourceViews:ID3D11ShaderResourceView Ptr)
	Method DSGetShader(ppDomainShader:ID3D11DomainShader Ptr, ppClassInstances:ID3D11ClassInstance Ptr, pNumClassInstance:Int Ptr)
	Method DSGetSamplers(StartSlot:Int, NumSamplers:Int, ppSamplers:ID3D11SamplerState Ptr)
	Method DSGetConstantBuffers(StartSlot:Int, NumBuffers:Int, ppConstantBufferS:ID3D11Buffer Ptr)
	Method CSGetShaderResources(StartSlot:Int, NumViews:Int, ppShaderResourceViews:ID3D11ShaderResourceView Ptr)
	Method CSGetUnorderedAccessViews(StartSlot:Int, NumUAVs:Int, ppUnorderedAccessViews:ID3D11UnorderedAccessView Ptr)
	Method CSGetShader(ppComputeShader:ID3D11ComputeShader Ptr, ppClassInstances:ID3D11ClassInstance Ptr, pNumClassInstances:Int Ptr)
	Method CSGetSamplers(StartSlot:Int, NumSamplers:Int, ppSamplers:ID3D11SamplerState Ptr)
	Method CSGetConstantBuffers(StartSlot:Int, NumBuffers:Int, ppConstantBuffers:ID3D11Buffer Ptr)
	Method ClearState()
	Method Flush()
	Method GetType:Int()
	Method GetContextFlags:Int()
	Method FinishCommandList(RestoreDefferedContextState:Int, ppCommandList:ID3D11CommandList Ptr)
EndType

Type ID3D11Device Extends IUnknown
	Method CreateBuffer:Int(pDesc:Byte Ptr ,pInitialData:Byte Ptr, ppBuffer:ID3D11Buffer Ptr)
	Method CreateTexture1D:Int(pDesc:Byte Ptr, pInitialData:Byte Ptr, ppTexture1D:ID3D11Texture1D Ptr)
	Method CreateTexture2D:Int(pDesc:Byte Ptr, pInitialData:Byte Ptr, ppTexture2D:ID3D11Texture2D Ptr)
	Method CreateTexture3D:Int(pDesc:Byte Ptr, pInitialData:Byte Ptr, ppTexture3D:ID3D11Texture3D Ptr)
	Method CreateShaderResourceView:Int(pResource:ID3D11Resource, pDesc:Byte Ptr, ppSRView:ID3D11ShaderResourceView Ptr)
	Method CreateUnorderedAccessView:Int(pResource:ID3D11Resource, pDesc:Byte Ptr, ppUAView:ID3D11UnorderedAccessView Ptr)
	Method CreateRenderTargetView:Int(pResource:ID3D11Resource, pDesc:Byte Ptr, ppRTView:ID3D11RenderTargetView Ptr)
	Method CreateDepthStencilView:Int(pResource:ID3D11Resource, pDesc:Byte Ptr, ppDepthStencilView:ID3D11DepthStencilView Ptr)
	Method CreateInputLayout:Int(pInputElementDescs:Byte Ptr, NumElements:Int, pShaderBytecodeWithInputSignature:Byte Ptr, BytecodeLength:Int, ppInputLayout:ID3D11InputLayout Ptr)
	Method CreateVertexShader:Int(pShaderBytecode:Byte Ptr, BytecodeLength:Int, pClassLinkage:ID3D11ClassLinkage, ppVertexShader:ID3D11VertexShader Ptr)
	Method CreateGeometryShader:Int(pShaderByteCode:Byte Ptr, ByteCodeLength:Int, pClassLinkage:ID3D11ClassLinkage, ppGeometryShader:ID3D11GeometryShader Ptr)
	Method CreateGeometryShaderWithStreamOutput:Int(pShaderByteCode:Byte Ptr, ByteCodeLength:Int, pSODeclarations:Byte Ptr, NumEntries:Int, pBufferStrides:Int Ptr, NumStrides:Int, RasterizedStream:Int, pClassLinkage:ID3D11ClassLinkage, ppGeometryShader:ID3D11GeometryShader Ptr)
	Method CreatePixelShader:Int(pShaderBytecode:Byte Ptr, BytecodeLength:Int, pClassLinkage:ID3D11ClassLinkage, ppPixelShader:ID3D11PixelShader Ptr)
	Method CreateHullShader:Int(pShaderBytecode:Byte Ptr, BytecodeLength:Int, pClassLinkage:ID3D11ClassLinkage, ppHullShader:ID3D11HullShader Ptr)
	Method CreateDomainShader:Int(pShaderBytecode:Byte Ptr, BytecodeLength:Int, pClassLinkage:ID3D11ClassLinkage, ppDomainShader:ID3D11DomainShader Ptr)
	Method CreateComputeShader:Int(pShaderBytecode:Byte Ptr, BytecodeLength:Int, pClassLinkage:ID3D11ClassLinkage, ppDomainShader:ID3D11ComputeShader Ptr)
	Method CreateClassLinkage:Int(ppLinkage:ID3D11ClassLinkage Ptr)
	Method CreateBlendState:Int(pBlendStateDesc:Byte Ptr, ppBlendState:ID3D11BlendState Ptr)
	Method CreateDepthStencilState:Int(pDepthStencilDesc:Byte Ptr, ppDepthStencilState:ID3D11DepthStencilState Ptr)
	Method CreateRasterizerState:Int(pRasterizerDesc:Byte Ptr, ppRasterizerState:ID3D11RasterizerState Ptr)
	Method CreateSamplerState:Int(pSamplerDesc:Byte Ptr, ppSamplerState:ID3D11SamplerState Ptr)
	Method CreateQuery:Int(pQueryDesc:Byte Ptr, ppQuery:ID3D11Query Ptr)
	Method CreatePredicate:Int(pPredicateDesc:Byte Ptr, ppPredicate:ID3D11Predicate Ptr)
	Method CreateCounter:Int(pCounterDesc:Byte Ptr, ppCounter:ID3D11Counter Ptr)
	Method CreateDeferredContext:Int(ContextFlags:Int, ppDeferredContext:ID3D11DeviceContext Ptr)
	Method OpenSharedResource:Int(hResource:Byte Ptr, ReturnedInterface:Byte Ptr, ppResource:Byte Ptr Ptr)
	Method CheckFormatSupport:Int(Format:Int, pFormatSupport:Int Ptr)
	Method CheckMultisampleQualityLevels:Int(Format:Int, SampleCount:Int, pNumQualityLevels:Int Ptr)
	Method CheckCounterInfo(pCounterInfo:Byte Ptr)
	Method CheckCounter:Int(pCounterDesc:Byte Ptr, pType:Int Ptr, pActiveCounters:Int Ptr, szName:Byte Ptr, pNameLength:Int Ptr, szUnits:Byte Ptr, pUnitsLength:Int, szDescription:Byte Ptr, pDescriptionLength:Int Ptr)
	Method CheckFeatureSupport:Int(Feature:Int, pFeatureSupportData:Byte Ptr, FeatureSupportDataSize:Int)
	Method GetPrivateData:Int(guid:Byte Ptr, pDataSize:Int Ptr, pData:Byte Ptr)
	Method SetPrivateData:Int(guid:Byte Ptr, DataSize:Int, pData:Byte Ptr)
	Method SetPrivateDataInterface:Int(guid:Byte Ptr, pData:IUnknown)
	Method GetFeatureLevel:Int()
	Method GetCreationFlags:Int()
	Method GetDeviceRemovedReason:Int()
	Method GetImmediateContext(ppImmediateContext:ID3D11DeviceContext Ptr)
	Method SetExceptionMode:Int(RaiseFlags:Int)
	Method GetExceptionMode:Int()
EndType
EndExtern

Global _d3d11Dll:Int = LoadLibraryA("D3D11.dll")

If Not _d3d11Dll Return

'Core
Global D3D11CreateDevice:Int(pAdapter:IDXGIAdapter, DriverType:Int, Software:Byte Ptr, Flags:Int, pFeatureLevels:Int Ptr, Featurelevels:Int, SDKVersion:Int, ppDevice:ID3D11Device Ptr,..
			pFeatureLevel:Int Ptr, ppImmediateContext:ID3D11DeviceContext Ptr)"win32" = GetProcAddress(_d3d11Dll, "D3D11CreateDevice")
Global D3D11CreateDeviceAndSwapChain:Int(pAdapter:IDXGIAdapter, DriverType:Int, Software:Byte Ptr, Flags:Int, pFeatureLevels:Int Ptr, FeatureLevels:Int, SDKVersion:Int, pSwapChainDesc:Byte Ptr,..
			pSwapChain:IDXGISwapChain Ptr, ppDevice:ID3D11Device Ptr, pFeatureLevel:Int Ptr, ppDeviceContext:ID3D11DeviceContext Ptr)"win32" = GetProcAddress(_d3d11Dll, "D3D11CreateDeviceAndSwapChain")
