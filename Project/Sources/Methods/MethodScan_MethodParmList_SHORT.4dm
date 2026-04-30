//%attributes = {"invisible":true}
// MethodScan_MethodParmList_SHORT (methodPath) : html
// 
// DESCRIPTION
//    Returns an abbreviated list of parameters for the method.
//
#DECLARE($methodPath : Text)->$html : Text
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
$html:=""

var MethodStatsMasterObj : Object  // defined by MethodStats__Init
MethodStats__Init

var $methodDetails : Object
If (MethodStatsMasterObj[$methodPath]#Null:C1517)
	$methodDetails:=MethodStatsMasterObj[$methodPath]
End if 

If ($methodDetails#Null:C1517)
	var $hasReturnValue : Boolean
	var $parameterList : Collection
	$parameterList:=New collection:C1472
	
	var $parameterNo : Integer
	var $parameterIsDefined : Boolean
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
