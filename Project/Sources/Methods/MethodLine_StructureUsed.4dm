//%attributes = {"invisible":true}
// MethodLine_StructureUsed (array of tokens; ; knownUsedStructure; pointers) : result
// MethodLine_StructureUsed (pointer; text; pointer...) : result
// 
// DESCRIPTION
//   Returns a string that has all the fields that are used
//   by the tokenized line.
//
C_POINTER:C301($1; $tokenArrPtr)
C_TEXT:C284($2; $knownStructureUsed)
C_POINTER:C301($3; $tableNamesArr)
C_POINTER:C301($4; $tableFieldNamesArr)
C_TEXT:C284($0)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (08/28/2017)
// ----------------------------------------------------

$knownStructureUsed:=""
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 4; Count parameters:C259))
	$tokenArrPtr:=$1
	$knownStructureUsed:=$2
	$tableNamesArr:=$3
	$tableFieldNamesArr:=$4
	
	If ($knownStructureUsed="")
		$knownStructureUsed:=","
	End if 
	
	C_LONGINT:C283($vl_tokenNo)
	C_BOOLEAN:C305($doAdd)
	For ($vl_tokenNo; 1; Size of array:C274($tokenArrPtr->))
		$doAdd:=False:C215
		If (Find in array:C230($tableNamesArr->; $tokenArrPtr->{$vl_tokenNo})>0)
			$doAdd:=True:C214
			
		Else 
			If (Find in array:C230($tableFieldNamesArr->; $tokenArrPtr->{$vl_tokenNo})>0)
				$doAdd:=True:C214
			End if 
		End if 
		
		If ($doAdd)
			If (Position:C15(","+$tokenArrPtr->{$vl_tokenNo}+","; $knownStructureUsed)<1)
				$knownStructureUsed:=$knownStructureUsed+$tokenArrPtr->{$vl_tokenNo}+","
			End if 
		End if 
	End for 
End if   // ASSERT
$0:=$knownStructureUsed