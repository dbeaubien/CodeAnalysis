//%attributes = {"invisible":true,"shared":true}
// Structure_GetFieldIndexRatio (tableNo; fieldNo) : indexUsageRatio
// Structure_GetFieldIndexRatio (longint; longint) : real
// 
// DESCRIPTION
//   Returns the uniqueness ratio for the specified field.
//   Value range between 1.00 (100% unique) to 0 (1 value for every record).
//
#DECLARE($tableNo : Integer; $fieldNo : Integer; $fieldStatistics : Object)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=3)
$fieldStatistics.indexUsageRatio:=1  // Default to fully unique

OnErr_Install_Handler("OnErr_GENERIC")

If (Is table number valid:C999($tableNo))
	If (Is field number valid:C1000($tableNo; $fieldNo))
		
		var $fieldtype; $fieldLength : Integer
		var $indexed; $unique : Boolean
		GET FIELD PROPERTIES:C258($tableNo; $fieldNo; $fieldtype; $fieldLength; $indexed; $unique)
		
		If ($indexed)
			$fieldStatistics.numberOfRecords:=Records in table:C83(Table:C252($tableNo)->)
			ALL RECORDS:C47(Table:C252($tableNo)->)
			
			If ($fieldStatistics.numberOfRecords>0)
				Case of 
					: ($unique)
						$fieldStatistics.distinctValues:=$fieldStatistics.numberOfRecords
						
					: (($fieldtype=Is alpha field:K8:1) | ($fieldtype=Is text:K8:3))
						ARRAY TEXT:C222($aText; 0)
						DISTINCT VALUES:C339(Field:C253($tableNo; $fieldNo)->; $aText)
						$fieldStatistics.distinctValues:=Size of array:C274($aText)
						ARRAY TEXT:C222($aText; 0)
						
					: (($fieldtype=Is integer:K8:5) | ($fieldtype=Is longint:K8:6) | ($fieldtype=Is time:K8:8))
						ARRAY LONGINT:C221($aiLongInt; 0)
						DISTINCT VALUES:C339(Field:C253($tableNo; $fieldNo)->; $aiLongInt)
						$fieldStatistics.distinctValues:=Size of array:C274($aiLongInt)
						ARRAY LONGINT:C221($aiLongInt; 0)
						
					: (($fieldtype=Is real:K8:4) | ($fieldtype=_o_Is float:K8:26))
						ARRAY REAL:C219($arReals; 0)
						DISTINCT VALUES:C339(Field:C253($tableNo; $fieldNo)->; $arReals)
						$fieldStatistics.distinctValues:=Size of array:C274($arReals)
						ARRAY REAL:C219($arReals; 0)
						
					: (($fieldtype=Is date:K8:7))
						ARRAY DATE:C224($addates; 0)
						DISTINCT VALUES:C339(Field:C253($tableNo; $fieldNo)->; $addates)
						$fieldStatistics.distinctValues:=Size of array:C274($addates)
						ARRAY DATE:C224($addates; 0)
						
					Else 
						$fieldStatistics.distinctValues:=$fieldStatistics.numberOfRecords
				End case 
				REDUCE SELECTION:C351(Table:C252($tableNo)->; 0)
				
				$fieldStatistics.indexUsageRatio:=$fieldStatistics.distinctValues/$fieldStatistics.numberOfRecords
				$fieldStatistics.distinctValues:=$fieldStatistics.distinctValues
			End if 
		Else 
			$fieldStatistics.indexUsageRatio:=-1
		End if 
	End if 
End if 

OnErr_ClearError  //   Mod by: Dani Beaubien (06/22/2013)
OnErr_Install_Handler