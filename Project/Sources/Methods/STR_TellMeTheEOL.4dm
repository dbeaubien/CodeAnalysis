//%attributes = {"invisible":true}
// STR_TellMeTheEOL (string) : theEOL
// 
// DESCRIPTION
//   scans the text and returns what the EOLs are.
//
#DECLARE($vt_srcTxt : Text)->$vt_theEOL : Text
// ----------------------------------------------------
$vt_theEOL:=""

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	var $vl_pos_CR; $vl_pos_LF : Integer
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
	
End if 
