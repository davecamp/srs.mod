
SuperStrict

Const D3D11_SDK_VERSION:Int = 7

Const D3D11_CREATE_DEVICE_SINGLETHREADED:Int							= $1
Const D3D11_CREATE_DEVICE_DEBUG:Int										= $2
Const D3D11_CREATE_DEVICE_SWITCH_TO_REF:Int								= $4
Const D3D11_CREATE_DEVICE_PREVENT_INTERNAL_THREADING_OPTIMIZATIONS:Int	= $8
Const D3D11_CREATE_DEVICE_BGRA_SUPPORT:Int								= $20

Const D3D11_USAGE_DEFAULT:Int	= 0
Const D3D11_USAGE_IMMUTABLE:Int	= 1
Const D3D11_USAGE_DYNAMIC:Int	= 2
Const D3D11_USAGE_STAGING:Int	= 3

Const D3D11_DEFAULT_STENCIL_READ_MASK:Byte  = $FF
Const D3D11_DEFAULT_STENCIL_WRITE_MASK:Byte = $FF

Const D3D11_UAV_DIMENSION_UNKNOWN:Int         = 0
Const D3D11_UAV_DIMENSION_BUFFER:Int          = 1
Const D3D11_UAV_DIMENSION_TEXTURE1D:Int       = 2
Const D3D11_UAV_DIMENSION_TEXTURE1DARRAY:Int  = 3
Const D3D11_UAV_DIMENSION_TEXTURE2D:Int       = 4
Const D3D11_UAV_DIMENSION_TEXTURE2DARRAY:Int  = 5
Const D3D11_UAV_DIMENSION_TEXTURE3D:Int       = 8

Const D3D11_DSV_DIMENSION_UNKNOWN:Int            = 0
Const D3D11_DSV_DIMENSION_TEXTURE1D:Int          = 1
Const D3D11_DSV_DIMENSION_TEXTURE1DARRAY:Int     = 2
Const D3D11_DSV_DIMENSION_TEXTURE2D:Int          = 3
Const D3D11_DSV_DIMENSION_TEXTURE2DARRAY:Int     = 4
Const D3D11_DSV_DIMENSION_TEXTURE2DMS:Int        = 5
Const D3D11_DSV_DIMENSION_TEXTURE2DMSARRAY:Int   = 6 

Const D3D11_BIND_VERTEX_BUFFER:Int		= $1
Const D3D11_BIND_INDEX_BUFFER:Int		= $2
Const D3D11_BIND_CONSTANT_BUFFER:Int	= $4
Const D3D11_BIND_SHADER_RESOURCE:Int	= $8
Const D3D11_BIND_STREAM_OUTPUT:Int		= $10
Const D3D11_BIND_RENDER_TARGET:Int		= $20
Const D3D11_BIND_DEPTH_STENCIL:Int		= $40
Const D3D11_BIND_UNORDERED_ACCESS:Int 	= $80

Const D3D11_CPU_ACCESS_WRITE:Int	= $10000
Const D3D11_CPU_ACCESS_READ:Int	= $20000

Const D3D11_MAP_READ:Int = 1
Const D3D11_MAP_WRITE:Int = 2
Const D3D11_MAP_READ_WRITE:Int = 3
Const D3D11_MAP_WRITE_DISCARD:Int = 4
Const D3D11_MAP_WRITE_NO_OVERWRITE:Int = 5
Const D3D11_MAP_FLAG_DO_NOT_WAIT:Int = $100000

Const D3D11_INPUT_PER_VERTEX_DATA:Int     = 0
Const D3D11_INPUT_PER_INSTANCE_DATA:Int   = 1 

Const D3D11_APPEND_ALIGNED_ELEMENT:Int = $ffffffff
Const D3D11_FLOAT32_MAX# = 340282346638528860000000000000000000000.0

