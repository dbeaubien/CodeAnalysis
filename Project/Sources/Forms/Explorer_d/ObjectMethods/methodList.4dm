
C_BOOLEAN:C305($doDoubleClick)
$doDoubleClick:=False:C215

C_OBJECT:C1216(selectedMethodObj)  // set by the list box
Case of 
	: (String:C10(selectedMethodObj.path)="")  // do nothing
		
	: (Form event code:C388=On Double Clicked:K2:5)
		$doDoubleClick:=True:C214
		
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($vlMouseX; $vlMouseY; $vlButton)
		GET MOUSE:C468($vlMouseX; $vlMouseY; $vlButton)
		If (Macintosh control down:C544 | ($vlButton=2))
			ARRAY TEXT:C222($at_menuItems; 0)
			ARRAY TEXT:C222($at_selectedMethodPaths; 0)
			APPEND TO ARRAY:C911($at_menuItems; "Code Review…")
			APPEND TO ARRAY:C911($at_menuItems; "Open Method…")
			APPEND TO ARRAY:C911($at_selectedMethodPaths; "")
			APPEND TO ARRAY:C911($at_selectedMethodPaths; "")
			
			If (selectedMethodObj.upstreamMethodPaths.length>0)
				APPEND TO ARRAY:C911($at_menuItems; "(-")
				APPEND TO ARRAY:C911($at_selectedMethodPaths; "")
				
				//APPEND TO ARRAY($at_menuItems;selectedMethodObj.name)
				//APPEND TO ARRAY($at_selectedMethodPaths;"")
				
				C_TEXT:C284($methodPath)
				For each ($methodPath; selectedMethodObj.upstreamMethodPaths)
					APPEND TO ARRAY:C911($at_menuItems; "Called by \""+Replace string:C233($methodPath; "/"; " > ")+"\"…")
					APPEND TO ARRAY:C911($at_selectedMethodPaths; $methodPath)
				End for each 
			End if 
			
			// Convert the array into the pop-up menu
			C_TEXT:C284($vtItems)
			C_LONGINT:C283($i)
			$vtItems:=""
			For ($i; 1; Size of array:C274($at_menuItems))
				If ($vtItems#"")
					$vtItems:=$vtItems+";"
				End if 
				$vtItems:=$vtItems+$at_menuItems{$i}
			End for 
			
			// Show pop-up and handle choice
			C_LONGINT:C283($vlUserChoice)
			$vlUserChoice:=Pop up menu:C542($vtItems)
			Case of 
				: ($vlUserChoice=0)
				: ($vlUserChoice>Size of array:C274($at_selectedMethodPaths))
					
				: ($at_menuItems{$vlUserChoice}="Open Method...")
					$doDoubleClick:=True:C214
					
				: ($at_menuItems{$vlUserChoice}="Code Review...")
					C_TEXT:C284(<>_DIFF_MethodName)
					<>_DIFF_MethodName:=selectedMethodObj.name
					CODE_DoCodeReview
					
				Else 
					METHOD OPEN PATH:C1213($at_selectedMethodPaths{$vlUserChoice}; *)
					
			End case 
			
			
		End if 
		
End case 


If ($doDoubleClick)
	C_TEXT:C284($methodPath)
	$methodPath:=String:C10(selectedMethodObj.path)
	If ($methodPath#"")
		METHOD OPEN PATH:C1213($methodPath; *)
	End if 
End if 
