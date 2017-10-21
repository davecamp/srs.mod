SuperStrict

Import Pub.Win32
Import BRL.System
Import "d3dcommon_ng.bmx"
Import "d3dcompiler.bmx"

Global _d3dcompiler:Byte Ptr = LoadLibraryW("d3dcompiler_47.dll")
If Not _d3dcompiler _d3dcompiler = LoadLibraryW("d3dcompiler_43.dll")
If Not _d3dcompiler Return False

Global D3DCreateBlob:Int(Size:Int,ppBlob:ID3DBlob Var)"win32" = GetProcAddress(_d3dcompiler,"D3DCreateBlob")
Global D3DCompile:Int(pSrcData:Byte Ptr,SrcDataSize:Int,pSourceName:Byte Ptr,pDefines:Byte Ptr,pInclude:Byte Ptr,pEntryPoint:Byte Ptr,pTarget:Byte Ptr,Flags1:Int,Flags2:Int,ppCode:ID3DBlob Var,ppErrorMsgs:ID3DBlob Var)"win32" = GetProcAddress(_d3dcompiler,"D3DCompile")
'Global D3DPreprocess()
'Global D3DGetDebugInfo()
'Global D3DReflect()
'Global D3DDisassemble()
'Global D3DDisassemble10Effect()
'Global D3DGetInputSignatureBlob()
'Global D3DGetInputAndOutputSignatureBlob()
'Global D3DStripShader()
'Global D3DGetBlobPart()
'Global D3DCompressShaders()
'Global D3DDecompressShaders()