//%attributes = {"invisible":true,"preemptive":"capable"}
// Array_ConvertFromTextDelimited (ArrayPtr, srcText; delimiter)
// Array_ConvertFromTextDelimited (pointer; text; text)
//
// DESCRIPTION
//   Converts a delimited text string into values
//   in the passed text array.
//
C_POINTER:C301($1; $vp_arrayPtr)
C_TEXT:C284($2; $vt_srcTxt)
C_TEXT:C284($3; $theDelimiter)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (04/19/07)
//   Mod: DB (09/25/2012) - Fixed bug if last character of srcTxt is the delimiter
//   Mod: DB (09/25/2012) - Removed code that trimed extra spaces
// ----------------------------------------------------

If (Asserted:C1132((Count parameters:C259=2) | (Count parameters:C259=3)))
	$vp_arrayPtr:=$1
	$vt_srcTxt:=$2
	If (Count parameters:C259=3)
		$theDelimiter:=$3
	Else 
		$theDelimiter:="•"
	End if 
	
	C_LONGINT:C283($vl_delSize)
	Array_Empty($vp_arrayPtr)
	$vl_delSize:=Length:C16($theDelimiter)
	
	C_LONGINT:C283($theSize; $pos)
	If ($vt_srcTxt#"")
		$theSize:=0
		$pos:=Position:C15($theDelimiter; $vt_srcTxt)
		While ($pos>0)
			$theSize:=$theSize+1
			INSERT IN ARRAY:C227($vp_arrayPtr->; $theSize; 1)
			
			$vp_arrayPtr->{$theSize}:=Substring:C12($vt_srcTxt; 1; $pos-1)
			$vt_srcTxt:=Substring:C12($vt_srcTxt; $pos+$vl_delSize)
			
			$pos:=Position:C15($theDelimiter; $vt_srcTxt)
		End while 
		
		//   Mod: DB (09/25/2012) - Add the an element for the last line.
		$theSize:=$theSize+1
		INSERT IN ARRAY:C227($vp_arrayPtr->; $theSize; 1)
		
		// If it is a non-empty line, then set the value
		If ($vt_srcTxt#"")
			$vp_arrayPtr->{$theSize}:=$vt_srcTxt
		End if 
		
	End if 
	
End if   // ASSERT
