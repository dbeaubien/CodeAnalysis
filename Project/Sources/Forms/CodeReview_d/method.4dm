//   Mod by: Dani Beaubien (10/25/2012) - Added support for ignoring multiple spaces and mixed case.

C_TEXT:C284($vt_theCode)
C_BOOLEAN:C305($vb_forceSpellCheck)

// Do the Diff
If (Form event code:C388=On Load:K2:1) | (BTN_Rescan=1)
	$vb_forceSpellCheck:=False:C215
	
	Logging_Method__init(True:C214)
	
	// --------- Grab the method code and get it ready
	C_LONGINT:C283($vs; $pos; $errCount; $errPos)
	$vs:=Milliseconds:C459
	CodeReview_LoadMethod(_DIFF_MethodName)
	LogEvent_Write(" CodeReview_LoadMethod took "+String:C10(Milliseconds:C459-$vs)+"ms")
	
	$vs:=Milliseconds:C459
	CodeReview_LoadAndScanVars
	LogEvent_Write(" CodeReview_LoadAndScanVars took "+String:C10(Milliseconds:C459-$vs)+"ms")
	
	// ##### Go through the methods and indent so that it is easier to read.
	MethodScan_IndentCodeInArray(->DEMO_File1_at)
	
	Logging_Method_ProfileStats2Log
End if 


If (BTN_SpellCheck=1) | ($vb_forceSpellCheck)
	C_TEXT:C284($myText)
	C_LONGINT:C283($i)
	For ($i; 1; Size of array:C274(DEMO_File1_at))
		DEMO_BackColors_al{$i}:=0x00FFFFFF
		DEMO_FontColors_al{$i}:=0x0000
		
		$myText:=ST Get plain text:C1092(DEMO_File1_at{$i})
		$pos:=Position:C15("//"; $myText)  // Also start position to start spell checking
		If ($pos>0)
			// Clear any existing "styles"
			ST SET ATTRIBUTES:C1093(DEMO_File1_at{$i}; 1; Length:C16(DEMO_File1_at{$i})+1; Attribute italic style:K65:2; 0)
			ST SET ATTRIBUTES:C1093(DEMO_File1_at{$i}; 1; Length:C16(DEMO_File1_at{$i})+1; Attribute underline style:K65:4; 0)
			ST SET ATTRIBUTES:C1093(DEMO_File1_at{$i}; 1; Length:C16(DEMO_File1_at{$i})+1; Attribute text color:K65:7; "#00000")
			
			// Scan for mis-spelled words
			$errCount:=0
			ARRAY TEXT:C222($at_errorWords; 0)
			ARRAY TEXT:C222($at_Suggestions; 0)
			C_LONGINT:C283($errLength)
			C_TEXT:C284($errorWord)
			Repeat 
				SPELL CHECK TEXT:C1215($myText; $errPos; $errLength; $pos; $at_Suggestions)
				If (OK=0)
					
					$errCount:=$errCount+1  // count any errors
					$errorWord:=Substring:C12($myText; $errPos; $errLength)
					APPEND TO ARRAY:C911($at_errorWords; $errorWord)  // array of errors
					
					ST SET ATTRIBUTES:C1093(DEMO_File1_at{$i}; $errPos; $errPos+Length:C16($errorWord); Attribute italic style:K65:2; 1; Attribute underline style:K65:4; 1; Attribute text color:K65:7; "#FF0000")
					$pos:=$errPos+$errLength  //continue check
					OK:=0
				End if 
				
			Until (OK=1)
			// In the end $errCount=Size of array($at_errorWords)
			
			
		End if 
	End for 
End if 