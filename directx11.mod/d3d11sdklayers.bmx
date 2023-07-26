
SuperStrict

Import Pub.Win32
Import "d3d11_brl.bmx"

Extern"win32"

Type ID3D11Debug Extends IUnknown
	Method SetFeatureMask:Int(Mask:Int)
	Method GetFeatureMask:Int()
	Method SetPresentPerRenderOpDelay:Int(Milliseconds:Int)
	Method GetPresentPerRenderOpDelay:Int()
	Method SetSwapChain:Int(pSwapChain:IDXGISwapChain)
	Method GetSwapChain:Int(ppSwapChain:IDXGISwapChain Ptr)
	Method ValidateContext:Int(pContext:ID3D11DeviceContext)
	Method ReportLiveDeviceObjects:Int(Flags:Int)
	Method ValidateContextForDispatch:Int(pContext:ID3D11DeviceContext)
EndType

Type ID3D11InfoQueue Extends IUnknown
	Method SetMessageCountLimit:Int(MessageCountLimit:Long)
	Method ClearStoredMessages()
	Method GetMessage:Int(MessageIndex:Long, pMessage:Byte Ptr, pMessageByteLength:Int Ptr)
	Method GetNumMessagesAllowedByStorageFilter:Long()
	Method GetNumMessagesDeniedByStorageFilter:Long()
	Method GetNumStoredMessages:Long()
	Method GetNumStoredMessagesAllowedByRetrievalFilter:Long()
	Method GetNumMessagesDiscardedByMessageCountLimit:Long()
	Method GetMessageCountLimit:Long()
	Method AddStorageFilterEntries:Int(pFilter:Byte Ptr)
	Method GetStorageFilter:Int(pFilter:Byte Ptr, pFilterByteLength:Int Ptr)
	Method ClearStorageFilter()
	Method PushEmptyStorageFilter:Int()
	Method PushCopyOfStorageFilter:Int()
	Method PushStorageFilter:Int(pFilter:Byte Ptr)
	Method PopStorageFilter()
	Method GetStorageFilterStackSize:Int()
	Method AddRetrievalFilterEntries:Int(pFilter:Byte Ptr)
	Method GetRetrievalFilter:Int(pFilter:Byte Ptr, pFilterByteLength:Int Ptr)
	Method ClearRetrievalFilter()
	Method PushEmptyRetrievalFilter:Int()
	Method PushCopyOfRetrievalFilter:Int()
	Method PushRetrievalFilter:Int(pFilter:Byte Ptr)
	Method PopRetrievalFilter()
	Method GetRetrievalFilterStackSize:Int()
	Method AddMessage:Int(Category:Int, Severity:Int, ID:Int, pDescription$z)
	Method AddApplicationMessage:Int(Severity:Int, pDescription$z)
	Method SetBreakOnCategory:Int(Category:Int, bEnable:Int)
	Method SetBreakOnSeverity:Int(Severity:Int, bEnable:Int)
	Method SetBreakOnID:Int(ID:Int, bEnable:Int)
	Method GetBreakOnCategory:Int(Category:Int)
	Method GetBreakOnSeverity:Int(Severity:Int)
	Method GetBreakOnID:Int(ID:Int)
	Method SetMuteDebugOutput(bMute:Int)
	Method GetMuteDebugOutput:Int()
EndType

EndExtern

Global IID_ID3D11Debug:Int[] = [$79cf2233, $49487536, $461e369d, $6057dc92]
Global IID_ID3D11InfoQueue:Int[] = [$6543dbb6, $42f51b48, $7ee982ab, $f62643c7]


