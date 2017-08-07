Strict

Import pub.win32
Import "d3dcommon_brl.bmx"

Const D3D11_SHVER_PIXEL_SHADER:Int = 0
Const D3D11_SHVER_VERTEX_SHADER:Int = 1
Const D3D11_SHVER_GEOMETRY_SHADER:Int = 2
Const D3D11_SHVER_HULL_SHADER:Int = 3
Const D3D11_SHVER_DOMAIN_SHADER:Int = 4
Const D3D11_SHVER_COMPUTE_SHADER:Int = 5
Const D3D11_SHVER_RESERVED0:Int = $fff0

Function D3D11_SHVER_GET_TYPE:Int(version:Int)
	Return (version Shr 16) & $ffff
EndFunction

Function D3D11_SHVER_GET_MAJOR:Int(version:Int)
	Return (version Shr 4) & $f
EndFunction

Function D3D11_SHVER_GET_MINOR:Int(version:Int)
	Return version & $f
EndFunction

Const D3D_RETURN_PARAMETER_INDEX:Int = -1

' D3D_PARAMETER_FLAGS
Const D3D_PF_NONE:Int = 0
Const D3D_PF_IN:Int = 1
Const D3D_PF_OUT:Int = 2
Const D3D_PF_FORCE_DWORD:Int = $7fffffff

Type D3D11_SIGNATURE_PARAMETER_DESC
	Field SemanticName:Byte Ptr
	Field SemanticIndex:Int
	Field Register:Int
	Field SystemValueType:Int
	Field ComponentType:Int
	Field Mask:Byte
	Field ReadWriteMask:Byte
	Field Stream:Int
	Field MinPrecision:Int
EndType

Type D3D11_SHADER_BUFFER_DESC
	Field Name:Byte Ptr
	Field Type_:Int
	Field Variables:Int
	Field Size:Int
	Field uFlags:Int
EndType

Type D3D11_SHADER_VARIABLE_DESC
	Field Name:Byte Ptr
	Field StartOffset:Int
	Field Size:Int
	Field uFlags:Int
	Field DefaultValue:Byte Ptr
	Field StartTexture:Int
	Field TextureSize:Int
	Field StartSampler:Int
	Field SamplerSize:Int
EndType

Type D3D11_SHADER_TYPE_DESC
	Field Class:Int
	Field Type_:Int
	Field Rows:Int
	Field Columns:Int
	Field Elements:Int
	Field Members:Int
	Field Offset:Int
	Field Name:Byte Ptr
EndType

Type D3D11_SHADER_DESC
	Field Version:Int
	Field Creator:Int
	Field Flags:Int
	
	Field ConstantBuffers:Int
	Field BoundResources:Int
	Field InputParameters:Int
	Field OutputParameters:Int
	
	Field InstructionCount:Int
	Field TempRegisterCount:Int
	Field TempArrayCount:Int
	Field DefCount:Int
	Field DclCount:Int
	Field TextureNormalInstructions:Int
	Field TextureLoadInstructions:Int
	Field TextureCompInstructions:Int
	Field TextureBiasInstructions:Int
	Field TextureGradientInstructions:Int
	Field FloatInstructionCount:Int
	Field IntInstructionCount:Int
	Field UintInstructionCount:Int
	Field StaticFlowControlCount:Int
	Field DynamicFlowControlCount:Int
	Field MacroInstrictionCount:Int
	Field ArrayInstructionCount:Int
	Field CutInstructionCount:Int
	Field EmitInstructionCount:Int
	Field GSOutputTopology:Int
	Field GSMaxOutputVertexCount:Int
	Field InputPrimitive:Int
	Field PatchConstantParameters:Int
	Field cGSInstanceCount:Int
	Field cCOntrolPoints:Int
	Field HSOutputPrimitive:Int
	Field HSPartitioning:Int
	Field TessellatorDomain:Int
	Field cBarrierInstructions:Int
	Field cInterlockedInstructions:Int
	Field cTextureStoreInstructions:Int
EndType

Type D3D11_SHADER_INPUT_BIND_DESC
	Field Name:Byte Ptr
	Field Type_:Int
	Field BindPoint:Int
	Field BindCount:Int
	Field uFlags:Int
	Field ReturnType:Int
	Field Dimension:Int
	Field NumSamples:Int
EndType

Type D3D11_LIBRARY_DESC
	Field Creator:Byte Ptr
	Field Flags:Int
	Field FunctionCount:Int
EndType

