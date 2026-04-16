//%attributes = {"invisible":true}
// Folder_ParentName
//
// Returns the Parent Name of the file pathname we pass in
//
#DECLARE($platformPath : Text; $folder_separator : Text)->$parent_folder_name : Text
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT_RANGE(Current method name:C684; 1; 2; Count parameters:C259))
	If ($folder_separator="")
		$folder_separator:=Folder separator:K24:12
	End if 
	
	var $i : Integer
	For ($i; Length:C16($platformPath); 1; -1)
		If ($platformPath[[$i]]=$folder_separator) & ($i#Length:C16($platformPath))
			$parent_folder_name:=Substring:C12($platformPath; 1; $i)
			$i:=0  //end loop
		End if 
	End for 
End if 
