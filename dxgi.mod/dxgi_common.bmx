
SuperStrict

Import Pub.Win32
Import BRL.System

Const DXGI_CPU_ACCESS_NONE:Int					= 0
Const DXGI_CPU_ACCESS_DYNAMIC:Int				= 1
Const DXGI_CPU_ACCESS_READ_WRITE:Int			= 2
Const DXGI_CPU_ACCESS_SCRATCH:Int				= 3
Const DXGI_CPU_ACCESS_FIELD:Int					= 15

Const DXGI_USAGE_SHADER_INPUT:Long				= 1 Shl ( 0 + 4 )
Const DXGI_USAGE_RENDER_TARGET_OUTPUT:Long		= 1 Shl ( 1 + 4 )
Const DXGI_USAGE_BACK_BUFFER:Long				= 1 Shl ( 2 + 4 )
Const DXGI_USAGE_SHARED:Long					= 1 Shl ( 3 + 4 )
Const DXGI_USAGE_READ_ONLY:Long					= 1 Shl ( 4 + 4 )
Const DXGI_USAGE_DISCARD_ON_PRESENT:Long		= 1 Shl ( 5 + 4 )
Const DXGI_USAGE_UNORDERED_ACCESS:Long			= 1 Shl ( 6 + 4 )

Const DXGI_MWA_NO_WINDOW_CHANGES:Int			= ( 1 Shl 0 )
Const DXGI_MWA_NO_ALT_ENTER:Int					= ( 1 Shl 1 )
Const DXGI_MWA_NO_PRINT_SCREEN:Int				= ( 1 Shl 2 )
Const DXGI_MWA_VALID:Int						= ( $7 )

Const DXGI_MODE_SCALING_UNSPECIFIED:Int   = 0
Const DXGI_MODE_SCALING_CENTERED:Int      = 1
Const DXGI_MODE_SCALING_STRETCHED:Int     = 2

Const DXGI_MODE_SCANLINE_ORDER_UNSPECIFIED:Int         = 0
Const DXGI_MODE_SCANLINE_ORDER_PROGRESSIVE:Int         = 1
Const DXGI_MODE_SCANLINE_ORDER_UPPER_FIELD_FIRST:Int   = 2
Const DXGI_MODE_SCANLINE_ORDER_LOWER_FIELD_FIRST:Int   = 3

