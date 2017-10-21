Strict

Import Pub.Win32
Import BRL.System
Import "d3dcommon_brl.bmx"
Import "d3dcompiler.bmx"

Global _d3dcompiler = LoadLibraryA("d3dcompiler_47.dll")
If Not _d3dcompiler _d3dcompiler = LoadLibraryA("d3dcompiler_43.dll")
If Not _d3dcompiler Return

Global D3DCreateBlob(Size,ppBlob:ID3DBlob Var)"win32" = GetProcAddress(_d3dcompiler,"D3DCreateBlob")
Global D3DCompile(pSrcData:Byte Ptr,SrcDataSize,pSourceName:Byte Ptr,pDefines:Byte Ptr,pInclude:Byte Ptr,pEntryPoint:Byte Ptr,pTarget:Byte Ptr,Flags1,Flags2,ppCode:ID3DBlob Var,ppErrorMsgs:ID3DBlob Var)"win32" = GetProcAddress(_d3dcompiler,"D3DCompile")
'Global D3DPreprocess()
Global D3DGetDebugInfo(pSrcData:Byte Ptr, SrcDataSize:Int, ppDebugInfo:ID3DBlob Ptr)"win32" = GetProcAddress(_d3dcompiler, "D3DGetDebugInfo")
Global D3DReflect(pSrcData:Byte Ptr, SrcDataSize:Int, pInterface:Byte Ptr, ppReflector:Byte Ptr)"win32" = GetProcAddress(_d3dcompiler, "D3DReflect")
'Global D3DDisassemble()
'Global D3DDisassemble10Effect()
'Global D3DGetInputSignatureBlob()
'Global D3DGetInputAndOutputSignatureBlob()
Global D3DGetOutputSignatureBlob(pSrcData:Byte Ptr, srcDataSize:Int, ppSignatureBlob:ID3DBlob Var)"Win32" = GetProcAddress(_d3dcompiler, "D3DGetOutputSignatureBlob")
'Global D3DStripShader()
'Global D3DGetBlobPart()
'Global D3DCompressShaders()
'Global D3DDecompressShaders()