SuperStrict

Import BRL.SystemDefault
Import BRL.Graphics
Import BRL.LinkedList
Import BRL.Retro
Import PUB.Win32
Import SRS.DirectX11
Import SRS.Dxgi

?Win32

Function SAFE_RELEASE(pUnknown:IUnknown_ Var)
	If pUnknown..
		pUnknown.Release_()
		
	pUnknown = Null
EndFunction

Type TD3D11GraphicsGpuResources	
	Field Device:ID3D11Device
	Field DeviceContext:ID3D11DeviceContext
	
	Field Swapchain:IDXGISwapChain1
	Field BackBuffer:ID3D11RenderTargetView
	
	Method Close()
		SAFE_RELEASE(BackBuffer)
		SAFE_RELEASE(Swapchain)
		SAFE_RELEASE(DeviceContext)
		SAFE_RELEASE(Device)
	EndMethod
EndType

Global _Graphics:TD3D11Graphics
Global _GraphicsDriver:TD3D11GraphicsDriver
Global _GraphicsModes:TGraphicsMode[]
Global _IsWindowed:Int

Type TGraphicsAdapter
	Field Name:String
	Field MajorVersion:Int
	Field MinorVersion:Int
	
	Field DedicatedVideoMemory:Long
	Field DedicatedSystemMemory:Long
	Field SharedSystemMemory:Long
	
	Field UniqueId:Long
EndType

