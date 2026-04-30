//%attributes = {"invisible":true}
// MACRO_MethodBody
// 
// DESCRIPTION
//   Handles the saving of the method to disk.
//
#DECLARE($vt_methodName : Text)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$vt_methodName:=$vt_methodName+" "+Time2String(Current time:C178; "24hh.mm")
	
	If (Not:C34(Is compiled mode:C492(*)))
		var $vt_text : Text
		var $vh_docRef : Time
		
		GET MACRO PARAMETER:C997(Full method text:K5:17; $vt_text)
		$vt_text:=Replace string:C233($vt_text; Char:C90(160); " ")
		$vt_text:=Replace string:C233($vt_text; "◊"; "<>")
		$vt_text:=Replace string:C233($vt_text; "≤"; "[[")
		$vt_text:=Replace string:C233($vt_text; "≥"; "]]")
		
		// Make sure that our folder exists
		var $vt_saveToPath : Text
		If (Application type:C494=4D Remote mode:K5:5)
			$vt_saveToPath:=File_GetFolderName(Application file:C491)
		Else 
			$vt_saveToPath:=File_GetFolderName(Structure file:C489(*))
		End if 
		If ($vt_saveToPath=("@.4dbase"+Folder separator:K24:12))
			$vt_saveToPath:=Folder_ParentName($vt_saveToPath)
		End if 
		$vt_saveToPath:=$vt_saveToPath+File_GetFileName(Structure file:C489(*))+" CHANGES"+Folder separator:K24:12+Date2String(Current date:C33; "YYYY-MM-DD")+Folder separator:K24:12
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
End if 

