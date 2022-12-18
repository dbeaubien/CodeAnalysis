//%attributes = {"invisible":true,"preemptive":"capable"}
// MethodStats_IsLineOutdent (lineOfCode) : doOutdent
// MethodStats_IsLineOutdent (text) : boolean
// 
// DESCRIPTION
//   Returns true if the line reduces nesting.
//
C_TEXT:C284($1; $vt_lineOfCode)
C_BOOLEAN:C305($0; $vb_doOutdent)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (07/20/2016)
// ----------------------------------------------------

$vb_doOutdent:=False:C215
If (Asserted:C1132(Count parameters:C259=1))
	$vt_lineOfCode:=$1
	
	
	Case of 
		: ($vt_lineOfCode="End for@") | ($vt_lineOfCode="Fin de boucle @")
			$vb_doOutdent:=True:C214
			
		: ($vt_lineOfCode="End While@") | ($vt_lineOfCode="Fin tant que @")
			$vb_doOutdent:=True:C214
			
		: ($vt_lineOfCode="Until @") | ($vt_lineOfCode="Jusque @")
			$vb_doOutdent:=True:C214
			
		: ($vt_lineOfCode="Else@") | ($vt_lineOfCode="Sinon@")
			$vb_doOutdent:=True:C214
			
		: ($vt_lineOfCode="End If@") | ($vt_lineOfCode="Fin de si@")
			$vb_doOutdent:=True:C214
			
		: ($vt_lineOfCode="End case@") | ($vt_lineOfCode="Fin de cas@")
			$vb_doOutdent:=True:C214
		Else 
			// NOP
	End case 
	
End if   // ASSERT
$0:=$vb_doOutdent