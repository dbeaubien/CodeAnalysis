C_TEXT:C284($folderForSavedStats)
$folderForSavedStats:=File_GetFolderName(Pref__GetFile2PrefFile)
Folder_VerifyExistance($folderForSavedStats)

SHOW ON DISK:C922($folderForSavedStats; *)
