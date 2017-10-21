
Strict

Const D3D11_SDK_VERSION = 7

Const D3D11_CREATE_DEVICE_SINGLETHREADED	= $1
Const D3D11_CREATE_DEVICE_DEBUG	= $2
Const D3D11_CREATE_DEVICE_SWITCH_TO_REF	= $4
Const D3D11_CREATE_DEVICE_PREVENT_INTERNAL_THREADING_OPTIMIZATIONS	= $8
Const D3D11_CREATE_DEVICE_BGRA_SUPPORT	= $20

Const D3D11_USAGE_DEFAULT	= 0
Const D3D11_USAGE_IMMUTABLE	= 1
Const D3D11_USAGE_DYNAMIC	= 2
Const D3D11_USAGE_STAGING	= 3

Const D3D11_DEFAULT_STENCIL_READ_MASK:Byte = $FF
Const D3D11_DEFAULT_STENCIL_WRITE_MASK:Byte = $FF

Const D3D11_UAV_DIMENSION_UNKNOWN         = 0
Const D3D11_UAV_DIMENSION_BUFFER          = 1
Const D3D11_UAV_DIMENSION_TEXTURE1D       = 2
Const D3D11_UAV_DIMENSION_TEXTURE1DARRAY  = 3
Const D3D11_UAV_DIMENSION_TEXTURE2D       = 4
Const D3D11_UAV_DIMENSION_TEXTURE2DARRAY  = 5
Const D3D11_UAV_DIMENSION_TEXTURE3D       = 8

Const D3D11_DSV_DIMENSION_UNKNOWN            = 0
Const D3D11_DSV_DIMENSION_TEXTURE1D          = 1
Const D3D11_DSV_DIMENSION_TEXTURE1DARRAY     = 2
Const D3D11_DSV_DIMENSION_TEXTURE2D          = 3
Const D3D11_DSV_DIMENSION_TEXTURE2DARRAY     = 4
Const D3D11_DSV_DIMENSION_TEXTURE2DMS        = 5
Const D3D11_DSV_DIMENSION_TEXTURE2DMSARRAY   = 6 

Const D3D11_BIND_VERTEX_BUFFER	= $1
Const D3D11_BIND_INDEX_BUFFER	= $2
Const D3D11_BIND_CONSTANT_BUFFER	= $4
Const D3D11_BIND_SHADER_RESOURCE	= $8
Const D3D11_BIND_STREAM_OUTPUT	= $10
Const D3D11_BIND_RENDER_TARGET	= $20
Const D3D11_BIND_DEPTH_STENCIL	= $40
Const D3D11_BIND_UNORDERED_ACCESS = $80

Const D3D11_CPU_ACCESS_WRITE	= $10000
Const D3D11_CPU_ACCESS_READ	= $20000

Const D3D11_MAP_READ = 1
Const D3D11_MAP_WRITE = 2
Const D3D11_MAP_READ_WRITE = 3
Const D3D11_MAP_WRITE_DISCARD = 4
Const D3D11_MAP_WRITE_NO_OVERWRITE = 5
Const D3D11_MAP_FLAG_DO_NOT_WAIT = $100000

Const D3D11_INPUT_PER_VERTEX_DATA     = 0
Const D3D11_INPUT_PER_INSTANCE_DATA   = 1 

Const D3D11_APPEND_ALIGNED_ELEMENT = $ffffffff
Const D3D11_FLOAT32_MAX# = 340282346638528860000000000000000000000.0

