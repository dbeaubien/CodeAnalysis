//%attributes = {"invisible":true,"preemptive":"capable"}
// LibraryImage_GetPlatformPath (image_name) : platformPath
// 
#DECLARE($image_name : Text)->$platformPath : Text
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)

$platformPath:=Folder:C1567(fk resources folder:K87:11)\
.folder("Images")\
.folder("Library")\
.file($image_name)\
.platformPath