'DXGI_FORMAT
Const DXGI_FORMAT_UNKNOWN:Int	                  = 0
Const DXGI_FORMAT_R32G32B32A32_TYPELESS:Int       = 1
Const DXGI_FORMAT_R32G32B32A32_FLOAT:Int          = 2
Const DXGI_FORMAT_R32G32B32A32_UINT:Int           = 3
Const DXGI_FORMAT_R32G32B32A32_SINT:Int           = 4
Const DXGI_FORMAT_R32G32B32_TYPELESS:Int          = 5
Const DXGI_FORMAT_R32G32B32_FLOAT:Int             = 6
Const DXGI_FORMAT_R32G32B32_UINT:Int              = 7
Const DXGI_FORMAT_R32G32B32_SINT:Int              = 8
Const DXGI_FORMAT_R16G16B16A16_TYPELESS:Int       = 9
Const DXGI_FORMAT_R16G16B16A16_FLOAT:Int          = 10
Const DXGI_FORMAT_R16G16B16A16_UNORM:Int          = 11
Const DXGI_FORMAT_R16G16B16A16_UINT:Int           = 12
Const DXGI_FORMAT_R16G16B16A16_SNORM:Int          = 13
Const DXGI_FORMAT_R16G16B16A16_SINT:Int           = 14
Const DXGI_FORMAT_R32G32_TYPELESS:Int             = 15
Const DXGI_FORMAT_R32G32_FLOAT:Int                = 16
Const DXGI_FORMAT_R32G32_UINT:Int                 = 17
Const DXGI_FORMAT_R32G32_SINT:Int                 = 18
Const DXGI_FORMAT_R32G8X24_TYPELESS:Int           = 19
Const DXGI_FORMAT_D32_FLOAT_S8X24_UINT:Int        = 20
Const DXGI_FORMAT_R32_FLOAT_X8X24_TYPELESS:Int    = 21
Const DXGI_FORMAT_X32_TYPELESS_G8X24_UINT:Int     = 22
Const DXGI_FORMAT_R10G10B10A2_TYPELESS:Int        = 23
Const DXGI_FORMAT_R10G10B10A2_UNORM:Int           = 24
Const DXGI_FORMAT_R10G10B10A2_UINT:Int            = 25
Const DXGI_FORMAT_R11G11B10_FLOAT:Int             = 26
Const DXGI_FORMAT_R8G8B8A8_TYPELESS:Int           = 27
Const DXGI_FORMAT_R8G8B8A8_UNORM:Int              = 28
Const DXGI_FORMAT_R8G8B8A8_UNORM_SRGB:Int         = 29
Const DXGI_FORMAT_R8G8B8A8_UINT:Int               = 30
Const DXGI_FORMAT_R8G8B8A8_SNORM:Int              = 31
Const DXGI_FORMAT_R8G8B8A8_SINT:Int               = 32
Const DXGI_FORMAT_R16G16_TYPELESS:Int             = 33
Const DXGI_FORMAT_R16G16_FLOAT:Int                = 34
Const DXGI_FORMAT_R16G16_UNORM:Int                = 35
Const DXGI_FORMAT_R16G16_UINT:Int                 = 36
Const DXGI_FORMAT_R16G16_SNORM:Int                = 37
Const DXGI_FORMAT_R16G16_SINT:Int                 = 38
Const DXGI_FORMAT_R32_TYPELESS:Int                = 39
Const DXGI_FORMAT_D32_FLOAT:Int                   = 40
Const DXGI_FORMAT_R32_FLOAT:Int                   = 41
Const DXGI_FORMAT_R32_UINT:Int                    = 42
Const DXGI_FORMAT_R32_SINT:Int                    = 43
Const DXGI_FORMAT_R24G8_TYPELESS:Int              = 44
Const DXGI_FORMAT_D24_UNORM_S8_UINT:Int           = 45
Const DXGI_FORMAT_R24_UNORM_X8_TYPELESS:Int       = 46
Const DXGI_FORMAT_X24_TYPELESS_G8_UINT:Int        = 47
Const DXGI_FORMAT_R8G8_TYPELESS:Int               = 48
Const DXGI_FORMAT_R8G8_UNORM:Int                  = 49
Const DXGI_FORMAT_R8G8_UINT:Int                   = 50
Const DXGI_FORMAT_R8G8_SNORM:Int                  = 51
Const DXGI_FORMAT_R8G8_SINT:Int                   = 52
Const DXGI_FORMAT_R16_TYPELESS:Int                = 53
Const DXGI_FORMAT_R16_FLOAT:Int                   = 54
Const DXGI_FORMAT_D16_UNORM:Int                   = 55
Const DXGI_FORMAT_R16_UNORM:Int                   = 56
Const DXGI_FORMAT_R16_UINT:Int                    = 57
Const DXGI_FORMAT_R16_SNORM:Int                   = 58
Const DXGI_FORMAT_R16_SINT:Int                    = 59
Const DXGI_FORMAT_R8_TYPELESS:Int                 = 60
Const DXGI_FORMAT_R8_UNORM:Int                    = 61
Const DXGI_FORMAT_R8_UINT:Int                     = 62
Const DXGI_FORMAT_R8_SNORM:Int                    = 63
Const DXGI_FORMAT_R8_SINT:Int                     = 64
Const DXGI_FORMAT_A8_UNORM:Int                    = 65
Const DXGI_FORMAT_R1_UNORM:Int                    = 66
Const DXGI_FORMAT_R9G9B9E5_SHAREDEXP:Int          = 67
Const DXGI_FORMAT_R8G8_B8G8_UNORM:Int             = 68
Const DXGI_FORMAT_G8R8_G8B8_UNORM:Int             = 69
Const DXGI_FORMAT_BC1_TYPELESS:Int                = 70
Const DXGI_FORMAT_BC1_UNORM:Int                   = 71
Const DXGI_FORMAT_BC1_UNORM_SRGB:Int              = 72
Const DXGI_FORMAT_BC2_TYPELESS:Int                = 73
Const DXGI_FORMAT_BC2_UNORM:Int                   = 74
Const DXGI_FORMAT_BC2_UNORM_SRGB:Int              = 75
Const DXGI_FORMAT_BC3_TYPELESS:Int                = 76
Const DXGI_FORMAT_BC3_UNORM:Int                   = 77
Const DXGI_FORMAT_BC3_UNORM_SRGB:Int              = 78
Const DXGI_FORMAT_BC4_TYPELESS:Int                = 79
Const DXGI_FORMAT_BC4_UNORM:Int                   = 80
Const DXGI_FORMAT_BC4_SNORM:Int                   = 81
Const DXGI_FORMAT_BC5_TYPELESS:Int                = 82
Const DXGI_FORMAT_BC5_UNORM:Int                   = 83
Const DXGI_FORMAT_BC5_SNORM:Int                   = 84
Const DXGI_FORMAT_B5G6R5_UNORM:Int                = 85
Const DXGI_FORMAT_B5G5R5A1_UNORM:Int              = 86
Const DXGI_FORMAT_B8G8R8A8_UNORM:Int              = 87
Const DXGI_FORMAT_B8G8R8X8_UNORM:Int              = 88
Const DXGI_FORMAT_R10G10B10_XR_BIAS_A2_UNORM:Int  = 89
Const DXGI_FORMAT_B8G8R8A8_TYPELESS:Int           = 90
Const DXGI_FORMAT_B8G8R8A8_UNORM_SRGB:Int         = 91
Const DXGI_FORMAT_B8G8R8X8_TYPELESS:Int           = 92
Const DXGI_FORMAT_B8G8R8X8_UNORM_SRGB:Int         = 93
Const DXGI_FORMAT_BC6H_TYPELESS:Int               = 94
Const DXGI_FORMAT_BC6H_UF16:Int                   = 95
Const DXGI_FORMAT_BC6H_SF16:Int                   = 96
Const DXGI_FORMAT_BC7_TYPELESS:Int                = 97
Const DXGI_FORMAT_BC7_UNORM:Int                   = 98
Const DXGI_FORMAT_BC7_UNORM_SRGB:Int              = 99
Const DXGI_FORMAT_FORCE_UINT:Int                  = $ffffffff

