//%attributes = {"invisible":true}
// AnalysisGraph_GetTemplate () : html
// 
// DESCRIPTION
//   Loads the graphing template from the resources folder.
//
#DECLARE()->$html : Text
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=0)
$html:=""

var $pathToTemplate : Text
$pathToTemplate:=Get 4D folder:C485(Current resources folder:K5:16)+"Graphs"+Folder separator:K24:12+"CA_Template.html"

If (File_DoesExist($pathToTemplate))
	$html:=Document to text:C1236($pathToTemplate; "utf-8")
Else 
	$html:=$pathToTemplate+" cannot be found."
End if 

return $html