Type D3D11_FUNCTION_DESC
	Field Version:Int
	Field Creator:Byte Ptr
	Field Flags:Int
	Field ConstantBuffers:Int
	Field BoundResources:Int
	Field InstructionCount:Int
	Field TempRegisterCount:Int
	Field TempArrayCount:Int
	Field DefCount:Int
	Field DclCount:Int
	Field TextureNormalInstructions:Int
	Field TextureLoadInstructions:Int
	Field TextureCompInstructions:Int
	Field TextureBiasInstructions:Int
	Field TextureGradientInstructions:Int
	Field FloatInstructionCount:Int
	Field IntInstructionCount:Int
	Field UintInstructionCount:Int
	Field StaticFlowControlCount:Int
	Field DynamicFlowControlCount:Int
	Field MacroInstructionCount:Int
	Field ArrayInstructionCount:Int
	Field MovInstructionCount:Int
	Field MovcInstructionCount:Int
	Field ConversionInstructionCount:Int
	Field BitwiseInstructionCount:Int
	Field MinFeatureLevel:Int
	Field RequiredFeatureFlags:Int
	Field Name:Byte Ptr
	Field FunctionParameterCount:Int
	Field HasReturn:Int
	Field Has10Level9VertexShader:Int
	Field Has10Level9PixelShader:Int
EndType

Type D3D11_PARAMETER_DESC
	Field Name:Byte Ptr
	Field SemanticName:Byte Ptr
	Field Type_:Int
	Field Class:Int
	Field Rows:Int
	Field Columns:Int
	Field InterpolationMode:Int
	Field Flags:Int
	Field FirstInRegister:Int
	Field FirstInComponent:Int
	Field FirstOutRegister:Int
	Field FirstOutComponent:Int
EndType

Extern"Win32"
Type ID3D11ShaderReflectionType Extends IUnknown
	Method GetDesc:Int(pDesc:Byte Ptr)
	Method GetMemberTypeByIndex:ID3D11ShaderReflectionType(index:Int)
	Method GetMemberTypeByName:ID3D11ShaderReflectionType(Name:Byte Ptr)
	Method GetMemberTypeName:Byte Ptr(index:Int)
	Method IsEqual:Int(pType:ID3D11ShaderReflectionType)
	Method GetSubType:ID3D11ShaderReflectionType()
	Method GetBaseClass:ID3D11ShaderReflectionType()
	Method GetNumInterface:Int()
	Method GetInterfaceByIndex:ID3D11ShaderReflectionType(index:Int)
	Method IsOfType:Int(pType:ID3D11ShaderReflectionType)
	Method ImplementsInterface:Int(pBase:ID3D11ShaderReflectionType)
EndType

Type ID3D11ShaderReflectionVariable Extends IUnknown
	Method GetDesc:Int(pDesc:Byte Ptr)
	Method GetType:ID3D11ShaderReflectionType()
	Method GetBuffer:ID3D11ShaderReflectionConstantBuffer()
	Method GetInterfaceSlot:Int(uArrayIndex:Int)
EndType

Type ID3D11ShaderReflectionConstantBuffer Extends IUnknown
	Method GetDesc:Int(pDesc:Byte Ptr)
	Method GetVariableByIndex:ID3D11ShaderReflectionVariable(index:Int)
	Method GetVariableByName:ID3D11ShaderReflectionVariable(name:Byte Ptr)
EndType

Type ID3D11ShaderReflection Extends IUnknown
	Method GetDesc:Int(pDesc:Byte Ptr)
	Method GetConstantBufferByIndex:ID3D11ShaderReflectionConstantBuffer(index:Int)
	Method GetConstantBufferByName:ID3D11ShaderReflectionConstantBuffer(name:Byte Ptr)
	Method GetResourceBindingDesc:Int(ResourceIndex:Int, pDesc:Byte Ptr)
	Method GetInputParameterDesc:Int(ParameterIndex:Int, pDesc:Byte Ptr)
	Method GetOutputParameterDesc:Int(ParameterIndex:Int, pDesc:Byte Ptr)
	Method GetPatchConstantParameterDesc(ParameterIndex:Int, pDesc:Byte Ptr)
	Method GetVariableByName:ID3D11ShaderReflectionVariable(name:Byte Ptr)
	Method GetResourceBindingDescByName:Int(name:Byte Ptr, pDesc:Byte Ptr)
	Method GetMovInstructionCount:Int()
	Method GetMovcInstructionCount:Int()
	Method GetConversionInstructionCount:Int()
	Method BitwiseInstructionCount:Int()
	Method GetGSInputPrimitive:Int()
	Method GetIsSampleFrequencyShader:Int()
	Method GetNumInterfaceSlots:Int()
	Method GetMinFeatureLevel(pLevel:Int Ptr)
	Method GetThreadGroupSize:Int(pSizeX:Int Ptr, pSizeY:Int Ptr, pSizeZ:Int Ptr)
	Method GetRequiresFlags:Int()
EndType

Type ID3D11LibraryReflection Extends IUnknown
	Method GetDesc:Int(pDesc:Byte Ptr)
	Method GetFunctionByIndex:ID3D11FunctionReflection(FunctionIndex:Int)