Const D3D11_FILTER_MIN_MAG_MIP_POINT:Int                            = 0
Const D3D11_FILTER_MIN_MAG_POINT_MIP_LINEAR:Int                     = $1
Const D3D11_FILTER_MIN_POINT_MAG_LINEAR_MIP_POINT:Int               = $4
Const D3D11_FILTER_MIN_POINT_MAG_MIP_LINEAR:Int                     = $5
Const D3D11_FILTER_MIN_LINEAR_MAG_MIP_POINT:Int                     = $10
Const D3D11_FILTER_MIN_LINEAR_MAG_POINT_MIP_LINEAR:Int              = $11
Const D3D11_FILTER_MIN_MAG_LINEAR_MIP_POINT:Int                     = $14
Const D3D11_FILTER_MIN_MAG_MIP_LINEAR:Int                           = $15
Const D3D11_FILTER_ANISOTROPIC:Int                                  = $55
Const D3D11_FILTER_COMPARISON_MIN_MAG_MIP_POINT:Int                 = $80
Const D3D11_FILTER_COMPARISON_MIN_MAG_POINT_MIP_LINEAR:Int          = $81
Const D3D11_FILTER_COMPARISON_MIN_POINT_MAG_LINEAR_MIP_POINT:Int    = $84
Const D3D11_FILTER_COMPARISON_MIN_POINT_MAG_MIP_LINEAR:Int          = $85
Const D3D11_FILTER_COMPARISON_MIN_LINEAR_MAG_MIP_POINT:Int          = $90
Const D3D11_FILTER_COMPARISON_MIN_LINEAR_MAG_POINT_MIP_LINEAR:Int   = $91
Const D3D11_FILTER_COMPARISON_MIN_MAG_LINEAR_MIP_POINT:Int          = $94
Const D3D11_FILTER_COMPARISON_MIN_MAG_MIP_LINEAR :Int               = $95
Const D3D11_FILTER_COMPARISON_ANISOTROPIC:Int                       = $d5
Const D3D11_FILTER_TEXT_1BIT:Int                                    = $80000000 

Const D3D11_TEXTURE_ADDRESS_WRAP:Int          = 1
Const D3D11_TEXTURE_ADDRESS_MIRROR:Int        = 2
Const D3D11_TEXTURE_ADDRESS_CLAMP:Int         = 3
Const D3D11_TEXTURE_ADDRESS_BORDER:Int        = 4
Const D3D11_TEXTURE_ADDRESS_MIRROR_ONCE:Int   = 5

Const D3D11_COMPARISON_NEVER:Int           = 1
Const D3D11_COMPARISON_LESS:Int            = 2
Const D3D11_COMPARISON_EQUAL:Int           = 3
Const D3D11_COMPARISON_LESS_EQUAL:Int      = 4
Const D3D11_COMPARISON_GREATER:Int         = 5
Const D3D11_COMPARISON_NOT_EQUAL:Int       = 6
Const D3D11_COMPARISON_GREATER_EQUAL:Int   = 7
Const D3D11_COMPARISON_ALWAYS:Int          = 8

Const D3D11_DEPTH_WRITE_MASK_ZERO:Int	= 0
Const D3D11_DEPTH_WRITE_MASK_ALL:Int	= 1

Const D3D11_CLEAR_DEPTH:Int     = 1
Const D3D11_CLEAR_STENCIL:Int   = 2

Const D3D11_STENCIL_OP_KEEP:Int	= 1
Const D3D11_STENCIL_OP_ZERO:Int	= 2
Const D3D11_STENCIL_OP_REPLACE:Int	= 3
Const D3D11_STENCIL_OP_INCR_SAT:Int	= 4
Const D3D11_STENCIL_OP_DECR_SAT:Int	= 5
Const D3D11_STENCIL_OP_INVERT:Int	= 6
Const D3D11_STENCIL_OP_INCR:Int	= 7
Const D3D11_STENCIL_OP_DECR:Int	= 8

Const D3D11_FILL_WIREFRAME:Int   = 2
Const D3D11_FILL_SOLID:Int       = 3

Const D3D11_CULL_NONE:Int    = 1
Const D3D11_CULL_FRONT:Int   = 2
Const D3D11_CULL_BACK:Int    = 3 

