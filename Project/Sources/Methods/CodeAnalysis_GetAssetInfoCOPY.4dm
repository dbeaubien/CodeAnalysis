//%attributes = {"invisible":true}
// CodeAnalysis_GetAssetInfo (selector; ptr1; ptr2)
//
// DESCRIPTION
//   This method is called by the Code Analysis component
//   to fetch information from the host structure.
//   These calls must all be called from the host structure.
//
#DECLARE($vt_selector : Text; $vp_pointer1 : Pointer; $vp_pointer2 : Pointer)
// ----------------------------------------------------

If (Asserted:C1132((Count parameters:C259=3) | (Count parameters:C259=2); "Expected 2 or 3 parameters"))
	
	Case of 
		: ($vt_selector="MethodVersion")
			$vp_pointer1->:=2
			
		: ($vt_selector="GetListOfPicts")
			PICTURE LIBRARY LIST:C564($vp_pointer1->; $vp_pointer2->)
			
		: ($vt_selector="GetPict")
			GET PICTURE FROM LIBRARY:C565($vp_pointer1->; $vp_pointer2->)
			
		: ($vt_selector="GetListOfLists")
			LIST OF CHOICE LISTS:C957($vp_pointer1->; $vp_pointer2->)
			
		: ($vt_selector="GetList")
			$vp_pointer2->:=Load list:C383($vp_pointer1->)
			
		: ($vt_selector="GetListOfProjectForms")
			FORM GET NAMES:C1167($vp_pointer1->)
			
		: ($vt_selector="GetListOfTableForms")
			FORM GET NAMES:C1167(Table:C252($vp_pointer1->)->; $vp_pointer2->)
			
	End case 
	
End if 