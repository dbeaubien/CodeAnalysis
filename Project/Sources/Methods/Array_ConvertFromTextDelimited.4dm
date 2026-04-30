//%attributes = {"invisible":true,"preemptive":"capable"}
// Array_ConvertFromTextDelimited (ArrayPtr, srcText; delimiter)
//
// DESCRIPTION
//   Converts a delimited text string into values
//   in the passed text array.
//
#DECLARE($array_ptr : Pointer\
; $vt_srcTxt : Text\
; $theDelimiter : Text)
// ----------------------------------------------------

If (Asserted:C1132((Count parameters:C259=2) | (Count parameters:C259=3)))
	If ($theDelimiter="")
		$theDelimiter:="•"
	End if 
	
	var $vl_delSize : Integer
	Array_Empty($array_ptr)
	$vl_delSize:=Length:C16($theDelimiter)
	
	var $theSize; $pos : Integer
	If ($vt_srcTxt#"")
		$theSize:=0
		$pos:=Position:C15($theDelimiter; $vt_srcTxt)
		While ($pos>0)
			$theSize:=$theSize+1
			INSERT IN ARRAY:C227($array_ptr->; $theSize; 1)
			
			$array_ptr->{$theSize}:=Substring:C12($vt_srcTxt; 1; $pos-1)
			$vt_srcTxt:=Substring:C12($vt_srcTxt; $pos+$vl_delSize)
			
			$pos:=Position:C15($theDelimiter; $vt_srcTxt)
		End while 
		
		//   Mod: DB (09/25/2012) - Add the an element for the last line.
		$theSize:=$theSize+1
		INSERT IN ARRAY:C227($array_ptr->; $theSize; 1)
		
		// If it is a non-empty line, then set the value
		If ($vt_srcTxt#"")
			$array_ptr->{$theSize}:=$vt_srcTxt
		End if 
		
	End if 
	
End if 
