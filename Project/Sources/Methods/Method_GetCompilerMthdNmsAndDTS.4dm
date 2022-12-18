//%attributes = {"invisible":true}
// Method_GetCompilerMthdNmsAndDTS (methodNamesArrPtr; methodDTSArrPtr) 
// Method_GetCompilerMthdNmsAndDTS (pointer; pointer)
// 
// DESCRIPTION
//   Returns an array of the "Compiler_" methods and their modified DTS.
//
C_POINTER:C301($1; $at_methodNames_ArrPtr)
C_POINTER:C301($1; $at_methodDTS_ArrPtr)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (12/21/2015)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	$at_methodNames_ArrPtr:=$1
	$at_methodDTS_ArrPtr:=$2
	
	Array_Empty($at_methodNames_ArrPtr)
	Array_Empty($at_methodDTS_ArrPtr)
	
	
	// Get the "Compiler" method names
	ARRAY TEXT:C222($at_methodNames; 0)
	METHOD GET PATHS:C1163(Path project method:K72:1; $at_methodNames; *)
	C_LONGINT:C283($i)
	For ($i; Size of array:C274($at_methodNames); 1; -1)
		If ($at_methodNames{$i}="Compiler_@")
			APPEND TO ARRAY:C911($at_methodNames_ArrPtr->; $at_methodNames{$i})
		End if 
	End for 
	
	
	//   Mod: DB (11/27/2014) - Get the last mod date & time
	ARRAY DATE:C224($ad_methodModDate; 0)
	ARRAY LONGINT:C221($ah_methodModTime; 0)
	METHOD GET MODIFICATION DATE:C1170($at_methodNames_ArrPtr->; $ad_methodModDate; $ah_methodModTime; *)
	Array_SetSize(Size of array:C274($at_methodNames_ArrPtr->); $at_methodDTS_ArrPtr)
	For ($i; 1; Size of array:C274($at_methodNames_ArrPtr->))
		$at_methodDTS_ArrPtr->{$i}:=TS_FromDateTime($ad_methodModDate{$i}; $ah_methodModTime{$i})
	End for 
	
End if   // ASSERT

