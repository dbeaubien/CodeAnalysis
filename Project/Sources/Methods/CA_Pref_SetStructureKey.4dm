//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// CA_Pref_SetStructureKey (uniqueStructureKey)
// 
// DESCRIPTION
//   This method will allows teh caller to set the unique key
//   that is attributed to the host structure.
//   Suggest that a GUID be used.
//
//   The key is stored in the "InternalProjectName.txt" file in
//   the CodeAnalysis folder witin the host's Resources folder.
//
C_TEXT:C284($1; $structureInternalName)
ASSERT:C1129(Count parameters:C259=1)
$structureInternalName:=$1

C_TEXT:C284($vt_tmpFilePath)
$vt_tmpFilePath:=Get 4D folder:C485(Current resources folder:K5:16; *)+"Code Analysis"+Folder separator:K24:12+"InternalProjectName.txt"
Folder_VerifyExistance(File_GetFolderName($vt_tmpFilePath))
File_Delete($vt_tmpFilePath)  // remove any existing document that might be there

C_TIME:C306($fileRef)
$fileRef:=Create document:C266($vt_tmpFilePath)
If (OK=1)
	SEND PACKET:C103($fileRef; $structureInternalName)
	CLOSE DOCUMENT:C267($fileRef)
End if 

If (Storage:C1525.hostStructure=Null:C1517)
	Use (Storage:C1525)
		Storage:C1525.hostStructure:=New shared object:C1526
	End use 
End if 

Use (Storage:C1525.hostStructure)
	Storage:C1525.hostStructure.internalName:=$structureInternalName
End use 