Type TD3D11Graphics Extends TGraphics
	Field _Width:Int
	Field _Height:Int
	Field _Depth:Int
	Field _Hertz:Int
	Field _Flags:Long
	Field _Hwnd:Byte Ptr
	Field _Attached:Int
	Field _IsWindowed:Int
	Field _GpuFeatureLevel:Int
	Field _GpuResources:TD3D11GraphicsGpuResources = New TD3D11GraphicsGpuResources

	Method GetDirect3DDevice:ID3D11Device()
		Return _GpuResources.Device
	EndMethod
	
	Method GetDirect3DDeviceContext:ID3D11DeviceContext()
		Return _GpuResources.DeviceContext
	EndMethod
	
	Method GetBackBufferRenderTargetView:ID3D11RenderTargetView()
		Return _GpuResources.BackBuffer
	EndMethod
	
	'TGraphics
	Method Driver:TD3D11GraphicsDriver()
		Return _GraphicsDriver
	EndMethod
	
	'TGraphics
	Method GetSettings(width:Int Var,height:Int Var,depth:Int Var,hertz:Int Var,flags:Long Var,x:Int Var,y:Int Var)  Override
	'Method GetSettings:Int(width:Int Var,height:Int Var,depth:Int Var,hertz:Int Var,flags:Int Var, X:Int Var, Y:Int Var)
		width = _width
		height = _height
		depth = _depth
		hertz = _hertz
		flags = _flags
	EndMethod
	
	Method Position(x:Int, y:Int) Override
	End Method
	
	'TGraphics
	Method Close()
		If Not _Hwnd..
			Return
	
		If _GpuResources.SwapChain..
			_GpuResources.Swapchain.SetFullScreenState False,Null
		
		_GpuResources.Close()
		
		If Not _attached..
			DestroyWindow(_hwnd)
	
		_Hwnd = Null	
		_IsWindowed = False
	EndMethod
	
	Method Attach:TD3D11Graphics(hwnd:Byte Ptr, flags:Long)
		Local rect:Int[4]
		
		GetClientRect(hwnd, rect)
		Local width:Int = rect[2] - rect[0]
		Local height:Int = rect[3] - rect[1]
		
		If Not CreateD3D11Device()..
			Return Null

		If Not CreateSwapChain(hwnd, width, height, 0, 0, flags)..
			Return Null

		_hwnd = hwnd
		_width = width
		_height = height
		_flags = flags
		_attached = True
		
		Return Self
	EndMethod
	
	Method Create:TD3D11Graphics(width:Int, height:Int, Depth:Int, Hertz:Int, flags:Long, x:Int, y:Int)
		' Use a normal window that's fullscreen
		If _Depth..
			Return Null

		'register the window class with win32
		Local WindowClassName:String = "BBDX11Device Window Class"
		Local WC:WNDCLASS = New WNDCLASS
		WC.hInstance = GetModuleHandleW(Null)
		WC.lpfnWndProc = D3D11WndProc
		WC.hCursor = LoadCursorW(Null, Short Ptr IDC_ARROW)
		WC.lpszClassName = WindowClassName.ToWString()
		Local Atom:Int = RegisterClassW(WC)
		MemFree WC.lpszClassName
		
		If Not Atom
			Throw("Failed to register win32 window class")
			Return Null
		EndIf

		'Create the window
		Local wStyle:Int = WS_VISIBLE | WS_POPUP

		'centre window on screen
		Local Rect:Int[4]
		If Not Depth
			' Windowed window
			If Not (flags & 128)..
				wStyle = WS_VISIBLE | WS_CAPTION | WS_SYSMENU | WS_MINIMIZEBOX

			Local DesktopRect:Int[4]
			GetWindowRect(GetDesktopWindow(), DesktopRect)

			' Put the app window in the centre of the desktop window
			Rect[0] = DesktopRect[2] / 2 - width / 2
			Rect[1] = DesktopRect[3] / 2 - height / 2
			Rect[2] = Rect[0] + width
			Rect[3] = Rect[1] + height

			AdjustWindowRect(Rect, Wstyle, 0)
			_IsWindowed = True
		Else
			' Full screen
			Rect[2] = width
			Rect[3] = height

			_IsWindowed = False
		EndIf

		Local Hwnd:Byte Ptr = CreateWindowExW(0, WindowClassName, AppTitle, wStyle, Rect[0], Rect[1], Rect[2] - Rect[0], Rect[3] - Rect[1], 0, 0, GetModuleHandleW(Null), Null)
		If Not Hwnd..
			Return Null

		If Not CreateD3D11Device()
			DestroyWindow(Hwnd)
			Return Null
		EndIf

		If Not Depth
			' Get the real size of the windows that Windows has created
			GetClientRect(Hwnd, Rect)
			width = Rect[2] - Rect[0]
			height = Rect[3] - Rect[1]
		EndIf

		If Not _Depth..
			CreateSwapChain(Hwnd, width, height, Depth, Hertz, flags:Long)

		_Hwnd = Hwnd
		_Width = width
		_Height = height
		_Depth = Depth
		_Hertz = Hertz
		_Flags = flags

		Return Self
	EndMethod
	
	Function D3D11WndProc:Byte Ptr(Hwnd:Byte Ptr, Msg:UInt, Wp:WParam, Lp:LParam)"win32"
		bbSystemEmitOSEvent(Hwnd, Msg, Wp, Lp, Null)
		
		Select Msg
		Case WM_CLOSE
			Return 0
		Case WM_SYSKEYDOWN
			If Wp <> KEY_F4..
				Return 0
			
		Case WM_ACTIVATE
			If _Graphics..
				_Graphics.Reactivate(Wp)
	
			Return 0
		EndSelect
		
		Return DefWindowProcW(Hwnd, Msg, Wp, Lp)
	End Function

	' TD3D11Graphics
	Method CreateD3D11Device:Int()
	
		Local CreationFlag:Int = D3D11_CREATE_DEVICE_SINGLETHREADED | D3D11_CREATE_DEVICE_BGRA_SUPPORT
?Debug
		'CreationFlag :| D3D11_CREATE_DEVICE_DEBUG