Const D3D11_FILTER_MIN_MAG_MIP_POINT                            = 0
Const D3D11_FILTER_MIN_MAG_POINT_MIP_LINEAR                     = $1
Const D3D11_FILTER_MIN_POINT_MAG_LINEAR_MIP_POINT               = $4
Const D3D11_FILTER_MIN_POINT_MAG_MIP_LINEAR                     = $5
Const D3D11_FILTER_MIN_LINEAR_MAG_MIP_POINT                     = $10
Const D3D11_FILTER_MIN_LINEAR_MAG_POINT_MIP_LINEAR              = $11
Const D3D11_FILTER_MIN_MAG_LINEAR_MIP_POINT                     = $14
Const D3D11_FILTER_MIN_MAG_MIP_LINEAR                           = $15
Const D3D11_FILTER_ANISOTROPIC                                  = $55
Const D3D11_FILTER_COMPARISON_MIN_MAG_MIP_POINT                 = $80
Const D3D11_FILTER_COMPARISON_MIN_MAG_POINT_MIP_LINEAR          = $81
Const D3D11_FILTER_COMPARISON_MIN_POINT_MAG_LINEAR_MIP_POINT    = $84
Const D3D11_FILTER_COMPARISON_MIN_POINT_MAG_MIP_LINEAR          = $85
Const D3D11_FILTER_COMPARISON_MIN_LINEAR_MAG_MIP_POINT          = $90
Const D3D11_FILTER_COMPARISON_MIN_LINEAR_MAG_POINT_MIP_LINEAR   = $91
Const D3D11_FILTER_COMPARISON_MIN_MAG_LINEAR_MIP_POINT          = $94
Const D3D11_FILTER_COMPARISON_MIN_MAG_MIP_LINEAR                = $95
Const D3D11_FILTER_COMPARISON_ANISOTROPIC                       = $d5
Const D3D11_FILTER_TEXT_1BIT                                    = $80000000 

Const D3D11_TEXTURE_ADDRESS_WRAP          = 1
Const D3D11_TEXTURE_ADDRESS_MIRROR        = 2
Const D3D11_TEXTURE_ADDRESS_CLAMP         = 3
Const D3D11_TEXTURE_ADDRESS_BORDER        = 4
Const D3D11_TEXTURE_ADDRESS_MIRROR_ONCE   = 5

Const D3D11_COMPARISON_NEVER           = 1
Const D3D11_COMPARISON_LESS            = 2
Const D3D11_COMPARISON_EQUAL           = 3
Const D3D11_COMPARISON_LESS_EQUAL      = 4
Const D3D11_COMPARISON_GREATER         = 5
Const D3D11_COMPARISON_NOT_EQUAL       = 6
Const D3D11_COMPARISON_GREATER_EQUAL   = 7
Const D3D11_COMPARISON_ALWAYS          = 8

Const D3D11_DEPTH_WRITE_MASK_ZERO	= 0
Const D3D11_DEPTH_WRITE_MASK_ALL	= 1

Const D3D11_CLEAR_DEPTH     = 1
Const D3D11_CLEAR_STENCIL   = 2

Const D3D11_STENCIL_OP_KEEP	= 1
Const D3D11_STENCIL_OP_ZERO	= 2
Const D3D11_STENCIL_OP_REPLACE	= 3
Const D3D11_STENCIL_OP_INCR_SAT	= 4
Const D3D11_STENCIL_OP_DECR_SAT	= 5
Const D3D11_STENCIL_OP_INVERT	= 6
Const D3D11_STENCIL_OP_INCR	= 7
Const D3D11_STENCIL_OP_DECR	= 8

Const D3D11_FILL_WIREFRAME   = 2
Const D3D11_FILL_SOLID       = 3

Const D3D11_CULL_NONE    = 1
Const D3D11_CULL_FRONT   = 2
Const D3D11_CULL_BACK    = 3 

Const D3D11_BLEND_ZERO               = 1
Const D3D11_BLEND_ONE                = 2
Const D3D11_BLEND_SRC_COLOR          = 3
Const D3D11_BLEND_INV_SRC_COLOR      = 4
Const D3D11_BLEND_SRC_ALPHA          = 5
Const D3D11_BLEND_INV_SRC_ALPHA      = 6
Const D3D11_BLEND_DEST_ALPHA         = 7
Const D3D11_BLEND_INV_DEST_ALPHA     = 8
Const D3D11_BLEND_DEST_COLOR         = 9
Const D3D11_BLEND_INV_DEST_COLOR     = 10
Const D3D11_BLEND_SRC_ALPHA_SAT      = 11
Const D3D11_BLEND_BLEND_FACTOR       = 14
Const D3D11_BLEND_INV_BLEND_FACTOR   = 15
Const D3D11_BLEND_SRC1_COLOR         = 16
Const D3D11_BLEND_INV_SRC1_COLOR     = 17
Const D3D11_BLEND_SRC1_ALPHA         = 18
Const D3D11_BLEND_INV_SRC1_ALPHA     = 19

