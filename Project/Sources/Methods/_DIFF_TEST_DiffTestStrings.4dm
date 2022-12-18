//%attributes = {"invisible":true}
C_TEXT:C284($1; $A_t)
C_TEXT:C284($2; $B_t)
C_TEXT:C284($3; $Result_t)
C_TEXT:C284($4; $TestName_t)
C_BOOLEAN:C305($0; $Success_b)

$A_t:=$1
$B_t:=$2
$Result_t:=$3
If (Count parameters:C259>=4)
	$TestName_t:=$4
End if 

ARRAY TEXT:C222($A; 0)
ARRAY TEXT:C222($B; 0)

ARRAY LONGINT:C221($StartA; 0)
ARRAY LONGINT:C221($StartB; 0)
ARRAY LONGINT:C221($DeletedA; 0)
ARRAY LONGINT:C221($InsertedB; 0)

C_TEXT:C284($Changes_t)

ARRAY_Unpack($A_t; ->$A; ",")
ARRAY_Unpack($B_t; ->$B; ",")

_DIFF_Diff(->$A; ->$B; ->$StartA; ->$StartB; ->$DeletedA; ->$InsertedB)

$Changes_t:=_DIFF_ChangesText(->$StartA; ->$StartB; ->$DeletedA; ->$InsertedB)

//C_TEXT($Message_t)
//$Message_t:=$Changes_t+"\r"+$TestName_t

If ($Changes_t=$Result_t)
	//_DBG_WriteLine ($Changes_t)
	//_DBG_WriteLine ($TestName_t+" test passed.")
	
	//$Message_t:=$Message_t+" test passed."
	$Success_b:=True:C214
	
Else 
	//_DBG_WriteLine ($Changes_t)
	//_DBG_WriteLine ($TestName_t+" test failed. Expected "+$Result_t)
	
	//$Message_t:=$Message_t+" test failed. Expected "+$Result_t
	$Success_b:=False:C215
	
End if 

$0:=$Success_b

