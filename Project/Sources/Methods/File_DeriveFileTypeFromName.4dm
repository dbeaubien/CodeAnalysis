//%attributes = {"invisible":true}
// File_DeriveFileTypeFromName
// 
// DESCRIPTION
//   Figure out what the file type is basd on the file name.
//
#DECLARE($vt_fileName : Text)->$vt_FileType : Text
// ----------------------------------------------------
$vt_FileType:=""

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	
	// Get our file extn. If windows, then we are done
	$vt_FileType:=File_GetExtension($vt_fileName)
	
	// If mac, then we have more work to do
	If (Is macOS:C1572)
		Case of 
			: ($vt_FileType="xls") | ($vt_FileType="slk")
				$vt_FileType:="XLS8"
				
			Else   // by default
				$vt_FileType:="TEXT"
		End case 
	End if 
	
End if 
