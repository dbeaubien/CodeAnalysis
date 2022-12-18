//%attributes = {"invisible":true}
// Explorer_FocusOnSearchField (formPage)
//
// DESCRIPTION
//   
//
C_LONGINT:C283($1; $formPage)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (02/16/2021)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
$formPage:=$1

Case of 
	: ($formPage=1)
		EXECUTE METHOD IN SUBFORM:C1085("MethodSearchPicker"; "FocusOnObject"; *; \
			Choose:C955(Is macOS:C1572; "SearchText_Mac"; "SearchText_Win"))
		
	: ($formPage=2)
		EXECUTE METHOD IN SUBFORM:C1085("StructureFilterThingy"; "FocusOnObject"; *; \
			Choose:C955(Is macOS:C1572; "SearchText_Mac"; "SearchText_Win"))
		
End case 
