Strict

Import Pub.Win32
Import "d3dcommon_common.bmx"

Global Rpcrt4Dll:Long = LoadLibraryA("Rpcrt4.dll")
Global UuidFromStringW:Int(psz$w, pUuid:Byte Ptr)"Win32" = GetProcAddress(Rpcrt4Dll, "UuidFromStringW")

Extern "win32"
Type ID3DBlob Extends IUnknown
	Method GetBufferPointer:Byte Ptr()
	Method GetBufferSize()
EndType
EndExtern

