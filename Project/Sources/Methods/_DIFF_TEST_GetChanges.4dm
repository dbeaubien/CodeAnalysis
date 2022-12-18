//%attributes = {"invisible":true}
C_TEXT:C284($1; $A_t)
C_TEXT:C284($2; $B_t)
C_TEXT:C284($0; $Changes_t)

$A_t:=$1
$B_t:=$2

ARRAY TEXT:C222($A; 0)
ARRAY TEXT:C222($B; 0)

ARRAY LONGINT:C221($StartA; 0)
ARRAY LONGINT:C221($StartB; 0)
ARRAY LONGINT:C221($DeletedA; 0)
ARRAY LONGINT:C221($InsertedB; 0)

ARRAY_Unpack($A_t; ->$A; ",")
ARRAY_Unpack($B_t; ->$B; ",")

_DIFF_Diff(->$A; ->$B; ->$StartA; ->$StartB; ->$DeletedA; ->$InsertedB)

$Changes_t:=_DIFF_ChangesText(->$StartA; ->$StartB; ->$DeletedA; ->$InsertedB)

$0:=$Changes_t

