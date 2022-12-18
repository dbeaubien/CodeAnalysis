//%attributes = {"invisible":true}
// Sqlite_DoCommand (PathToDatabase; command) : results
// Sqlite_DoCommand (text; text) : results
// 
// DESCRIPTION
//   Executes the command on the specified Sqlite database.
//
C_TEXT:C284($1; $vt_PathToDatabase)
C_TEXT:C284($2; $vt_command)
C_TEXT:C284($0; $vt_result)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (08/04/2013)
// ----------------------------------------------------

$vt_result:=""
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	$vt_PathToDatabase:=$1
	$vt_command:=Replace string:C233($2; "'"; "\\'")
	
	C_TEXT:C284($vt_commandToExecute)
	$vt_commandToExecute:="sqlite3 \""+POSIX_of_FilePath($vt_PathToDatabase)+"\" "
	$vt_commandToExecute:=$vt_commandToExecute+"'"+$vt_command+"'"
	
	C_BLOB:C604($in; $out; $err)
	LAUNCH EXTERNAL PROCESS:C811($vt_commandToExecute; $in; $out; $err)
	
	If (BLOB size:C605($out)>0)
		$vt_result:="OUT: "+Convert to text:C1012($out; "utf-8")
	End if 
	
	If (BLOB size:C605($err)>0)
		If ($vt_result#"")
			$vt_result:=$vt_result+"\r"
		End if 
		$vt_result:="ERROR: "+Convert to text:C1012($err; "utf-8")
	End if 
	
End if   // ASSERT
$0:=$vt_result