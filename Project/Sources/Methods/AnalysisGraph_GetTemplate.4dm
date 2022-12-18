//%attributes = {"invisible":true}
// AnalysisGraph_GetTemplate () : html
// AnalysisGraph_GetTemplate () : text
// 
// DESCRIPTION
//   Loads the graphing template from the resources folder.
//
C_TEXT:C284($0; $html)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (05/12/2015)
//   Mod by: Dani Beaubien (02/02/2021) - Updated to user 4D v18 commands
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=0)
$html:=""

C_TEXT:C284($pathToTemplate)
$pathToTemplate:=Get 4D folder:C485(Current resources folder:K5:16)+"Graphs"+Folder separator:K24:12+"CA_Template.html"

If (File_DoesExist($pathToTemplate))
	$html:=Document to text:C1236($pathToTemplate; "utf-8")
Else 
	$html:=$pathToTemplate+" cannot be found."
End if 

$0:=$html