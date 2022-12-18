//%attributes = {"invisible":true}
// FormProperties_RemoveStub ()
//
// DESCRIPTION
//   Removes the usage of "CodeAnalysis_FormObjectStub" from
//   the code. THe need for this code has been depricated.
//
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (11/05/2012)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 0; Count parameters:C259))
	If (Structure file:C489(*)=Structure file:C489)  // Are we running locally?
		BEEP:C151
		ALERT:C41("This function can not be used directly from within the Code Analysis Component.")
		
	Else 
		C_LONGINT:C283($progHdl)
		$progHdl:=Progress New
		
		C_PICTURE:C286($vg_icon)
		READ PICTURE FILE:C678(LibraryImage_GetPlatformPath("Progress_RemoveCode.png"); $vg_icon)
		Progress SET ICON($progHdl; $vg_icon)
		
		Progress SET TITLE($progHdl; "Removing Code Analysis Code Stubs"; -1; "Initializing..."; True:C214)
		Progress SET BUTTON ENABLED($progHdl; True:C214)
		
		// Get the max count for the progress window
		C_LONGINT:C283($vl_maxCount)
		$vl_maxCount:=0
		ARRAY TEXT:C222(at_methodNames; 0)
		METHOD GET PATHS:C1163(Path project form:K72:3; at_methodNames; *)
		$vl_maxCount:=$vl_maxCount+Size of array:C274(at_methodNames)
		METHOD GET PATHS:C1163(Path table form:K72:5; at_methodNames; *)
		$vl_maxCount:=$vl_maxCount+Size of array:C274(at_methodNames)
		
		C_LONGINT:C283($vl_curCount; $loop; $i)
		For ($loop; 1; 2)
			ARRAY TEXT:C222(at_methodNames; 0)
			If ($loop=1)
				Progress SET MESSAGE($progHdl; "Removing from project forms...")
				METHOD GET PATHS:C1163(Path project form:K72:3; at_methodNames; *)  //   Mod by: Dani Beaubien (10/03/2012)
			End if 
			If ($loop=2)
				Progress SET MESSAGE($progHdl; "Removing from table forms...")
				METHOD GET PATHS:C1163(Path table form:K72:5; at_methodNames; *)  //   Mod by: Dani Beaubien (10/03/2012)
			End if 
			
			C_TEXT:C284($vt_theCode)
			C_BOOLEAN:C305($vb_changeMade)
			$vt_theCode:=""
			For ($i; 1; Size of array:C274(at_methodNames))
				$vl_curCount:=$vl_curCount+1
				Progress SET PROGRESS($progHdl; ($vl_curCount/$vl_maxCount))
				
				If (at_methodNames{$i}#"@/CodeAnalysis_FormScanner/@") | ($loop=2)  // don't modify our project form
					METHOD GET CODE:C1190(at_methodNames{$i}; $vt_theCode; *)
					
					ARRAY TEXT:C222($at_codeLines; 0)
					ARRAY_Unpack($vt_theCode; ->$at_codeLines; "\r")
					
					$vb_changeMade:=False:C215
					Case of 
						: (Size of array:C274($at_codeLines)<2)
							// NOP 
							
						: ($at_codeLines{2}="CodeAnalysis_FormObjectStub @")
							$vb_changeMade:=True:C214
							DELETE FROM ARRAY:C228($at_codeLines; 2; 1)
							
						Else   // all is good
							// NOP 
					End case 
					
					If ($vb_changeMade)
						$vt_theCode:=Array_ConvertToTextDelimited(->$at_codeLines; "\r")  //   Mod by: Dani Beaubien (02/17/2014)
						METHOD SET CODE:C1194(at_methodNames{$i}; $vt_theCode; *)
					End if 
				End if 
				
				// Progess window was aborted, stop processing
				If (Progress Stopped($progHdl))
					$i:=Size of array:C274(at_methodNames)+1
					$loop:=5
				End if 
				
			End for 
		End for 
		
		Progress QUIT($progHdl)
	End if 
End if   // ASSERT