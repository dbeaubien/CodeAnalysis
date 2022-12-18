//%attributes = {"invisible":true}
// DEV_Get_QueryCommandsArray (cmdNoArrPtr; cmdStrArrPtr)
// DEV_Get_QueryCommandsArray (pointer; pointer)
//
// DESCRIPTION
//   Defines an array of commands that commands that use
//   indexed fields.
//
C_POINTER:C301($1; $2)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (01/30/2015)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	
	// see DEV_Get_VAR_tokens
	ARRAY LONGINT:C221($al_CommandNo; 0)
	APPEND TO ARRAY:C911($al_CommandNo; 277)  // QUERY
	APPEND TO ARRAY:C911($al_CommandNo; 644)  // QUERY WITH ARRAY
	APPEND TO ARRAY:C911($al_CommandNo; 1050)  // QUERY SELECTION WITH ARRAY
	APPEND TO ARRAY:C911($al_CommandNo; 341)  // QUERY SELECTION
	//APPEND TO ARRAY($al_CommandNo;48)  // QUERY BY FORMULA
	//APPEND TO ARRAY($al_CommandNo;108)  // QUERY SUBRECORDS
	//APPEND TO ARRAY($al_CommandNo;207)  // QUERY SELECTION BY FORMULA
	//APPEND TO ARRAY($al_CommandNo;292)  // QUERY BY EXAMPLE
	APPEND TO ARRAY:C911($al_CommandNo; 339)  // DISTINCT VALUES
	
	
	APPEND TO ARRAY:C911($al_CommandNo; 653)  // Find in field
	APPEND TO ARRAY:C911($al_CommandNo; 1)  // Sum
	APPEND TO ARRAY:C911($al_CommandNo; 3)  // Max
	APPEND TO ARRAY:C911($al_CommandNo; 4)  // Min
	
	
	ARRAY TEXT:C222($at_CommandStr; 0)
	C_LONGINT:C283($i)
	For ($i; 1; Size of array:C274($al_CommandNo))
		APPEND TO ARRAY:C911($at_CommandStr; Command name:C538($al_CommandNo{$i}))
	End for 
	
	
	COPY ARRAY:C226($al_CommandNo; $1->)
	COPY ARRAY:C226($at_CommandStr; $2->)
	
	
End if   // ASSERT
