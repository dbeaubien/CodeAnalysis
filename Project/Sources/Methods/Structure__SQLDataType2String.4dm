//%attributes = {"invisible":true}
// Structure__SQLDataType2String
//
// DESCRIPTION
//   This function converts all textlines of the text into 
//   unique numbers for every unique textline so further 
//   work can work only with simple numbers.
//
C_TEXT:C284($0; $vt_SQLdataTypeAsText)
C_LONGINT:C283($1; $vl_SQLdataType)
// ----------------------------------------------------
// HISTORY
//   Created by: ddancy (02/18/2008)
//   Mod by: Dani Beaubien (10/25/2012) - Added support for $vb_ignoreMultipleSpaces and $vb_ignoreCase
// ----------------------------------------------------

$vt_SQLdataTypeAsText:=""
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$vl_SQLdataType:=$1
	
	Case of 
		: ($1=1)
			$vt_SQLdataTypeAsText:="Boolean"
			
		: ($1=3)
			$vt_SQLdataTypeAsText:="Smallint"
			
		: ($1=4)
			$vt_SQLdataTypeAsText:="Int"
			
		: ($1=5)
			$vt_SQLdataTypeAsText:="Int64"
			
		: ($1=6)
			$vt_SQLdataTypeAsText:="Real"
			
		: ($1=7)
			$vt_SQLdataTypeAsText:="Float"
			
		: ($1=8)
			$vt_SQLdataTypeAsText:="Timestamp"
			
		: ($1=9)
			$vt_SQLdataTypeAsText:="Duration or Interval"
			
		: ($1=10)
			$vt_SQLdataTypeAsText:="Varchar"
			
		: ($1=12)
			$vt_SQLdataTypeAsText:="Picture"
			
		: ($1=13)
			$vt_SQLdataTypeAsText:="UUID"
			
		: ($1=14)
			$vt_SQLdataTypeAsText:="Clob"
			
		: ($1=18)
			$vt_SQLdataTypeAsText:="Blob"
			
		Else 
			$vt_SQLdataTypeAsText:="SQL DataType "+String:C10($1)
			//TRACE
	End case 
	
End if   // ASSERT
$0:=$vt_SQLdataTypeAsText