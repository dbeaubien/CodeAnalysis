//%attributes = {"invisible":true}
C_LONGINT:C283($Test_l; $TestCount_l)

$TestCount_l:=5

ARRAY LONGINT:C221($Expected; 0)
APPEND TO ARRAY:C911($Expected; 5)
APPEND TO ARRAY:C911($Expected; 7)
APPEND TO ARRAY:C911($Expected; 5)
APPEND TO ARRAY:C911($Expected; 5)
APPEND TO ARRAY:C911($Expected; 2)

C_BOOLEAN:C305($Pass)
$Pass:=True:C214

For ($Test_l; 1; $TestCount_l)
	If ($Pass)
		C_LONGINT:C283($SES)
		
		C_TEXT:C284($A; $B)
		ARRAY TEXT:C222($SMS; 0)
		
		Case of 
			: ($Test_l=1)
				$A:="ABCABBA"
				$B:="CBABAC"
				
			: ($Test_l=2)
				$A:="TRUSTED"
				$B:="TRYSTING"
				
			: ($Test_l=3)
				$A:="STRICT"
				$B:="TRIES"
				
			: ($Test_l=4)
				$A:="STRICTLY"
				$B:="TIGHTLY"
				
			: ($Test_l=5)
				$A:="abcdef"
				$B:="bcdefx"
				
		End case 
		
		$SES:=_DIFF_SES(->$A; ->$B; ->$SMS)
		
		$Pass:=($SES=$Expected{$Test_l})
	End if 
End for 

If ($Pass)
	ALERT:C41("All tests passed.")
Else 
	ALERT:C41("Test failed.")
	TRACE:C157
End if 