Const D3D11_BLEND_ZERO:Int               = 1
Const D3D11_BLEND_ONE:Int                = 2
Const D3D11_BLEND_SRC_COLOR:Int          = 3
Const D3D11_BLEND_INV_SRC_COLOR:Int      = 4
Const D3D11_BLEND_SRC_ALPHA:Int          = 5
Const D3D11_BLEND_INV_SRC_ALPHA:Int      = 6
Const D3D11_BLEND_DEST_ALPHA:Int         = 7
Const D3D11_BLEND_INV_DEST_ALPHA:Int     = 8
Const D3D11_BLEND_DEST_COLOR:Int         = 9
Const D3D11_BLEND_INV_DEST_COLOR:Int     = 10
Const D3D11_BLEND_SRC_ALPHA_SAT:Int      = 11
Const D3D11_BLEND_BLEND_FACTOR:Int       = 14
Const D3D11_BLEND_INV_BLEND_FACTOR:Int   = 15
Const D3D11_BLEND_SRC1_COLOR:Int         = 16
Const D3D11_BLEND_INV_SRC1_COLOR:Int     = 17
Const D3D11_BLEND_SRC1_ALPHA:Int         = 18
Const D3D11_BLEND_INV_SRC1_ALPHA:Int     = 19

Const D3D11_BLEND_OP_ADD:Int            = 1
Const D3D11_BLEND_OP_SUBTRACT:Int       = 2
Const D3D11_BLEND_OP_REV_SUBTRACT:Int   = 3
Const D3D11_BLEND_OP_MIN:Int            = 4
Const D3D11_BLEND_OP_MAX:Int            = 5

Const D3D11_COLOR_WRITE_ENABLE_RED:Int     = 1
Const D3D11_COLOR_WRITE_ENABLE_GREEN:Int   = 2
Const D3D11_COLOR_WRITE_ENABLE_BLUE:Int    = 4
Const D3D11_COLOR_WRITE_ENABLE_ALPHA:Int   = 8
Const D3D11_COLOR_WRITE_ENABLE_ALL:Int     = 15

Const D3D11_QUERY_EVENT:Int                   = 0
Const D3D11_QUERY_OCCLUSION:Int               = 1
Const D3D11_QUERY_TIMESTAMP:Int               = 2
Const D3D11_QUERY_TIMESTAMP_DISJOINT:Int      = 3
Const D3D11_QUERY_PIPELINE_STATISTICS:Int     = 4
Const D3D11_QUERY_OCCLUSION_PREDICATE:Int     = 5
Const D3D11_QUERY_SO_STATISTICS:Int           = 6
Const D3D11_QUERY_SO_OVERFLOW_PREDICATE:Int   = 7
Const D3D11_QUERY_SO_STATISTICS_STREAM0:Int	= 8
Const D3D11_QUERY_SO_OVERFLOW_PREDICATE_STREAM0:Int	= 9
Const D3D11_QUERY_SO_STATISTICS_STREAM1:Int	= 10
Const D3D11_QUERY_SO_OVERFLOW_PREDICATE_STREAM1:Int	= 11
Const D3D11_QUERY_SO_STATISTICS_STREAM2:Int	= 12
Const D3D11_QUERY_SO_OVERFLOW_PREDICATE_STREAM2:Int	= 13
Const D3D11_QUERY_SO_STATISTICS_STREAM3:Int	= 14
Const D3D11_QUERY_SO_OVERFLOW_PREDICATE_STREAM3:Int	= 15 

Const D3D11_COUNTER_DEVICE_DEPENDENT_0:Int = $40000000 

Const D3D11_FEATURE_THREADING:Int                  = 0
Const D3D11_FEATURE_DOUBLES:Int                    = ( D3D11_FEATURE_THREADING + 1 )
Const D3D11_FEATURE_FORMAT_SUPPORT:Int             = ( D3D11_FEATURE_DOUBLES + 1 )
Const D3D11_FEATURE_FORMAT_SUPPORT2:Int            = ( D3D11_FEATURE_FORMAT_SUPPORT + 1 )
Const D3D11_FEATURE_D3D10_X_HARDWARE_OPTIONS:Int   = ( D3D11_FEATURE_FORMAT_SUPPORT2 + 1 )

