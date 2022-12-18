//%attributes = {"invisible":true}
// Method_LoadFromFile (methodName; pathToFile) : err
// Method_LoadFromFile (text; text) : longint
// 
// DESCRIPTION
//   Loads the identified method into the host DB.
//
C_TEXT:C284($1; $vt_methodName)
C_TEXT:C284($2; $vt_pathToFileToLoad)
C_LONGINT:C283($0; $vl_err)
// ----------------------------------------------------
// CALLED BY
//   Layout Genearator_d.ListBox_diffs
//   Host_VerifyMethodExists
// ----------------------------------------------------
// HISTORY
//   Created by: DB (03/28/2014)
// ----------------------------------------------------

C_LONGINT:C283($0; $vl_err)
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	$vt_methodName:=$1
	$vt_pathToFileToLoad:=$2
	
	C_TEXT:C284($vt_currentOnErrorMethod)
	$vt_currentOnErrorMethod:=Method called on error:C704
	OnErr_ClearError
	ON ERR CALL:C155("OnErr_GENERIC")
	
	If (File_DoesExist($vt_pathToFileToLoad))
		C_BLOB:C604($vx_methodBLOB)
		DOCUMENT TO BLOB:C525($vt_pathToFileToLoad; $vx_methodBLOB)
		
		C_BLOB:C604($vx_BOM)
		$vx_BOM:=UTF8_BOMString
		
		// Take the BOM off (if it has one)
		If (BLOB size:C605($vx_methodBLOB)>BLOB size:C605($vx_BOM)) & (BLOB size:C605($vx_BOM)>0)
			C_BOOLEAN:C305($vb_BOM_doesExist)
			$vb_BOM_doesExist:=True:C214  // assume it is there
			C_LONGINT:C283($i)
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
		
		C_TEXT:C284($vt_theCode)
		$vt_theCode:=BLOB to text:C555($vx_methodBLOB; UTF8 text without length:K22:17)
		
		//   Mod by: Dani Beaubien (02/17/2014) - Convert EOL to CR before adding to 4D
		C_TEXT:C284($vt_EOL_Current)
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
End if   // ASSERT
$0:=$vl_err