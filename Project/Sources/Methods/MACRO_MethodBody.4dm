//%attributes = {"invisible":true}
// ----------------------------------------------------
// METHOD: MACRO_MethodBody
// 
// DESCRIPTION
//   Handles the saving of the method to disk.
//
// PARAMETERS:
C_TEXT:C284($1; $vt_methodName)
//
// RETURNS:
//   none
// ----------------------------------------------------
// CALLED BY
//   
// ----------------------------------------------------
// HISTORY 
//   Created by: DB (07/05/10)
//   Mod: DB (08/06/2010) - added support for "≤" and "≥"
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$vt_methodName:=$1
	
	$vt_methodName:=$vt_methodName+" "+Time2String(CurrentTime; "24hh.mm")
	
	If (Not:C34(Is compiled mode:C492(*)))
		C_TEXT:C284($vt_text)
		C_TIME:C306($vh_docRef)
		
		GET MACRO PARAMETER:C997(Full method text:K5:17; $vt_text)
		$vt_text:=Replace string:C233($vt_text; Char:C90(160); " ")
		$vt_text:=Replace string:C233($vt_text; "◊"; "<>")
		$vt_text:=Replace string:C233($vt_text; "≤"; "[[")
		$vt_text:=Replace string:C233($vt_text; "≥"; "]]")
		
		// Make sure that our folder exists
		C_TEXT:C284($vt_saveToPath)
		If (Application type:C494=4D Remote mode:K5:5)
			$vt_saveToPath:=File_GetFolderName(Application file:C491)
		Else 
			$vt_saveToPath:=File_GetFolderName(Structure file:C489(*))
		End if 
		If ($vt_saveToPath=("@.4dbase"+Folder separator:K24:12))
			$vt_saveToPath:=Folder_ParentName($vt_saveToPath)
		End if 
		$vt_saveToPath:=$vt_saveToPath+File_GetFileName(Structure file:C489(*))+" CHANGES"+Folder separator:K24:12+Date2String(CurrentDate; "YYYY-MM-DD")+Folder separator:K24:12
		Folder_VerifyExistance($vt_saveToPath)
		
		// Save the file
		$vt_saveToPath:=$vt_saveToPath+$vt_methodName+".txt"
		File_Delete($vt_saveToPath)
		$vh_docRef:=Create document:C266($vt_saveToPath)
		If (OK=1)
			SEND PACKET:C103($vh_docRef; $vt_text)
			CLOSE DOCUMENT:C267($vh_docRef)
		End if 
	End if 
End if   // ASSERT

