//%attributes = {"invisible":true}
// AnalysisGraph_doTab3Graph ()
// 
// DESCRIPTION
//   Build a graph that shows nesting levels.
//
// ----------------------------------------------------
// CALLED BY
//   AnalysisGraph_doGraphs
// ----------------------------------------------------
// HISTORY
//   Created by: DB (07/27/2016)
//   Mod by: Dani Beaubien (02/02/2021) - Updated to use objects
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=0)

// Setup the arrays to hold our graph data
ARRAY LONGINT:C221($al_lineBreaks; 0)
APPEND TO ARRAY:C911($al_lineBreaks; 1)  // 0 to 2
APPEND TO ARRAY:C911($al_lineBreaks; 2)  // 0 to 2
APPEND TO ARRAY:C911($al_lineBreaks; 3)  // 2 to 3
APPEND TO ARRAY:C911($al_lineBreaks; 4)  // 3 to 4
APPEND TO ARRAY:C911($al_lineBreaks; 5)  // 4 to 5
APPEND TO ARRAY:C911($al_lineBreaks; 6)  // 5 to 6
APPEND TO ARRAY:C911($al_lineBreaks; 7)  // 6 to 7
APPEND TO ARRAY:C911($al_lineBreaks; MAXLONG:K35:2)
ARRAY LONGINT:C221($al_lineBreaksCounts; Size of array:C274($al_lineBreaks))

// Load the template
C_TEXT:C284($templateHTML)
$templateHTML:=AnalysisGraph_GetTemplate

ARRAY TEXT:C222($methodObjNames; 0)
Method_GetMethodObjNames(->$methodObjNames)

ARRAY LONGINT:C221($al_tmp; 0)
ARRAY LONGINT:C221($al_tmp; Size of array:C274($methodObjNames))
C_OBJECT:C1216($methodLineCounts)
For ($i; 1; Size of array:C274($methodObjNames))
	$al_tmp{$i}:=MethodStatsMasterObj[$methodObjNames{$i}].analysis.max_nesting_level
End for 
SORT ARRAY:C229($al_tmp)

C_LONGINT:C283($vl_curIndex; $vl_lowerLimit; $vl_upperLimit; $vl_nextNum)
$vl_curIndex:=1
$vl_lowerLimit:=0
$vl_upperLimit:=$al_lineBreaks{$vl_curIndex}
For ($i; 1; Size of array:C274($al_tmp))
	$vl_nextNum:=$al_tmp{$i}
	
	// Is the next number in the current "slot", if not then find the right slot
	If (Not:C34(($vl_lowerLimit<=$vl_nextNum) & ($vl_nextNum<=$vl_upperLimit)))
		$vl_lowerLimit:=0
		For ($j; 1; Size of array:C274($al_lineBreaks))
			If ($vl_nextNum<=$al_lineBreaks{$j})
				$vl_curIndex:=$j
				$vl_upperLimit:=$al_lineBreaks{$j}
				$j:=Size of array:C274($al_lineBreaks)  // Break out of the loop
			Else 
				$vl_lowerLimit:=$al_lineBreaks{$j}
			End if 
		End for 
		
	End if 
	
	$al_lineBreaksCounts{$vl_curIndex}:=$al_lineBreaksCounts{$vl_curIndex}+1
End for 


// Build the strings that will get put into the template
C_TEXT:C284($labelStr; $dataStr)
$labelStr:=""
$dataStr:=""
$vl_lowerLimit:=0
C_LONGINT:C283($i; $j)
For ($i; 1; Size of array:C274($al_lineBreaks))
	If ($i#1)
		$labelStr:=$labelStr+","
		$dataStr:=$dataStr+","
		$vl_lowerLimit:=$al_lineBreaks{$i-1}
	End if 
	$vl_upperLimit:=$al_lineBreaks{$i}
	
	Case of 
		: ($vl_upperLimit=MAXLONG:K35:2)
			$labelStr:=$labelStr+"\""+String:C10($vl_lowerLimit+1)+"+ levels\""
			
		: (($vl_lowerLimit+1)=$vl_upperLimit)
			$labelStr:=$labelStr+"\""+String:C10($vl_lowerLimit+1)+" levels\""
			
		Else 
			$labelStr:=$labelStr+"\""+String:C10($vl_lowerLimit+1)+"-"+String:C10($vl_upperLimit)+" levels\""
	End case 
	
	$dataStr:=$dataStr+String:C10($al_lineBreaksCounts{$i})
End for 


// Update the template
C_TEXT:C284($pathToGraphFile)
$pathToGraphFile:=Get 4D folder:C485(Current resources folder:K5:16)+"Graph_tabs"+Folder separator:K24:12+"tab_3.html"
File_Delete($pathToGraphFile)
$templateHTML:=Replace string:C233($templateHTML; "##GRAPH_CA_LABELS##"; $labelStr)
$templateHTML:=Replace string:C233($templateHTML; "##GRAPH_CA_VALUES##"; $dataStr)
TEXT TO DOCUMENT:C1237($pathToGraphFile; $templateHTML; "utf-8")
