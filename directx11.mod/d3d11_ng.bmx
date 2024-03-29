SuperStrict 

Import Pub.Win32

Import srs.dxgi
Import "d3dcommon_ng.bmx"
Import "d3d11.bmx"

Extern"win32"

Interface ID3D11DeviceChild Extends IUnknown_
	Method GetDevice(Device:ID3D11Device Ptr)
	Method GetPrivateData:Int(Guid:Byte Ptr, pDataSize:Int Ptr, pData:Byte Ptr)
	Method SetPrivateData:Int(Guid:Byte Ptr, DataSize:Int, pData:Byte Ptr)
	Method SetPrivateDataInterface:Int(Guid:Byte Ptr, pData:IUnknown_)
EndInterface 

Interface ID3D11DepthStencilState Extends ID3D11DeviceChild
	Method GetDesc:Int(pDesc:Byte Ptr)
EndInterface 

Interface ID3D11BlendState Extends ID3D11DeviceChild
	Method GetDesc:Int(pDesc:Byte Ptr)
EndInterface 

Interface ID3D11RasterizerState Extends ID3D11DeviceChild
	Method GetDesc:Int(pDesc:Byte Ptr)
EndInterface 

Interface ID3D11Resource Extends ID3D11DeviceChild
	Method GetType(pResourceDimension:Int Ptr)
	Method SetEvictionPriority(EvictionPriority:Int)
	Method GetEvictionPriority:Int()
EndInterface 

Interface ID3D11Buffer Extends ID3D11Resource
	Method GetDesc:Int(pDesc:Byte Ptr)
EndInterface 

Interface ID3D11Texture1D Extends ID3D11Resource
	Method GetDesc:Int(pDesc:Byte Ptr)
EndInterface 

Interface ID3D11Texture2D Extends ID3D11Resource	
	Method GetDesc:Int(pDesc:Byte Ptr)
EndInterface 

Interface ID3D11Texture3D Extends ID3D11Resource
	Method GetDesc:Int(pDesc:Byte Ptr)
EndInterface 

Interface ID3D11View Extends ID3D11DeviceChild
	Method GetResource:Int(ppResource:ID3D11Resource Ptr)
EndInterface 

Interface ID3D11ShaderResourceView Extends ID3D11View
	Method GetDesc:Int(pDesc:Byte Ptr)
EndInterface 

Interface ID3D11RenderTargetView Extends ID3D11View
	Method GetDesc:Int(pDesc:Byte Ptr)
EndInterface 

Interface ID3D11DepthStencilView Extends ID3D11View
	Method GetDesc:Int(pDesc:Byte Ptr)
EndInterface 

Interface ID3D11UnorderedAccessView Extends ID3D11View
	Method GetDesc:Int(pDesc:Byte Ptr)
EndInterface 

Interface ID3D11VertexShader Extends ID3D11DeviceChild
EndInterface 

Interface ID3D11HullShader Extends ID3D11DeviceChild
EndInterface 

Interface ID3D11DomainShader Extends ID3D11DeviceChild
EndInterface 

Interface ID3D11GeometryShader Extends ID3D11DeviceChild
EndInterface 

Interface ID3D11PixelShader Extends ID3D11DeviceChild
EndInterface 

Interface ID3D11ComputeShader Extends ID3D11DeviceChild
EndInterface 

Interface ID3D11InputLayout Extends ID3D11DeviceChild
EndInterface 

Interface ID3D11SamplerState Extends ID3D11DeviceChild
	Method GetDesc:Int(pDesc:Byte Ptr)
EndInterface 

Interface ID3D11Asynchronous Extends ID3D11DeviceChild
	Method GetDataSize:Int()
EndInterface 

Interface ID3D11Query Extends ID3D11Asynchronous
	Method GetDesc:Int(pDesc:Byte Ptr)
EndInterface 

Interface ID3D11Predicate Extends ID3D11Query
EndInterface 

