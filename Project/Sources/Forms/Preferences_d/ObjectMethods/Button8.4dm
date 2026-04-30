var $folderForSavedStats : Text
$folderForSavedStats:=File_GetFolderName(Pref__GetFile2PrefFile)
Folder_VerifyExistance($folderForSavedStats)

SHOW ON DISK:C922($folderForSavedStats; *)
