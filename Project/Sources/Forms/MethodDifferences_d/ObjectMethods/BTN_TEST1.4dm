//   Mod: DB (03/29/2014) - Added pop-up menu

If (True:C214)  // DEFINE THE MENU CHOICES
	ARRAY TEXT:C222($at_items; 0)
	//APPEND TO ARRAY($at_items;"(Import All Updates")
	//APPEND TO ARRAY($at_items;"(-")
	
	C_TEXT:C284($vt_itemStr)
	$vt_itemStr:=""
	If (Pref_GetPrefString("DIFF HideAttributeLine")="Yes")
		$vt_itemStr:="!-"
	End if 
	$vt_itemStr:=$vt_itemStr+"Hide Attribute Line;"
	APPEND TO ARRAY:C911($at_items; $vt_itemStr)
	
	
	$vt_itemStr:=""
	If (Pref_GetPrefString("DIFF HideComments")="Yes")
		$vt_itemStr:="!-"
	End if 
	$vt_itemStr:=$vt_itemStr+"Hide Comments;"
	APPEND TO ARRAY:C911($at_items; $vt_itemStr)
	
	
	$vt_itemStr:=""
	If (Pref_GetPrefString("DIFF HideBlankLines")="Yes")
		$vt_itemStr:="!-"
	End if 
	$vt_itemStr:=$vt_itemStr+"Hide Blank Lines"
	APPEND TO ARRAY:C911($at_items; $vt_itemStr)
	
	
	//   Mod: DB (05/14/2014) - 
	APPEND TO ARRAY:C911($at_items; "(-")
	If (Pref_GetPrefString("DIFF DifferenceView")="")
		APPEND TO ARRAY:C911($at_items; "!-Show Differences Side by Side")
		APPEND TO ARRAY:C911($at_items; "Show Differences Vertically")
	Else 
		APPEND TO ARRAY:C911($at_items; "Show Differences Side by Side")
		APPEND TO ARRAY:C911($at_items; "!-Show Differences Vertically")
	End if 
	
	C_TEXT:C284($vt_menuStr)
	$vt_menuStr:=""
	C_LONGINT:C283($i)
	For ($i; 1; Size of array:C274($at_items))
		If ($i#1)
			$vt_menuStr:=$vt_menuStr+";"
		End if 
		$vt_menuStr:=$vt_menuStr+$at_items{$i}
	End for 
	
End if 


// Show the pop-up menu
C_LONGINT:C283($vlUserChoice)
$vlUserChoice:=Pop up menu:C542($vt_menuStr)


// Deal with the choice
Case of 
	: ($at_items{$vlUserChoice}="@Hide Attribute Line@")
		BTN_Rescan:=1  // Force a rescan
		If (Pref_GetPrefString("DIFF HideAttributeLine")="Yes")
			Pref_SetPrefString("DIFF HideAttributeLine"; "")
		Else 
			Pref_SetPrefString("DIFF HideAttributeLine"; "Yes")
		End if 
		
	: ($at_items{$vlUserChoice}="@Hide Comments@")
		BTN_Rescan:=1  // Force a rescan
		If (Pref_GetPrefString("DIFF HideComments")="Yes")
			Pref_SetPrefString("DIFF HideComments"; "")
		Else 
			Pref_SetPrefString("DIFF HideComments"; "Yes")
		End if 
		
	: ($at_items{$vlUserChoice}="@Hide Blank Lines@")
		BTN_Rescan:=1  // Force a rescan
		If (Pref_GetPrefString("DIFF HideBlankLines")="Yes")
			Pref_SetPrefString("DIFF HideBlankLines"; "")
		Else 
			Pref_SetPrefString("DIFF HideBlankLines"; "Yes")
		End if 
		
	: ($at_items{$vlUserChoice}="@Show Differences Side by Side@")
		BTN_Rescan:=1  // Force a rescan
		Pref_SetPrefString("DIFF DifferenceView"; "")
		_FORM_CurrentPage:=1
		FORM GOTO PAGE:C247(1)
		
	: ($at_items{$vlUserChoice}="@Show Differences Vertically@")
		BTN_Rescan:=1  // Force a rescan
		Pref_SetPrefString("DIFF DifferenceView"; "VerticalView")
		_FORM_CurrentPage:=2
		FORM GOTO PAGE:C247(2)
		
End case 