//%attributes = {"invisible":true}
// CodeReview_LoadAndScanVars ()
// 
// DESCRIPTION
//   Parses the content and parses the variables for displaying
//   on the Code Review window.
//
C_LONGINT:C283($1)
C_TEXT:C284($0)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (01/08/2017)
// ----------------------------------------------------

Logging_Method_START(Current method name:C684)
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 0; Count parameters:C259))
	
	CODE_PreLoadProcessVarsArrs  //   Mod: DB (12/22/2015) - Get our interprocess vars "known"
	
	ARRAY TEXT:C222($at_C_declarVarToken; 0)
	ARRAY TEXT:C222($at_ARR_declarVarToken; 0)
	Structure_GetTokenArr_Cdefn(->$at_C_declarVarToken)
	Structure_GetTokenArr_ArrDefn(->$at_ARR_declarVarToken)
	
	C_TEXT:C284($vT_Pattern)
	$vT_Pattern:="((\\$)|[<>])(.)+"  // Matches any interprocess and local var
	$vT_Pattern:="(?mi-s)(<>[0-9a-zA-Z_.]+)+|(\\$[0-9a-zA-Z_.]+)+"
	
	ARRAY TEXT:C222($at_foundVars; 0)
	ARRAY TEXT:C222($at_foundVarTypes; 0)
	ARRAY TEXT:C222($at_foundVarPositions; 0)
	C_LONGINT:C283($vl_start; $vl_pos_found; $vl_length_found)
	C_LONGINT:C283($i; $j; $pos; $vl_posOfMatchingCommand)
	C_TEXT:C284($vt_varName; $vt_varType; $vt_varPosition)
	For ($i; 1; Size of array:C274(DEMO_File1_at))
		ARRAY TEXT:C222($at_tokens; 0)
		Tokenize_LineOfCode(DEMO_File1_at{$i}; ->$at_tokens)
		
		For ($j; 1; Size of array:C274($at_tokens))
			$vt_varName:=""
			$vt_varType:=""
			Case of 
				: ($at_tokens{$j}="<>@")  // Interprocess variable?
					$vt_varName:=$at_tokens{$j}
					$vt_varType:=""
					
					$pos:=Find in array:C230(at_PROCESS_VarNames; $vt_varName)
					If ($pos>0)
						$vt_varType:=at_PROCESS_VarTypes{$pos}
					End if 
					
					
				: ($at_tokens{$j}="$@")  // Local variable?
					$vt_varName:=$at_tokens{$j}
					$vt_varType:=""
					If ($j>1)  // Try to find the type
						$vl_posOfMatchingCommand:=Find in array:C230($at_C_declarVarToken; $at_tokens{1})
						If ($vl_posOfMatchingCommand>0)
							$vt_varType:=$at_tokens{1}
						Else 
							$vl_posOfMatchingCommand:=Find in array:C230($at_ARR_declarVarToken; $at_tokens{1})
							If ($vl_posOfMatchingCommand>0)
								$vt_varType:=$at_tokens{1}
							End if 
						End if 
					End if 
					
					
				Else   // Check for Process variable
					$pos:=Find in array:C230(at_PROCESS_VarNames; $at_tokens{$j})
					If ($pos>0)
						$vt_varName:=$at_tokens{$j}
						$vt_varType:=at_PROCESS_VarTypes{$pos}
					End if 
			End case 
			
			If ($vt_varName#"")
				$vt_varPosition:=String:C10($i)+";"  // +"/"+String($vl_pos_found)+";"
				$pos:=Find in array:C230($at_foundVars; $at_tokens{$j})
				If ($pos>0)
					$at_foundVarPositions{$pos}:=$at_foundVarPositions{$pos}+$vt_varPosition
				Else 
					APPEND TO ARRAY:C911($at_foundVars; $at_tokens{$j})
					APPEND TO ARRAY:C911($at_foundVarTypes; $vt_varType)
					APPEND TO ARRAY:C911($at_foundVarPositions; $vt_varPosition)
				End if 
			End if 
		End for 
		
		
	End for 
	SORT ARRAY:C229($at_foundVars; $at_foundVarTypes; $at_foundVarPositions; >)
	
	ARRAY TEXT:C222(at_LocalVarsUsed; 0)
	ARRAY TEXT:C222(at_LocalVarsType; 0)
	ARRAY TEXT:C222(at_LocalVarsPositions; 0)
	For ($i; 1; Size of array:C274($at_foundVars))
		APPEND TO ARRAY:C911(at_LocalVarsUsed; $at_foundVars{$i})
		APPEND TO ARRAY:C911(at_LocalVarsType; $at_foundVarTypes{$i})
		APPEND TO ARRAY:C911(at_LocalVarsPositions; ";"+$at_foundVarPositions{$i})
	End for 
	
	
End if   // ASSERT
Logging_Method_STOP(Current method name:C684)
