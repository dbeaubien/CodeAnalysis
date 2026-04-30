//%attributes = {"invisible":true}
// MethodStats__GatherParmInfo (tokenizedLineArrPtr; parmArrayPtr)
//
#DECLARE($ap_tokenizedLinePtr : Pointer; $vp_parmsObjPtr : Pointer)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=2)

OnErr_ClearError

var $vl_numTokens; $pos; $len : Integer
$vl_numTokens:=Size of array:C274($ap_tokenizedLinePtr->)
If ($vl_numTokens>1)
	ARRAY TEXT:C222($at_C_declarVarToken; 0)
	Structure_GetTokenArr_Cdefn(->$at_C_declarVarToken)
	
	ON ERR CALL:C155("")
	var $vb_addAsParm : Boolean
	
	// Is this some sort of "C_" declaration?
	var $vt_theComment; $pattern : Text
	$vt_theComment:=""
	$pattern:="\\$\\{*[0-9]+\\}*"  // Pattern to regex $1 and ${2} type strings
	
	If (Find in array:C230($at_C_declarVarToken; $ap_tokenizedLinePtr->{1})>0)  // starts with a C_DEF
		
		// Checks to see if is of form that is interpretable.
		Case of 
			: ($vl_numTokens=4) | ($vl_numTokens=5)  // Line is of the form: "C_TEXT ($1)"
				If ($vl_numTokens=5)  // Line is of the form: "C_TEXT ($1) // some comment"
					$vt_theComment:=$ap_tokenizedLinePtr->{5}
				End if 
				If (Match regex:C1019($pattern; $ap_tokenizedLinePtr->{3}; 1; $pos; $len))
					MethodStats__GatherParmInfo2($vp_parmsObjPtr; $ap_tokenizedLinePtr->{3}; $ap_tokenizedLinePtr->{1}; ""; $vt_theComment)
				End if 
				
				
			: ($vl_numTokens=6) | ($vl_numTokens=7)  // Line is of the form: "C_TEXT ($1;$var)"
				If ($vl_numTokens=7)  // Line is of the form: "C_TEXT ($1;$var) // some comment"
					$vt_theComment:=$ap_tokenizedLinePtr->{7}
				End if 
				
				var $vb_pos3_is_a_parm; $vb_pos5_is_a_parm : Boolean
				$vb_pos3_is_a_parm:=(Match regex:C1019($pattern; $ap_tokenizedLinePtr->{3}; 1; $pos; $len))
				$vb_pos5_is_a_parm:=(Match regex:C1019($pattern; $ap_tokenizedLinePtr->{5}; 1; $pos; $len))
				If (OnErr_GetLastError#0)
					TRACE:C157
				End if 
				
				Case of 
					: ($vb_pos3_is_a_parm & Not:C34($vb_pos5_is_a_parm))
						MethodStats__GatherParmInfo2($vp_parmsObjPtr; $ap_tokenizedLinePtr->{3}; $ap_tokenizedLinePtr->{1}; $ap_tokenizedLinePtr->{5}; $vt_theComment)
						
					: ($vb_pos5_is_a_parm & Not:C34($vb_pos3_is_a_parm))
						MethodStats__GatherParmInfo2($vp_parmsObjPtr; $ap_tokenizedLinePtr->{5}; $ap_tokenizedLinePtr->{1}; $ap_tokenizedLinePtr->{3}; $vt_theComment)
						
					: ($vb_pos3_is_a_parm & $vb_pos5_is_a_parm)
						MethodStats__GatherParmInfo2($vp_parmsObjPtr; $ap_tokenizedLinePtr->{3}; $ap_tokenizedLinePtr->{1}; ""; $vt_theComment)
						MethodStats__GatherParmInfo2($vp_parmsObjPtr; $ap_tokenizedLinePtr->{5}; $ap_tokenizedLinePtr->{1}; ""; $vt_theComment)
						
					Else 
						// NOP
				End case 
				
			Else 
				
				// Scan to see if there are parms in a non-optimal defined way
				var $i : Integer
				For ($i; 1; Size of array:C274($ap_tokenizedLinePtr->))
					If (Match regex:C1019($pattern; $ap_tokenizedLinePtr->{$i}; 1; $pos; $len))
						MethodStats__GatherParmInfo2($vp_parmsObjPtr; $ap_tokenizedLinePtr->{$i}; $ap_tokenizedLinePtr->{1}; ""; "")
					End if 
				End for 
				
		End case 
		
	End if 
	
	
End if   // ($vl_numTokens>1)
