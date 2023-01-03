//%attributes = {"preemptive":"capable"}
//Progress QUIT (0)

//_DIFF_ChangesText 

C_TEXT:C284($vTStruc)
EXPORT STRUCTURE:C1311($vTStruc)


C_TEXT:C284($xml_source; $xml_Child_Ref; $xml_field_Ref)
C_TEXT:C284($attribName; $attribValue; $new_var)
C_TEXT:C284($appendedRef)
C_LONGINT:C283($count)

//$xml_source:=DOM Parse XML source("")
$xml_source:=DOM Parse XML variable:C720($vTStruc)

//DOM GET XML CHILD NODES($xml_source; $childTypesArr; $nodesRefArr)

var $abort; $abort_table : Boolean
var $childName; $childValue : Text
var $attribName; $attribValue : Text
var $siblingElemName; $siblingElemValue : Text
$abort:=False:C215
Repeat 
	$abort_table:=False:C215
	$siblingElemName:=""
	If ($childName="")
		$xml_Child_Ref:=DOM Get first child XML element:C723($xml_source; $childName; $childValue)
	Else 
		$xml_Child_Ref:=DOM Get next sibling XML element:C724($xml_Child_Ref; $childName; $childValue)
	End if 
	
	Case of 
		: (OK=0)
			$abort:=True:C214
			
		: ($childName="Schema")
			
		: ($childName="Table")
			Repeat 
				If ($siblingElemName="")
					$xml_field_Ref:=DOM Get first child XML element:C723($xml_Child_Ref; $siblingElemName; $siblingElemValue)
				Else 
					$xml_field_Ref:=DOM Get next sibling XML element:C724($xml_field_Ref; $siblingElemName; $siblingElemValue)
				End if 
				
				Case of 
					: (OK=0)
						$abort_table:=True:C214
					: ($siblingElemName="Field")
						For ($i; 1; DOM Count XML attributes:C727($xml_field_Ref))
							DOM GET XML ATTRIBUTE BY INDEX:C729($xml_field_Ref; $i; $attribName; $attribValue)
							If ($attribName="never_null")
								
							End if 
						End for 
						
					: ($siblingElemName="primary_key")
					: ($siblingElemName="table_extra")
					Else 
						
				End case 
			Until ($abort_table)
			
		: ($childName="Index")
			
		: ($childName="Base_extra")
			
		Else 
			
	End case 
Until ($abort)

If (False:C215)
	$xml_Child_Ref:=DOM Get first child XML element:C723($xml_source; $childName; $childValue)
	If ($childName="Schema")
		
		$next_XML_Ref:=$xml_Child_Ref
		While (OK=1)
			$next_XML_Ref:=DOM Get next sibling XML element:C724($next_XML_Ref\
				$siblingElemName; $siblingElemValue)
			If ($siblingElemName="relation")
				$count:=DOM Count XML attributes:C727($next_XML_Ref)
				C_LONGINT:C283($i; $end)
				$end:=$count
				For ($i; 1; $end)
					DOM GET XML ATTRIBUTE BY INDEX:C729($next_XML_Ref; $i; $attribName; $attribValue)
					If ($attribName="integrity")
						If ($attribValue="delete")
							//
						End if 
					End if 
				End for 
			End if 
		End while 
	End if 
End if 

DOM CLOSE XML:C722($xml_source)