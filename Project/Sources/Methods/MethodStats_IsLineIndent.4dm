//%attributes = {"invisible":true}
// MethodStats_IsLineIndent (lineOfCode) : doIndent
// 
// DESCRIPTION
//   Returns true if the line increases nesting.
//
#DECLARE($vt_lineOfCode : Text)->$vb_doIndent : Boolean
// ----------------------------------------------------
$vb_doIndent:=False:C215

If (Asserted:C1132(Count parameters:C259=1))
	
	Case of 
		: ($vt_lineOfCode="For @") | ($vt_lineOfCode="Boucle @")
			$vb_doIndent:=True:C214
			
		: ($vt_lineOfCode="Repeat@") | ($vt_lineOfCode="Repeter @")
			$vb_doIndent:=True:C214
			
		: ($vt_lineOfCode="While @") | ($vt_lineOfCode="Tant que @")
			$vb_doIndent:=True:C214
			
		: ($vt_lineOfCode="Case of@") | ($vt_lineOfCode="Au cas ou@")
			$vb_doIndent:=True:C214
			
		: ($vt_lineOfCode="If @") | ($vt_lineOfCode="Si @")
			$vb_doIndent:=True:C214
			
		: ($vt_lineOfCode="Else@") | ($vt_lineOfCode="Sinon@")
			$vb_doIndent:=True:C214
			
		Else 
			// NOP
	End case 
	
End if 

