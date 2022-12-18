//%attributes = {"invisible":true}
// File_GetFileName (filePath) : filename
// File_GetFileName (text) : text
//
// DESCRIPTION
//   Given the path to a document, returns the document itself.
//
C_TEXT:C284($1; $vt_docPath)  // Full path to document
C_TEXT:C284($0; $vt_document)  // file name
//---------------------------------------------------
// HISTORY
//   Created: Jeremy Sullivan (October 16, 2001  5:29 PM) - HD Industries, Inc (http://www.hdind.com)
//   Mod by: Dani Beaubien (01/22/2016) - Rewrote
//---------------------------------------------------

$vt_document:=""
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$vt_docPath:=$1
	
	Case of 
		: ($vt_docPath="")
			$vt_document:=""
			
		: ($vt_docPath=(Folder separator:K24:12+"@"))
			$vt_document:=""
			
		Else 
			ARRAY TEXT:C222($at_segments; 0)
			Array_ConvertFromTextDelimited(->$at_segments; $vt_docPath; Folder separator:K24:12)
			If (Size of array:C274($at_segments)=1)
				$vt_document:=$at_segments{1}
			Else 
				$vt_document:=Substring:C12($vt_docPath; 1+Length:C16($vt_docPath)-Length:C16($at_segments{Size of array:C274($at_segments)}))
			End if 
	End case 
	
End if   // ASSERT
$0:=$vt_document