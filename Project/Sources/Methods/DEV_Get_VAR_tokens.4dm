//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method: DEV_Get_VAR_tokens
// Description
//   This method generates the code that identifies all
//   the 4D tokens that are used to type vars.
//
// Parameters
// ----------------------------------------------------
// User name (OS): Dani Beaubien
// Date and time: 03/09/12, 08:37:17
// ----------------------------------------------------

C_BOOLEAN:C305($vb_doQueryStuff)
CONFIRM:C162("Gather commands #s for Query or C Def statements?"; "Query"; "C Defs")
If (OK=1)
	$vb_doQueryStuff:=True:C214
Else 
	$vb_doQueryStuff:=False:C215
End if 

// Loads all the 4D commands into an array
ARRAY TEXT:C222($at_commandName1; 0)
ARRAY LONGINT:C221($al_commandNo1; 0)
ARRAY TEXT:C222($at_commandName2; 0)
ARRAY LONGINT:C221($al_commandNo2; 0)
C_LONGINT:C283($i)
C_TEXT:C284($vt)
For ($i; 1; 2000)
	$vt:=Command name:C538($i)
	//If ($vt#"")
	If ($vb_doQueryStuff)
		If ($vt="QUERY@") | ($vt="DISTINCT VALUES") | ($vt="Find in field")
			If ($vt#"@SQL@")  // Don't want the Query by SQL statement
				APPEND TO ARRAY:C911($at_commandName1; $vt)
				APPEND TO ARRAY:C911($al_commandNo1; $i)
			End if 
		End if 
		
	Else 
		If ($vt="C_@") | ($vt="_O_C_@")
			APPEND TO ARRAY:C911($at_commandName1; $vt)
			APPEND TO ARRAY:C911($al_commandNo1; $i)
		End if 
		
		If (($vt="ARRAY @") & ($vt#"ARRAY TO @")) | (($vt="_O_ARRAY@") & ($vt#"_O_ARRAY TO @"))
			APPEND TO ARRAY:C911($at_commandName2; $vt)
			APPEND TO ARRAY:C911($al_commandNo2; $i)
		End if 
	End if 
	
End for 


// Turn the arrays into code that I can paste

If ($vb_doQueryStuff)
	C_TEXT:C284($vt_codeStr)
	$vt_codeStr:="array longint($al_QueryTokenCommandNo;0)\r"
	For ($i; 1; Size of array:C274($at_commandName1))
		$vt_codeStr:=$vt_codeStr+"append to array($al_QueryTokenCommandNo;"+String:C10($al_commandNo1{$i})+") // "+$at_commandName1{$i}+"\r"
	End for 
	$vt_codeStr:=$vt_codeStr+"\r"
	$vt_codeStr:=$vt_codeStr+"array text($at_QueryTokenCommandStr;0)\r"
	$vt_codeStr:=$vt_codeStr+"For ($i;1;size of array($al_QueryTokenCommandNo))\r"
	$vt_codeStr:=$vt_codeStr+"append to array($at_QueryTokenCommandStr;Command name($al_QueryTokenCommandNo{$i}))\r"
	$vt_codeStr:=$vt_codeStr+"End for\r"
	
Else 
	$vt_codeStr:="array text($vp_cDefnTokenArrPtr->;0)\r"
	For ($i; 1; Size of array:C274($at_commandName1))
		$vt_codeStr:=$vt_codeStr+"append to array($vp_cDefnTokenArrPtr->;Command name("+String:C10($al_commandNo1{$i})+")) // "+$at_commandName1{$i}+"\r"
	End for 
	
	If (Size of array:C274($at_commandName2)>0)
		$vt_codeStr:=$vt_codeStr+"\rarray text($vp_arrDefnTokenArrPtr->;0)\r"
		For ($i; 1; Size of array:C274($at_commandName2))
			$vt_codeStr:=$vt_codeStr+"append to array($vp_arrDefnTokenArrPtr->;Command name("+String:C10($al_commandNo2{$i})+")) // "+$at_commandName2{$i}+"\r"
		End for 
	End if 
End if 
SET TEXT TO PASTEBOARD:C523($vt_codeStr)

If ($vb_doQueryStuff)
	ALERT:C41("Done.\r\rCode is in pasteboard update the \"DEV_Get_QueryCommandsArray\" method.")
	METHOD OPEN PATH:C1213("DEV_Get_QueryCommandsArray")
Else 
	ALERT:C41("Done.\r\rCode is in pasteboard and update the \"Structure_GetTokenArr_Cdefn\" method.")
	METHOD OPEN PATH:C1213("Structure_GetTokenArr_Cdefn")
	METHOD OPEN PATH:C1213("Structure_GetTokenArr_Cdefn")
End if 

ABORT:C156  // HERE IS AN EXAMPLE OF WHAT WAS GENERATED

/*
ARRAY TEXT($vp_cDefnTokenArrPtr->;0)
APPEND TO ARRAY($vp_cDefnTokenArrPtr->;Command name(282))  // _O_C_INTEGER
APPEND TO ARRAY($vp_cDefnTokenArrPtr->;Command name(283))  // C_LONGINT
APPEND TO ARRAY($vp_cDefnTokenArrPtr->;Command name(284))  // C_TEXT
APPEND TO ARRAY($vp_cDefnTokenArrPtr->;Command name(285))  // C_REAL
APPEND TO ARRAY($vp_cDefnTokenArrPtr->;Command name(286))  // C_PICTURE
APPEND TO ARRAY($vp_cDefnTokenArrPtr->;Command name(293))  // _O_C_STRING
APPEND TO ARRAY($vp_cDefnTokenArrPtr->;Command name(301))  // C_POINTER
APPEND TO ARRAY($vp_cDefnTokenArrPtr->;Command name(305))  // C_BOOLEAN
APPEND TO ARRAY($vp_cDefnTokenArrPtr->;Command name(306))  // C_TIME
APPEND TO ARRAY($vp_cDefnTokenArrPtr->;Command name(307))  // C_DATE
APPEND TO ARRAY($vp_cDefnTokenArrPtr->;Command name(352))  // _O_C_GRAPH
APPEND TO ARRAY($vp_cDefnTokenArrPtr->;Command name(604))  // C_BLOB
APPEND TO ARRAY($vp_cDefnTokenArrPtr->;Command name(1216))  // C_OBJECT
APPEND TO ARRAY($vp_cDefnTokenArrPtr->;Command name(1488))  // C_COLLECTION
APPEND TO ARRAY($vp_cDefnTokenArrPtr->;Command name(1683))  // C_VARIANT

ARRAY TEXT($vp_arrDefnTokenArrPtr->;0)
APPEND TO ARRAY($vp_arrDefnTokenArrPtr->;Command name(218))  // _O_ARRAY STRING
APPEND TO ARRAY($vp_arrDefnTokenArrPtr->;Command name(219))  // ARRAY REAL
APPEND TO ARRAY($vp_arrDefnTokenArrPtr->;Command name(220))  // ARRAY INTEGER
APPEND TO ARRAY($vp_arrDefnTokenArrPtr->;Command name(221))  // ARRAY LONGINT
APPEND TO ARRAY($vp_arrDefnTokenArrPtr->;Command name(222))  // ARRAY TEXT
APPEND TO ARRAY($vp_arrDefnTokenArrPtr->;Command name(223))  // ARRAY BOOLEAN
APPEND TO ARRAY($vp_arrDefnTokenArrPtr->;Command name(224))  // ARRAY DATE
APPEND TO ARRAY($vp_arrDefnTokenArrPtr->;Command name(279))  // ARRAY PICTURE
APPEND TO ARRAY($vp_arrDefnTokenArrPtr->;Command name(280))  // ARRAY POINTER
APPEND TO ARRAY($vp_arrDefnTokenArrPtr->;Command name(1221))  // ARRAY OBJECT
APPEND TO ARRAY($vp_arrDefnTokenArrPtr->;Command name(1222))  // ARRAY BLOB
APPEND TO ARRAY($vp_arrDefnTokenArrPtr->;Command name(1223))  // ARRAY TIME

ARRAY TEXT($at_C_declarVarToken;0)
APPEND TO ARRAY($at_C_declarVarToken;Command name(48))  // QUERY BY FORMULA
APPEND TO ARRAY($at_C_declarVarToken;Command name(108))  // QUERY SUBRECORDS
APPEND TO ARRAY($at_C_declarVarToken;Command name(207))  // QUERY SELECTION BY FORMULA
APPEND TO ARRAY($at_C_declarVarToken;Command name(277))  // QUERY
APPEND TO ARRAY($at_C_declarVarToken;Command name(292))  // QUERY BY EXAMPLE
APPEND TO ARRAY($at_C_declarVarToken;Command name(341))  // QUERY SELECTION
APPEND TO ARRAY($at_C_declarVarToken;Command name(644))  // QUERY WITH ARRAY
APPEND TO ARRAY($at_C_declarVarToken;Command name(1050))  // QUERY SELECTION WITH ARRAY
*/


