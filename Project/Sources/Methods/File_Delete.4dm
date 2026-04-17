//%attributes = {"invisible":true}
// File_Delete (path to file)
// 
// DESCRIPTION
//   Deletes the document pass to it.
//
#DECLARE($file_platformPath : Text)
// ----------------------------------------------------

If ($file_platformPath#"") && (Test path name:C476($file_platformPath)=Is a document:K24:1)
	DELETE DOCUMENT:C159($file_platformPath)
End if 
