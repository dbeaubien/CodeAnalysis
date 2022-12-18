//%attributes = {"invisible":true}
// CODE_PreLoadProcessVarsArrs ()
// 
// DESCRIPTION
//   Scans the "Compiler_@" methods and determines what the
//   process variables are.
//   Also gets a full list of declared inter-process vars.
//
C_LONGINT:C283($1)
C_TEXT:C284($0)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (12/21/2015)
// ----------------------------------------------------

Logging_Method_START(Current method name:C684)
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 0; Count parameters:C259))
	
	// Get the names and DTS of the compiler methods
	ARRAY TEXT:C222($at_methodNames; 0)
	ARRAY LONGINT:C221($al_methodDTS; 0)
	Method_GetCompilerMthdNmsAndDTS(->$at_methodNames; ->$al_methodDTS)
	
	C_LONGINT:C283($vl_maxDTS)
	C_LONGINT:C283($i)
	For ($i; 1; Size of array:C274($at_methodNames))
		If ($al_methodDTS{$i}>$vl_maxDTS)
			$vl_maxDTS:=$al_methodDTS{$i}
		End if 
	End for 
	
	
	// Get the DTS of our last time through this method
	C_LONGINT:C283($vl_lastRefresh_DTS)
	$vl_lastRefresh_DTS:=Num:C11(Pref_GetPrefString("InterProcessVars_LastScanDTS"; "0"))
	
	
	// Compare our "last refresh DTS" against the compiler methods to determine if they have
	// been updated or not
	C_BOOLEAN:C305($vb_doUpdate)
	$vb_doUpdate:=False:C215
	If ($vl_maxDTS>$vl_lastRefresh_DTS)
		$vb_doUpdate:=True:C214
	End if 
	
	
	
	C_LONGINT:C283($vl_err)
	C_TEXT:C284($vt_prefFolderPath)
	$vt_prefFolderPath:=File_GetFolderName(Pref__GetFile2PrefFile)
	ARRAY TEXT:C222(at_PROCESS_VarNames; 0)
	ARRAY TEXT:C222(at_PROCESS_VarTypes; 0)
	If ($vb_doUpdate)
		
		ARRAY TEXT:C222($at_C_declarVarToken; 0)
		ARRAY TEXT:C222($at_ARR_declarVarToken; 0)
		Structure_GetTokenArr_Cdefn(->$at_C_declarVarToken)
		Structure_GetTokenArr_ArrDefn(->$at_ARR_declarVarToken)
		
		
		
		ARRAY TEXT:C222($at_processVars_Names; 0)
		ARRAY TEXT:C222($at_processVars_types; 0)
		C_TEXT:C284($vt_theCode)
		C_LONGINT:C283($vl_line; $vl_posOfMatchingCommand; $vl_posOfMatchingCommand2)
		For ($i; 1; Size of array:C274($at_methodNames))
			If ($at_methodNames{$i}="Compiler_@")
				$vt_theCode:=Method_GetNormalizedCode($at_methodNames{$i})
				
				ARRAY TEXT:C222($at_methodLines; 0)
				Array_ConvertFromTextDelimited(->$at_methodLines; $vt_theCode; Pref_GetEOL)
				
				
				For ($vl_line; 2; Size of array:C274($at_methodLines))  // skip the first line, that is 4d attributes
					ARRAY TEXT:C222($at_tokens; 0)
					Tokenize_LineOfCode($at_methodLines{$vl_line}; ->$at_tokens)
					
					If (Size of array:C274($at_tokens)>3)
						$vl_posOfMatchingCommand:=Find in array:C230($at_C_declarVarToken; $at_tokens{1})
						$vl_posOfMatchingCommand2:=Find in array:C230($at_ARR_declarVarToken; $at_tokens{1})
						If ($vl_posOfMatchingCommand>0) | ($vl_posOfMatchingCommand2>0)  // Starts with a C_def or an Array Def
							
							Case of 
								: ($at_tokens{1}=Command name:C538(293)) & (Size of array:C274($at_tokens)=6)  // C_STRING
									APPEND TO ARRAY:C911($at_processVars_Names; $at_tokens{3})
									APPEND TO ARRAY:C911($at_processVars_types; $at_tokens{1})
									
								: (Size of array:C274($at_tokens)=4)  // Other C_defns
									APPEND TO ARRAY:C911($at_processVars_Names; $at_tokens{3})
									APPEND TO ARRAY:C911($at_processVars_types; $at_tokens{1})
									
								: (Size of array:C274($at_tokens)=6) & ($vl_posOfMatchingCommand2>0)  // Try to identify the Array definitions
									APPEND TO ARRAY:C911($at_processVars_Names; $at_tokens{3})
									APPEND TO ARRAY:C911($at_processVars_types; $at_tokens{1})
									
							End case 
							
						End if 
						
					End if 
				End for 
			End if 
		End for 
		
		
		COPY ARRAY:C226($at_processVars_Names; at_PROCESS_VarNames)
		COPY ARRAY:C226($at_processVars_types; at_PROCESS_VarTypes)
		$vl_err:=Array_SaveToFile(->at_PROCESS_VarNames; $vt_prefFolderPath+"PROCESS_vNAMES")
		$vl_err:=Array_SaveToFile(->at_PROCESS_VarTypes; $vt_prefFolderPath+"PROCESS_vTYPES")
		Pref_SetPrefString("InterProcessVars_LastScanDTS"; String:C10($vl_maxDTS))
		
		
	Else 
		
		
		If ($vl_err=0)
			$vl_err:=Array_LoadFromFile(->at_PROCESS_VarNames; $vt_prefFolderPath+"PROCESS_vNAMES")
		End if 
		
		If ($vl_err=0)
			$vl_err:=Array_LoadFromFile(->at_PROCESS_VarTypes; $vt_prefFolderPath+"PROCESS_vTYPES")
		End if 
		
		If ($vl_err#0)
			Pref_SetPrefString("InterProcessVars_LastScanDTS"; "0")  // Force a refresh since something must be wrong
			CODE_PreLoadProcessVarsArrs
		End if 
		
	End if 
	
End if   // ASSERT
Logging_Method_STOP(Current method name:C684)