Const D3D11_BLEND_OP_ADD            = 1
Const D3D11_BLEND_OP_SUBTRACT       = 2
Const D3D11_BLEND_OP_REV_SUBTRACT   = 3
Const D3D11_BLEND_OP_MIN            = 4
Const D3D11_BLEND_OP_MAX            = 5

Const D3D11_COLOR_WRITE_ENABLE_RED     = 1
Const D3D11_COLOR_WRITE_ENABLE_GREEN   = 2
Const D3D11_COLOR_WRITE_ENABLE_BLUE    = 4
Const D3D11_COLOR_WRITE_ENABLE_ALPHA   = 8
Const D3D11_COLOR_WRITE_ENABLE_ALL     = 15

Const D3D11_QUERY_EVENT                   = 0
Const D3D11_QUERY_OCCLUSION               = 1
Const D3D11_QUERY_TIMESTAMP               = 2
Const D3D11_QUERY_TIMESTAMP_DISJOINT      = 3
Const D3D11_QUERY_PIPELINE_STATISTICS     = 4
Const D3D11_QUERY_OCCLUSION_PREDICATE     = 5
Const D3D11_QUERY_SO_STATISTICS           = 6
Const D3D11_QUERY_SO_OVERFLOW_PREDICATE   = 7
Const D3D11_QUERY_SO_STATISTICS_STREAM0	= 8
Const D3D11_QUERY_SO_OVERFLOW_PREDICATE_STREAM0	= 9
Const D3D11_QUERY_SO_STATISTICS_STREAM1	= 10
Const D3D11_QUERY_SO_OVERFLOW_PREDICATE_STREAM1	= 11
Const D3D11_QUERY_SO_STATISTICS_STREAM2	= 12
Const D3D11_QUERY_SO_OVERFLOW_PREDICATE_STREAM2	= 13
Const D3D11_QUERY_SO_STATISTICS_STREAM3	= 14
Const D3D11_QUERY_SO_OVERFLOW_PREDICATE_STREAM3	= 15 

Const D3D11_COUNTER_DEVICE_DEPENDENT_0 = $40000000 

Const D3D11_FEATURE_THREADING                  = 0
Const D3D11_FEATURE_DOUBLES                    = ( D3D11_FEATURE_THREADING + 1 )
Const D3D11_FEATURE_FORMAT_SUPPORT             = ( D3D11_FEATURE_DOUBLES + 1 )
Const D3D11_FEATURE_FORMAT_SUPPORT2            = ( D3D11_FEATURE_FORMAT_SUPPORT + 1 )
Const D3D11_FEATURE_D3D10_X_HARDWARE_OPTIONS   = ( D3D11_FEATURE_FORMAT_SUPPORT2 + 1 )

