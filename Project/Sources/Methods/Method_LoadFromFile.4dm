//%attributes = {"invisible":true}
// Method_LoadFromFile (methodName; pathToFile) : err
// 
// DESCRIPTION
//   Loads the identified method into the host DB.
//
#DECLARE($vt_methodName : Text; $vt_pathToFileToLoad : Text)->$vl_err : Integer
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	var $vt_currentOnErrorMethod : Text
	$vt_currentOnErrorMethod:=Method called on error:C704
	OnErr_ClearError
	ON ERR CALL:C155("OnErr_GENERIC")
	
	If (File_DoesExist($vt_pathToFileToLoad))
		var $vx_methodBLOB : Blob
		DOCUMENT TO BLOB:C525($vt_pathToFileToLoad; $vx_methodBLOB)
		
		var $vx_BOM : Blob
		$vx_BOM:=UTF8_BOMString
		
		// Take the BOM off (if it has one)
		If (BLOB size:C605($vx_methodBLOB)>BLOB size:C605($vx_BOM)) & (BLOB size:C605($vx_BOM)>0)
			var $vb_BOM_doesExist : Boolean
			$vb_BOM_doesExist:=True:C214  // assume it is there
			var $i : Integer
			For ($i; 0; BLOB size:C605($vx_BOM)-1)
				If ($vx_methodBLOB{$i}#$vx_BOM{$i})  // if not match then not there
					$vb_BOM_doesExist:=False:C215
				End if 
			End for 
			
			// take it off if is there
			If ($vb_BOM_doesExist)
				DELETE FROM BLOB:C560($vx_methodBLOB; 0; BLOB size:C605($vx_BOM))
			End if 
		End if 
		
		var $vt_theCode : Text
		$vt_theCode:=BLOB to text:C555($vx_methodBLOB; UTF8 text without length:K22:17)
		
		// Convert EOL to CR before adding to 4D
		var $vt_EOL_Current : Text
		$vt_EOL_Current:=STR_TellMeTheEOL($vt_theCode)
		If ($vt_EOL_Current#Char:C90(Carriage return:K15:38))
			$vt_theCode:=Replace string:C233($vt_theCode; $vt_EOL_Current; Char:C90(Carriage return:K15:38))
		End if 
		
		METHOD SET CODE:C1194($vt_methodName; $vt_theCode; *)
		
		$vl_err:=OnErr_GetLastError
		If ($vl_err=-9766)
			BEEP:C151
			ALERT:C41(OnErr_Message)
		End if 
		
	Else 
		$vl_err:=-43  // File Not Found
	End if 
	
	OnErr_ClearError
	ON ERR CALL:C155($vt_currentOnErrorMethod)
End if 