Const D3D11_FORMAT_SUPPORT_BUFFER:Int                        = $1
Const D3D11_FORMAT_SUPPORT_IA_VERTEX_BUFFER:Int              = $2
Const D3D11_FORMAT_SUPPORT_IA_INDEX_BUFFER:Int               = $4
Const D3D11_FORMAT_SUPPORT_SO_BUFFER:Int                     = $8
Const D3D11_FORMAT_SUPPORT_TEXTURE1D:Int                     = $10
Const D3D11_FORMAT_SUPPORT_TEXTURE2D:Int                     = $20
Const D3D11_FORMAT_SUPPORT_TEXTURE3D:Int                     = $40
Const D3D11_FORMAT_SUPPORT_TEXTURECUBE:Int                   = $80
Const D3D11_FORMAT_SUPPORT_SHADER_LOAD:Int                   = $100
Const D3D11_FORMAT_SUPPORT_SHADER_SAMPLE:Int                 = $200
Const D3D11_FORMAT_SUPPORT_SHADER_SAMPLE_COMPARISON:Int      = $400
Const D3D11_FORMAT_SUPPORT_SHADER_SAMPLE_MONO_TEXT:Int       = $800
Const D3D11_FORMAT_SUPPORT_MIP:Int                           = $1000
Const D3D11_FORMAT_SUPPORT_MIP_AUTOGEN:Int                   = $2000
Const D3D11_FORMAT_SUPPORT_RENDER_TARGET:Int                 = $4000
Const D3D11_FORMAT_SUPPORT_BLENDABLE:Int                     = $8000
Const D3D11_FORMAT_SUPPORT_DEPTH_STENCIL:Int                 = $10000
Const D3D11_FORMAT_SUPPORT_CPU_LOCKABLE:Int                  = $20000
Const D3D11_FORMAT_SUPPORT_MULTISAMPLE_RESOLVE:Int           = $40000
Const D3D11_FORMAT_SUPPORT_DISPLAY:Int                       = $80000
Const D3D11_FORMAT_SUPPORT_CAST_WITHIN_BIT_LAYOUT:Int        = $100000
Const D3D11_FORMAT_SUPPORT_MULTISAMPLE_RENDERTARGET:Int      = $200000
Const D3D11_FORMAT_SUPPORT_MULTISAMPLE_LOAD :Int             = $400000
Const D3D11_FORMAT_SUPPORT_SHADER_GATHER:Int                 = $800000
Const D3D11_FORMAT_SUPPORT_BACK_BUFFER_CAST:Int              = $1000000
Const D3D11_FORMAT_SUPPORT_TYPED_UNORDERED_ACCESS_VIEW:Int   = $2000000
Const D3D11_FORMAT_SUPPORT_SHADER_GATHER_COMPARISON:Int      = $4000000 

Const D3D11_FORMAT_SUPPORT2_UAV_ATOMIC_ADD:Int                                 = $1
Const D3D11_FORMAT_SUPPORT2_UAV_ATOMIC_BITWISE_OPS:Int                         = $2
Const D3D11_FORMAT_SUPPORT2_UAV_ATOMIC_COMPARE_STORE_OR_COMPARE_EXCHANGE:Int   = $4
Const D3D11_FORMAT_SUPPORT2_UAV_ATOMIC_EXCHANGE:Int                            = $8
Const D3D11_FORMAT_SUPPORT2_UAV_ATOMIC_SIGNED_MIN_OR_MAX:Int                   = $10
Const D3D11_FORMAT_SUPPORT2_UAV_ATOMIC_UNSIGNED_MIN_OR_MAX:Int                 = $20
Const D3D11_FORMAT_SUPPORT2_UAV_TYPED_LOAD:Int                                 = $40
Const D3D11_FORMAT_SUPPORT2_UAV_TYPED_STORE:Int                                = $80 

