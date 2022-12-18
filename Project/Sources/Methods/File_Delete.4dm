//%attributes = {"invisible":true}
// File_Delete (path to file)
// File_Delete (text)
// 
// DESCRIPTION
//   Deletes the document pass to it.
//
C_TEXT:C284($1; $vt_fileName)
// ----------------------------------------------------
//   Created by: DB (07/25/07)
// ----------------------------------------------------

$vt_fileName:=$1

If (File_DoesExist($vt_fileName))
	DELETE DOCUMENT:C159($vt_fileName)
End if 
