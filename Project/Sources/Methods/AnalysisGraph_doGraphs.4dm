//%attributes = {"invisible":true}
// AnalysisGraph_doGraphs ()
// 
// DESCRIPTION
//   Builds the code analysis graphs.
//   Relies on process arrays being populated.
//
// ----------------------------------------------------
// HISTORY
//   Created by: DB (11/12/2014)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=0)

C_BOOLEAN:C305(<>_GraphIsInited)
<>_GraphIsInited:=True:C214
ARRAY PICTURE:C279(<>_Graphs; 3)
ARRAY TEXT:C222(<>_Graphs_Label; 3)

C_LONGINT:C283($graphNo)
For ($graphNo; 1; Size of array:C274(<>_Graphs))
	Case of 
		: ($graphNo=1)
			<>_Graphs_Label{$graphNo}:="# by Length"
			AnalysisGraph_doTab1Graph
			
		: ($graphNo=2)
			<>_Graphs_Label{$graphNo}:="# by Complexity"
			AnalysisGraph_doTab2Graph
			
		: ($graphNo=3)
			<>_Graphs_Label{$graphNo}:="# by Max Nested Level"
			AnalysisGraph_doTab3Graph
			
			
	End case 
	
End for 