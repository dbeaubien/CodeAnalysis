//%attributes = {"invisible":true}
// (PM) UnitTest_AssertEqualTextAndCase
// Asserts whether two texts are equal and the same case
// $1 = Expected
// $2 = Actual
// $3 = Failure message (optional)

C_TEXT:C284($1; $expected)
C_TEXT:C284($2; $actual)
C_TEXT:C284($3; $message)

$expected:=$1
$actual:=$2

If (Count parameters:C259>=3)
	$message:=$3
Else 
	$message:="AssertEqualTextAndCase Expected \""+$expected+"\" but got \""+$actual+"\""
End if 

C_BOOLEAN:C305($vb_isGood)
If ($expected=$actual)
	$vb_isGood:=True:C214  // assume is good
	C_LONGINT:C283($i)
	For ($i; 1; Length:C16($expected))
		If (Character code:C91($expected[[$i]])#Character code:C91($actual[[$i]]))
			$vb_isGood:=False:C215
		End if 
	End for 
End if 

UnitTest_Assert($vb_isGood; $message)