?
		Local FeatureLevel:Int
		Local Device:ID3D11Device
		Local DeviceContext:ID3D11DeviceContext

		Local AdapterToUse:TGraphicsAdapter = D3D11GraphicsDriver().GetGraphicsAdapter()
		Local DxgiAdapter:IDXGIAdapter
		Local DriverType:Int

		If AdapterToUse
			DxgiAdapter = D3D11GraphicsDriver().GetDXGIAdapterByLuid(AdapterToUse.UniqueId)
			DriverType = D3D_DRIVER_TYPE_UNKNOWN
		Else
			DriverType = D3D_DRIVER_TYPE_HARDWARE
		EndIf
		
		If D3D11CreateDevice(DxgiAdapter, DriverType, Null, CreationFlag, Null, 0, D3D11_SDK_VERSION, Varptr Device, Varptr FeatureLevel, Varptr DeviceContext) < 0
			Throw "Critical Error!~nCould not create D3D11Device for the default adapter"
			Return False	
		EndIf
			
		If FeatureLevel < D3D_FEATURE_LEVEL_11_0
			SAFE_RELEASE(DeviceContext)
			SAFE_RELEASE(Device)

			Throw	"Critical Error!~n" +..
					"Make sure your GPU is Dx11 compatible or~n" +..
					"Make sure you have the latest drivers for your GPU."
					
			Return False
		EndIf
		
		_GpuResources.Device = Device
		_GpuResources.DeviceContext = DeviceContext
		_GpuFeatureLevel = FeatureLevel
		
		Return True
	EndMethod
	
	Method CreateSwapChain:Int(Hwnd:Byte Ptr, width:Int, height:Int, Depth:Int, Hertz:Int, flags:Long)
		Local IsWindowed:Int = False
		Local FullScreenTarget:TGraphicsMode

		If Depth
			Local Index:Int
			Local Modes:TGraphicsMode[] = GraphicsModes()
			For Local i:TGraphicsMode = EachIn Modes
				If width = i.width
					If height = i.height
						If Depth = i.depth
							If Hertz = i.hertz
								FullScreenTarget = Modes[Index]
								Exit
							EndIf
						EndIf
					EndIf
				EndIf
				
				Index :+ 1
			Next
		Else
			IsWindowed = True
		EndIf

		Local SwapchainDesc:DXGI_SWAP_CHAIN_DESC = New DXGI_SWAP_CHAIN_DESC
		SwapchainDesc.BufferCount = 2
		SwapchainDesc.BufferDesc_Format = DXGI_FORMAT_B8G8R8A8_UNORM
		SwapchainDesc.BufferDesc_Width = width
		SwapchainDesc.BufferDesc_Height = height
		SwapchainDesc.BufferDesc_Scaling = 0
		SwapchainDesc.BufferDesc_ScanlineOrdering = 0
		SwapchainDesc.BufferDesc_RefreshRate_Denominator = 1
		SwapchainDesc.Windowed = IsWindowed
		SwapchainDesc.BufferUsage = DXGI_USAGE_RENDER_TARGET_OUTPUT
		SwapchainDesc.OutputWindow = Hwnd
		SwapchainDesc.flags = DXGI_SWAP_CHAIN_FLAG_ALLOW_MODE_SWITCH
		SwapchainDesc.SampleDesc_Count = 1
		SwapchainDesc.SampleDesc_Quality = 0

		If Depth And FullScreenTarget
			SwapchainDesc.BufferDesc_RefreshRate_Numerator = FullscreenTarget.Hertz
			SwapchainDesc.SwapEffect = DXGI_SWAP_EFFECT_FLIP_SEQUENTIAL
		Else
			SwapchainDesc.BufferDesc_RefreshRate_Numerator = 0
			SwapchainDesc.SwapEffect = DXGI_SWAP_EFFECT_DISCARD
		EndIf

		Local Factory:IDXGIFactory
		Local Adapter1:IDXGIAdapter1
		Local Device1:IDXGIDevice1

		If _GpuResources.Device.QueryInterface(IID_IDXGIDevice1, Device1) < 0
			Throw("Could not query for device1 interface")
			Return False
		EndIf
		
		Device1.GetParent(IID_IDXGIAdapter1, Byte Ptr Ptr (Varptr Adapter1))
		If Not Adapter1
			SAFE_RELEASE(Device1)
			Throw("Could not query for adapter1 interface from device")
			Return False
		EndIf

		Adapter1.GetParent(IID_IDXGIFactory, Byte Ptr Ptr (Varptr Factory))
		If Not Factory
			SAFE_RELEASE(Device1)
			SAFE_RELEASE(Adapter1)
			Throw("Could not query for factory interface from adapter")
			Return False
		EndIf

		Local SwapChain:IDXGISwapchain
		Local Hr:Int = Factory.CreateSwapChain(Device1, SwapchainDesc, Varptr Swapchain)
		SAFE_RELEASE(Device1)
		SAFE_RELEASE(Adapter1)
		SAFE_RELEASE(Factory)
		
		If Hr < 0
			Throw("Could not create swap chain")
			Return False
		EndIf

		If Depth
			Hr = Swapchain.SetFullscreenState(True, Null)
		EndIf
		
		Hr = Swapchain.ResizeTarget(SwapchainDesc)
		Hr = Swapchain.ResizeBuffers(0, 0, 0, DXGI_FORMAT_UNKNOWN, 0)

		' Get the back buffer
		Local pBackBuffer:ID3D11Texture2D
		If Swapchain.GetBuffer(0, IID_ID3D11Texture2D, Byte Ptr Ptr(Varptr pBackBuffer)) < 0
			Throw("Critical Error!~nCould not get back buffer texture")
			Return False
		EndIf

		Local BackBufferRenderTargetView:ID3D11RenderTargetView
		If _GpuResources.Device.CreateRenderTargetView(pBackBuffer, Null, Varptr BackBufferRenderTargetView) < 0
			Throw("Critical Error!~nCould not create render target view for back buffer")
			Return False
		EndIf

		_GpuResources.BackBuffer = BackBufferRenderTargetView
		If Swapchain.QueryInterface(IID_IDXGISwapchain1, _GpuResources.Swapchain) < 0..
			Return False
			
		SAFE_RELEASE(Swapchain)
		SAFE_RELEASE(pBackBuffer)
	EndMethod
	
	Method Flip(sync:Int)
		Local PresentParameters:DXGI_PRESENT_PARAMETERS = New DXGI_PRESENT_PARAMETERS
		If Sync
			_GpuResources.Swapchain.Present1(1, 0, PresentParameters)
		Else
			_GpuResources.Swapchain.Present1(0, 0, PresentParameters)
		EndIf
	EndMethod
	
	Method GetFeatureLevel:Int()
		Return _GpuFeatureLevel
	EndMethod
	
	Method Reactivate(Wp:WParam)
		If Not _IsWindowed
			If _GpuResources.Swapchain
				_GpuResources.Swapchain.SetFullscreenState(Wp <> 0, Null)
			EndIf
			
			' Wp = 0 = WA_INACTIVE
			If Not Wp..
				ShowWindow(_Hwnd, SW_MINIMIZE)

		EndIf
	EndMethod
	
	Method Resize(width:Int, height:Int) Override
	EndMethod
