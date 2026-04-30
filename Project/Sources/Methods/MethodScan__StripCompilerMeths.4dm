//%attributes = {"invisible":true}
// MethodScan__StripCompilerMeths (methodNamesArrPtr)
// 
// DESCRIPTION
//   If the preference is set, all "Compiler" methods
//   are removed from the array.
//
#DECLARE($vp_methodNamesArrPtr : Pointer)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	
	If (Size of array:C274($vp_methodNamesArrPtr->)>0)
		
		//   Mod by: Dani Beaubien (09/29/2012) - do we strip out the compiler methods?
		If (Pref_GetPrefString("CA include Compiler Methods"; "1")#"1")
			var $i : Integer
			For ($i; Size of array:C274($vp_methodNamesArrPtr->); 1; -1)
				If ($vp_methodNamesArrPtr->{$i}="Compiler_@")
					DELETE FROM ARRAY:C228($vp_methodNamesArrPtr->; $i; 1)
				End if 
			End for 
		End if 
		
	End if 
	
End if 