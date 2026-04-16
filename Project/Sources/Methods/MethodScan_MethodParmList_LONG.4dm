//%attributes = {"invisible":true}
// MethodScan_MethodParmList_LONG (methodName) : html
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
	var $parameterNo : Integer
	var $parameterList : Collection
	$parameterList:=New collection:C1472
	
	var $paramDetail : Object
	var $parameterIsDefined : Boolean
	For ($parameterNo; 0; $methodDetails.parameters.maxParmNo)
		$parameterIsDefined:=Not:C34($methodDetails.parameters["parm"+String:C10($parameterNo)]=Null:C1517)
		
		Case of 
			: ($parameterIsDefined)
				$paramDetail:=$methodDetails.parameters["parm"+String:C10($parameterNo)]
				
				$html:=$html+"<tr class=\"parmLine\">"
				$html:=$html+"<td>"+$paramDetail.cType+"</td>"
				$html:=$html+"<td>"+$paramDetail.parm+"</td>"
				$html:=$html+"<td>"+$paramDetail.lvar+"</td>"
				$html:=$html+"<td>"+$paramDetail.rem+"</td>"
				$html:=$html+"</tr>"
				
			: ($parameterNo#0)
				$html:=$html+"<tr class=\"parmLine\">"
				$html:=$html+"<td>UNKNOWN TYPE</td>"
				$html:=$html+"<td>$"+String:C10($parameterNo)+"</td>"
				$html:=$html+"<td>&nbsp;</td>"
				$html:=$html+"<td>&nbsp;</td>"
				$html:=$html+"</tr>"
				
		End case 
	End for 
	
	If ($html#"")
		$html:="<table width=100%>"+"<tr><th width=60>Parm</th><th width=100>Type</th><th>localVar</th><th>Comment</th></tr>"+$html
		$html:=$html+"</table>"
	End if 
	
End if 