EndType

Type ID3D11FunctionReflection Extends IUnknown
	Method GetConstantBufferByIndex:ID3D11ShaderReflectionConstantBuffer(index:Int)
	Method GetConstantBufferByName:ID3D11ShaderReflectionConstantBuffer(name:Byte Ptr)
	Method GetResourceBindingDesc:Int(ResourceIndex:Int, pDesc:Byte Ptr)
	Method GetVariableByName:ID3D11ShaderReflectionVariable(name:Byte Ptr)
	Method GetResourceBindingDescByName:Int(name:Byte Ptr, pDesc:Byte Ptr)
	Method GetFunctionParameter:ID3D11FunctionParameterReflection(parameterIndex:Int)
EndType

Type ID3D11FunctionParameterReflection Extends IUnknown
	Method GetDesc:Int(pDesc:Byte Ptr)
EndType

Type ID3D11Module Extends IUnknown
	Method CreateInstance:Int(pNamespace:Byte Ptr, ppModuleInstance:ID3D11ModuleInstance Var)
EndType

Type ID3D11ModuleInstance Extends IUnknown
	Method BindConstantBuffer:Int(uSrcSlot:Int, uDstSlot:Int, cbDstOffset:Int)
	Method BindConstantBufferByName:Int(pName:Byte Ptr, uDstSlot:Int, cbDstOffset:Int)
	Method BindResource:Int(uSrcSlot:Int, uDstSlot:Int, uCount:Int)
	Method BindResourceByName:Int(pName:Byte Ptr, uDstSlot:Int, uCount:Int)
	Method BindSampler:Int(uSrcSlot:Int, uDstSlot:Int, uCount:Int)
	Method BindSamplerByName:Int(pName:Byte Ptr, uDstSlot:Int, uCount:Int)
	Method BindUnorderedAccessView:Int(uSrcSlot:Int, uDstSlot:Int, uCount:Int)
	Method BindUnorderedAccessViewByName:Int(pName:Byte Ptr, uDstSlot:Int, uCount:Int)
	Method BindResourceAsUnorderedAccessView:Int(uSrcSrvSlot:Int, uDstUavSlot:Int, uCount:Int)
	Method BindResourceAsUnorderedAccessViewByName:Int(pSrvName:Byte Ptr, uDstUavSloat:Int, uCount:Int)
EndType

Type ID3D11Linker Extends IUnknown
	Method Link:Int(pEntry:ID3D11ModuleInstance, pEntryName:Byte Ptr, pTargetName:Byte Ptr, uFlags:Int, ppShaderBlob:ID3DBlob Ptr, ppErrorBuffer:ID3DBlob Ptr)
	Method UseLibrary:Int(pLibraryMI:ID3D11ModuleInstance)
	Method AddClipPlaneFromCBuffer:Int(uCBufferSlot:Int, uCBufferEntry:Int)
EndType

Type ID3D11LinkingNode Extends IUnknown
EndType

Type ID3D11FunctionLinkingGraph Extends IUnknown
	Method CreateModuleInstance:Int(ppModuleInstance:ID3D11ModuleInstance Ptr, ppErrorBuffer:ID3DBlob Ptr)
	Method SetInputSignature:Int(pInputParameters:Byte Ptr, cInputParameters:Int, ppInputMode:ID3D11LinkingNode Ptr)
	Method SetOutputSignature:Int(pOutputParameters:Byte Ptr, cOutputParameters:Int, ppOutputNode:ID3D11LinkingNode Ptr)
	Method CallFunction:Int(pModuleInstanceNamespace:Byte Ptr, pModuleWithFunctionPrototype:ID3D11Module, pFunctionName:Byte Ptr, ppCallNode:ID3D11LinkingNode Ptr)
	Method PassValue:Int(pSrcNode:ID3D11LinkingNode, srcParameterIndex:Int, pDstNode:ID3D11LinkingNode, dstParameterIndex:Int)
	Method PassValueWithSwizzle:Int(pSrcNode:ID3D11LinkingNode, srcParameterIndex:Int, pSrcSwizzle:Int, pDstNode:ID3D11LinkingNode, dstParameterIndex:Int, pDstSwizzle:Int)
	Method GetLastError:Int(ppErrorBuffer:ID3DBlob Ptr)
	Method GenerateHlsl:Int(uFlags:Int, ppBuffer:ID3DBlob Ptr)
EndType
EndExtern

