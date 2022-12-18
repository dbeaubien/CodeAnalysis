//%attributes = {"invisible":true}
// Generator__SetPage (mainTab{; subTab}) 
// Generator__SetPage (longint{; longint}) 
// 
// DESCRIPTION
//   The method manages the changing of the pages on the main window.
//
C_LONGINT:C283($1; $vl_mainTab)
C_LONGINT:C283($2; $vl_subTab)
// ----------------------------------------------------
// CALLED BY
//   
// ----------------------------------------------------
// HISTORY
//   Created by: DB (05/18/2015)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT_RANGE(Current method name:C684; 1; 2; Count parameters:C259))
	$vl_mainTab:=$1
	If (Count parameters:C259>=2)
		$vl_subTab:=$2
	Else 
		$vl_subTab:=0
	End if 
	
	C_LONGINT:C283($tabPos_Differences; $tabPos_Exporting; $tabPos_MethodComments)
	$tabPos_Differences:=1
	$tabPos_Exporting:=2
	$tabPos_MethodComments:=3
	
	// Main tab has changed, update subtab values
	C_LONGINT:C283(vl_mainTabPos)
	If (vl_mainTabPos#$vl_mainTab)
		vl_mainTabPos:=$vl_mainTab
		TabControl:=$vl_mainTab
		
		Case of 
			: ($vl_mainTab=$tabPos_Differences)  // Differences
				OBJECT SET VISIBLE:C603(SubTabControl; True:C214)
				ARRAY TEXT:C222(SubTabControl; 2)
				SubTabControl{1}:=Get localized string:C991("TabLabel_Methods")
				SubTabControl{2}:=Get localized string:C991("TabLabel_Folders")
				
			: ($vl_mainTab=$tabPos_Exporting)  // Exporting
				OBJECT SET VISIBLE:C603(SubTabControl; False:C215)
				ARRAY TEXT:C222(SubTabControl; 0)
				
			: ($vl_mainTab=$tabPos_MethodComments)  // Method Comments
				OBJECT SET VISIBLE:C603(SubTabControl; False:C215)
				ARRAY TEXT:C222(SubTabControl; 0)
				
		End case 
	End if 
	
	
	
	C_LONGINT:C283(vl_subTab1Pos; vl_subTab2Pos; vl_subTab3Pos; $vl_Page)  // place to store the last tab position
	Case of 
		: ($vl_mainTab=$tabPos_Differences)  // Differences
			If (vl_subTab2Pos=0)
				vl_subTab2Pos:=1
			End if 
			If ($vl_subTab#0)
				vl_subTab2Pos:=$vl_subTab
			End if 
			
			SubTabControl:=vl_subTab2Pos
			$vl_Page:=1+(vl_subTab2Pos-1)
			
			
		: ($vl_mainTab=$tabPos_Exporting)  // Exporting
			$vl_Page:=3
			
			
		: ($vl_mainTab=$tabPos_MethodComments)  // Method Comments
			$vl_Page:=4
			
	End case 
	
	If (FORM Get current page:C276#$vl_Page)
		FORM GOTO PAGE:C247($vl_Page)
	End if 
	
End if   // ASSERT