Const D3D11_RESOURCE_MISC_GENERATE_MIPS:Int            = $1
Const D3D11_RESOURCE_MISC_SHARED:Int                   = $2
Const D3D11_RESOURCE_MISC_TEXTURECUBE:Int              = $4
Const D3D11_RESOURCE_MISC_DRAWINDIRECT_ARGS:Int        = $10
Const D3D11_RESOURCE_MISC_BUFFER_ALLOW_RAW_VIEWS:Int   = $20
Const D3D11_RESOURCE_MISC_BUFFER_STRUCTURED:Int        = $40
Const D3D11_RESOURCE_MISC_RESOURCE_CLAMP:Int           = $80
Const D3D11_RESOURCE_MISC_SHARED_KEYEDMUTEX:Int        = $100
Const D3D11_RESOURCE_MISC_GDI_COMPATIBLE:Int           = $200 

Function D3D11CalcSubresource:Int(MipSlice:Int, ArraySlice:Int, MipLevels:int)
	Return MipSlice+(ArraySlice*MipLevels)
EndFunction

Type D3D11_BUFFER_DESC
	Field ByteWidth:Int
	Field Usage:Int
	Field BindFlags:Int
  	Field CPUAccessFlags:Int
	Field MiscFlags:Int
	Field StructureByteStride:Int
EndType

Type D3D11_SUBRESOURCE_DATA
	Field pSysMem:Byte Ptr
	Field SysMemPitch:Int
	Field SysMemSlicePitch:Int
EndType

Type D3D11_TEXTURE1D_DESC
	Field Width:Int
	Field MipLevels:Int
	Field ArraySize:Int
	Field Format:Int
	Field Usage:Int
	Field BindFlags:Int
	Field CPUAccessFlags:Int
	Field MiscFlags:Int
EndType

Type D3D11_TEXTURE2D_DESC
	Field Width:Int
	Field Height:Int
	Field MipLevels:Int
	Field ArraySize:Int
	Field Format:Int
	Field SampleDesc_Count:Int
	Field SampleDesc_Quality:Int
	Field Usage:Int
	Field BindFlags:Int
	Field CPUAccessFlags:Int
	Field MiscFlags:Int
EndType

Type D3D11_TEXTURE3D_DESC
	Field Width:Int
	Field Height:Int
	Field Depth:Int
	Field MipLevels:Int
	Field Format:Int
	Field Usage:Int
	Field BindFlags:Int
	Field CPUAccessFlags:Int
	Field MiscFlags:Int
EndType

Type D3D11_VIEWPORT
	Field TopLeftX#
	Field TopLeftY#
	Field Width#
	Field Height#
	Field MinDepth#
	Field MaxDepth#
EndType

Type D3D11_INPUT_ELEMENT_DESC
	Field SemanticName:Byte Ptr
	Field SemanticIndex:Int
	Field Format:Int
	Field InputSlot:Int
	Field AlignedByteOffset:Int
	Field InputSlotClass:Int
	Field InstanceDataStepRate:Int
EndType

Type D3D11_SAMPLER_DESC
	Field Filter:Int
	Field AddressU:Int
	Field AddressV:Int
	Field AddressW:Int
	Field MipLODBias#
	Field MaxAnisotropy:Int
	Field ComparisonFunc:Int
	Field BorderColor0#
	Field BorderColor1#
	Field BorderColor2#
	Field BorderColor3#
	Field MinLOD#
	Field MaxLOD#
EndType

Type D3D11_RASTERIZER_DESC
	Field FillMode:Int
	Field CullMode:Int
	Field FrontCounterClockwise:Int
	Field DepthBias:Int
	Field DepthBiasClamp#
	Field SlopeScaledDepthBias#
	Field DepthClipEnable:Int
	Field ScissorEnable:Int
	Field MultisampleEnable:Int
	Field AntialiasedLineEnable:Int
EndType

