//%attributes = {"invisible":true}
// ----------------------------------------------------
// METHOD: File_GetExtension
// 
// DESCRIPTION
//   Returns the extension from a filename
//
// PARAMETERS:
C_TEXT:C284($1; $path)
//
// RETURNS:
C_TEXT:C284($0)
// ----------------------------------------------------
// CALLED BY
//   
// ----------------------------------------------------
// HISTORY
//   Created by:  Rob Liveau (nuggers)
//   Mod: DB (11/20/07) - pay attention to the folder seperator
// ----------------------------------------------------

C_LONGINT:C283($i; $position)
$path:=$1

$position:=0
For ($i; Length:C16($path); 1; -1)
	Case of 
		: ($path[[$i]]=".")
			$position:=$i
			$i:=0
			
		: ($path[[$i]]=Folder separator:K24:12) & ($i#Length:C16($path))  // end of file name
			$i:=0
	End case 
End for 


If ($position>0)
	$0:=Substring:C12($path; $position+1)
Else 
	$0:=""  // no extension
End if 