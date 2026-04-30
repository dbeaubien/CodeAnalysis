//%attributes = {"invisible":true}
// Structure__SQLDataType2String
//
// DESCRIPTION
//   This function converts all textlines of the text into 
//   unique numbers for every unique textline so further 
//   work can work only with simple numbers.
//
#DECLARE($vl_SQLdataType : Integer)->$vt_SQLdataTypeAsText : Text
// ----------------------------------------------------

$vt_SQLdataTypeAsText:=""
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	
	Case of 
		: ($vl_SQLdataType=1)
			$vt_SQLdataTypeAsText:="Boolean"
			
		: ($vl_SQLdataType=3)
			$vt_SQLdataTypeAsText:="Smallint"
			
		: ($vl_SQLdataType=4)
			$vt_SQLdataTypeAsText:="Int"
			
		: ($vl_SQLdataType=5)
			$vt_SQLdataTypeAsText:="Int64"
			
		: ($vl_SQLdataType=6)
			$vt_SQLdataTypeAsText:="Real"
			
		: ($vl_SQLdataType=7)
			$vt_SQLdataTypeAsText:="Float"
			
		: ($vl_SQLdataType=8)
			$vt_SQLdataTypeAsText:="Timestamp"
			
		: ($vl_SQLdataType=9)
			$vt_SQLdataTypeAsText:="Duration or Interval"
			
		: ($vl_SQLdataType=10)
			$vt_SQLdataTypeAsText:="Varchar"
			
		: ($vl_SQLdataType=12)
			$vt_SQLdataTypeAsText:="Picture"
			
		: ($vl_SQLdataType=13)
			$vt_SQLdataTypeAsText:="UUID"
			
		: ($vl_SQLdataType=14)
			$vt_SQLdataTypeAsText:="Clob"
			
		: ($vl_SQLdataType=18)
			$vt_SQLdataTypeAsText:="Blob"
			
		Else 
			$vt_SQLdataTypeAsText:="SQL DataType "+String:C10($vl_SQLdataType)
			//TRACE
	End case 
	
End if 