Type D3D11_BLEND_DESC
	Field AlphaToCoverageEnable:Int
	Field IndependentBlendEnable:Int
	Field RenderTarget0_BlendEnable:Int
	Field RenderTarget0_SrcBlend:Int
	Field RenderTarget0_DestBlend:Int
	Field RenderTarget0_BlendOp:Int
	Field RenderTarget0_SrcBlendAlpha:Int
	Field RenderTarget0_DestBlendAlpha:Int
	Field RenderTarget0_BlendOpAlpha:Int
	Field RenderTarget0_RenderTargetWriteMask:Int
	Field RenderTarget1_BlendEnable:Int
	Field RenderTarget1_SrcBlend:Int
	Field RenderTarget1_DestBlend:Int
	Field RenderTarget1_BlendOp:Int
	Field RenderTarget1_SrcBlendAlpha:Int
	Field RenderTarget1_DestBlendAlpha:Int
	Field RenderTarget1_BlendOpAlpha:Int
	Field RenderTarget1_RenderTargetWriteMask:Int
	Field RenderTarget2_BlendEnable:Int
	Field RenderTarget2_SrcBlend:Int
	Field RenderTarget2_DestBlend:Int
	Field RenderTarget2_BlendOp:Int
	Field RenderTarget2_SrcBlendAlpha:Int
	Field RenderTarget2_DestBlendAlpha:Int
	Field RenderTarget2_BlendOpAlpha:Int
	Field RenderTarget2_RenderTargetWriteMask:Int
	Field RenderTarget3_BlendEnable:Int
	Field RenderTarget3_SrcBlend:Int
	Field RenderTarget3_DestBlend:Int
	Field RenderTarget3_BlendOp:Int
	Field RenderTarget3_SrcBlendAlpha:Int
	Field RenderTarget3_DestBlendAlpha:Int
	Field RenderTarget3_BlendOpAlpha:Int
	Field RenderTarget3_RenderTargetWriteMask:Int
	Field RenderTarget4_BlendEnable:Int
	Field RenderTarget4_SrcBlend:Int
	Field RenderTarget4_DestBlend:Int
	Field RenderTarget4_BlendOp:Int
	Field RenderTarget4_SrcBlendAlpha:Int
	Field RenderTarget4_DestBlendAlpha:Int
	Field RenderTarget4_BlendOpAlpha:Int
	Field RenderTarget4_RenderTargetWriteMask:Int
	Field RenderTarget5_BlendEnable:Int
	Field RenderTarget5_SrcBlend:Int
	Field RenderTarget5_DestBlend:Int
	Field RenderTarget5_BlendOp:Int
	Field RenderTarget5_SrcBlendAlpha:Int
	Field RenderTarget5_DestBlendAlpha:Int
	Field RenderTarget5_BlendOpAlpha:Int
	Field RenderTarget5_RenderTargetWriteMask:Int
	Field RenderTarget6_BlendEnable:Int
	Field RenderTarget6_SrcBlend:Int
	Field RenderTarget6_DestBlend:Int
	Field RenderTarget6_BlendOp:Int
	Field RenderTarget6_SrcBlendAlpha:Int
	Field RenderTarget6_DestBlendAlpha:Int
	Field RenderTarget6_BlendOpAlpha:Int
	Field RenderTarget6_RenderTargetWriteMask:Int
	Field RenderTarget7_BlendEnable:Int
	Field RenderTarget7_SrcBlend:Int
	Field RenderTarget7_DestBlend:Int
	Field RenderTarget7_BlendOp:Int
	Field RenderTarget7_SrcBlendAlpha:Int
	Field RenderTarget7_DestBlendAlpha:Int
	Field RenderTarget7_BlendOpAlpha:Int
	Field RenderTarget7_RenderTargetWriteMask:Int
EndType

Type D3D11_DEPTH_STENCIL_DESC
	Field DepthEnable:Int
	Field DepthWriteMask:Int
	Field DepthFunc:Int
	Field StencilEnable:Int
	Field StencilReadMask:Int
	Field StencilWriteMask:Int
	Field FrontFace_StencilFailOp:Int
	Field FrontFace_StencilDepthFailOp:Int
	Field FrontFace_StencilPassOp:Int
	Field FrontFace_StencilFunc:Int
	Field BackFace_StencilFailOp:Int
	Field BackFace_StencilDepthFailOp:Int
	Field BackFace_StencilPassOp:Int
	Field BackFace_StencilFunc:Int
EndType

Type D3D11_DEPTH_STENCIL_VIEW_DESC
	Field Format:Int
	Field ViewDimension:Int
	Field Flags:Int
	Field Texture_MipSlice:Int
	Field Texture_FirstArraySlice:Int
	Field Texture_ArraySize:Int