Const D3D11_FORMAT_SUPPORT_BUFFER                        = $1
Const D3D11_FORMAT_SUPPORT_IA_VERTEX_BUFFER              = $2
Const D3D11_FORMAT_SUPPORT_IA_INDEX_BUFFER               = $4
Const D3D11_FORMAT_SUPPORT_SO_BUFFER                     = $8
Const D3D11_FORMAT_SUPPORT_TEXTURE1D                     = $10
Const D3D11_FORMAT_SUPPORT_TEXTURE2D                     = $20
Const D3D11_FORMAT_SUPPORT_TEXTURE3D                     = $40
Const D3D11_FORMAT_SUPPORT_TEXTURECUBE                   = $80
Const D3D11_FORMAT_SUPPORT_SHADER_LOAD                   = $100
Const D3D11_FORMAT_SUPPORT_SHADER_SAMPLE                 = $200
Const D3D11_FORMAT_SUPPORT_SHADER_SAMPLE_COMPARISON      = $400
Const D3D11_FORMAT_SUPPORT_SHADER_SAMPLE_MONO_TEXT       = $800
Const D3D11_FORMAT_SUPPORT_MIP                           = $1000
Const D3D11_FORMAT_SUPPORT_MIP_AUTOGEN                   = $2000
Const D3D11_FORMAT_SUPPORT_RENDER_TARGET                 = $4000
Const D3D11_FORMAT_SUPPORT_BLENDABLE                     = $8000
Const D3D11_FORMAT_SUPPORT_DEPTH_STENCIL                 = $10000
Const D3D11_FORMAT_SUPPORT_CPU_LOCKABLE                  = $20000
Const D3D11_FORMAT_SUPPORT_MULTISAMPLE_RESOLVE           = $40000
Const D3D11_FORMAT_SUPPORT_DISPLAY                       = $80000
Const D3D11_FORMAT_SUPPORT_CAST_WITHIN_BIT_LAYOUT        = $100000
Const D3D11_FORMAT_SUPPORT_MULTISAMPLE_RENDERTARGET      = $200000
Const D3D11_FORMAT_SUPPORT_MULTISAMPLE_LOAD              = $400000
Const D3D11_FORMAT_SUPPORT_SHADER_GATHER                 = $800000
Const D3D11_FORMAT_SUPPORT_BACK_BUFFER_CAST              = $1000000
Const D3D11_FORMAT_SUPPORT_TYPED_UNORDERED_ACCESS_VIEW   = $2000000
Const D3D11_FORMAT_SUPPORT_SHADER_GATHER_COMPARISON      = $4000000 

Const D3D11_FORMAT_SUPPORT2_UAV_ATOMIC_ADD                                 = $1
Const D3D11_FORMAT_SUPPORT2_UAV_ATOMIC_BITWISE_OPS                         = $2
Const D3D11_FORMAT_SUPPORT2_UAV_ATOMIC_COMPARE_STORE_OR_COMPARE_EXCHANGE   = $4
Const D3D11_FORMAT_SUPPORT2_UAV_ATOMIC_EXCHANGE                            = $8
Const D3D11_FORMAT_SUPPORT2_UAV_ATOMIC_SIGNED_MIN_OR_MAX                   = $10
Const D3D11_FORMAT_SUPPORT2_UAV_ATOMIC_UNSIGNED_MIN_OR_MAX                 = $20
Const D3D11_FORMAT_SUPPORT2_UAV_TYPED_LOAD                                 = $40
Const D3D11_FORMAT_SUPPORT2_UAV_TYPED_STORE                                = $80 

Const D3D11_RESOURCE_MISC_GENERATE_MIPS            = $1
Const D3D11_RESOURCE_MISC_SHARED                   = $2
Const D3D11_RESOURCE_MISC_TEXTURECUBE              = $4
Const D3D11_RESOURCE_MISC_DRAWINDIRECT_ARGS        = $10
Const D3D11_RESOURCE_MISC_BUFFER_ALLOW_RAW_VIEWS   = $20
Const D3D11_RESOURCE_MISC_BUFFER_STRUCTURED        = $40
Const D3D11_RESOURCE_MISC_RESOURCE_CLAMP           = $80
Const D3D11_RESOURCE_MISC_SHARED_KEYEDMUTEX        = $100
Const D3D11_RESOURCE_MISC_GDI_COMPATIBLE           = $200 

Function D3D11CalcSubresource(MipSlice,ArraySlice,MipLevels)
	Return MipSlice+(ArraySlice*MipLevels)
EndFunction

Type D3D11_BUFFER_DESC
	Field ByteWidth
	Field Usage
	Field BindFlags
  	Field CPUAccessFlags
	Field MiscFlags
	Field StructureByteStride
EndType

