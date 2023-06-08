//%attributes = {"invisible":true,"preemptive":"capable"}
//================================================================================
//@xdoc-start : en
//@name : XML__XPathNewSyntax
//@scope : private 
//@deprecated : no
//@description : This function returns TRUE if the new xpath syntax is used
//@parameter[0-OUT-XPathNewSyntax-BOOLEAN] : returns TRUE if the xpath new syntax is used
//@notes : This value is only applicable in the component. the compatibility setting "Use standard XPath" applies only to the component. 
//@example : XML__XPathNewSyntax
//@see : 
//@version : 1.00.00
//@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2022
//@history : 
//  CREATION : Bruno LEGAY (BLE) - 07/11/2022, 18:21:15 - 3.00.00
//@xdoc-end
//================================================================================

C_BOOLEAN:C305($0; $vb_newXpathSyntax)

$vb_newXpathSyntax:=False:C215

C_TEXT:C284($vt_domRef; $vt_domRefChild; $vt_domRefGrandChild)
$vt_domRef:=DOM Create XML Ref:C861("test")
If (ok=1)
	
	$vt_domRefChild:=DOM Append XML child node:C1080($vt_domRef; XML ELEMENT:K45:20; "child")
	$vt_domRefGrandChild:=DOM Append XML child node:C1080($vt_domRefChild; XML ELEMENT:K45:20; "grandchild")
	
	ARRAY TEXT:C222($tt_domRefList; 0)
	
	C_TEXT:C284($vt_xpath)
	$vt_xpath:="grandchild"  // new xpath syntax
	//$vt_xpath:="child/grandchild" // old xpath syntax
	
	C_TEXT:C284($va_domRefDummy)
	$va_domRefDummy:=DOM Find XML element:C864($vt_domRefChild; $vt_xpath; $tt_domRefList)
	If (Size of array:C274($tt_domRefList)=1)
		$vb_newXpathSyntax:=True:C214
	Else   // $va_domRefDummy = "00000000000000000000000000000000" and $tt_domRefList size = 0
		
	End if 
	
	ARRAY TEXT:C222($tt_domRefList; 0)
	
	DOM CLOSE XML:C722($vt_domRef)
End if 
$0:=$vb_newXpathSyntax