EndType

Type TD3D11GraphicsDriver Extends TGraphicsDriver
	Field AllAdapters:TGraphicsAdapter[]
	Field AdapterToUse:TGraphicsAdapter
	
	Method Create:TD3D11GraphicsDriver()
		' Did the dll's load?
		If Not _d3d11Dll Return Null
		If Not _DXGIDll Return Null
		If Not _d3dcompiler Return Null

		AllAdapters = GraphicsAdapters()

		Return Self
	EndMethod
	
	Method GraphicsAdapters:TGraphicsAdapter[]()
		Local SupportLevels:Int[] = [D3D_FEATURE_LEVEL_11_1, D3D_FEATURE_LEVEL_11_0, D3D_FEATURE_LEVEL_10_1, D3D_FEATURE_LEVEL_10_0]
		Local ActualLevel:Int

		Local Factory:IDXGIFactory
		If CreateDXGIFactory(IID_IDXGIFactory, Varptr Factory) < 0..
			Return Null

		Local Index:Int = 0
		Local Adapter:IDXGIAdapter
		Local AdapterList:TList = New TList
		
		While Factory.EnumAdapters(Index, Varptr Adapter) >= 0
			If D3D11CreateDevice(Adapter, D3D_DRIVER_TYPE_UNKNOWN, Null, D3D11_CREATE_DEVICE_SINGLETHREADED, SupportLevels, SupportLevels.Length, D3D11_SDK_VERSION, Null, Varptr ActualLevel, Null) < 0
				SAFE_RELEASE(Adapter)
				Index :+ 1
				Continue
			EndIf
			
			Local DxgiDesc:DXGI_ADAPTER_DESC = New DXGI_ADAPTER_DESC
			If Adapter.GetDesc(DxgiDesc) < 0
				SAFE_RELEASE(Adapter)
				Index :+ 1
				Continue
			EndIf
						
			' cache the gpu information
			Local AdapterInfo:TGraphicsAdapter = New TGraphicsAdapter
			AdapterInfo.Name = DxgiDesc.Description()
			AdapterInfo.UniqueId = (DxgiDesc.LuidLow Shl 32) | DxgiDesc.LuidHigh
			
			AdapterInfo.DedicatedVideoMemory = DxgiDesc.DedicatedVideoMemory
			If AdapterInfo.DedicatedVideoMemory < 0
				AdapterInfo.DedicatedVideoMemory :~ $ffffffff00000000:Long
			EndIf
			
			AdapterInfo.DedicatedSystemMemory = DxgiDesc.DedicatedSystemMemory 
			If AdapterInfo.DedicatedSystemMemory < 0
				AdapterInfo.DedicatedSystemMemory :~ $ffffffff00000000:Long
			EndIf
			
			AdapterInfo.SharedSystemMemory = DxgiDesc.SharedSystemMemory 
			If AdapterInfo.SharedSystemMemory < 0
				AdapterInfo.SharedSystemMemory :~ $ffffffff00000000:Long
			EndIf
			
			If ActualLevel = D3D_FEATURE_LEVEL_11_1
				AdapterInfo.MajorVersion = 11
				AdapterInfo.MinorVersion = 1

			Else If ActualLevel = D3D_FEATURE_LEVEL_11_0
				AdapterInfo.MajorVersion = 11
				AdapterInfo.MinorVersion = 0
				
			Else If ActualLevel = D3D_FEATURE_LEVEL_10_1
				AdapterInfo.MajorVersion = 10
				AdapterInfo.MinorVersion = 1

			Else If ActualLevel = D3D_FEATURE_LEVEL_10_0
				AdapterInfo.MajorVersion = 10
				AdapterInfo.MinorVersion = 0
			EndIf

			ListAddLast(AdapterList, AdapterInfo)
			Index :+ 1
			SAFE_RELEASE(Adapter)
		Wend

		SAFE_RELEASE(Factory)
		
		Return TGraphicsAdapter[](ListToArray(AdapterList))
	EndMethod
	
	Method SetGraphicsAdapter(Adapter:TGraphicsAdapter)
		AdapterToUse = Adapter
	EndMethod
	
	Method GetGraphicsAdapter:TGraphicsAdapter()
		Return AdapterToUse
	EndMethod
	
	'TGraphicsDriver	
	Method GraphicsModes:TGraphicsMode[]()
		' no adapter selected? Use the default one
		If Not AdapterToUse
			AdapterToUse = GraphicsAdapters()[0]
		EndIf
		
		If Not AdapterToUse
			Throw ("No suitable graphics adapters found.")
			Return Null
		EndIf

		Local DXGIAdapter:IDXGIAdapter = GetDXGIAdapterByLuid(AdapterToUse.UniqueId)
		If Not DXGIAdapter
			Throw ("Invalid adapter information.")
			Return Null
		EndIf

		Local Outputs:IDXGIOutput[] = EnumerateDXGIOutputs(DXGIAdapter)
		
		For Local Output:IDXGIOutput = EachIn Outputs
			Local DXGIModeCount:Int = 0
			If Output.GetDisplayModeList(DXGI_FORMAT_B8G8R8A8_UNORM, 0, Varptr DXGIModeCount, Null) < 0
				Continue
			EndIf
			
			If DXGIModeCount = 0
				Continue
			EndIf
			
			Local DXGIModesPtr:Byte Ptr = MemAlloc(DXGIModeCount * SizeOf DXGI_MODE_DESC)
			If Output.GetDisplayModeList(DXGI_FORMAT_B8G8R8A8_UNORM, 0, Varptr DXGIModeCount, DXGIModesPtr) < 0
				Continue
			EndIf
			
			Local DXGIModes:DXGI_MODE_DESC[] = New DXGI_MODE_DESC[DXGIModeCount]
			For Local i:Int = 0 Until DXGIModeCount
				DXGIModes[i] = New DXGI_MODE_DESC
				MemCopy(DXGIModes[i], DXGIModesPtr, SizeOf(DXGI_MODE_DESC))
				DXGIModesPtr :+ SizeOf(DXGI_MODE_DESC)
			Next			
			
			Local ModeList:TList = New TList
			For Local DXGIMode:DXGI_MODE_DESC = EachIn DXGIModes
				Local Mode:TGraphicsMode = New TGraphicsMode
				Mode.width = DXGIMode.width
				Mode.height = DXGIMode.height
				Mode.depth = 32
				Mode.hertz = DXGIMode.RefreshRate_Numerator / DXGIMode.RefreshRate_Denominator
				
				ListAddLast(ModeList, Mode)
			Next
			
			Return TGraphicsMode[](ListToArray(ModeList))
		Next
		
		Return Null
	EndMethod
	
	Method GetDXGIAdapterByLuid:IDXGIAdapter(Luid:Long)
		Local Factory:IDXGIFactory
		If CreateDXGIFactory(IID_IDXGIFactory, Varptr Factory) < 0
			Throw("Could not create DXGIFactory.")
			Return Null
		EndIf

		Local Index:Int = 0
		Local DXGIAdapter:IDXGIAdapter
		While Factory.EnumAdapters(Index, Varptr DXGIAdapter) >= 0
			Local Desc:DXGI_ADAPTER_DESC = New DXGI_ADAPTER_DESC
			If DXGIAdapter.GetDesc(Desc) < 0
				DXGIAdapter.Release_(); DXGIAdapter = Null
				Index :+ 1
				Continue
			EndIf
			
			If ((Desc.LuidLow Shl 32) | Desc.LuidLow) = Luid
				Exit
			EndIf

			SAFE_RELEASE(DXGIAdapter)
			
			Index :+ 1
		Wend
		SAFE_RELEASE(Factory)
				
		Return DXGIAdapter
	EndMethod
	
	Method EnumerateDXGIOutputs:IDXGIOutput[](DXGIAdapter:IDXGIAdapter)
		Local Outputs:IDXGIOutput[]

		Local Index:Int = 0
		Local Output:IDXGIOutput
		While DXGIAdapter.EnumOutputs(Index, Varptr Output) >= 0
			Outputs = Outputs[..Outputs.Length + 1]
			Outputs[Outputs.Length - 1] = Output
			
			Index :+ 1
		Wend

		Return Outputs
	EndMethod

	Method AttachGraphics:TD3D11Graphics(hwnd:Byte Ptr, flags:Long) Override
		Return New TD3D11Graphics.Attach(hwnd, flags)
	EndMethod
	
	Method CreateGraphics:TD3D11Graphics(width:Int, height:Int, depth:Int, hertz:Int, flags:Long, x:Int, y:Int)
		Return New TD3D11Graphics.Create(width, height, depth, hertz, flags, x, y)
	EndMethod
	
	Method SetGraphics(g:TGraphics)
		_Graphics = TD3D11Graphics(g)
	EndMethod
	
	Method Flip:Int(sync:Int)
		_Graphics.Flip(sync)
	EndMethod
	
	Method ToString:String()
		Return "D3D11GraphicsDriver"
	EndMethod
EndType

Function D3D11GraphicsDriver:TD3D11GraphicsDriver()
	Global _DoneD3D11:Int
	If Not _DoneD3D11
		_GraphicsDriver = New TD3D11GraphicsDriver.Create()
		If _GraphicsDriver..
			_DoneD3D11 = True
	EndIf

	Return _GraphicsDriver
EndFunction
