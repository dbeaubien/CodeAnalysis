//%attributes = {}
//Dev_4DprefsFilePath
//$0 chemin du fichier des préférences 4D courant
//contient entre autres les couleurs de l'éditeur de méthode

// FROM DISCUSS FORUM: https://discuss.4d.com/t/formatted-method-code/14299/9


C_TEXT:C284($0; $path_t)
C_TEXT:C284($version_t)

$path_t:=Convert path system to POSIX:C1106(System folder:C487(User preferences_user:K41:4))
$path_t:=$path_t+"/4D/4D Preferences __VERSION__.4DPreferences"
$version_t:="v"+Substring:C12(Application version:C493; 1; 2)
$path_t:=Replace string:C233($path_t; "__VERSION__"; $version_t; *)
$path_t:=Convert path POSIX to system:C1107($path_t)
If (Test path name:C476($path_t)=Is a document:K24:1)
	$0:=$path_t
End if 
//_