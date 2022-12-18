//%attributes = {"invisible":true}
// MethodStats__LoadFromDisk () 
// 
// DESCRIPTION
//   Restores the results of the stored method stats
//   from disk.
//
// ----------------------------------------------------
// CALLED BY
//   MethodStats__Init
// ----------------------------------------------------
// HISTORY
//   Created by: DB (12/17/2014)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=0)

C_TEXT:C284($folderForSavedStats)
$folderForSavedStats:=File_GetFolderName(Pref__GetFile2PrefFile)

If (File_DoesExist($folderForSavedStats+"method stats.json"))  // If file does not exist, then do nothing 
	C_TEXT:C284($json)
	$json:=Document to text:C1236($folderForSavedStats+"method stats.json"; "utf-8")
	If ($json="{@}")
		C_OBJECT:C1216($parsedJson)
		$parsedJson:=JSON Parse:C1218($json)
		Use (Storage:C1525)
			Storage:C1525.methodStats:=New shared object:C1526  // make sure it exists and has been cleared
		End use 
		
		Use (Storage:C1525.methodStats)
			OB_CopyObject($parsedJson; Storage:C1525.methodStats)
		End use 
		
		MethodStats__RefreshTotals
	End if 
End if 