Const D3D_SHADER_REQUIRES_DOUBLES                         = $00000001
Const D3D_SHADER_REQUIRES_EARLY_DEPTH_STENCIL             = $00000002
Const D3D_SHADER_REQUIRES_UAVS_AT_EVERY_STAGE             = $00000004
Const D3D_SHADER_REQUIRES_64_UAVS                         = $00000008
Const D3D_SHADER_REQUIRES_MINIMUM_PRECISION               = $00000010
Const D3D_SHADER_REQUIRES_11_1_DOUBLE_EXTENSIONS          = $00000020
Const D3D_SHADER_REQUIRES_11_1_SHADER_EXTENSIONS          = $00000040
Const D3D_SHADER_REQUIRES_LEVEL_9_COMPARISON_FILTERING    = $00000080
Const D3D_SHADER_REQUIRES_TILED_RESOURCES                 = $00000100
	
Const D3D11_SHADER_DEBUG                          = 1 Shl 0
Const D3D11_SHADER_SKIP_VALIDATION                = 1 Shl 1
Const D3D11_SHADER_SKIP_OPTIMIZATION              = 1 Shl 2
Const D3D11_SHADER_PACK_MATRIX_ROW_MAJOR          = 1 Shl 3
Const D3D11_SHADER_PACK_MATRIX_COLUMN_MAJOR       = 1 Shl 4
Const D3D11_SHADER_PARTIAL_PRECISION              = 1 Shl 5
Const D3D11_SHADER_FORCE_VS_SOFTWARE_NO_OPT       = 1 Shl 6
Const D3D11_SHADER_FORCE_PS_SOFTWARE_NO_OPT       = 1 Shl 7
Const D3D11_SHADER_NO_PRESHADER                   = 1 Shl 8
Const D3D11_SHADER_AVOID_FLOW_CONTROL             = 1 Shl 9
Const D3D11_SHADER_PREFER_FLOW_CONTROL            = 1 Shl 10
Const D3D11_SHADER_ENABLE_STRICTNESS              = 1 Shl 11
Const D3D11_SHADER_ENABLE_BACKWARDS_COMPATIBILITY = 1 Shl 12
Const D3D11_SHADER_IEEE_STRICTNESS                = 1 Shl 13
Const D3D11_SHADER_OPTIMIZATION_LEVEL0            = 1 Shl 14
Const D3D11_SHADER_OPTIMIZATION_LEVEL1            = 0
Const D3D11_SHADER_OPTIMIZATION_LEVEL2            = ((1 Shl 14) | (1 Shl 15))
Const D3D11_SHADER_OPTIMIZATION_LEVEL3            = 1 Shl 15
Const D3D11_SHADER_WARNINGS_ARE_ERRORS            = 1 Shl 18

Global IID_ID3D11ShaderReflectionType:Int[4]
Global IID_ID3D11ShaderReflectionVariable:Int[4]
Global IID_ID3D11ShaderReflectionConstantBuffer:Int[4]
Global IID_ID3D11ShaderReflection:Int[4]
Global IID_ID3D11LibraryReflection:Int[4]
Global IID_ID3D11FunctionReflection:Int[4]
Global IID_ID3D11FunctionParameterReflection:Int[4]
Global IID_ID3D11Module:Int[4]
Global IID_ID3D11ModuleInstance:Int[4]
Global IID_ID3D11Linker:Int[4]
Global IID_ID3D11LinkingNode:Int[4]
Global IID_ID3D11FunctionLinkingGraph:Int[4]

GUIDFromStringW("{6E6FFA6A-9BAE-4613-A51E-91652D508C21}", IID_ID3D11ShaderReflectionType)
GUIDFromStringW("{51F23923-F3E5-4BD1-91CB-606177D8DB4C}", IID_ID3D11ShaderReflectionVariable)
GUIDFromStringW("{EB62D63D-93DD-4318-8AE8-C6F83AD371B8}", IID_ID3D11ShaderReflectionConstantBuffer)
GUIDFromStringW("{8d536ca1-0cca-4956-a837-786963755584}", IID_ID3D11ShaderReflection)
GUIDFromStringW("{54384F1B-5B3E-4BB7-AE01-60BA3097CBB6}", IID_ID3D11LibraryReflection)
GUIDFromStringW("{207BCECB-D683-4A06-A8A3-9B149B9F73A4}", IID_ID3D11FunctionReflection)
GUIDFromStringW("{42757488-334F-47FE-982E-1A65D08CC462}", IID_ID3D11FunctionParameterReflection)
GUIDFromStringW("{CAC701EE-80FC-4122-8242-10B39C8CEC34}", IID_ID3D11Module)
GUIDFromStringW("{469E07F7-045A-48D5-AA12-68A478CDF75D}", IID_ID3D11ModuleInstance)
GUIDFromStringW("{59A6CD0E-E10D-4C1F-88C0-63ABA1DAF30E}", IID_ID3D11Linker)
GUIDFromStringW("{D80DD70C-8D2F-4751-94A1-03C79B3556DB}", IID_ID3D11LinkingNode)
GUIDFromStringW("{54133220-1CE8-43D3-8236-9855C5CEECFF}", IID_ID3D11FunctionLinkingGraph)