Type D3D11_SUBRESOURCE_DATA
	Field pSysMem:Byte Ptr
	Field SysMemPitch
	Field SysMemSlicePitch
EndType

Type D3D11_TEXTURE1D_DESC
	Field Width
	Field MipLevels
	Field ArraySize
	Field Format
	Field Usage
	Field BindFlags
	Field CPUAccessFlags
	Field MiscFlags
EndType

Type D3D11_TEXTURE2D_DESC
	Field Width
	Field Height
	Field MipLevels
	Field ArraySize
	Field Format
	Field SampleDesc_Count
	Field SampleDesc_Quality
	Field Usage
	Field BindFlags
	Field CPUAccessFlags
	Field MiscFlags
EndType

Type D3D11_TEXTURE3D_DESC
	Field Width
	Field Height
	Field Depth
	Field MipLevels
	Field Format
	Field Usage
	Field BindFlags
	Field CPUAccessFlags
	Field MiscFlags
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
	Field SemanticIndex
	Field Format
	Field InputSlot
	Field AlignedByteOffset
	Field InputSlotClass
	Field InstanceDataStepRate
EndType

Type D3D11_SAMPLER_DESC
	Field Filter
	Field AddressU
	Field AddressV
	Field AddressW
	Field MipLODBias#
	Field MaxAnisotropy
	Field ComparisonFunc
	Field BorderColor0#
	Field BorderColor1#
	Field BorderColor2#
	Field BorderColor3#
	Field MinLOD#
	Field MaxLOD#
EndType

Type D3D11_RASTERIZER_DESC
	Field FillMode
	Field CullMode
	Field FrontCounterClockwise
	Field DepthBias
	Field DepthBiasClamp#
	Field SlopeScaledDepthBias#
	Field DepthClipEnable
	Field ScissorEnable
	Field MultisampleEnable
	Field AntialiasedLineEnable
EndType

Type D3D11_BLEND_DESC
	Field AlphaToCoverageEnable
	Field IndependentBlendEnable
	Field RenderTarget0_BlendEnable
	Field RenderTarget0_SrcBlend
	Field RenderTarget0_DestBlend
	Field RenderTarget0_BlendOp
	Field RenderTarget0_SrcBlendAlpha
	Field RenderTarget0_DestBlendAlpha
	Field RenderTarget0_BlendOpAlpha
	Field RenderTarget0_RenderTargetWriteMask
	Field RenderTarget1_BlendEnable
	Field RenderTarget1_SrcBlend
	Field RenderTarget1_DestBlend
	Field RenderTarget1_BlendOp
	Field RenderTarget1_SrcBlendAlpha
	Field RenderTarget1_DestBlendAlpha
	Field RenderTarget1_BlendOpAlpha
	Field RenderTarget1_RenderTargetWriteMask
	Field RenderTarget2_BlendEnable
	Field RenderTarget2_SrcBlend
	Field RenderTarget2_DestBlend
	Field RenderTarget2_BlendOp
	Field RenderTarget2_SrcBlendAlpha
	Field RenderTarget2_DestBlendAlpha
	Field RenderTarget2_BlendOpAlpha
	Field RenderTarget2_RenderTargetWriteMask
	Field RenderTarget3_BlendEnable
	Field RenderTarget3_SrcBlend
	Field RenderTarget3_DestBlend
	Field RenderTarget3_BlendOp
	Field RenderTarget3_SrcBlendAlpha
	Field RenderTarget3_DestBlendAlpha
	Field RenderTarget3_BlendOpAlpha
	Field RenderTarget3_RenderTargetWriteMask
	Field RenderTarget4_BlendEnable
	Field RenderTarget4_SrcBlend
	Field RenderTarget4_DestBlend
	Field RenderTarget4_BlendOp
	Field RenderTarget4_SrcBlendAlpha
	Field RenderTarget4_DestBlendAlpha
	Field RenderTarget4_BlendOpAlpha
	Field RenderTarget4_RenderTargetWriteMask
	Field RenderTarget5_BlendEnable
	Field RenderTarget5_SrcBlend
	Field RenderTarget5_DestBlend
	Field RenderTarget5_BlendOp
	Field RenderTarget5_SrcBlendAlpha
	Field RenderTarget5_DestBlendAlpha
	Field RenderTarget5_BlendOpAlpha
	Field RenderTarget5_RenderTargetWriteMask
	Field RenderTarget6_BlendEnable
	Field RenderTarget6_SrcBlend
	Field RenderTarget6_DestBlend
	Field RenderTarget6_BlendOp
	Field RenderTarget6_SrcBlendAlpha
	Field RenderTarget6_DestBlendAlpha
	Field RenderTarget6_BlendOpAlpha
	Field RenderTarget6_RenderTargetWriteMask
	Field RenderTarget7_BlendEnable
	Field RenderTarget7_SrcBlend
	Field RenderTarget7_DestBlend
	Field RenderTarget7_BlendOp
	Field RenderTarget7_SrcBlendAlpha
	Field RenderTarget7_DestBlendAlpha
	Field RenderTarget7_BlendOpAlpha
	Field RenderTarget7_RenderTargetWriteMask