Const DXGI_MAX_SWAP_CHAIN_BUFFERS:Int     = 16
Const DXGI_PRESENT_TEST:Int               = $00000001
Const DXGI_PRESENT_DO_NOT_SEQUENCE:Int    = $00000002
Const DXGI_PRESENT_RESTART:Int            = $00000004

Const DXGI_ENUM_MODES_INTERLACED:Int = 1
Const DXGI_ENUM_MODES_SCALING:Int = 2

Type DXGI_MODE_DESC
	Field Width:Int
	Field Height:Int
  	Field RefreshRate_Numerator:Int
	Field RefreshRate_Denominator:Int
	Field Format:Int
	Field ScanlineOrdering:Int
	Field Scaling:Int
EndType

Type DXGI_FRAME_STATISTICS
	Field PresentCount:Int
	Field PresentRefreshCount:Int
	Field SyncRefreshCount:Int
	Field SyncQPCTime:Long
	Field SyncGPUTime:Long
EndType

Type DXGI_MAPPED_RECT
	Field Pitch:Int
	Field Bits:Byte Ptr
EndType

Type DXGI_ADAPTER_DESC
	Field Desc0:Short, Desc1:Int, Desc2:Int, Desc3:Int, Desc4:Int, Desc5:Int, Desc6:Int, Desc7:Int, Desc8:Int, Desc9:Int
	Field Desc10:Int, Desc11:Int, Desc12:Int, Desc13:Int, Desc14:Int, Desc15:Int, Desc16:Int, Desc17:Int, Desc18:Int, Desc19:Int
	Field Desc20:Int, Desc21:Int, Desc22:Int, Desc23:Int, Desc24:Int, Desc25:Int, Desc26:Int, Desc27:Int, Desc28:Int, Desc29:Int
	Field Desc30:Int, Desc31:Int, Desc32:Int, Desc33:Int, Desc34:Int, Desc35:Int, Desc36:Int, Desc37:Int, Desc38:Int, Desc39:Int
	Field Desc40:Int, Desc41:Int, Desc42:Int, Desc43:Int, Desc44:Int, Desc45:Int, Desc46:Int, Desc47:Int, Desc48:Int, Desc49:Int
	Field Desc50:Int, Desc51:Int, Desc52:Int, Desc53:Int, Desc54:Int, Desc55:Int, Desc56:Int, Desc57:Int, Desc58:Int, Desc59:Int
	Field Desc60:Int, Desc61:Int, Desc62:Int, Desc63:Int

	Field VendorID:Int
	Field DeviceID:Int
	Field SubSysID:Int
	Field Revision:Int
	Field DedicatedVideoMemory:Int
	Field DedicatedSystemMemory:Int
	Field SharedSystemMemory:Int
	Field LuidLow:Int
	Field LuidHigh:Int
	
	Method Description$()
		Return String.FromWString(Varptr Desc0)
	EndMethod
