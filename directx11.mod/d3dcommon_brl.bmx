Strict

Import Pub.Win32
Import "d3dcommon_common.bmx"

Global Shell32Dll:Long = LoadLibraryA("Shell32")
Global GUIDFromStringW:Int(psz$w, pGuid:Byte Ptr)"Win32" = GetProcAddress(Shell32Dll, "GUIFromStringW")


Extern "win32"
Type ID3DBlob Extends IUnknown
	Method GetBufferPointer:Byte Ptr()
	Method GetBufferSize()
EndType
EndExtern

