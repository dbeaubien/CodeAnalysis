//%attributes = {"invisible":true}
// AnalysisGraph_doTab2Graph ()
// 
// DESCRIPTION
//   Produces the HTML file for the method break down by complexity.
//
// ----------------------------------------------------
// CALLED BY
//   AnalysisGraph_doGraphs
// ----------------------------------------------------
// HISTORY
//   Created by: DB (05/12/2015)
//   Mod by: Dani Beaubien (02/02/2021) - Updated to use objects
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=0)

// Setup the arrays to hold our graph data
C_LONGINT:C283($vl_CC_mid; $vl_CC_high)
$vl_CC_mid:=Num:C11(Pref_GetPrefString("CC Med Risk"; "11"))
$vl_CC_high:=Num:C11(Pref_GetPrefString("CC High Risk"; "25"))
ARRAY LONGINT:C221($al_lineBreaks; 0)
APPEND TO ARRAY:C911($al_lineBreaks; 5)  // 0 to 5
APPEND TO ARRAY:C911($al_lineBreaks; $vl_CC_mid)  // 0 to 11?
APPEND TO ARRAY:C911($al_lineBreaks; $vl_CC_high)  // 11 to 25
APPEND TO ARRAY:C911($al_lineBreaks; MAXLONG:K35:2)
ARRAY LONGINT:C221($al_lineBreaksCounts; Size of array:C274($al_lineBreaks))

// Load the template
C_TEXT:C284($templateHTML)
$templateHTML:=AnalysisGraph_GetTemplate

ARRAY TEXT:C222($methodObjNames; 0)
Method_GetMethodObjNames(->$methodObjNames)

ARRAY LONGINT:C221($al_tmp; Size of array:C274($methodObjNames))
C_OBJECT:C1216($methodLineCounts)
For ($i; 1; Size of array:C274($methodObjNames))
	$al_tmp{$i}:=MethodStatsMasterObj[$methodObjNames{$i}].analysis.complexity
End for 
SORT ARRAY:C229($al_tmp)

C_LONGINT:C283($i; $vl_curIndex; $vl_lowerLimit; $vl_upperLimit)
$vl_curIndex:=1
$vl_lowerLimit:=0
$vl_upperLimit:=$al_lineBreaks{$vl_curIndex}
For ($i; 1; Size of array:C274($al_tmp))
	If ($al_tmp{$i}<=$vl_upperLimit)
		$al_lineBreaksCounts{$vl_curIndex}:=$al_lineBreaksCounts{$vl_curIndex}+1
	Else 
		$i:=$i-1  // roll back one loop
		
		$vl_curIndex:=$vl_curIndex+1
		$vl_lowerLimit:=$vl_upperLimit
		$vl_upperLimit:=$al_lineBreaks{$vl_curIndex}
	End if 
End for 


// Build the strings that will get put into the template
C_TEXT:C284($labelStr; $dataStr)
$labelStr:=""
$dataStr:=""
$vl_lowerLimit:=0
For ($i; 1; Size of array:C274($al_lineBreaks))
	If ($i#1)
		$labelStr:=$labelStr+","
		$dataStr:=$dataStr+","
		$vl_lowerLimit:=$al_lineBreaks{$i-1}
	End if 
	$vl_upperLimit:=$al_lineBreaks{$i}
	If ($vl_upperLimit=MAXLONG:K35:2)
		$labelStr:=$labelStr+"\""+String:C10($vl_lowerLimit+1)+"+ complexity\""
	Else 
		$labelStr:=$labelStr+"\""+String:C10($vl_lowerLimit+1)+"-"+String:C10($vl_upperLimit)+" complexity\""
	End if 
	
	$dataStr:=$dataStr+String:C10($al_lineBreaksCounts{$i})
End for 


// Update the template
C_TEXT:C284($pathToGraphFile)
$pathToGraphFile:=Get 4D folder:C485(Current resources folder:K5:16)+"Graph_tabs"+Folder separator:K24:12+"tab_2.html"
File_Delete($pathToGraphFile)
$templateHTML:=Replace string:C233($templateHTML; "##GRAPH_CA_LABELS##"; $labelStr)
$templateHTML:=Replace string:C233($templateHTML; "##GRAPH_CA_VALUES##"; $dataStr)
TEXT TO DOCUMENT:C1237($pathToGraphFile; $templateHTML; "utf-8")
