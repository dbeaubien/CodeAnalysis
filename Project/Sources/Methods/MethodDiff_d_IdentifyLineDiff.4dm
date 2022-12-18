//%attributes = {"invisible":true}
// MethodDiff_d_IdentifyLineDiff
//
// DESCRIPTION
//   Go through the areas of change and identify the
//   areas of each line that has changed.
//
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (10/30/2012)
//   Mod: DB (11/21/2013) - Clean up "<" & ">" in the method text
//   Mod: DB (02/17/2014) - Clean up if no changes to either line
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 0; Count parameters:C259))
	
	// Look for changes within the lines
	C_LONGINT:C283($i; $j)
	For ($i; 1; Size of array:C274(DEMO_File2_at))  // Look for lines changes
		
		If (DEMO_BackColors_al{$i}#0x00FFFFFF)  // If this line has a change on it.
			
			Case of 
				: (DEMO_File1_at{$i}="") & (DEMO_File2_at{$i}="")
					// NOP
					
				: (DEMO_File1_at{$i}#"") & (DEMO_File2_at{$i}="")
					DEMO_File1_at{$i}:=Utility_MakeTextStyleSafe(DEMO_File1_at{$i})  //   Mod: DB (11/21/2013) - First style setting?
					ST SET ATTRIBUTES:C1093(DEMO_File1_at{$i}; 1; Length:C16(DEMO_File1_at{$i})+1; Attribute bold style:K65:1; 1; Attribute underline style:K65:4; 1; Attribute text color:K65:7; "#009000")
					
					
				: (DEMO_File1_at{$i}="") & (DEMO_File2_at{$i}#"")
					DEMO_File2_at{$i}:=Utility_MakeTextStyleSafe(DEMO_File2_at{$i})  //   Mod: DB (11/21/2013) - First style setting?
					ST SET ATTRIBUTES:C1093(DEMO_File2_at{$i}; 1; Length:C16(DEMO_File2_at{$i})+1; Attribute bold style:K65:1; 1; Attribute underline style:K65:4; 1; Attribute text color:K65:7; "#D00000")
					
				Else 
					ARRAY LONGINT:C221($StartA; 0)
					ARRAY LONGINT:C221($StartB; 0)
					ARRAY LONGINT:C221($DeletedA; 0)
					ARRAY LONGINT:C221($InsertedB; 0)
					_DIFF_Diff(->DEMO_File1_at{$i}; ->DEMO_File2_at{$i}; ->$StartA; ->$StartB; ->$DeletedA; ->$InsertedB)
					
					For ($j; 1; Size of array:C274($StartA))
						If ($DeletedA{$j}>0)
							DEMO_File1_at{$i}:=Utility_MakeTextStyleSafe(DEMO_File1_at{$i})  //   Mod: DB (11/21/2013) - First style setting?
							ST SET ATTRIBUTES:C1093(DEMO_File1_at{$i}; $StartA{$j}; $StartA{$j}+$DeletedA{$j}; Attribute bold style:K65:1; 1; Attribute underline style:K65:4; 1; Attribute text color:K65:7; "#009000")
						End if 
						
						If ($InsertedB{$j}>0)
							DEMO_File2_at{$i}:=Utility_MakeTextStyleSafe(DEMO_File2_at{$i})  //   Mod: DB (11/21/2013) - First style setting?
							ST SET ATTRIBUTES:C1093(DEMO_File2_at{$i}; $StartB{$j}; $StartB{$j}+$InsertedB{$j}; Attribute bold style:K65:1; 1; Attribute underline style:K65:4; 1; Attribute text color:K65:7; "#D00000")
						End if 
						
					End for 
			End case 
			
		Else   //   Mod: DB (02/17/2014)
			DEMO_File1_at{$i}:=Utility_MakeTextStyleSafe(DEMO_File1_at{$i})  //   Mod: DB (02/17/2014)
			DEMO_File2_at{$i}:=Utility_MakeTextStyleSafe(DEMO_File2_at{$i})  //   Mod: DB (02/17/2014)
			
		End if 
	End for 
	
End if   // ASSERT