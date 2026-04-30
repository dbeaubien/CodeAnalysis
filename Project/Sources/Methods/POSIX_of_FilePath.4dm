//%attributes = {"invisible":true}
// POSIX_of_FilePath (filePath) : posixPath
// 
// DESCRIPTION
//   Takes a input file path and converts it to a posix (unix safe) file path
//   on the mac os platform. Does nothing on windows.
//
#DECLARE($vt_pathToConvert : Text)->$vt_posixPath : Text
// ----------------------------------------------------
$vt_posixPath:=""

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	
	If (Is Windows:C1573)
		$vt_posixPath:=$vt_pathToConvert
	Else 
		var $vt_applescriptToExecute : Text
		$vt_applescriptToExecute:="osascript -e 'POSIX path of \""+$vt_pathToConvert+"\"'"
		
		var $in; $out; $err : Blob
		LAUNCH EXTERNAL PROCESS:C811($vt_applescriptToExecute; $in; $out; $err)
		$vt_posixPath:=Convert to text:C1012($out; "utf-8")
		$vt_posixPath:=Substring:C12($vt_posixPath; 1; Length:C16($vt_posixPath)-1)  //strip terminator 
	End if 
	
End if 
