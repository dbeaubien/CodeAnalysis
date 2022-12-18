//%attributes = {"invisible":true}
//Method: Folder_ParentName
//Created by: Peter, Feb, 2000 11:30
//Called from many places including StartWindows, StartMacintosh
//Returns the Parent Name of the file pathname we pass in
//
// Last Modified by: DB (7/25/03 @ 09:28:20) - added alternate seperator

C_TEXT:C284($0; $HFS_ParentName)
$HFS_ParentName:=""

If (DEV_ASSERT_PARMCOUNT_RANGE(Current method name:C684; 1; 2; Count parameters:C259))
	C_TEXT:C284($1; $HFS_FullPath)
	C_TEXT:C284($2)
	C_TEXT:C284($HFS_AltSeperator)
	$HFS_FullPath:=$1
	If (Count parameters:C259=2)
		$HFS_AltSeperator:=$2
	Else 
		$HFS_AltSeperator:=Folder separator:K24:12
	End if 
	
	C_LONGINT:C283($i)
	For ($i; Length:C16($HFS_FullPath); 1; -1)
		If ($HFS_FullPath[[$i]]=$HFS_AltSeperator) & ($i#Length:C16($HFS_FullPath))
			$HFS_ParentName:=Substring:C12($HFS_FullPath; 1; $i)
			$i:=0  //end loop
		End if 
	End for 
End if   // ASSERT

$0:=$HFS_ParentName

