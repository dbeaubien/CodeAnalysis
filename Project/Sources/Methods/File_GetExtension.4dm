//%attributes = {"invisible":true}
// File_GetExtension
// 
// DESCRIPTION
//   Returns the extension from a filename
//
#DECLARE($path : Text) : Text
// ----------------------------------------------------

var $i; $position : Integer

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
	return Substring:C12($path; $position+1)
Else 
	return ""  // no extension
End if 