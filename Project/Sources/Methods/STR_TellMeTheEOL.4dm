//%attributes = {"invisible":true}
// STR_TellMeTheEOL (string) : theEOL
// STR_TellMeTheEOL (texxt) : text
// 
// DESCRIPTION
//   scans the text and returns what the EOLs are.
//
C_TEXT:C284($1; $vt_srcTxt)
C_TEXT:C284($0; $vt_theEOL)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (10/01/12)
// ----------------------------------------------------

$vt_theEOL:=""
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$vt_srcTxt:=$1
	
	C_LONGINT:C283($vl_pos_CR; $vl_pos_LF)
	$vl_pos_CR:=Position:C15(Char:C90(Carriage return:K15:38); $vt_srcTxt; *)
	$vl_pos_LF:=Position:C15(Char:C90(Line feed:K15:40); $vt_srcTxt; *)
	
	Case of 
		: ($vl_pos_CR=0) & ($vl_pos_LF=0)  // NOT_GOOD.
			$vt_theEOL:=Char:C90(Carriage return:K15:38)  // GUESS
			
		: ($vl_pos_CR=0) & ($vl_pos_LF#0)
			$vt_theEOL:=Char:C90(Line feed:K15:40)
			
		: ($vl_pos_LF=0) & ($vl_pos_CR#0)
			$vt_theEOL:=Char:C90(Carriage return:K15:38)
			
			
		: ($vl_pos_CR#0) & ($vl_pos_LF<$vl_pos_CR)  // NOT_GOOD.
			$vt_theEOL:=Char:C90(Line feed:K15:40)  // GUESS
			
			
		: ($vl_pos_CR#0) & ($vl_pos_LF=($vl_pos_CR+1))
			$vt_theEOL:=Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
			
		Else 
			$vt_theEOL:=Char:C90(Carriage return:K15:38)  // GUESS
			
	End case 
	
End if   // ASSERT
$0:=$vt_theEOL
