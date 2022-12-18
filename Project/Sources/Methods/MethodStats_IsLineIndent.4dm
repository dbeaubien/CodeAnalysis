//%attributes = {"invisible":true}
// MethodStats_IsLineIndent (lineOfCode) : doIndent
// MethodStats_IsLineIndent (text) : boolean
// 
// DESCRIPTION
//   Returns true if the line increases nesting.
//
C_TEXT:C284($1; $vt_lineOfCode)
C_BOOLEAN:C305($0; $vb_doIndent)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (07/20/2016)
// ----------------------------------------------------

$vb_doIndent:=False:C215
If (Asserted:C1132(Count parameters:C259=1))
	$vt_lineOfCode:=$1
	
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
	
End if   // ASSERT
$0:=$vb_doIndent
