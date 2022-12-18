//%attributes = {"invisible":true}
// CodeReview_LoadMethod (methodName) 
// CodeReview_LoadMethod (text) 
// 
// DESCRIPTION
//   Loads the method code and parses the content for displaying
//   on the Code Review window
//
C_TEXT:C284($1; _DIFF_MethodName)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (01/08/2017)
// ----------------------------------------------------

Logging_Method_START(Current method name:C684)
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	_DIFF_MethodName:=$1
	
	
	ARRAY TEXT:C222(DEMO_File1_at; 0)
	ARRAY LONGINT:C221(DEMO_File1LineNo_al; 0)
	ARRAY TEXT:C222(DEMO_tokens_at; 0)  //   Mod: DB (06/13/2016) - Holds the "tokens" for each line
	If (_DIFF_MethodName#"")
		OnErr_ClearError
		ON ERR CALL:C155("OnErr_GENERIC")
		
		C_TEXT:C284($vt_theCode)
		$vt_theCode:=Method_GetNormalizedCode(_DIFF_MethodName; True:C214)  //   Mod by: Dani Beaubien (02/17/2014) 
		//METHOD GET CODE(_DIFF_MethodName;$vt_theCode;*)
		ON ERR CALL:C155("")
		
		ARRAY_Unpack($vt_theCode; ->DEMO_File1_at; Pref_GetEOL)  //   Mod by: Dani Beaubien (02/17/2014)
		//ARRAY_Unpack ($vt_theCode;->DEMO_File1_at;"\r")
		If (Size of array:C274(DEMO_File1_at)>0)
			If (DEMO_File1_at{1}="//%attributes@")
				DELETE FROM ARRAY:C228(DEMO_File1_at; 1; 1)
			End if 
			
			
			Array_SetSize(Size of array:C274(DEMO_File1_at); ->DEMO_File1LineNo_al; ->DEMO_tokens_at)
			C_LONGINT:C283($i; $j)
			For ($i; 1; Size of array:C274(DEMO_File1_at))
				DEMO_File1LineNo_al{$i}:=$i
				
				ARRAY TEXT:C222($at_tokens; 0)
				Tokenize_LineOfCode(DEMO_File1_at{$i}; ->$at_tokens)
				For ($j; 1; Size of array:C274($at_tokens))
					If ($j=1)
						DEMO_tokens_at{$i}:=$at_tokens{$j}
					Else 
						DEMO_tokens_at{$i}:=DEMO_tokens_at{$i}+", "+$at_tokens{$j}
					End if 
				End for 
			End for 
		End if 
		
		OBJECT SET ENABLED:C1123(BTN_OpenMthd; True:C214)
		If (gError#0)  // method does not exist in the structure
			OBJECT SET ENABLED:C1123(BTN_OpenMthd; False:C215)
		End if 
	End if 
	
	
	
	// Make sure that there is at least 1 row
	If (Size of array:C274(DEMO_File1_at)=0)
		APPEND TO ARRAY:C911(DEMO_File1_at; "")
	End if 
	
	
	
	
	// ##### Move the font colour to the background colour
	ARRAY LONGINT:C221(DEMO_FontColors_al; Size of array:C274(DEMO_File1_at))
	ARRAY LONGINT:C221(DEMO_BackColors_al; Size of array:C274(DEMO_File1_at))
	ARRAY LONGINT:C221(DEMO_Styles_al; Size of array:C274(DEMO_File1_at))
	For ($i; 1; Size of array:C274(DEMO_FontColors_al))
		DEMO_Styles_al{$i}:=-255  // default
		DEMO_BackColors_al{$i}:=0x00FFFFFF  // no change
		DEMO_FontColors_al{$i}:=0x0000  // Clear this
	End for 
	
	
	
End if   // ASSERT
Logging_Method_STOP(Current method name:C684)

