//%attributes = {"invisible":true}


#DECLARE($A_t : Text; $B_t : Text)->$Changes_t : Text

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
