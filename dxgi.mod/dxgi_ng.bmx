
SuperStrict

Import Pub.Win32
Import BRL.System

Type DXGI_SWAP_CHAIN_DESC
	Field BufferDesc_Width:Int
	Field BufferDesc_Height:Int
	Field BufferDesc_RefreshRate_Numerator:Int
	Field BufferDesc_RefreshRate_Denominator:Int
	Field BufferDesc_Format:Int
	Field BufferDesc_ScanlineOrdering:Int
	Field BufferDesc_Scaling:Int
	Field SampleDesc_Count:Int
	Field SampleDesc_Quality:Int
	Field BufferUsage:Int
	Field BufferCount:Int
	Field OutputWindow:Byte Ptr
	Field Windowed:Int
	Field SwapEffect:Int
	Field flags:Int
EndType

Type DXGI_PRESENT_PARAMETERS
	Field DirtyRectsCount:Int
	Field pDirtyRects:Byte Ptr
	Field pScrollRect:Byte Ptr
	Field pScrollOffset:Byte Ptr
EndType

Extern"win32"

Interface IDXGIObject Extends IUnknown_
	Method SetPrivateData:Int(Name:Byte Ptr,DataSize:Int,pData:Byte Ptr)
	Method SetPrivateDataInterface:Int(Name:Byte Ptr,pUnknown:Byte Ptr)
	Method GetPrivateData:Int(Name:Byte Ptr,pDataSize:Int Ptr,pData:Byte Ptr)
	Method GetParent:Int(riid:Byte Ptr,ppParent:IUnknown_ Ptr)
EndInterface 

Interface IDXGIDeviceSubObject Extends IDXGIObject
	Method GetDevice:Int()
EndInterface 

Interface IDXGIResource Extends IDXGIDeviceSubObject
	Method GetSharedHandle:Int(pShareHandle:Byte Ptr Ptr)
	Method GetUsage:Int(pUsage:Int Ptr)
	Method SetEvictionPriority:Int(EvictionPriority:Int)
	Method GetEvictionPriority:Int(pEvictionPriority:Int Ptr)
EndInterface 

Interface IDXGIKeyedMutex Extends IDXGIDeviceSubObject
	Method AcquireSync:Int(Key:Long,dwMilliseconds:Int)
	Method ReleaseSync:Int(Key:Long)
EndInterface 

Interface IDXGISurface Extends IDXGIDeviceSubObject
	Method GetDesc:Int(pDesc:Byte Ptr)
	Method Map:Int(pLockedRect:Byte Ptr,MapFlags:Int)
	Method UnMap:Int()
EndInterface 

Interface IDXGISurface1 Extends IDXGISurface
	Method GetDC:Int(Discard:Int,pHdc:Byte Ptr Ptr)
	Method ReleaseDC:Int(pDirectRect:Byte Ptr)
EndInterface 

Interface IDXGIAdapter Extends IDXGIObject
	Method EnumOutputs:Int(Output:Int,ppOutput:IDXGIOutput Ptr)
	Method GetDesc:Int(pDesc:Byte Ptr)
	Method CheckInterfaceSupport:Int(InterfaceName:Byte Ptr,pUMDVersion:Long Ptr)
EndInterface

Interface IDXGIOutput Extends IDXGIObject
	Method GetDesc:Int(pDesc:Byte Ptr)
	Method GetDisplayModeList:Int(EnumFormat:Int,flags:Int,pNumModes:Int Ptr,pDesc:Byte Ptr)
	Method FindClosestMatchMode:Int(pModeToMatch:Byte Ptr,pClosestMatch:Byte Ptr,pConcernedDevice:Byte Ptr)
	Method WaitForVBlank:Int()
	Method TakeOwnership:Int(pDevice:Byte Ptr,Exclusive:Int)
	Method ReleaseOwnership:Int()
	Method GetGammaControlCapabilities:Int(pGammaCaps:Byte Ptr)
	Method SetGammaControl:Int(pArray:Byte Ptr)
	Method GetGammaControl:Int(pArray:Byte Ptr)
	Method SetDisplaySurface:Int(pScanoutSurface:Byte Ptr)
	Method GetDisplaySurfaceData:Int(pDestination:Byte Ptr)
	Method GetFrameStatistics:Int(pStats:Byte Ptr)
EndInterface 

