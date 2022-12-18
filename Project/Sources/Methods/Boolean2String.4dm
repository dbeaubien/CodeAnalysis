//%attributes = {"invisible":true}
// ----------------------------------------------------
// METHOD: Boolean2String
// 
// DESCRIPTION
//   Turns a boolean into a nice string
//
// PARAMETERS:
//   $1: boolean
//   $2: yes value
//   $3: no value
// RETURNS:
//   $0: converted string
// ----------------------------------------------------
// Created by: DB (04/12/04)
// ----------------------------------------------------

C_TEXT:C284($0)
$0:=""

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 3; Count parameters:C259))
	C_BOOLEAN:C305($1)  // Value to Convert
	C_TEXT:C284($2)
	C_TEXT:C284($3)
	
	If ($1)
		$0:=$2
	Else 
		$0:=$3
	End if 
	
End if   // ASSERT
