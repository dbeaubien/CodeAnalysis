//%attributes = {}
// ExplorerWin_MethodUpdated (methodPath, updateToDo)
//
// DESCRIPTION
//   A way to notify the explorer window that an update is
//   needed for the specified method.
//
#DECLARE($methodPath : Text; $updateToDo : Text)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=2)
ASSERT:C1129(STR_IsOneOf($updateToDo; "update"; "add"; "delete"))

Case of 
	: (Num:C11(Storage:C1525.explorerWindow.processId)=0)
		// NOP
		
	: (Storage:C1525.explorerWindow.windowRef=0)  // window not open yet?
		// NOP
		
	: (Storage:C1525.explorerWindow.processId#Current process:C322)
		CALL FORM:C1391(Storage:C1525.explorerWindow.windowRef; Current method name:C684; $methodPath; $updateToDo)
		
	Else   // in context of the form
		Explorer_UpdateMethodInfo(Form:C1466; $methodPath; $updateToDo)
		Explorer_ApplyMethodFilter(Form:C1466)
End case 