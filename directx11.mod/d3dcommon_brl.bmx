Strict

Import "-lOle32"

Import Pub.Win32
Import "d3dcommon_common.bmx"

Extern"win32"
Function StringFromIID(rclsid:Byte Ptr, lplpsz:Byte Ptr)
Function IIDFromString(lpsz$w, lpiid:Byte Ptr)
EndExtern

Extern "win32"
Type ID3DBlob Extends IUnknown
	Method GetBufferPointer:Byte Ptr()
	Method GetBufferSize()
EndType
EndExtern

