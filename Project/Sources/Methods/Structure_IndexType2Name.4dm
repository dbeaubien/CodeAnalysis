//%attributes = {"invisible":true}
// Structure_IndexType2Name (indexType) : indexTypeName
// Structure_IndexType2Name (longint) : text
//
// DESCRIPTION
//   Returns a human readable name for the specified index type
//
C_TEXT:C284($0)
C_LONGINT:C283($1)
// ----------------------------------------------------
// HISTORY
//   Created By: Dani Beaubien (08/19/2013)
// ----------------------------------------------------

$0:=""
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	
	Case of 
		: ($1=-1)
			$0:="Multi"
			
		: ($1=1)
			$0:="B-tree"
			
		: ($1=3)
			$0:="Cluster B-tree"
			
		: ($1=7)
			$0:="Automatic"
			
		Else 
			$0:="Unknown Index Type #"+String:C10($1)
	End case 
	
End if   // ASSERT