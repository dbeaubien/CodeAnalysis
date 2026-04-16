//%attributes = {"invisible":true}
// Structure_GetAllFormNames (ARR_tableNos; ARR_FormNames)
//
// DESCRIPTION
//   Returns the names and table nos of all the forms in the structure.
//   Project forms will have a table no of 0.
//
#DECLARE($al_tableNos_Ptr : Pointer; $at_FormNames_Ptr : Pointer)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	
	// Gets Project Form Names
	FORM GET NAMES:C1167($at_FormNames_Ptr->; *)
	Array_SetSize(Size of array:C274($at_FormNames_Ptr->); $al_tableNos_Ptr)
	
	var $tableNo; $i : Integer
	For ($tableNo; 1; Last table number:C254)
		ARRAY TEXT:C222($at_tmp_formName; 0)
		If (Is table number valid:C999($tableNo))
			FORM GET NAMES:C1167(Table:C252($tableNo)->; $at_tmp_formName; *)  // Gets Project Form Names
			
			For ($i; 1; Size of array:C274($at_tmp_formName))
				APPEND TO ARRAY:C911($al_tableNos_Ptr->; $tableNo)
				APPEND TO ARRAY:C911($at_FormNames_Ptr->; $at_tmp_formName{$i})
			End for 
		End if 
	End for 
	
End if 