Interface IDXGISwapChain Extends IDXGIDeviceSubObject
	Method Present:Int(SyncInterval:Int,flags:Int)
	Method GetBuffer:Int(Buffer:Int,riid:Byte Ptr,ppSurface:IUnknown_ Ptr)
	Method SetFullscreenState:Int(FullScreen:Int,pTarget:IDXGIOutput)
	Method GetFullscreenState:Int(pFullScreen:Int Ptr,ppTarget:IDXGIOutput Ptr)
	Method GetDesc:Int(pDesc:Byte Ptr)
	Method ResizeBuffers:Int(BufferCount:Int,width:Int,Hieght:Int,NewFormat:Int,SwapChainFlags:Int)
	Method ResizeTarget:Int(pNewTargetParameters:Byte Ptr)
	Method GetContainingOutput:Int(ppOutput:IDXGIOutput Ptr)
	Method GetFrameStatistics:Int(pStats:Byte Ptr)
	Method GetLastPresentCount:Int(pLastPresentCount:Int Ptr)
EndInterface

Interface IDXGISwapChain1 Extends IDXGISwapChain
	Method GetDesc1:Int(pDesc:Byte Ptr)
	Method GetFullscreenDesc:Int(pDesc:Byte Ptr)
	Method GetHwnd:Int(pHwnd:Int Ptr)
	Method GetCoreWindow:Int(refiid:Byte Ptr, ppUnknown:Byte Ptr Ptr)
	Method Present1:Int(SyncInterval:Int, PresentFlags:Int, pPresentParameters:Byte Ptr)
	Method IsTemporaryMonoSupported:Int()
	Method GetRestrictToOutput:Int(ppRestrictToOutput:IDXGIOutput Ptr)
	Method SetBackgroundColor:Int(pColor:Byte Ptr)
	Method GetBackgroundColor:Int(pColor:Byte Ptr)
	Method SetRotation:Int(Rotation:Int)
	Method GetRotation:Int(pRotation:Int Ptr)
EndInterface

Interface IDXGIFactory Extends IDXGIObject
	Method EnumAdapters:Int(Adapter:Int,ppAdapter:IDXGIAdapter Ptr)
	Method MakeWindowAssociation:Int(WindowHandle:Byte Ptr,flags:Int)
	Method GetWindowAssociation:Int(pWindowHandle:Byte Ptr Ptr)
	Method CreateSwapChain:Int(pDevice:IUnknown_,pDesc:Byte Ptr,ppSwapChain:IDXGISwapChain Ptr)
	Method CreateSoftwareAdapter:Int(Module_:Byte Ptr,ppAdapter:IDXGIAdapter Ptr)
EndInterface 

Interface IDXGIDevice Extends IDXGIObject
	Method GetAdapter:Int(pAdapter:IDXGIAdapter Ptr)
	Method CreateSurface:Int(pDesc:Byte Ptr,NumSurfaces:Int,Usage:Int,pSharedResource:Int,ppSurface:IDXGISurface Ptr)
	Method QueryResourceResidency:Int(ppRresource:Byte Ptr,pResidencyStatus:Int Ptr,NumResources:Int)
	Method SetGPUThreadPriority:Int(Priority:Int)
	Method GetGPUThreadPriority:Int(pPriority:Int Ptr)
EndInterface 

Interface IDXGIFactory1 Extends IDXGIFactory
	Method EnumAdapters1:Int(Adapter:Int,ppAdapter:IDXGIAdapter1)
	Method IsCurrent:Int()
EndInterface 

Interface IDXGIAdapter1 Extends IDXGIAdapter
	Method GetDesc1:Int(pDesc:Byte Ptr)
EndInterface 

Interface IDXGIDevice1 Extends IDXGIDevice
	Method SetMaximumFrameLatency:Int(MaxLatency:Int)
	Method GetMaximumFrameLatency:Int(pMaxLatency:Int Ptr)
EndInterface 

EndExtern

Global _DXGIDll:Byte Ptr = LoadLibraryW("dxgi.dll")
If Not _DXGIDll Return Null

Global IID_IDXGIFactory:Int[]=[$7b7166ec,$44ae21c7,$aec91ab2,$69e31a32]
Global IID_IDXGIFactory1:Int[]=[$770aae78,$4dbaf26f,$3c2529a8,$87b3d183]
Global IID_IDXGIAdapter:Int[]=[$2411e7e1,$4ccf12ac,$989714bd,$c04d53e8]
Global IID_IDXGIAdapter1:Int[]=[$29038f61,$46263839,$6808fd91,$051a0179]
Global IID_IDXGIDevice:Int[]= [$54ec77fa,$44e61377,$fd88328c,$4cc8445f]
Global IID_IDXGIDevice1:Int[]= [$77db970f,$48ba6276,$010728ba,$2c39b443]
Global IID_IDXGISwapChain1:Int[] = [$790a45f7, $48760d42, $550a3a98, $aaf4e6cf]



Global CreateDXGIFactory:Int(riid:Byte Ptr,ppFactory:IDXGIFactory Ptr)"win32" = GetProcAddress(_DXGIDll,"CreateDXGIFactory")