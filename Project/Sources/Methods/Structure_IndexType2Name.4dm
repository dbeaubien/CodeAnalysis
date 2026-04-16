//%attributes = {"invisible":true}
// Structure_IndexType2Name (indexType) : indexTypeName
//
// DESCRIPTION
//   Returns a human readable name for the specified index type
//
#DECLARE($index_type : Integer) : Text
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	
	Case of 
		: ($index_type=-1)
			return "Multi"
			
		: ($index_type=1)
			return "B-tree"
			
		: ($index_type=3)
			return "Cluster B-tree"
			
		: ($index_type=7)
			return "Automatic"
			
		Else 
			return "Unknown Index Type #"+String:C10($index_type)
	End case 
	
End if 