EndType

Type D3D11_DEPTH_STENCIL_DESC
	Field DepthEnable
	Field DepthWriteMask
	Field DepthFunc
	Field StencilEnable
	Field StencilReadMask
	Field StencilWriteMask
	Field FrontFace_StencilFailOp
	Field FrontFace_StencilDepthFailOp
	Field FrontFace_StencilPassOp
	Field FrontFace_StencilFunc
	Field BackFace_StencilFailOp
	Field BackFace_StencilDepthFailOp
	Field BackFace_StencilPassOp
	Field BackFace_StencilFunc
EndType

Type D3D11_DEPTH_STENCIL_VIEW_DESC
	Field Format
	Field ViewDimension
	Field Flags
	Field Texture_MipSlice
	Field Texture_FirstArraySlice
	Field Texture_ArraySize
EndType

Type D3D11_QUERY_DESC
	Field Query
	Field MiscFlags
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
	Field Disjoint
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
	Field Counter
	Field MiscFlags
EndType

Type D3D11_COUNTER_INFO
	Field LastDeviceDependantCounter
	Field NumSimultaneousCounters
	Field NumDetectableParallelUnits
EndType

Type D3D11_MAPPED_SUBRESOURCE
	Field pData:Byte Ptr
	Field RowPitch
	Field DepthPitch
EndType

Type D3D11_SHADER_RESOURCE_VIEW_DESC
	Field Format
 	Field ViewDimension
	Field Texture_MostDetailedMip
	Field Texture_MipLevels
	Field Texture_FirstArraySlice
	Field Texture_ArraySize
	Field ElementOffset:Int Ptr=Varptr Texture_MostDetailedMip
	Field ElementWidth:Int Ptr=Varptr Texture_MipLevels
EndType

Type D3D11_RENDER_TARGET_VIEW_DESC
	Field Format
	Field ViewDimension
	Field Texture_MipSlice
EndType

Type D3D11_FEATURE_DATA_THREADING
	Field DriverConCurrentCreates
	Field DriverCommandLists
EndType

Type D3D11_FEATURE_DATA_DOUBLES
 	Field DoublePrecisionFloatShaderOps
EndType

Type D3D11_FEATURE_DATA_D3D10_X_HARDWARE_OPTIONS
  Field ComputeShaders_Plus_RawAndStructuredBuffers_Via_Shader_4_x
EndType

Type D3D11_FEATURE_DATA_FORMAT_SUPPORT
	Field InFormat
	Field OutFormatSupport
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

