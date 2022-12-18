//%attributes = {"invisible":true,"preemptive":"capable"}
// Explorer_MetaInfoFunction_Mthd () : metaInfo
//
// DESCRIPTION
//   Method meta function for the Explorer window
//
C_OBJECT:C1216($0; $metaInfo)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (12/18/2020)
// ----------------------------------------------------

// Reference: https://developer.4d.com/docs/18/en/FormObjects/propertiesText.html#meta-info-expression

C_LONGINT:C283(mediumComplexity; highComplexity)
If (mediumComplexity=0) | (highComplexity=0)  // try to only fetch from prefs once
	mediumComplexity:=Num:C11(Pref_GetPrefString("CC Med Risk"; "11"))
	highComplexity:=Num:C11(Pref_GetPrefString("CC High Risk"; "25"))
End if 

$metaInfo:=New object:C1471
Case of 
	: (Num:C11(This:C1470.codeComplexity)>highComplexity)
		//$metaInfo.fill:="#FF9999"
		$metaInfo.cell:=New object:C1471("Column5"; New object:C1471)
		//$metaInfo.cell.Column5.fontWeight:="bold"
		$metaInfo.cell.Column5.fill:="#FF9999"
		
	: (Num:C11(This:C1470.codeComplexity)>mediumComplexity)
		$metaInfo.cell:=New object:C1471("Column5"; New object:C1471)
		//$metaInfo.cell.Column5.fontWeight:="bold"
		$metaInfo.cell.Column5.fill:="#FFCC66"
		
	Else 
		$metaInfo.fill:=""
		//$metaInfo.stroke:=""
End case 

//If (This.numTimesCalled=0)
//$metaInfo.fontStyle:="italic"
//End if 

$0:=$metaInfo