//%attributes = {"invisible":true}
// CLEANUP_IsOldStuffInstalled () 
// 
// DESCRIPTION
//   Does a check to see if any old code/forms are installed
//   in the host database. Reports to the user with a reminder for
//   for them to delete if there are.
//
// ----------------------------------------------------
// HISTORY
//   Created by: DB (01/20/2015)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 0; Count parameters:C259))
	If (Structure file:C489(*)#Structure file:C489)  // Are we NOT running locally?
		
		C_TEXT:C284($vt_onErrorMethod)
		$vt_onErrorMethod:=Method called on error:C704
		ON ERR CALL:C155("OnErr_SupressError")
		
		// Init vars
		ARRAY TEXT:C222($at_stuffToRemove; 0)
		C_TEXT:C284($vt_formCode)
		
		// Check project form
		OnErr_ClearError
		METHOD GET CODE:C1190("[projectForm]/CodeAnalysis_FormScanner/Invisible Button"; $vt_formCode; *)
		If (OnErr_GetLastError=0)
			APPEND TO ARRAY:C911($at_stuffToRemove; "ProjectForm \"CodeAnalysis_FormScanner\"")
		End if 
		
		// Check "CodeAnalysis_GetFormNames" project method
		OnErr_ClearError
		METHOD GET CODE:C1190("CodeAnalysis_GetFormNames"; $vt_formCode; *)
		If (OnErr_GetLastError=0)
			APPEND TO ARRAY:C911($at_stuffToRemove; "Project Method \"CodeAnalysis_GetFormNames\"")
		End if 
		
		// Check "CodeAnalysis_GetFormProperties" project method
		OnErr_ClearError
		METHOD GET CODE:C1190("CodeAnalysis_GetFormProperties"; $vt_formCode; *)
		If (OnErr_GetLastError=0)
			APPEND TO ARRAY:C911($at_stuffToRemove; "Project Method \"CodeAnalysis_GetFormProperties\"")
		End if 
		
		// Check "CodeAnalysis_FormScannerDialog" project method
		OnErr_ClearError
		METHOD GET CODE:C1190("CodeAnalysis_FormScannerDialog"; $vt_formCode; *)
		If (OnErr_GetLastError=0)
			APPEND TO ARRAY:C911($at_stuffToRemove; "Project Method \"CodeAnalysis_FormScannerDialog\"")
		End if 
		
		// Check "CodeAnalysis_FormObjectStub" project method
		OnErr_ClearError
		METHOD GET CODE:C1190("CodeAnalysis_FormObjectStub"; $vt_formCode; *)
		If (OnErr_GetLastError=0)
			If (Pref_GetPrefString("isFormObjectStubRemoved")="")  // only clean up "once"
				FormProperties_RemoveStub
				Pref_SetPrefString("isFormObjectStubRemoved"; "Done "+Date2String(CurrentDate; "YYYY-MM-DD"))
			End if 
			APPEND TO ARRAY:C911($at_stuffToRemove; "Project Method \"CodeAnalysis_FormObjectStub\"")
		End if 
		
		
		OnErr_ClearError  //   Mod by: Dani Beaubien (06/22/2013)
		ON ERR CALL:C155($vt_onErrorMethod)  // restore our method
		
		If (Size of array:C274($at_stuffToRemove)>0)
			C_TEXT:C284($vt_msg)
			$vt_msg:="The following items are no longer needed and can be deleted from your structure:"
			C_LONGINT:C283($i)
			For ($i; 1; Size of array:C274($at_stuffToRemove))
				$vt_msg:=$vt_msg+"\r - "+$at_stuffToRemove{$i}
			End for 
			
			LogEvent_Write(Str_DateTimeStamp+"\t ** "+$vt_msg+"\r")  // Write to the log
			
			BEEP:C151
			ALERT:C41($vt_msg)
		End if 
	End if 
End if   // ASSERT
