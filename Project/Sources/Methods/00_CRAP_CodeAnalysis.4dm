//%attributes = {"invisible":true}

C_TEXT:C284($vt_filePath)
$vt_filePath:=CodeAnalysis__GetDestFolder+"Test File.txt"
ARRAY TEXT:C222($vt_array1; 0)
ARRAY LONGINT:C221($vl_array2; 0)

APPEND TO ARRAY:C911($vt_array1; "cell 1")
APPEND TO ARRAY:C911($vl_array2; 1)

APPEND TO ARRAY:C911($vt_array1; "cell 2")
APPEND TO ARRAY:C911($vl_array2; 2)

APPEND TO ARRAY:C911($vt_array1; "cell 3")
APPEND TO ARRAY:C911($vl_array2; 3)

File_Delete($vt_filePath)
File_ExportArrays2CSV($vt_filePath; ->$vt_array1; ->$vl_array2)

SHOW ON DISK:C922($vt_filePath)

ABORT:C156
// STRUCTURE diff
// Object Methods
// Object objects

SHOW ON DISK:C922(Pref__GetFile2PrefFile)
ABORT:C156

BEEP:C151
ALERT:C41("text")

ALL RECORDS:C47([Table_1:1])
[Table_1:1]Field_1:1:="tst"
[Table_4:4]Field_6_IndexPart2:7:="tst"

//%attributes = {"lang":"en","invisible":true} comment added and reserved by 4D.

C_BOOLEAN:C305($someValue)
C_LONGINT:C283($i)
If ($someValue)  // IF
	BEEP:C151
Else   // ELSE
	BEEP:C151
End if   // END IF
While ($someValue)  // WHILE
	BEEP:C151
End while   // END WHILE
Repeat   // REPEAT
	BEEP:C151
Until ($someValue)  // UNTIL
For ($i; 1; 10)  // FOR
	BEEP:C151
End for   // END FOR
Case of   // CASE OF
	: ($someValue)
		BEEP:C151
	Else 
		BEEP:C151
End case   // END CASE