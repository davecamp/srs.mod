SuperStrict

Import "-lOle32"

Import Pub.Win32
Import "d3dcommon.bmx"

Extern"win32"
Function StringFromIID(rclsid:Byte Ptr, lplpsz:Byte Ptr) = "RESULT StringFromIID(REFIID, LPOLESTR*)!"
Function IIDFromString(lpsz$w, lpiid:Byte Ptr) = "HRESULT IIDFromString(LPCOLESTR, LPIID)!"

Interface ID3DBlob Extends IUnknown_
	Method GetBufferPointer:Byte Ptr()
	Method GetBufferSize:Int()
EndInterface
EndExtern

