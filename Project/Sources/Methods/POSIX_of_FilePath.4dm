//%attributes = {"invisible":true}
// POSIX_of_FilePath (filePath) : posixPath
// POSIX_of_FilePath (text) : text
// 
// DESCRIPTION
//   Takes a input file path and converts it to a posix (unix safe) file path
//   on the mac os platform. Does nothing on windows.
//
// PARAMETERS:
C_TEXT:C284($1; $vt_pathToConvert)
//
// RETURNS:
C_TEXT:C284($0; $vt_posixPath)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (12/30/2010)
// ----------------------------------------------------

$vt_posixPath:=""
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$vt_pathToConvert:=$1
	
	If (Is Windows:C1573)
		$vt_posixPath:=$vt_pathToConvert
	Else 
		C_TEXT:C284($vt_applescriptToExecute)
		$vt_applescriptToExecute:="osascript -e 'POSIX path of \""+$vt_pathToConvert+"\"'"
		
		C_BLOB:C604($in; $out; $err)
		LAUNCH EXTERNAL PROCESS:C811($vt_applescriptToExecute; $in; $out; $err)
		$vt_posixPath:=Convert to text:C1012($out; "utf-8")
		$vt_posixPath:=Substring:C12($vt_posixPath; 1; Length:C16($vt_posixPath)-1)  //strip terminator 
	End if 
	
End if   // ASSERT
$0:=$vt_posixPath