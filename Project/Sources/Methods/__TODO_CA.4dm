//%attributes = {}
// Look at easier way to be able to export/copy a number of methods
//  to a new location disk.



// TODO
// 1 - Double check that exporting folders only updates the file if the file has changed
// 2 - Add option so that exporting the folder will remove any extra files on the remote

SET DATABASE LOCALIZATION:C1104("FR")
SET DATABASE LOCALIZATION:C1104("EN")

ABORT:C156



var $vo_callersObj : Object
$vo_callersObj:=CA_GetMethodsCalledByMethod(Current method name:C684)
$vo_callersObj:=CA_GetMethodsCallingTheMethod(Current method name:C684)

$vo_callersObj:=CA_GetMethodsCalledByMethod(Current method name:C684)
$vo_callersObj:=CA_GetMethodsCallingTheMethod(Current method name:C684)

$vo_callersObj:=CA_GetMethodsCalledByMethod(Current method name:C684)
$vo_callersObj:=CA_GetMethodsCallingTheMethod(Current method name:C684)

ABORT:C156
var $vt : Text
$vt:=""
__TODO_CA
MethodStats__Init







ABORT:C156


SET DATABASE LOCALIZATION:C1104("FR")
SET DATABASE LOCALIZATION:C1104("EN")

ABORT:C156

If (False:C215)
	var $string : Text
	$string:=""
	$vt:="54 6f 20 73 65 65 20 61 20 57 6f 72 6c 64 20 69 6e 20 61 20 47 72 61 69 6E 20 6F 66 20 53 61 6e 64 2e "
	$vt:=$vt+"20 48 6f 6c 64 20 49 6e 66 69 6e 69 74 79 20 69 6e 20 74 68 65 20 70 61 6c 6d 20 6f 66 20 79 6f 75 72 20 68 61 6e 64 2e"
	ARRAY TEXT:C222($at; 0)
	Array_ConvertFromTextDelimited(->$at; $vt; " ")
	var $i : Integer
	For ($i; 1; Size of array:C274($at))
		var someNum : Integer
		EXECUTE FORMULA:C63("someNum:=0x"+String:C10($at{$i}))
		$string:=$string+Char:C90(someNum)
	End for 
	ALERT:C41($string)
End if 

var \
$someVar; \
$someOtherVar : Text

If (False:C215)
	Case of 
		: (Form event code:C388=On Load:K2:1)
			vl_DIFF_ignoreCase:=Num:C11(Pref_GetPrefString("DIFF ignoreCase"; ""))
			
		: (Form event code:C388=On Clicked:K2:4)
			If (vl_DIFF_ignoreCase=1)
				Pref_SetPrefString("DIFF ignoreCase"; "1")
			Else 
				Pref_SetPrefString("DIFF ignoreCase"; "")
			End if 
	End case 
End if 


var $vt_line : Text
$vt_line:="<>_Graphs_Label{$graphNo}:=\"# Methods by Length\""
$vt_line:="$pos:=Position(\"//\";$myText)  // Also start position to start spell checking"
ARRAY TEXT:C222($at_tokens; 0)
Tokenize_LineOfCode($vt_line; ->$at_tokens)
ABORT:C156



ABORT:C156
Host_GetAssetInfo_GetFormProp

// RUNTIME ERROR occurred in method Host_GetAssetInfo_CheckVersion line #20 **:
// [Error #-10508] Project method not found.


FormProperties_SaveToFile

CLEANUP_IsOldStuffInstalled


//ABORT


// List table forms from a component
// A pointer is necessary because the table name is unknown
ARRAY TEXT:C222(arr_Names; 0)
tablePtr:=->[Table_1:1]

Host_GetAssetInfo_GetTableForms(Table:C252(tablePtr); ->arr_Names)
FORM GET NAMES:C1167(tablePtr->; arr_Names; *)

ABORT:C156

ARRAY TEXT:C222($objNamesArr; 0)
ARRAY POINTER:C280($varArr; 0)
ARRAY LONGINT:C221($pagesArr; 0)
ARRAY LONGINT:C221($objTypeArr; 0)
ARRAY TEXT:C222($objActionArr; 0)

var $vp_table : Pointer
$vp_table:=->[Table_1:1]
FORM LOAD:C1103($vp_table->; "Input"; *)

//FORM GET OBJECTS($objNamesArr; $varArr; $pagesArr; *)
//For ($i; 1; Size of array($objNamesArr))
//APPEND TO ARRAY($objTypeArr; OBJECT Get type(*; $objNamesArr{$i}))
//APPEND TO ARRAY($objActionArr; _O_OBJECT Get action(*; $objNamesArr{$i}))
//End for 
//FORM UNLOAD

CA_SaveFormProperties

ABORT:C156

var $vl_tableNo : Integer
var $vt_formName; $vt_diskFilePath : Text
$vl_tableNo:=Table:C252(->[Table_1:1])
$vt_formName:="Input"
$vt_diskFilePath:="test.json"
FormProperties_SaveToFile($vl_tableNo; $vt_formName; $vt_diskFilePath)



ABORT:C156


//$someVar:=$1
//<>_CA_QUICKLAUNCHER_PROCID:=0

var $vl_test; $vsomeVar : Integer
$vl_test:=0
var $vt_msg : Text
$vt_msg:=Replace string:C233(Localized string:C991("Msg_STRCT_DfltFldBadChar"); "%1"; Folder separator:K24:12)

ALERT:C41($vt_msg)



If (False:C215)
	//[CRAp]
	//[CRAp]test2
	$vt:=$vt[[1]]+[Table_4:4]Filed_6_IndexPart1:6
	
	QUERY:C277([Table_4:4]; [Table_4:4]Filed_6_IndexPart1:6="asfd"; *)
	QUERY:C277([Table_4:4];  & ; [Table_4:4]Field_3:3="asfd")
	
	QUERY SELECTION:C341([Table_4:4]; [Table_4:4]Field_2_Unique:2="asfd"; *)
	QUERY SELECTION:C341([Table_4:4];  | ; [Table_4:4]Field_1:1="asfd")
End if 

//Method_GetNormalizedCode 
// ==============
//Progress QUIT (1)
//ABORT

//SHOW ON DISK(File_GetFolderName (Pref__GetFile2PrefFile ))
//ABORT
