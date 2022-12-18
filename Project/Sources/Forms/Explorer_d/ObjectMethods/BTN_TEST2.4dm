//   Mod: DB (03/29/2014) - Added pop-up menu

If (True:C214)  // DEFINE THE MENU CHOICES
	C_TEXT:C284($vt_itemStr)
	ARRAY TEXT:C222($at_items; 0)
	
	
	If (True:C214)  // Filters by method type
		// Hide Project Methods
		$vt_itemStr:=""
		If (Pref_GetPrefString("EXPLORE HideMethod Project")="1")
			$vt_itemStr:="!-"
		End if 
		$vt_itemStr:=$vt_itemStr+"Hide Project Methods;"
		APPEND TO ARRAY:C911($at_items; $vt_itemStr)
		
		// Hide Database Methods
		$vt_itemStr:=""
		If (Pref_GetPrefString("EXPLORE HideMethod Database")="1")
			$vt_itemStr:="!-"
		End if 
		$vt_itemStr:=$vt_itemStr+"Hide Database Methods;"
		APPEND TO ARRAY:C911($at_items; $vt_itemStr)
		
		// Hide Project Form Methods
		$vt_itemStr:=""
		If (Pref_GetPrefString("EXPLORE HideMethod ProjectForm")="1")
			$vt_itemStr:="!-"
		End if 
		$vt_itemStr:=$vt_itemStr+"Hide Project Form Methods;"
		APPEND TO ARRAY:C911($at_items; $vt_itemStr)
		
		// Hide Table Form Methods
		$vt_itemStr:=""
		If (Pref_GetPrefString("EXPLORE HideMethod TableForm")="1")
			$vt_itemStr:="!-"
		End if 
		$vt_itemStr:=$vt_itemStr+"Hide Table Form Methods;"
		APPEND TO ARRAY:C911($at_items; $vt_itemStr)
		
		// Hide Trigger Methods
		$vt_itemStr:=""
		If (Pref_GetPrefString("EXPLORE HideMethod Trigger")="1")
			$vt_itemStr:="!-"
		End if 
		$vt_itemStr:=$vt_itemStr+"Hide Trigger Methods;"
		APPEND TO ARRAY:C911($at_items; $vt_itemStr)
		
		//   Mod: DB (05/31/2017) - Added support for v16 preemptive methods
		If (Num:C11(Substring:C12(Application version:C493; 1; 2))>=16)  // Are we v16 or greater?
			// Hide preemptive indifferent method
			$vt_itemStr:=""
			If (Pref_GetPrefString("EXPLORE HideMethod PreemptiveCapable")="1")
				$vt_itemStr:="!-"
			End if 
			$vt_itemStr:=$vt_itemStr+"Hide Preemptive Capable Methods;"
			APPEND TO ARRAY:C911($at_items; $vt_itemStr)
			
			// Hide preemptive indifferent method
			$vt_itemStr:=""
			If (Pref_GetPrefString("EXPLORE HideMethod PreemptiveInCapable")="1")
				$vt_itemStr:="!-"
			End if 
			$vt_itemStr:=$vt_itemStr+"Hide Preemptive Incapable Methods;"
			APPEND TO ARRAY:C911($at_items; $vt_itemStr)
			
			// Hide preemptive indifferent method
			$vt_itemStr:=""
			If (Pref_GetPrefString("EXPLORE HideMethod PreemptiveIndifferent")="1")
				$vt_itemStr:="!-"
			End if 
			$vt_itemStr:=$vt_itemStr+"Hide Preemptive Indifferent Methods;"
			APPEND TO ARRAY:C911($at_items; $vt_itemStr)
			
		End if 
		
		// Reset
		APPEND TO ARRAY:C911($at_items; "Show All Method Types")
	End if 
	
	APPEND TO ARRAY:C911($at_items; "(-")  // Horizontal Line
	
	
	If (True:C214)  // Filters by method type
		ARRAY LONGINT:C221($al_days; 0)
		APPEND TO ARRAY:C911($al_days; 1)
		APPEND TO ARRAY:C911($al_days; 3)
		APPEND TO ARRAY:C911($al_days; 7)
		APPEND TO ARRAY:C911($al_days; 14)
		APPEND TO ARRAY:C911($al_days; 30)
		APPEND TO ARRAY:C911($al_days; 60)
		APPEND TO ARRAY:C911($al_days; 90)
		APPEND TO ARRAY:C911($al_days; 180)
		
		C_BOOLEAN:C305($vb_oneSet)
		C_LONGINT:C283($i)
		For ($i; 1; Size of array:C274($al_days))
			$vt_itemStr:=""
			If (Pref_GetPrefString("EXPLORE LastMod DayCount")=String:C10($al_days{$i}))
				$vt_itemStr:="!-"
				$vb_oneSet:=True:C214
			End if 
			If ($al_days{$i}=1)
				$vt_itemStr:=$vt_itemStr+"Modified Today;"
			Else 
				$vt_itemStr:=$vt_itemStr+"Modified in last "+String:C10($al_days{$i})+" days;"
			End if 
			APPEND TO ARRAY:C911($at_items; $vt_itemStr)
		End for 
		
		// Show All
		$vt_itemStr:=""
		If (Not:C34($vb_oneSet))
			$vt_itemStr:="!-"
		End if 
		$vt_itemStr:=$vt_itemStr+"Modified Anytime;"
		APPEND TO ARRAY:C911($at_items; $vt_itemStr)
		
	End if 
	
	
	APPEND TO ARRAY:C911($at_items; "(-")  // Horizontal Line
	
	
	If (True:C214)  // Filters for method attributes
		$vt_itemStr:=""
		If (Pref_GetPrefString("EXPLORE OnlyShowShared")="1")
			$vt_itemStr:="!-"
		End if 
		$vt_itemStr:=$vt_itemStr+"Only Show Shared Methods;"
		APPEND TO ARRAY:C911($at_items; $vt_itemStr)
		
		$vt_itemStr:=""
		If (Pref_GetPrefString("EXPLORE OnlyShowServerExecute")="1")
			$vt_itemStr:="!-"
		End if 
		$vt_itemStr:=$vt_itemStr+"Only Show Execute On Server Methods;"
		APPEND TO ARRAY:C911($at_items; $vt_itemStr)
		
		$vt_itemStr:=""
		If (Pref_GetPrefString("EXPLORE OnlyShowWeb")="1")
			$vt_itemStr:="!-"
		End if 
		$vt_itemStr:=$vt_itemStr+"Only Show Available to Web Methods;"
		APPEND TO ARRAY:C911($at_items; $vt_itemStr)
		
	End if 
	
	
	C_TEXT:C284($vt_menuStr)
	$vt_menuStr:=""
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
C_BOOLEAN:C305($vb_refreshGrid)
$vb_refreshGrid:=True:C214
Case of 
	: ($at_items{$vlUserChoice}="@Hide Preemptive Incapable Methods@")  //   Mod: DB (05/31/2017)
		If (Pref_GetPrefString("EXPLORE HideMethod PreemptiveInCapable")="1")
			Pref_SetPrefString("EXPLORE HideMethod PreemptiveInCapable"; "0")
		Else 
			Pref_SetPrefString("EXPLORE HideMethod PreemptiveInCapable"; "1")
		End if 
		
	: ($at_items{$vlUserChoice}="@Hide Preemptive Indifferent Methods@")  //   Mod: DB (05/31/2017)
		If (Pref_GetPrefString("EXPLORE HideMethod PreemptiveIndifferent")="1")
			Pref_SetPrefString("EXPLORE HideMethod PreemptiveIndifferent"; "0")
		Else 
			Pref_SetPrefString("EXPLORE HideMethod PreemptiveIndifferent"; "1")
		End if 
		
	: ($at_items{$vlUserChoice}="@Hide Preemptive Capable Methods@")  //   Mod: DB (05/31/2017)
		If (Pref_GetPrefString("EXPLORE HideMethod PreemptiveCapable")="1")
			Pref_SetPrefString("EXPLORE HideMethod PreemptiveCapable"; "0")
		Else 
			Pref_SetPrefString("EXPLORE HideMethod PreemptiveCapable"; "1")
		End if 
		
	: ($at_items{$vlUserChoice}="@Only Show Available to Web Methods@")  //   Mod: DB (02/22/2017)
		If (Pref_GetPrefString("EXPLORE OnlyShowWeb")="1")
			Pref_SetPrefString("EXPLORE OnlyShowWeb"; "0")
		Else 
			Pref_SetPrefString("EXPLORE OnlyShowWeb"; "1")
			Pref_SetPrefString("EXPLORE OnlyShowServerExecute"; "0")
			Pref_SetPrefString("EXPLORE OnlyShowShared"; "0")
		End if 
		
	: ($at_items{$vlUserChoice}="@Only Show Execute On Server Methods@")  //   Mod: DB (02/22/2017)
		If (Pref_GetPrefString("EXPLORE OnlyShowServerExecute")="1")
			Pref_SetPrefString("EXPLORE OnlyShowServerExecute"; "0")
		Else 
			Pref_SetPrefString("EXPLORE OnlyShowServerExecute"; "1")
			Pref_SetPrefString("EXPLORE OnlyShowShared"; "0")
			Pref_SetPrefString("EXPLORE OnlyShowWeb"; "0")
		End if 
		
	: ($at_items{$vlUserChoice}="@Only Show Shared Methods@")  //   Mod: DB (02/22/2017)
		If (Pref_GetPrefString("EXPLORE OnlyShowShared")="1")
			Pref_SetPrefString("EXPLORE OnlyShowShared"; "0")
		Else 
			Pref_SetPrefString("EXPLORE OnlyShowShared"; "1")
			Pref_SetPrefString("EXPLORE OnlyShowServerExecute"; "0")
			Pref_SetPrefString("EXPLORE OnlyShowWeb"; "0")
		End if 
		
	: ($at_items{$vlUserChoice}="@Hide Database Methods@")
		If (Pref_GetPrefString("EXPLORE HideMethod Database")="1")
			Pref_SetPrefString("EXPLORE HideMethod Database"; "0")
		Else 
			Pref_SetPrefString("EXPLORE HideMethod Database"; "1")
		End if 
		
		
	: ($at_items{$vlUserChoice}="@Hide Project Form Methods@")
		If (Pref_GetPrefString("EXPLORE HideMethod ProjectForm")="1")
			Pref_SetPrefString("EXPLORE HideMethod ProjectForm"; "0")
		Else 
			Pref_SetPrefString("EXPLORE HideMethod ProjectForm"; "1")
		End if 
		
		
	: ($at_items{$vlUserChoice}="@Hide Table Form Methods@")
		If (Pref_GetPrefString("EXPLORE HideMethod TableForm")="1")
			Pref_SetPrefString("EXPLORE HideMethod TableForm"; "0")
		Else 
			Pref_SetPrefString("EXPLORE HideMethod TableForm"; "1")
		End if 
		
	: ($at_items{$vlUserChoice}="@Hide Trigger Methods@")
		If (Pref_GetPrefString("EXPLORE HideMethod Trigger")="1")
			Pref_SetPrefString("EXPLORE HideMethod Trigger"; "0")
		Else 
			Pref_SetPrefString("EXPLORE HideMethod Trigger"; "1")
		End if 
		
	: ($at_items{$vlUserChoice}="@Hide Project Methods@")
		If (Pref_GetPrefString("EXPLORE HideMethod Project")="1")
			Pref_SetPrefString("EXPLORE HideMethod Project"; "0")
		Else 
			Pref_SetPrefString("EXPLORE HideMethod Project"; "1")
		End if 
		
	: ($at_items{$vlUserChoice}="@Show all Method Types@")
		Pref_SetPrefString("EXPLORE HideMethod Trigger"; "0")
		Pref_SetPrefString("EXPLORE HideMethod TableForm"; "0")
		Pref_SetPrefString("EXPLORE HideMethod ProjectForm"; "0")
		Pref_SetPrefString("EXPLORE HideMethod Database"; "0")
		Pref_SetPrefString("EXPLORE HideMethod Project"; "0")
		Pref_SetPrefString("EXPLORE HideMethod PreemptiveInCapable"; "0")
		Pref_SetPrefString("EXPLORE HideMethod PreemptiveIndifferent"; "0")
		Pref_SetPrefString("EXPLORE HideMethod PreemptiveCapable"; "0")
		
	: ($at_items{$vlUserChoice}="@Modified Anytime@")
		Pref_SetPrefString("EXPLORE LastMod DayCount"; "0")
		
	: ($at_items{$vlUserChoice}="@Modified Today@")
		Pref_SetPrefString("EXPLORE LastMod DayCount"; "1")
		
	: ($at_items{$vlUserChoice}="@Modified in last@days@")
		$vt_itemStr:=$at_items{$vlUserChoice}
		$vt_itemStr:=Replace string:C233($vt_itemStr; "!-"; "")
		$vt_itemStr:=Replace string:C233($vt_itemStr; "Modified in last "; "")
		$vt_itemStr:=Replace string:C233($vt_itemStr; " days;"; "")
		Pref_SetPrefString("EXPLORE LastMod DayCount"; $vt_itemStr)
		
		
	Else 
		$vb_refreshGrid:=False:C215
End case 


If ($vb_refreshGrid)
	Explorer_ApplyMethodFilter(Form:C1466)
End if 