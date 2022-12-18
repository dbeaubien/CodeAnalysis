//   Mod: DB (03/28/2014) - Use generic method for loading methods

C_OBJECT:C1216(selectedDiffMethod)
C_BOOLEAN:C305($userDoubleClicked)
$userDoubleClicked:=False:C215

Case of 
	: (Form event code:C388=On Double Clicked:K2:5)
		$userDoubleClicked:=True:C214
		
		
		
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($vlMouseX; $vlMouseY; $vlButton)
		GET MOUSE:C468($vlMouseX; $vlMouseY; $vlButton)
		If (Macintosh control down:C544 | ($vlButton=2))
			If (selectedDiffMethod#Null:C1517)
				
				ARRAY TEXT:C222($at_menuItems; 0)
				APPEND TO ARRAY:C911($at_menuItems; "View Differences...")
				If (selectedDiffMethod.description#"Only On Disk")
					APPEND TO ARRAY:C911($at_menuItems; "Open Method...")
				Else 
					APPEND TO ARRAY:C911($at_menuItems; "(Open Method...")
				End if 
				
				If (selectedDiffMethod.description#"Only in Structure")
					APPEND TO ARRAY:C911($at_menuItems; "Show File on Disk...")
				Else 
					APPEND TO ARRAY:C911($at_menuItems; "(Show File on Disk...")
				End if 
				
				If (selectedDiffMethod.methodFriendlyName="@Form]/@")  // Ensure cannot "Create" method on forms
					// DO NOTHING
				Else 
					If (selectedDiffMethod.description="Only On Disk")
						APPEND TO ARRAY:C911($at_menuItems; "Create Method from file")
					Else 
						APPEND TO ARRAY:C911($at_menuItems; "(Create Method from file")
					End if 
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
					: ($at_menuItems{$vlUserChoice}="View Differences...")
						$userDoubleClicked:=True:C214
						
					: ($at_menuItems{$vlUserChoice}="Show File on Disk...")  //   Mod: DB (03/29/2014) - Added, was missing
						SHOW ON DISK:C922(selectedDiffMethod.methodPathOnDisk)
						
					: ($at_menuItems{$vlUserChoice}="Open Method...")
						METHOD OPEN PATH:C1213(selectedDiffMethod.methodName; *)
						
					: ($at_menuItems{$vlUserChoice}="Create Method from file")
						BEEP:C151
						CONFIRM:C162("A new method called \""+selectedDiffMethod.methodName+"\" will be created with the text from the external file.\r\rPlease confirm you want the method to be created."; "Create Method"; "Cancel")
						If (OK=1)
							
							//   Mod: DB (03/28/2014)
							C_LONGINT:C283($vl_Err)
							$vl_Err:=Method_LoadFromFile(selectedDiffMethod.methodName; selectedDiffMethod.methodPathOnDisk)
							
							If ($vl_Err=0)
								selectedDiffMethod.description:=" * Created from File *"
							Else 
								BEEP:C151
								ALERT:C41("Loading the method failed due to error "+String:C10($vl_Err)+".")
							End if 
						End if 
						
				End case 
				
			Else 
				$vlUserChoice:=Pop up menu:C542("(no action possible on empty row")
			End if 
			
			
		End if 
		
End case 


If ($userDoubleClicked) & (selectedDiffMethod#Null:C1517)
	If (selectedDiffMethod.methodName#"")
		C_TEXT:C284(<>_DIFF_MethodName; <>_DIFF_PathToFileOnDisk)
		<>_DIFF_MethodName:=selectedDiffMethod.methodName
		<>_DIFF_PathToFileOnDisk:=selectedDiffMethod.methodPathOnDisk
		
		CODE_DoMethodDiff
	End if 
End if 