EndType

Type DXGI_OUTPUT_DESC
	Field DeviceName0:Short, DeviceName1:Int, DeviceName2:Int, DeviceName3:Int
	Field DeviceName4:Int, DeviceName5:Int, DeviceName6:Int, DeviceName7:Int
	Field DeviceName8:Short,DeviceName9:Short,DeviceName10:Short,DeviceName11:Short
	Field DeviceName12:Short,DeviceName13:Short,DeviceName14:Short,DeviceName15:Short
	Field DeviceName16:Short,DeviceName17:Short,DeviceName18:Short,DeviceName19:Short
	Field DeviceName20:Short,DeviceName21:Short,DeviceName22:Short,DeviceName23:Short
	Field DeviceName24:Short,DeviceName25:Short,DeviceName26:Short,DeviceName27:Short
	Field DeviceName28:Short,DeviceName29:Short,DeviceName30:Short,DeviceName31:Short
	
	
	Field DesktopCoordinates_Left:Int, DesktopCoordinates_Top:Int
	Field DesktopCoordinates_Right:Int, DesktopCoordinates_Bottom:Int
	Field AttachedToDesktop:Int
	Field Rotation:Int
	Field HMonitor:Int
	
	Method DeviceName$()
		Return String.FromWString(Varptr DeviceName0)
	EndMethod
EndType

Type DXGI_SHARED_RESOURCE
	Field Handle:Int
EndType

Const DXGI_RESOURCE_PRIORITY_MINIMUM:Int	= $28000000
Const DXGI_RESOURCE_PRIORITY_LOW:Int		= $50000000
Const DXGI_RESOURCE_PRIORITY_NORMAL:Int		= 78000000
Const DXGI_RESOURCE_PRIORITY_HIGH:Int		= $a0000000
Const DXGI_RESOURCE_PRIORITY_MAXIMUM:Int	= $c8000000

Const DXGI_RESIDENCY_FULLY_RESIDENT:Int 			= 1
Const DXGI_RESIDENCY_RESIDENT_IN_SHARED_MEMORY:Int	= 2
Const DXGI_RESIDENCY_EVICTED_TO_DISK:Int			= 3

Type DXGI_SURFACE_DESC
	Field Width:Int
	Field Height:Int
	Field Format:Int
	Field SampleDesc_Count:Int
	Field SampleDesc_Quality:Int
EndType

Const DXGI_SWAP_EFFECT_DISCARD:Int			= 0
Const DXGI_SWAP_EFFECT_SEQUENTIAL:Int		= 1
Const DXGI_SWAP_EFFECT_FLIP_SEQUENTIAL:Int	= 3
Const DXGI_SWAP_EFFECT_FLIP_DISCARD:Int		= 4

Const DXGI_SWAP_CHAIN_FLAG_NONPREROTATED:Int							= 1
Const DXGI_SWAP_CHAIN_FLAG_ALLOW_MODE_SWITCH:Int						= 2
Const DXGI_SWAP_CHAIN_FLAG_GDI_COMPATIBLE:Int							= 4
Const DXGI_SWAP_CHAIN_FLAG_RESTRICTED_CONTENT:Int						= 8
Const DXGI_SWAP_CHAIN_FLAG_RESTRICT_SHARED_RESOURCE_DRIVER:Int			= 16
Const DXGI_SWAP_CHAIN_FLAG_DISPLAY_ONLY:Int								= 32
Const DXGI_SWAP_CHAIN_FLAG_FRAME_LATENCY_WAITABLE_OBJECT:Int			= 64
Const DXGI_SWAP_CHAIN_FLAG_FOREGROUND_LAYER:Int							= 128
Const DXGI_SWAP_CHAIN_FLAG_FULLSCREEN_VIDEO:Int							= 256
Const DXGI_SWAP_CHAIN_FLAG_YUV_VIDEO:Int								= 512
Const DXGI_SWAP_CHAIN_FLAG_HW_PROTECTED:Int								= 1024
Const DXGI_SWAP_CHAIN_FLAG_ALLOW_TEARING:Int							= 2048
Const DXGI_SWAP_CHAIN_FLAG_RESTRICTED_TO_ALL_HOLOGRAPHIC_DISPLAYS:Int	= 4096


