Global IID_ID3D11DeviceChild[]			=[$1841e5c8,$489b16b0,$cf44c8bc,$aeded5b0]
Global IID_ID3D11DepthStencilState[]	=[$03823efb,$4e1c8d8f,$4bf6a29a,$f1fdcbb2]
Global IID_ID3D11BlendState[]			=[$75b68faa,$4159347d,$64a0458f,$9acd010f]
Global IID_ID3D11RasterizerState[]		=[$9bb4ab81,$4d8fab1a,$04fc06b5,$e76e0b20]
Global IID_ID3D11Resource[]				=[$dc8e63f3,$4952d12b,$455e7bb4,$2d866a02]
Global IID_ID3D11Buffer[]				=[$48570b85,$4fcdd1ee,$35eb50a2,$37b02207]
Global IID_ID3D11Texture1D[]			=[$f8fb5c27,$4f75c6b3,$9a43c8a4,$4c56eff2]
Global IID_ID3D11Texture2D[]			=[$6f15aaf2,$4e89d208,$9548b49a,$9c4fd335]
Global IID_ID3D11Texture3D[]			=[$037e866e,$4357f56d,$ab9dafa8,$0e256ebe]
Global IID_ID3D11View[]					=[$839d1216,$412bbb2e,$dba9f4b7,$d18ee0eb]
Global IID_ID3D11ShaderResourceView[]	=[$b0e06fe0,$4e1a8192,$d736cab1,$b2104741]
Global IID_ID3D11RenderTargetView[]		=[$dfdba067,$48650b8d,$b4d75b87,$64c16c51]
Global IID_ID3D11DepthStencilView[]		=[$9fdac92a,$48c31876,$b925adaf,$b6a9844f]
Global IID_ID3D11UnorderedAccessView[]	=[$28acf509,$48f67f5c,$16f31186,$80630a01]
Global IID_ID3D11VertexShader[]			=[$3b301d64,$4289d678,$f8229788,$f3728b92]
Global IID_ID3D11HullShader[]			=[$8e5c6061,$4c8e628a,$5ce4bb64,$ddd5b35c]
Global IID_ID3D11DomainShader[]			=[$f582c508,$490c0f36,$ee317799,$fa8c26ce]
Global IID_ID3D11GeometryShader[]		=[$38325b96,$4022effb,$792e02ba,$5c27705b]
Global IID_ID3D11PixelShader[]			=[$ea82e40d,$4f3351dc,$7cdbd493,$8cae2591]
Global IID_ID3D11ComputeShader[]		=[$4f5b196e,$495ec2bd,$de1f01bd,$69498ed3]
Global IID_ID3D11InputLayout[]			=[$e4819ddc,$40254cf0,$e85d26bd,$b7073e2a]
Global IID_ID3D11SamplerState[]			=[$da6fea51,$4487564c,$d0f01098,$a5e3b4f9]
Global IID_ID3D11Asynchronous[]			=[$4b35d0cd,$45281e15,$131b989c,$3bddf633]
Global IID_ID3D11Query[]				=[$d6c00747,$425e87b7,$d1444db8,$fd0a5608]
Global IID_ID3D11Predicate[]			=[$9eb576dd,$4d869f77,$ab8baa81,$e290e45f]
Global IID_ID3D11Counter[]				=[$6e8c49fb,$4770a371,$082940b4,$41b72260]
Global IID_ID3D11ClassInstance[]		=[$a6cd7faa,$4a2fb0b7,$62863694,$cb9757a6]
Global IID_ID3D11ClassLinkage[]			=[$ddf57cba,$46e49543,$07f22ba1,$ed7ffea0]
Global IID_ID3D11CommandList[]			=[$a24bc4d1,$43f7769e,$ff981380,$e2186c56]
Global IID_ID3D11DeviceContext[]		=[$c0bfa96c,$44fbe089,$f826af8e,$da906179]
Global IID_ID3D11Device[]				=[$db6f6ddb,$4e88ac77,$9d815382,$40f1bbf9]

'11 : db6f6ddb-ac77-4e88-8253-819d f9bb f140
'10 : 9B7E4C00-342C-4106-A19F-4F27 04F6 89F0
Global IID_ID3D10Device[]				=[$9b7e4c00,$4106342c,$274f9fa1,$f089f604]
Global IID_ID3D10Device1[]				=[$9b7e4c8f,$4106342c,$274f9fa1,$f089f604]
