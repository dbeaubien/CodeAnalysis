//%attributes = {"invisible":true}
// Sqlite_DoCommand (PathToDatabase; command) : results
// 
// DESCRIPTION
//   Executes the command on the specified Sqlite database.
//
#DECLARE($vt_PathToDatabase : Text; $vt_command : Text)->$vt_result : Text
// ----------------------------------------------------

$vt_result:=""
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	$vt_command:=Replace string:C233($vt_command; "'"; "\\'")
	
	var $vt_commandToExecute : Text
	$vt_commandToExecute:="sqlite3 \""+POSIX_of_FilePath($vt_PathToDatabase)+"\" "
	$vt_commandToExecute:=$vt_commandToExecute+"'"+$vt_command+"'"
	
	var $in; $out; $err : Blob
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
	
End if 
