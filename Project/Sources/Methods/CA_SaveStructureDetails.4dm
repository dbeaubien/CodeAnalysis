//%attributes = {"invisible":true,"shared":true}
// CA_SaveStructureDetails ({rootFolderPath})
// CA_SaveStructureDetails ({text})
//
// DESCRIPTION
//   Calling this method will cause the component to export the stucture.
//
//   If no folder is specified, then the folder as declared in the
//   component preferences will be used.
//
C_TEXT:C284($1; $vt_rootFolder)  // OPTIONAL - folder to store the exported method code
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (01/26/2021)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259<=1)

If (Count parameters:C259>=1)
	$vt_rootFolder:=$1
	If ($vt_rootFolder#"")
		If ($vt_rootFolder[[Length:C16($vt_rootFolder)]]#Folder separator:K24:12)  // make sure the path ends in a folder
			$vt_rootFolder:=$vt_rootFolder+Folder separator:K24:12
		End if 
	End if 
End if 

// # Get the folder name all worked out
If ($vt_rootFolder="")
	$vt_rootFolder:=CodeAnalysis__GetDestFolder
End if 
Folder_VerifyExistance($vt_rootFolder)

C_BOOLEAN:C305($vb_doAppendDate; $vb_doAppendTime)
If (Pref_GetPrefString("EXPORT - Append Date to Form Folder Name"; "1")="1")
	$vb_doAppendDate:=True:C214
	$vb_doAppendTime:=True:C214
Else 
	$vb_doAppendDate:=(Pref_GetPrefString("EXPORT - Append to Form Folder Name"; "Date and Time")="Date@")
	$vb_doAppendTime:=(Pref_GetPrefString("EXPORT - Append to Form Folder Name")="Date and Time")
End if 

// Build the file name
C_TEXT:C284($vt_fileName)
$vt_fileName:="Structure Table Definition"
If ($vb_doAppendDate)  //   Mod by: Dani Beaubien (10/01/2012) - Append Date?
	$vt_fileName:=$vt_fileName+Date2String(Current date:C33; " YYYY-MM-DD")
End if 
If ($vb_doAppendTime)  //   Mod: DB (08/29/2015)
	$vt_fileName:=$vt_fileName+Time2String(Current time:C178; " 24hh.mm.ss")
End if 
$vt_fileName:=$vt_fileName+".json"

Structure_SaveStructDefn2Folder($vt_rootFolder+$vt_fileName)

