//   Mod: DB (03/29/2014) - Added pop-up menu

If (True:C214)  // DEFINE THE MENU CHOICES
	C_TEXT:C284($vt_itemStr)
	ARRAY TEXT:C222($at_items; 0)
	//APPEND TO ARRAY($at_items;"(Import All Updates") // Commented out item
	//APPEND TO ARRAY($at_items;"(-")  // Horizontal Line
	
	// Ignore case
	$vt_itemStr:=""
	If (Pref_GetPrefString("DIFF ignoreCase")="1")
		$vt_itemStr:="!-"
	End if 
	$vt_itemStr:=$vt_itemStr+"Ignore case;"
	APPEND TO ARRAY:C911($at_items; $vt_itemStr)
	
	
	// Ignore multiple spaces
	$vt_itemStr:=""
	If (Pref_GetPrefString("DIFF ignoreMultipleSpaces")="1")
		$vt_itemStr:="!-"
	End if 
	$vt_itemStr:=$vt_itemStr+"Ignore multiple spaces;"
	APPEND TO ARRAY:C911($at_items; $vt_itemStr)
	
	
	// Ignore blank lines
	$vt_itemStr:=""
	If (Pref_GetPrefString("DIFF ignoreBlankLines")="1")
		$vt_itemStr:="!-"
	End if 
	$vt_itemStr:=$vt_itemStr+"Ignore blank lines;"
	APPEND TO ARRAY:C911($at_items; $vt_itemStr)
	
	
	// Ignore attribute line
	$vt_itemStr:=""
	If (Pref_GetPrefString("DIFF Ignore Attribute Line")="1")
		$vt_itemStr:="!-"
	End if 
	$vt_itemStr:=$vt_itemStr+"Ignore attribute line;"
	APPEND TO ARRAY:C911($at_items; $vt_itemStr)
	
	
	APPEND TO ARRAY:C911($at_items; "(-")  // Horizontal Line
	
	// Ignore methods only in structure
	$vt_itemStr:=""
	If (Pref_GetPrefString("DIFF Suppress Structure Only")="1")
		$vt_itemStr:="!-"
	End if 
	$vt_itemStr:=$vt_itemStr+"Ignore methods only in structure;"
	APPEND TO ARRAY:C911($at_items; $vt_itemStr)
	
	
	// Ignore methods only on disk
	$vt_itemStr:=""
	If (Pref_GetPrefString("DIFF Suppress Disk Only")="1")
		$vt_itemStr:="!-"
	End if 
	$vt_itemStr:=$vt_itemStr+"Ignore methods only on disk;"
	APPEND TO ARRAY:C911($at_items; $vt_itemStr)
	
	
	APPEND TO ARRAY:C911($at_items; "(-")  // Horizontal Line
	APPEND TO ARRAY:C911($at_items; "Set all ignores")
	APPEND TO ARRAY:C911($at_items; "Clear all ignores")
	
	
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
	: ($at_items{$vlUserChoice}="@Ignore multiple spaces@")
		If (Pref_GetPrefString("DIFF ignoreMultipleSpaces")="1")
			Pref_SetPrefString("DIFF ignoreMultipleSpaces"; "0")
		Else 
			Pref_SetPrefString("DIFF ignoreMultipleSpaces"; "1")
		End if 
		
		
	: ($at_items{$vlUserChoice}="@Ignore case@")
		If (Pref_GetPrefString("DIFF ignoreCase")="1")
			Pref_SetPrefString("DIFF ignoreCase"; "0")
		Else 
			Pref_SetPrefString("DIFF ignoreCase"; "1")
		End if 
		
		
	: ($at_items{$vlUserChoice}="@Ignore Blank Lines@")
		If (Pref_GetPrefString("DIFF ignoreBlankLines")="1")
			Pref_SetPrefString("DIFF ignoreBlankLines"; "0")
		Else 
			Pref_SetPrefString("DIFF ignoreBlankLines"; "1")
		End if 
		
		
	: ($at_items{$vlUserChoice}="@Ignore Attribute Line@")
		If (Pref_GetPrefString("DIFF Ignore Attribute Line")="1")
			Pref_SetPrefString("DIFF Ignore Attribute Line"; "0")
		Else 
			Pref_SetPrefString("DIFF Ignore Attribute Line"; "1")
		End if 
		
		
	: ($at_items{$vlUserChoice}="@Ignore methods only in structure@")
		If (Pref_GetPrefString("DIFF Suppress Structure Only")="1")
			Pref_SetPrefString("DIFF Suppress Structure Only"; "0")
		Else 
			Pref_SetPrefString("DIFF Suppress Structure Only"; "1")
		End if 
		
		
	: ($at_items{$vlUserChoice}="@Ignore methods only on disk@")
		If (Pref_GetPrefString("DIFF Suppress Disk Only")="1")
			Pref_SetPrefString("DIFF Suppress Disk Only"; "0")
		Else 
			Pref_SetPrefString("DIFF Suppress Disk Only"; "1")
		End if 
		
		
	: ($at_items{$vlUserChoice}="@Clear All@") | ($at_items{$vlUserChoice}="@Set All@")
		If ($at_items{$vlUserChoice}="@Clear All@")
			$vt_itemStr:="0"
		Else 
			$vt_itemStr:="1"
		End if 
		Pref_SetPrefString("DIFF ignoreMultipleSpaces"; $vt_itemStr)
		Pref_SetPrefString("DIFF ignoreCase"; $vt_itemStr)
		Pref_SetPrefString("DIFF ignoreBlankLines"; $vt_itemStr)
		Pref_SetPrefString("DIFF Ignore Attribute Line"; $vt_itemStr)
		Pref_SetPrefString("DIFF Suppress Structure Only"; $vt_itemStr)
		Pref_SetPrefString("DIFF Suppress Disk Only"; $vt_itemStr)
		
End case 