Interface ID3D11Counter Extends ID3D11Asynchronous
	Method GetDesc:Int(pDesc:Byte Ptr)
EndInterface 

Interface ID3D11ClassInstance Extends ID3D11DeviceChild
	Method GetClassLinkage:Int(ppLinkage:ID3D11ClassLinkage Ptr)
	Method GetDesc:Int(pDesc:Byte Ptr)
	Method GetInstanceName:Int(pInstanceName:Byte Ptr,pBufferLength:Int)
	Method GetTypeName:Int(pTypeName:Byte Ptr,pBufferLength:Int)
EndInterface 

Interface ID3D11ClassLinkage Extends ID3D11DeviceChild
	Method GetClassInstance:Int(pClassInstanceName:Byte Ptr,InstanceIndex:Int,ppInstance:ID3D11ClassInstance Ptr)
	Method CreateClassInstance:Int(pszClassTypeName:Byte,ConstantBufferOffset:Int,ConstantVectorOffset:Int,TextureOffset:Int,SamplerOffset:Int,ppInstsance:ID3D11ClassInstance Ptr)
EndInterface 

Interface ID3D11CommandList Extends ID3D11DeviceChild
	Method GetContextFlags:Int()
EndInterface 

Interface ID3D11DeviceContext Extends ID3D11DeviceChild
	Method VSSetConstantBuffers:Int(StartSlot:Int,NumBuffers:Int,ppConstantBuffers:Byte Ptr)
	Method PSSetShaderResources:Int(StartSlot:Int,NumViews:Int,ppShaderResourceViews:Byte Ptr)
	Method PSSetShader:Int(pPixelShader:ID3D11PixelShader,ppClassInstances:Byte Ptr,NumClassInstances:Int)
	Method PSSetSamplers:Int(StartSlot:Int,NumSamplers:Int,ppSamplers:Byte Ptr)
	Method VSSetShader:Int(pVertexShader:ID3D11VertexShader,ppClassInstances:Byte Ptr,NumClassInstances:Int)
	Method DrawIndexed:Int(IndexCount:Int,StartIndexLocation:Int,BaseVertexLocation:Int)
	Method Draw:Int(VertexCount:Int,StartVertexLocation:Int)
	Method Map:Int(pResource:ID3D11Resource,Subresource:Int,MapType:Int,MapFlags:Int,pMappedResource:Byte Ptr)
	Method UnMap:Int(pResource:ID3D11Resource,Subresource:Int)
	Method PSSetConstantBuffers:Int(StartSlot:Int,NumBuffers:Int,ppConstantBuffers:Byte Ptr)
	Method IASetInputLayout:Int(pInputLayout:ID3D11InputLayout)
	Method IASetVertexBuffers:Int(StartSlot:Int,NumBuffers:Int,ppVertexBuffers:Byte Ptr,pStrides:Byte Ptr,pOffsets:Byte Ptr)
	Method IASetIndexBuffer:Int(pIndexBuffer:ID3D11Buffer,format:Int,offset:Int)
	Method DrawIndexedInstanced:Int(IndexCountPerInstance:Int,InstanceCount:Int,StartIndexLocation:Int,BaseVertexLocation:Int,StartInstanceLocation:Int)
	Method DrawInstanced:Int(VertexCountPerInstance:Int,InstanceCount:Int,StartVertexLocation:Int,StartInstanceLocation:Int)
	Method GSSetConstantBuffers:Int(StartSlot:Int,NumBuffers:Int,ppConstantBuffers:Byte Ptr)
	Method GSSetShader:Int(pShader:ID3D11GeometryShader,ppClassInstance:Byte Ptr,NumClassInstances:Int)
	Method IASetPrimitiveTopology:Int(Topology:Int)
	Method VSSetShaderResources:Int(StartSlot:Int,NumViews:Int,ppShaderResourceViews:Byte Ptr)
	Method VSSetSamplers:Int(StartSlot:Int,NumSamplers:Int,ppSamplers:Byte Ptr)
	Method Begin:Int(pAsync:ID3D11Asynchronous)
	Method End_:Int(pAsync:ID3D11Asynchronous)
	Method GetData:Int(pAsync:ID3D11Asynchronous,pData:Byte Ptr,DataSize:Int,GetDataFlags:Int)
	Method SetPredication:Int(pPredicate:ID3D11Predicate,PredicateValue:Int)
	Method GSSetShaderResources:Int(StartSlot:Int,NumViews:Int,ppShaderResourceViews:Byte Ptr)
	Method GSSetSamplers:Int(StartSlot:Int,NumSamplers:Int,ppSamplers:Byte Ptr)
	Method OMSetRenderTargets:Int(NumViews:Int,ppRenderTargetViews:Byte Ptr,pDepthStencilView:Byte Ptr)
	Method OMSetRendetTargetsAndUnorderedAccessViews:Int(NumViews:Int,ppRenderTargetViews:Byte Ptr,ppDepthStencilView:ID3D11DepthStencilView Ptr,UAVStartSlot:Int,NumUAVs:Int,ppUnorderedAccessViews:Byte Ptr)
	Method OMSetBlendState:Int(pBlendState:ID3D11BlendState,BlendFactor:Byte Ptr,SampleMask:Int)
	Method OMSetDepthStencilState:Int(pDepthStencilState:ID3D11DepthStencilState,StencilRef:Int)
	Method SOSetTargets:Int(NumBuffers:Int,ppSOTargets:Byte Ptr,pOffsets:Byte Ptr)
	Method DrawAuto:Int()
	Method DrawIndexedInstancedIndirect:Int(pBufferForArgs:ID3D11Buffer,AlignedByteOffsetForArgs:Int)
	Method DrawInstancedIndirect:Int(pBufferForArgs:ID3D11Buffer,AlignedByteOffsetForArgs:Int)
	Method Dispatch:Int(ThreadGroupCountX:Int,ThreadGroupCountY:Int,ThreadCountZ:Int)
	Method DispatchIndirect:Int(pBufferForArgs:ID3D11Buffer,AlignedOffsetForArgs:Int)
	Method RSSetState:Int(pRasterizerState:ID3D11RasterizerState)
	Method RSSetViewports:Int(NumViewports:Int,pViewports:Byte Ptr)
	Method RSSetScissorRects:Int(NumRects:Int,pRects:Byte Ptr)
	Method CopySubresourceRegion:Int(pDstResource:ID3D11Resource,DstSubresource:Int,DstX:Int,DstY:Int,DstZ:Int,pSrcResource:ID3D11Resource,SrcSubresource:Int,pSrcBox:Byte Ptr)
	Method CopyResource:Int(pDstResource:ID3D11Resource,pSrcResource:ID3D11Resource)
	Method UpdateSubresource:Int(pDstResource:ID3D11Resource,DstSubresource:Int,pDstBox:Byte Ptr,pSrcData:Byte Ptr,SrcRowPitch:Int,SrcDepthPitch:Int)
	Method CopyStructureCount:Int(pDstBuffer:ID3D11Buffer,DstAlignedByteOffset:Int,pSrcView:ID3D11UnorderedAccessView)
	Method ClearRenderTargetView:Int(pRenderTargetView:ID3D11RenderTargetView,ColorRGBA:Byte Ptr)
	Method ClearUnorderedAccessViewUint:Int(pUnorderedAccessView:ID3D11UnorderedAccessView,Values:Byte Ptr)
	Method ClearUnorderedAccessViewFloat:Int(pUnorderedAccessView:ID3D11UnorderedAccessView,Values:Byte Ptr)
	Method ClearDepthStencilView:Int(pDepthStencilView:ID3D11DepthStencilView,ClearFlags:Int,Depth#,Stencil:Int)
	Method GenerateMips:Int(pShaderResouceView:ID3D11ShaderResourceView)
	Method SetResourceMinLOD:Int(pResource:ID3D11Resource,MinLOD#)
	Method GetResourceMinLOD#(pResource:ID3D11Resource)
	Method ResolveSubresource:Int(pDstResource:ID3D11Resource,DstSubresource:Int,pSrcResource:ID3D11Resource,SrcSubresource:Int,format:Int)
	Method ExecuteCommandList:Int(pCommandList:ID3D11CommandList,RestoreContextState:Int)
	Method HSSetShaderResources:Int(StartSlot:Int,NumViews:Int,ppShaderResourceViews:Byte Ptr)
	Method HSSetShader:Int(pShader:ID3D11HullShader,ppClassInstances:Byte Ptr,NumClassInstances:Int)
	Method HSSetSamplers:Int(StartsSlot:Int,NumSamplers:Int,ppSamplers:Byte Ptr)
	Method HSSetConstantBuffers:Int(StartSlot:Int,NumBuffers:Int,ppConstantBuffers:Byte Ptr)
	Method DSSetShaderResources:Int(StartSlot:Int,NumViews:Int,ppShaderResourceViews:Byte Ptr)
	Method DSSetShader:Int(pShader:ID3D11DomainShader,ppClassInstances:Byte Ptr,NumClassInstances:Int)
	Method DSSetSamplers:Int(StartsSlot:Int,NumSamplers:Int,ppSamplers:Byte Ptr)
	Method DSSetConstantBuffers:Int(StartSlot:Int,NumBuffers:Int,ppConstantBuffers:Byte Ptr)
	Method CSSetShaderResources:Int(StartSlot:Int,NumViews:Int,ppShaderResourceViews:Byte Ptr)
	Method CSSetUnorderedAccessViews:Int(StartSlot:Int,NumUAVs:Int,ppUnorderedAccessViews:Byte Ptr,pUAVInitialCounts:Byte Ptr)
	Method CSSetShader:Int(pShader:ID3D11ComputeShader,ppClassInstances:Byte Ptr)
	Method CSSetSamplers:Int(StartsSlot:Int,NumSamplers:Int,ppSamplers:Byte Ptr)
	Method CSSetConstantBuffers:Int(StartSlot:Int,NumBuffers:Int,ppConstantBuffers:Byte Ptr)
	Method VSGetConstantBuffers:Int(StartSlot:Int,NumBuffers:Int,ppConstantBuffers:Byte Ptr)
	Method PSGetShaderResources:Int(StartSlot:Int,NumBuffers:Int,ppShaderResourceViews:Byte Ptr)
	Method PSGetShader:Int(ppPixelShader:ID3D11PixelShader Ptr,ppClassInstances:Byte Ptr,pNumClassInstances:Int Ptr)
	Method PSGetSamplers:Int(StartSlot:Int,NumSamplers:Int,ppSamplers:Byte Ptr)
	Method VSGetShader:Int(ppVertexShader:ID3D11VertexShader Ptr,ppClassInstances:Byte Ptr,pNumClassInstances:Int Ptr)
	Method PSGetConstantBuffers:Int(StartSlot:Int,NumBuffers:Int,ppConstantBufferS:Byte Ptr)
	Method IAGetInputLayout:Int(ppInputLayout:ID3D11InputLayout Ptr)
	Method IAGetVertexBuffers:Int(StartSlot:Int,NumBuffers:Int,ppVertexBuffers:Byte Ptr,pStrides:Byte Ptr,pOffsets:Byte Ptr)
	Method IAGetIndexBuffer:Int(pIndexBuffer:ID3D11Buffer Ptr,format:Int,offset:Int)
	Method GSGetConstantBuffers:Int(StartSlot:Int,NumBuffers:Int,ppConstantBufferS:Byte Ptr)
	Method GSGetShader:Int(ppGeometryShader:ID3D11GeometryShader Ptr,ppClassInstances:Byte Ptr,pNumClassInsstances:Byte Ptr)
	Method IAGetPrimitiveTopology:Int(pTopology:Int Ptr)
	Method VSGetShaderResources:Int(StartSlot:Int,NumBuffers:Int,ppShaderResourceViews:Byte Ptr)
	Method VSGetSamplers:Int(StartSlot:Int,NumSamplers:Int,ppSamplers:Byte Ptr)
	Method GetPredication:Int(ppPredicate:ID3D11Predicate Ptr,pPredicateValue:Int Ptr)
	Method GSGetShaderResources:Int(StartSlot:Int,NumBuffers:Int,ppShaderResourceViews:Byte Ptr)
	Method GSGetSamplers:Int(StartSlot:Int,NumSamplers:Int,ppSamplers:Byte Ptr)
	Method OMGetRenderTargets:Int(NumViews:Int,ppRenderTargetViews:Byte Ptr,ppDepthStencilView:Byte Ptr)
	Method OMGetRenderTargetsAndUnorderedAccessViews:Int(NumViews:Int,ppRenderTargetViews:Byte Ptr,ppDepthStencilView:ID3D11DepthStencilView,UAVStartSlot:Int,NumUAVs:Int,ppUnorderedAccessViews:Byte Ptr)
	Method OMGetBlendState:Int(ppBlendState:ID3D11BlendState Ptr,BlendFactor:Byte Ptr,pSampleMask:Int Ptr)
	Method OMGetDepthStencilState:Int(ppDepthStencilState:ID3D11DepthStencilState Ptr,pStencilRef:Int Ptr)
	Method SOGetTargets:Int(NumBuffers:Int,ppSOTargets:Byte Ptr)
	Method RSGetState:Int(ppRasterizerState:ID3D11RasterizerState Ptr)
	Method RSGetViewports:Int(pNumViewports:Int Ptr,pViewports:Byte Ptr)
	Method RSGetScissorRects:Int(pNumRects:Int Ptr,pRects:Byte Ptr)
	Method HSGetShaderResources:Int(StartSlot:Int,NumBuffers:Int,ppShaderResourceViews:Byte Ptr)
	Method HSGetShader:Int(ppHullShader:ID3D11HullShader Ptr,ppClassInstances:Byte Ptr,pNumClassInstance:Int Ptr)
	Method HSGetSamplers:Int(StartSlot:Int,NumSamplers:Int,ppSamplers:Byte Ptr)
	Method HSGetConstantBuffers:Int(StartSlot:Int,NumBuffers:Int,ppConstantBuffers:Byte Ptr)
	Method DSGetShaderResources:Int(StartSlot:Int,NumBuffers:Int,ppShaderResourceViews:Byte Ptr)
	Method DSGetShader:Int(ppDomainShader:ID3D11DomainShader Ptr,ppClassInstances:Byte Ptr,pNumClassInstance:Int Ptr)
	Method DSGetSamplers:Int(StartSlot:Int,NumSamplers:Int,ppSamplers:Byte Ptr)
	Method DSGetConstantBuffers:Int(StartSlot:Int,NumBuffers:Int,ppConstantBufferS:Byte Ptr)
	Method CSGetShaderResources:Int(StartSlot:Int,NumBuffers:Int,ppShaderResourceViews:Byte Ptr)
	Method CSGetUnorderedAccessViews:Int(StartSlot:Int,NumUAVs:Int,ppUnorderedAccessViews:Byte Ptr)
	Method CSGetShader:Int(ppComputeShader:ID3D11ComputeShader Ptr,ppClassInstances:Byte Ptr,pNumClassInstances:Int Ptr)
	Method CSGetSamplers:Int(StartSlot:Int,NumSamplers:Int,ppSamplers:Byte Ptr)
	Method CSGetConstantBuffers:Int(StartSlot:Int,NumBuffers:Int,ppConstantBuffers:Byte Ptr)
	Method ClearState:Int()
	Method Flush:Int()
	Method GetType:Int()
	Method GetContextFlags:Int()
	Method FinishCommandList:Int(RestoreDefferedContextState:Int,ppCommandList:ID3D11CommandList Ptr)
EndInterface 

Interface ID3D11Device Extends IUnknown_
	Method CreateBuffer:Int(pDesc:Byte Ptr,pInitialData:Byte Ptr,ppBuffer:ID3D11Buffer Ptr)
	Method CreateTexture1D:Int(pDesc:Byte Ptr,pInitialData:Byte Ptr,ppTexture1D:ID3D11Texture1D Ptr)
	Method CreateTexture2D:Int(pDesc:Byte Ptr,pInitialData:Byte Ptr,ppTexture2D:ID3D11Texture2D Ptr)
	Method CreateTexture3D:Int(pDesc:Byte Ptr,pInitialData:Byte Ptr,ppTexture3D:ID3D11Texture3D Ptr)
	Method CreateShaderResourceView:Int(pResource:ID3D11Resource,pDesc:Byte Ptr,ppSRView:ID3D11ShaderResourceView Ptr)
	Method CreateUnorderedAccessView:Int(pResource:ID3D11Resource,pDesc:Byte Ptr,ppUAView:ID3D11UnorderedAccessView Ptr)
	Method CreateRenderTargetView:Int(pResource:ID3D11Resource,pDesc:Byte Ptr,ppRTView:ID3D11RenderTargetView Ptr)
	Method CreateDepthStencilView:Int(pResource:ID3D11Resource,pDesc:Byte Ptr,ppDepthStencilView:ID3D11DepthStencilView Ptr)
	Method CreateInputLayout:Int(pInputElementDescs:Byte Ptr,NumElements:Int,pShaderBytecodeWithInputSignature:Byte Ptr,BytecodeLength:Size_T,ppInputLayout:ID3D11InputLayout Ptr)
	Method CreateVertexShader:Int(pShaderBytecode:Byte Ptr,BytecodeLength:Size_T,pClassLinkage:ID3D11ClassLinkage,ppVertexShader:ID3D11VertexShader Ptr)
	Method CreateGeometryShader:Int(pShaderByteCode:Byte Ptr,ByteCodeLength:Size_T,pClassLinkage:ID3D11ClassLinkage,ppGeometryShader:ID3D11GeometryShader Ptr)
	Method CreateGeometryShaderWithStreamOutput:Int(pShaderByteCode:Byte Ptr,ByteCodeLength:Size_T,pSODeclarations:Byte Ptr,NumEntries:Int,pBufferStrides:Byte Ptr,NumStrides:Int,RasterizedStream:Int,pClassLinkage:ID3D11ClassLinkage,ppGeometryShader:ID3D11GeometryShader Ptr)
	Method CreatePixelShader:Int(pShaderBytecode:Byte Ptr,BytecodeLength:Size_T,pClassLinkage:ID3D11ClassLinkage,ppPixelShader:ID3D11PixelShader Ptr)
	Method CreateHullShader:Int(pShaderBytecode:Byte Ptr,BytecodeLength:Size_T,pClassLinkage:ID3D11ClassLinkage,ppHullShader:ID3D11HullShader Ptr)
	Method CreateDomainShader:Int(pShaderBytecode:Byte Ptr,BytecodeLength:Size_T,pClassLinkage:ID3D11ClassLinkage,ppDomainShader:ID3D11DomainShader Ptr)
	Method CreateComputeShader:Int(pShaderBytecode:Byte Ptr,BytecodeLength:size_t,pClassLinkage:ID3D11ClassLinkage,ppDomainShader:ID3D11ComputeShader Ptr)
	Method CreateClassLinkage:Int(ppLinkage:ID3D11ClassLinkage Ptr)
	Method CreateBlendState:Int(pBlendStateDesc:Byte Ptr,ppBlendState:ID3D11BlendState Ptr)
	Method CreateDepthStencilState:Int(pDepthStencilDesc:Byte Ptr,ppDepthStencilState:ID3D11DepthStencilState Ptr)
	Method CreateRasterizerState:Int(pRasterizerDesc:Byte Ptr,ppRasterizerState:ID3D11RasterizerState Ptr)
	Method CreateSamplerState:Int(pSamplerDesc:Byte Ptr,ppSamplerState:ID3D11SamplerState Ptr)
	Method CreateQuery:Int(pQueryDesc:Byte Ptr,ppQuery:ID3D11Query Ptr)
	Method CreatePredicate:Int(pPredicateDesc:Byte Ptr,ppPredicate:ID3D11Predicate Ptr)
	Method CreateCounter:Int(pCounterDesc:Byte Ptr,ppCounter:ID3D11Counter Ptr)
	Method CreateDeferredContext:Int(ContextFlags:Int,ppDeferredContext:ID3D11DeviceContext Ptr)
	Method OpenSharedResource:Int(hResource:Byte Ptr,ReturnedInterface:Byte Ptr,ppResource:IUnknown_ Ptr)
	Method CheckFormatSupport:Int(format:Int,pFormatSupport:Int Ptr)
	Method CheckMultisampleQualityLevels:Int(format:Int,SampleCount:Int,pNumQualityLevels:Int Ptr)
	Method CheckCounterInfo:Int(pCounterInfo:Byte Ptr)
	Method CheckCounter:Int(pCounterDesc:Byte Ptr,ppCounter:ID3D11Counter Ptr)
	Method CheckFeatureSupport:Int(Feature:Int,pFeatureSupportData:Byte Ptr,FeatureSupportDataSize:Int)
	Method GetPrivateData:Int(guid:Byte Ptr,pDataSize:Int Ptr,pData:Byte Ptr)
	Method SetPrivateData:Int(guid:Byte Ptr,DataSize:Int,pData:Byte Ptr)
	Method SetPrivateDataInterface:Int(guid:Byte Ptr,pData:Byte Ptr)
	Method GetFeatureLevel:Int()
	Method GetCreationFlags:Int()
	Method GetDeviceRemovedReason:Int()
	Method GetImmediateContext:Int(ppImmediateContext:ID3D11DeviceContext Ptr)
	Method SetExceptionMode:Int(RaiseFlags:Int)
	Method GetExceptionMode:Int()
EndInterface 
EndExtern

Global _d3d11Dll:Byte Ptr = LoadLibraryA("D3D11.dll")

If Not _d3d11Dll Return Null

'Core
Global D3D11CreateDevice:Int(pAdapter:IDXGIAdapter,DriverType:Int,hSoftware:Byte Ptr,flags:Int,pFeatureLevels:Byte Ptr,Featurelevels:Int,SDKVersion:Int,ppDevice:ID3D11Device Ptr,..
			pFeatureLevel:Byte Ptr,ppImmediateContext:ID3D11DeviceContext Ptr)"win32"=GetProcAddress(_d3d11Dll,"D3D11CreateDevice")
Global D3D11CreateDeviceAndSwapChain:Int(pAdapter:IDXGIAdapter,DriverType:Int,Software:Int,flags:Int,pFeatureLevels:Byte Ptr,FeatureLevels:Int,SDKVersion:Int,pSwapChainDesc:Byte Ptr,..
			_pSwapChain:IDXGISwapChain Ptr,_ppDevice:ID3D11Device Ptr,pFeatureLevel:Byte Ptr,ppDeviceContext:ID3D11DeviceContext Ptr)"win32"=GetProcAddress(_d3d11Dll,"D3D11CreateDeviceAndSwapChain")






