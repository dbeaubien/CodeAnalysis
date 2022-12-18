//%attributes = {"invisible":true}
// MethodScan_MethodParmList_LONG (methodName) : html
// MethodScan_MethodParmList_LONG (longint) : text
//
// Description
//   
//
// Parameters
C_TEXT:C284($1; $methodPath)
C_TEXT:C284($0; $html)
// ----------------------------------------------------
// User name (OS): Dani Beaubien
// Date and time: 03/12/12, 07:01:52
//   Mod: DB (04/25/2016) - Rewritten to support json version of information
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
	C_LONGINT:C283($parameterNo)
	C_COLLECTION:C1488($parameterList)
	$parameterList:=New collection:C1472
	
	C_OBJECT:C1216($paramDetail)
	C_BOOLEAN:C305($parameterIsDefined)
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

$0:=$html