EndType

Type D3D11_QUERY_DESC
	Field Query:Int
	Field MiscFlags:Int
EndType

Type D3D11_SO_DECLARATION_ENTRY
	Field Stream:Int
	Field SemanticName:Byte Ptr
	Field SemanticIndex:Int
	Field StartComponent:Byte
	Field ComponentCount:Byte
	Field OutputSlot:Byte
EndType

Type D3D11_QUERY_DATA_TIMESTAMP_DISJOINT
	Field Frequency:Long
	Field Disjoint:Int
EndType

Type D3D11_QUERY_DATA_PIPELINE_STATISTICS
	Field IAVertices:Long
	Field IAPrimitives:Long
	Field VSInvocations:Long
	Field GSInvocations:Long
	Field GSPrimitives:Long
	Field CInvocations:Long
	Field CPrimitives:Long
	Field PSInvocations:Long
	Field HSInvocations:Long
	Field DSInvocations:Long
	Field CSInvocations:Long
EndType

Type D3D11_COUNTER_DESC
	Field Counter:Int
	Field MiscFlags:Int
EndType

Type D3D11_COUNTER_INFO
	Field LastDeviceDependantCounter:Int
	Field NumSimultaneousCounters:Int
	Field NumDetectableParallelUnits:Int
EndType

Type D3D11_MAPPED_SUBRESOURCE
	Field pData:Byte Ptr
	Field RowPitch:Int
	Field DepthPitch:Int
EndType

Type D3D11_SHADER_RESOURCE_VIEW_DESC
	Field Format:Int
 	Field ViewDimension:Int
	Field Texture_MostDetailedMip:Int
	Field Texture_MipLevels:Int
	Field Texture_FirstArraySlice:Int
	Field Texture_ArraySize:Int
	Field ElementOffset:Int Ptr=Varptr Texture_MostDetailedMip
	Field ElementWidth:Int Ptr=Varptr Texture_MipLevels
EndType

Type D3D11_RENDER_TARGET_VIEW_DESC
	Field Format:Int
	Field ViewDimension:Int
	Field Texture_MipSlice:Int
EndType

Type D3D11_FEATURE_DATA_THREADING
	Field DriverConCurrentCreates:Int
	Field DriverCommandLists:Int
EndType

Type D3D11_FEATURE_DATA_DOUBLES
 	Field DoublePrecisionFloatShaderOps:Int
EndType

Type D3D11_FEATURE_DATA_D3D10_X_HARDWARE_OPTIONS
  Field ComputeShaders_Plus_RawAndStructuredBuffers_Via_Shader_4_x:Int
EndType

Type D3D11_FEATURE_DATA_FORMAT_SUPPORT
	Field InFormat:Int
	Field OutFormatSupport:Int
EndType

Type D3D11_UNORDERED_ACCESS_VIEW_DESC
	Rem
	use either
		D3D11_UNORDERED_ACCESS_VIEW_TEXTURE_DESC
	or
		D3D11_UNORDERED_ACCESS_VIEW_BUFFER_DESC
	EndRem
EndType

Type D3D11_UNORDERED_ACCESS_VIEW_TEXTURE_DESC
	Field Format:Int
	Field ViewDimension:Int
	Field Texture_MipSlice:Int
	Field Texture_FirstArraySlice:Int
	Field Texture_ArraySize:Int
EndType

Type D3D11_UNORDERED_ACCESS_VIEW_BUFFER_DESC
	Field Format:Int
	Field ViewDimension:Int
	Field FirstElement:Int
	Field NumElements:Int
	Field Flags:Int
EndType

