//%attributes = {"shared":true}
// CA_ShowExplorer ()
//
// DESCRIPTION
//   Opens the explorer window.
//
// Calling this method opens a window that shows all the methods in your project.
// From here you will be able to:
//  -View metrics on your code
//  -View the last time the method was updated
//
// NOTE: This method can only be used in an uncompiled host database
If (False:C215)
	// ----------------------------------------------------
	// HISTORY
	//   Created by: Dani Beaubien (12/14/2016)
	// ----------------------------------------------------
End if 

// NOTE: This method is shared with the host DB

If (Is compiled mode:C492(*))
	BEEP:C151
	ALERT:C41("This component can only be used in an uncompiled host database.")
	
Else 
	Component_init
	
	If (Process_LaunchAsNew(Current method name:C684; Current method name:C684))
		
		Use (Storage:C1525)
			Storage:C1525.explorerWindow:=New shared object:C1526("processId"; Current process:C322; "windowRef"; 0)
		End use 
		
		MethodStats_RecalculateModified
		
		C_POINTER:C301($NIL_p)
		WIN_Dialog($NIL_p; "Explorer_d"; Plain window:K34:13; "Code Analysis Explorer"; On the left:K39:2; At the top:K39:5)
		
		Use (Storage:C1525.explorerWindow)
			Storage:C1525.explorerWindow.processId:=0
			Storage:C1525.explorerWindow.windowRef:=0
		End use 
	End if 
	
End if 