//%attributes = {"invisible":true}
// MethodScan__StripCompilerMeths (methodNamesArrPtr)
// MethodScan__StripCompilerMeths (pointer)
// 
// DESCRIPTION
//   If the preference is set, all "Compiler" methods
//   are removed from the array.
//
C_POINTER:C301($1; $vp_methodNamesArrPtr)
// ----------------------------------------------------
// CALLED BY
//   MethodScan_LoadMethodNames
// ----------------------------------------------------
// HISTORY
//   Created by: DB (11/27/2014)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$vp_methodNamesArrPtr:=$1
	
	If (Size of array:C274($vp_methodNamesArrPtr->)>0)
		
		//   Mod by: Dani Beaubien (09/29/2012) - do we strip out the compiler methods?
		If (Pref_GetPrefString("CA include Compiler Methods"; "1")#"1")
			C_LONGINT:C283($i)
			For ($i; Size of array:C274($vp_methodNamesArrPtr->); 1; -1)
				If ($vp_methodNamesArrPtr->{$i}="Compiler_@")
					DELETE FROM ARRAY:C228($vp_methodNamesArrPtr->; $i; 1)
				End if 
			End for 
		End if 
		
	End if 
	
End if   // ASSERT