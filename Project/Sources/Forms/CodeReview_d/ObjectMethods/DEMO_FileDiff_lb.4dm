Case of 
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($vlMouseX; $vlMouseY; $vlButton)
		GET MOUSE:C468($vlMouseX; $vlMouseY; $vlButton)
		If (Macintosh control down:C544 | ($vlButton=2))
			
			If (Size of array:C274(DEMO_File1_at)>0)
				
				ARRAY TEXT:C222($at_menuItems; 0)
				APPEND TO ARRAY:C911($at_menuItems; "Open Method...")
				
				// Look to see if there are any mispelled words that the user might want to add to the user dictionary
				If (DEMO_File1_at#0)
					C_TEXT:C284($myText)
					C_LONGINT:C283($i; $pos; $errCount)
					$myText:=ST Get plain text:C1092(DEMO_File1_at{DEMO_File1_at})
					$pos:=Position:C15("//"; $myText)
					If ($pos>0)
						// Scan for mis-spelled words
						$errCount:=0
						ARRAY TEXT:C222($at_errorWords; 0)
						ARRAY TEXT:C222($tSuggestions; 0)
						C_LONGINT:C283($errPos; $errLength)
						C_TEXT:C284($errorWord)
						Repeat 
							SPELL CHECK TEXT:C1215($myText; $errPos; $errLength; $pos; $tSuggestions)
							If (OK=0)
								$errCount:=$errCount+1  // count any errors
								$errorWord:=Substring:C12($myText; $errPos; $errLength)
								APPEND TO ARRAY:C911($at_errorWords; $errorWord)  // array of errors
								
								$pos:=$errPos+$errLength  //continue check
								OK:=0
							End if 
						Until (OK=1)
						
						If ($errCount>0)  // In the end $errCount=Size of array($at_errorWords)
							APPEND TO ARRAY:C911($at_menuItems; "(-")
							For ($i; 1; Size of array:C274($at_errorWords))
								APPEND TO ARRAY:C911($at_menuItems; "Add \""+String:C10($at_errorWords{$i})+"\" to User Dic")
							End for 
						End if 
					End if 
				End if 
				
				
				// Convert the array into the pop-up menu
				C_TEXT:C284($vtItems)
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
					: ($at_menuItems{$vlUserChoice}="Open Method...")  // Open the method
						METHOD OPEN PATH:C1213(_DIFF_MethodName; *)
						
					: ($at_menuItems{$vlUserChoice}="@\" to User Dic")  // User want to add a word to the user dicationary
						$myText:=$at_menuItems{$vlUserChoice}
						$myText:=Substring:C12($myText; Position:C15("\""; $myText)+1)
						$myText:=Substring:C12($myText; 1; Position:C15("\""; $myText)-1)
						SPELL ADD TO USER DICTIONARY:C1214($myText)
						BTN_SpellCheck:=1
						
				End case 
				
			Else 
				$vlUserChoice:=Pop up menu:C542("(no action possible on empty row")
			End if 
			
			
		End if 
		
End case 