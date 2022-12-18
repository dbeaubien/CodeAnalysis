//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// CA_Pref_GetStructureKey : uniqueStructureKey
// CA_Pref_GetStructureKey : text
// 
// DESCRIPTION
//   This method will return the unique key that attributed
//   to the host structure. 
//
//   The key is stored in the "InternalProjectName.txt" file in
//   the CodeAnalysis folder witin the host's Resources folder.
//
C_TEXT:C284($0; $structureInternalName)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (03/25/2017)
// ----------------------------------------------------

$structureInternalName:=""

If (Storage:C1525.hostStructure=Null:C1517)
	Use (Storage:C1525)
		Storage:C1525.hostStructure:=New shared object:C1526
	End use 
End if 

If (String:C10(Storage:C1525.hostStructure.internalName)="")
	// Location for the internal name that CodeAnalysis uses to store the preferences
	C_TEXT:C284($tmpFilePath)
	$tmpFilePath:=Get 4D folder:C485(Current resources folder:K5:16; *)+"Code Analysis"+Folder separator:K24:12+"InternalProjectName.txt"
	Folder_VerifyExistance(File_GetFolderName($tmpFilePath))
	
	C_TIME:C306($fileRef)
	If (Test path name:C476($tmpFilePath)=Is a document:K24:1)
		$fileRef:=Open document:C264($tmpFilePath; Read mode:K24:5)
		If (OK=1)
			RECEIVE PACKET:C104($fileRef; $structureInternalName; 1000)
			CLOSE DOCUMENT:C267($fileRef)
		End if 
		
		Use (Storage:C1525.hostStructure)
			Storage:C1525.hostStructure.internalName:=$structureInternalName
		End use 
		
	Else 
		CA_Pref_SetStructureKey(Generate UUID:C1066)
	End if 
End if 

$structureInternalName:=Storage:C1525.hostStructure.internalName
$0:=$structureInternalName
