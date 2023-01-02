//%attributes = {"invisible":true,"shared":true}
// Structure_GetFieldIndexRatio (tableNo; fieldNo) : indexUsageRatio
// Structure_GetFieldIndexRatio (longint; longint) : real
// 
// DESCRIPTION
//   Returns the uniqueness ratio for the specified field.
//   Value range between 1.00 (100% unique) to 0 (1 value for every record).
//
#DECLARE($tableNo : Integer; $fieldNo : Integer)->$indexUsageRatio : Real
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=2)
$indexUsageRatio:=1  // Default to fully unique

OnErr_Install_Handler("OnErr_GENERIC")

If (Is table number valid:C999($tableNo))
	If (Is field number valid:C1000($tableNo; $fieldNo))
		
		C_LONGINT:C283($fieldtype; $fieldLength)
		C_BOOLEAN:C305($indexed; $unique)
		GET FIELD PROPERTIES:C258($tableNo; $fieldNo; $fieldtype; $fieldLength; $indexed; $unique)
		
		If ($indexed)
			C_LONGINT:C283($numberOfRecordsInTable; $numberOfRecordsHaveDistinctVals)
			$numberOfRecordsInTable:=Records in table:C83(Table:C252($tableNo)->)
			ALL RECORDS:C47(Table:C252($tableNo)->)
			
			If ($numberOfRecordsInTable>0)
				Case of 
					: ($unique)
						$numberOfRecordsHaveDistinctVals:=$numberOfRecordsInTable
						
					: (($fieldtype=Is alpha field:K8:1) | ($fieldtype=Is text:K8:3))
						ARRAY TEXT:C222($aText; 0)
						DISTINCT VALUES:C339(Field:C253($tableNo; $fieldNo)->; $aText)
						$numberOfRecordsHaveDistinctVals:=Size of array:C274($aText)
						ARRAY TEXT:C222($aText; 0)
						
					: (($fieldtype=Is integer:K8:5) | ($fieldtype=Is longint:K8:6) | ($fieldtype=Is time:K8:8))
						ARRAY LONGINT:C221($aiLongInt; 0)
						DISTINCT VALUES:C339(Field:C253($tableNo; $fieldNo)->; $aiLongInt)
						$numberOfRecordsHaveDistinctVals:=Size of array:C274($aiLongInt)
						ARRAY LONGINT:C221($aiLongInt; 0)
						
					: (($fieldtype=Is real:K8:4) | ($fieldtype=_o_Is float:K8:26))
						ARRAY REAL:C219($arReals; 0)
						DISTINCT VALUES:C339(Field:C253($tableNo; $fieldNo)->; $arReals)
						$numberOfRecordsHaveDistinctVals:=Size of array:C274($arReals)
						ARRAY REAL:C219($arReals; 0)
						
					: (($fieldtype=Is date:K8:7))
						ARRAY DATE:C224($addates; 0)
						DISTINCT VALUES:C339(Field:C253($tableNo; $fieldNo)->; $addates)
						$numberOfRecordsHaveDistinctVals:=Size of array:C274($addates)
						ARRAY DATE:C224($addates; 0)
						
					Else 
						$numberOfRecordsHaveDistinctVals:=$numberOfRecordsInTable
				End case 
				REDUCE SELECTION:C351(Table:C252($tableNo)->; 0)
				
				$indexUsageRatio:=$numberOfRecordsHaveDistinctVals/$numberOfRecordsInTable
			End if 
			
		Else 
			$indexUsageRatio:=-1  // no index
		End if 
		
	End if 
End if 

OnErr_ClearError  //   Mod by: Dani Beaubien (06/22/2013)
OnErr_Install_Handler