Global IID_ID3D11DeviceChild:Int[]			=[$1841e5c8,$489b16b0,$cf44c8bc,$aeded5b0]
Global IID_ID3D11DepthStencilState:Int[]	=[$03823efb,$4e1c8d8f,$4bf6a29a,$f1fdcbb2]
Global IID_ID3D11BlendState:Int[]			=[$75b68faa,$4159347d,$64a0458f,$9acd010f]
Global IID_ID3D11RasterizerState:Int[]		=[$9bb4ab81,$4d8fab1a,$04fc06b5,$e76e0b20]
Global IID_ID3D11Resource:Int[]				=[$dc8e63f3,$4952d12b,$455e7bb4,$2d866a02]
Global IID_ID3D11Buffer:Int[]				=[$48570b85,$4fcdd1ee,$35eb50a2,$37b02207]
Global IID_ID3D11Texture1D:Int[]			=[$f8fb5c27,$4f75c6b3,$9a43c8a4,$4c56eff2]
Global IID_ID3D11Texture2D:Int[]			=[$6f15aaf2,$4e89d208,$9548b49a,$9c4fd335]
Global IID_ID3D11Texture3D:Int[]			=[$037e866e,$4357f56d,$ab9dafa8,$0e256ebe]
Global IID_ID3D11View:Int[]					=[$839d1216,$412bbb2e,$dba9f4b7,$d18ee0eb]
Global IID_ID3D11ShaderResourceView:Int[]	=[$b0e06fe0,$4e1a8192,$d736cab1,$b2104741]
Global IID_ID3D11RenderTargetView:Int[]		=[$dfdba067,$48650b8d,$b4d75b87,$64c16c51]
Global IID_ID3D11DepthStencilView:Int[]		=[$9fdac92a,$48c31876,$b925adaf,$b6a9844f]
Global IID_ID3D11UnorderedAccessView:Int[]	=[$28acf509,$48f67f5c,$16f31186,$80630a01]
Global IID_ID3D11VertexShader:Int[]			=[$3b301d64,$4289d678,$f8229788,$f3728b92]
Global IID_ID3D11HullShader:Int[]			=[$8e5c6061,$4c8e628a,$5ce4bb64,$ddd5b35c]
Global IID_ID3D11DomainShader:Int[]			=[$f582c508,$490c0f36,$ee317799,$fa8c26ce]
Global IID_ID3D11GeometryShader:Int[]		=[$38325b96,$4022effb,$792e02ba,$5c27705b]
Global IID_ID3D11PixelShader:Int[]			=[$ea82e40d,$4f3351dc,$7cdbd493,$8cae2591]
Global IID_ID3D11ComputeShader:Int[]		=[$4f5b196e,$495ec2bd,$de1f01bd,$69498ed3]
Global IID_ID3D11InputLayout:Int[]			=[$e4819ddc,$40254cf0,$e85d26bd,$b7073e2a]
Global IID_ID3D11SamplerState:Int[]			=[$da6fea51,$4487564c,$d0f01098,$a5e3b4f9]
Global IID_ID3D11Asynchronous:Int[]			=[$4b35d0cd,$45281e15,$131b989c,$3bddf633]
Global IID_ID3D11Query:Int[]				=[$d6c00747,$425e87b7,$d1444db8,$fd0a5608]
Global IID_ID3D11Predicate:Int[]			=[$9eb576dd,$4d869f77,$ab8baa81,$e290e45f]
Global IID_ID3D11Counter:Int[]				=[$6e8c49fb,$4770a371,$082940b4,$41b72260]
Global IID_ID3D11ClassInstance:Int[]		=[$a6cd7faa,$4a2fb0b7,$62863694,$cb9757a6]
Global IID_ID3D11ClassLinkage:Int[]			=[$ddf57cba,$46e49543,$07f22ba1,$ed7ffea0]
Global IID_ID3D11CommandList:Int[]			=[$a24bc4d1,$43f7769e,$ff981380,$e2186c56]
Global IID_ID3D11DeviceContext:Int[]		=[$c0bfa96c,$44fbe089,$f826af8e,$da906179]
Global IID_ID3D11Device:Int[]				=[$db6f6ddb,$4e88ac77,$9d815382,$40f1bbf9]

'11 : db6f6ddb-ac77-4e88-8253-819d f9bb f140
'10 : 9B7E4C00-342C-4106-A19F-4F27 04F6 89F0
Global IID_ID3D10Device:Int[]				=[$9b7e4c00,$4106342c,$274f9fa1,$f089f604]
Global IID_ID3D10Device1:Int[]				=[$9b7e4c8f,$4106342c,$274f9fa1,$f089f604]
