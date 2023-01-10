//%attributes = {"invisible":true,"preemptive":"capable"}
// Explorer__MethodStatsToExlprRow (methodStatsObj;$explorerRowObj)
//
// DESCRIPTION
//   Updates the explorer row object with the information
//   from the method stats object.
//
C_OBJECT:C1216($1; $methodStatsObj)
C_OBJECT:C1216($2; $explorerRowObj)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (02/08/2021)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=2)
$methodStatsObj:=$1
$explorerRowObj:=$2

If ($methodStatsObj#Null:C1517)
	$explorerRowObj.path:=$methodStatsObj.path
	$explorerRowObj.name:=$methodStatsObj.viewing_name
	$explorerRowObj.numGitCommits:=0
	$explorerRowObj.numCodeLines:=$methodStatsObj.line_counts.lines
	$explorerRowObj.numCommentLines:=$methodStatsObj.line_counts.comments
	$explorerRowObj.numBlankLines:=$methodStatsObj.line_counts.blank
	$explorerRowObj.codeComplexity:=$methodStatsObj.analysis.complexity
	$explorerRowObj.nestedLevels:=$methodStatsObj.analysis.max_nesting_level
	If (STR_IsOneOf($explorerRowObj.name; "[DatabaseMethod]@"; "[ProjectForm]@"; "[TableForm]@"; "[trigger]@"; ""; ""))
		$explorerRowObj.numTimesCalled:=1
		$explorerRowObj.upstreamMethodPaths:=New collection:C1472
	Else 
		$explorerRowObj.numTimesCalled:=$methodStatsObj.references.upstream_methods.length
		$explorerRowObj.upstreamMethodPaths:=$methodStatsObj.references.upstream_methods
	End if 
	$explorerRowObj.lastSavedTS:=$methodStatsObj.last_modified_dts
	$explorerRowObj.lastSavedStr:=Date2String(TS_GetDate($methodStatsObj.last_modified_dts); "yyyy-mm-dd")+" @ "+Time2String(TS_GetTime($methodStatsObj.last_modified_dts); "24hh:mm:ss")
	$explorerRowObj.doHideRow:=True:C214
End if 