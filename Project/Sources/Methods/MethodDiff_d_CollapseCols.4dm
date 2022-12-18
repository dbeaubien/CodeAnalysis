//%attributes = {"invisible":true}
// MethodDiff_d_CollapseCols
//
// DESCRIPTION
//   Rejig the code arrays, collapsing the changes so
//   that they are side by side.
//
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (10/30/2012)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 0; Count parameters:C259))
	C_LONGINT:C283($vl_leftNo; $vl_rightNo; $vl_rightBlankLength; $vl_rightBlankLineStart; $vl_leftBlankLineStart)
	$vl_leftNo:=1
	$vl_rightNo:=1
	$vl_leftBlankLineStart:=0
	$vl_rightBlankLineStart:=0
	$vl_rightBlankLength:=0
	
	C_BOOLEAN:C305($vb_done)
	$vb_done:=False:C215
	Repeat   // Adjust the results so that the inserts and deletes appear beside each other.
		Case of 
				
			: (DEMO_File1LineNo_al{$vl_leftNo}=0)  // Hit a section where it is blank on the left
				If ($vl_rightBlankLength>0)  // still lines no the right that can be moved up
					DEMO_File2LineNo_al{$vl_rightBlankLineStart}:=DEMO_File2LineNo_al{$vl_rightNo}  // Move it up
					DEMO_File2_at{$vl_rightBlankLineStart}:=DEMO_File2_at{$vl_rightNo}  // Move it up
					DEMO_File2LineNo_al{$vl_rightNo}:=0  // clear the value
					DEMO_File2_at{$vl_rightNo}:=""  // clear the value
					$vl_rightBlankLineStart:=$vl_rightBlankLineStart+1
					$vl_rightBlankLength:=$vl_rightBlankLength-1
				Else 
					$vl_rightBlankLineStart:=0
				End if 
				
				
			: (DEMO_File2LineNo_al{$vl_rightNo}=0)  // Hit a section where it is blank on the right (aka insert on the left)
				If ($vl_rightBlankLineStart=0)
					$vl_rightBlankLineStart:=$vl_rightNo
				End if 
				$vl_rightBlankLength:=$vl_rightBlankLength+1
				
				
				// Non blank line for both
			: (DEMO_File1LineNo_al{$vl_leftNo}#0) & (DEMO_File2LineNo_al{$vl_rightNo}#0)
				$vl_rightBlankLength:=0
				$vl_rightBlankLineStart:=0
				
		End case 
		
		
		If (($vl_leftNo>=Size of array:C274(DEMO_File1_at)) & ($vl_rightNo>=Size of array:C274(DEMO_File2_at)))
			$vb_done:=True:C214
		End if 
		
		$vl_leftNo:=$vl_leftNo+1
		$vl_rightNo:=$vl_rightNo+1
		
	Until ($vb_done)
	
	
	// Remove the blank rows (no line#'s) that have been left behind from the collapse
	C_LONGINT:C283($i)
	For ($i; Size of array:C274(DEMO_File2_at); 1; -1)
		If (DEMO_File1LineNo_al{$i}=0) & (DEMO_File2LineNo_al{$i}=0)
			DELETE FROM ARRAY:C228(DEMO_File1LineNo_al; $i; 1)
			DELETE FROM ARRAY:C228(DEMO_File1_at; $i; 1)
			DELETE FROM ARRAY:C228(DEMO_File2LineNo_al; $i; 1)
			DELETE FROM ARRAY:C228(DEMO_File2_at; $i; 1)
			DELETE FROM ARRAY:C228(DEMO_Styles_al; $i; 1)
			DELETE FROM ARRAY:C228(DEMO_BackColors_al; $i; 1)
			DELETE FROM ARRAY:C228(DEMO_FontColors_al; $i; 1)
		End if 
	End for 
	
End if   // ASSERT