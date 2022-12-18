//%attributes = {"invisible":true}
// MethodScan_MethodParmList_SHORT (methodPath) : html
// 
// DESCRIPTION
//    Returns an abbreviated list of parameters for the method.
//
C_TEXT:C284($1; $methodPath)
C_TEXT:C284($0; $html)
// ----------------------------------------------------
// HISTORY
//   Created by Dani Beaubien : (2012-08-03)
//   Mod by: Dani Beaubien (02/07/2021) - convert to use objects
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
$methodPath:=$1
$html:=""

C_OBJECT:C1216(MethodStatsMasterObj)  // defined by MethodStats__Init
MethodStats__Init

C_OBJECT:C1216($methodDetails)
If (MethodStatsMasterObj[$methodPath]#Null:C1517)
	$methodDetails:=MethodStatsMasterObj[$methodPath]
End if 

If ($methodDetails#Null:C1517)
	C_BOOLEAN:C305($hasReturnValue)
	C_COLLECTION:C1488($parameterList)
	$parameterList:=New collection:C1472
	
	C_LONGINT:C283($parameterNo)
	C_BOOLEAN:C305($parameterIsDefined)
	For ($parameterNo; 0; $methodDetails.parameters.maxParmNo)
		$parameterIsDefined:=Not:C34($methodDetails.parameters["parm"+String:C10($parameterNo)]=Null:C1517)
		If ($parameterNo=0)
			$hasReturnValue:=$parameterIsDefined
		Else 
			$parameterList.push("$"+String:C10($parameterNo))
		End if 
	End for 
	
	If ($parameterList.length>0)
		$html:=" ("+$parameterList.join("; ")+")"
	End if 
	If ($hasReturnValue)
		$html:=$html+" : $0"
	End if 
	
End if 

$0:=$html