//%attributes = {"invisible":true}
// Explorer_UpdateStructureInfo (formObj {; calculateIndexUniqueness})
//
// DESCRIPTION
//   
//
C_OBJECT:C1216($1; $formObj)
C_BOOLEAN:C305($2; $calculateIndexUniqueness)  // optional
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (01/23/2021)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259>=1)
ASSERT:C1129(Count parameters:C259<=2)
$formObj:=$1
If (Count parameters:C259=2)
	$calculateIndexUniqueness:=$2
End if 

OnErr_Install_Handler("OnErr_GENERIC")
OnErr_ClearError

$formObj.fullStructureList:=New collection:C1472
$formObj.filteredStructureList:=$formObj.fullStructureList

ARRAY TEXT:C222($tableNamesArr; 0)
OB GET PROPERTY NAMES:C1232(ds:C1482; $tableNamesArr)

C_OBJECT:C1216($tableInfo; $dataClass; $item)
C_LONGINT:C283($i; $j)
C_TEXT:C284($tableName)
For ($i; 1; Size of array:C274($tableNamesArr))
	$dataClass:=ds:C1482[$tableNamesArr{$i}]
	$tableInfo:=$dataClass.getInfo()
	$tableName:="["+$tableInfo.name+"]"
	
	$item:=New object:C1471
	$item.name:=$tableName
	$item.table:=$tableInfo.name
	$item.tableNumber:=$tableInfo.tableNumber
	$item.field:=""
	$item.fieldNumber:=-1
	$item.isPrimaryKey:=False:C215
	$item.isIndexed:=False:C215
	$item.indexType:="n/a"
	$item.type:="Table #"+String:C10($tableInfo.tableNumber)
	$item.notes:=String:C10(Records in table:C83(Table:C252($tableInfo.tableNumber)->))+" records in table"
	$formObj.fullStructureList.push($item)
	
	ARRAY TEXT:C222($fieldNames; 0)
	C_OBJECT:C1216($dataClassAttribute)
	C_LONGINT:C283($fieldType; $fieldLength)
	OB GET PROPERTY NAMES:C1232($dataClass; $fieldNames)
	For ($j; 1; Size of array:C274($fieldNames))
		$dataClassAttribute:=$dataClass[$fieldNames{$j}]
		If ($dataClassAttribute.kind="storage")
			$item:=New object:C1471
			$item.name:=$tableName+$dataClassAttribute.name
			$item.table:=$tableInfo.name
			$item.tableNumber:=$tableInfo.tableNumber
			$item.field:=$dataClassAttribute.name
			$item.fieldNumber:=$dataClassAttribute.fieldNumber
			$item.isPrimaryKey:=($tableInfo.primaryKey=$dataClassAttribute.name)
			$item.isIndexed:=$dataClassAttribute.indexed | $dataClassAttribute.keywordIndexed
			$item.notes:=""
			
			If ($item.isIndexed)
				$item.indexType:=Structure_IndexType2Name(Structure_GetFieldIndexType($tableInfo.tableNumber; $dataClassAttribute.fieldNumber))
				If ($calculateIndexUniqueness)
					C_REAL:C285($vr_usageRatio)
					C_LONGINT:C283($numberOfRecordsInTable; $iNumDistinct; $progHdl)
					$numberOfRecordsInTable:=Records in table:C83(Table:C252($item.tableNumber)->)
					If ($numberOfRecordsInTable>10000)
						$progHdl:=Progress New
						Progress SET TITLE($progHdl; "Checking Field Value Uniquness..."; -1)
						Progress SET MESSAGE($progHdl; "Checking ["+Table name:C256($item.tableNumber)+"]"+Field name:C257(Num:C11($item.tableNumber); Num:C11($item.fieldNumber)))
					End if 
					$vr_usageRatio:=Structure_GetFieldIndexRatio($item.tableNumber; $item.fieldNumber)*100
					Case of 
						: ($numberOfRecordsInTable=0)
							$item.notes:="n/a - Table is empty"
							
						: ($vr_usageRatio>=100)
							$item.notes:="ALL values are unique"
							
						: ($vr_usageRatio<1)
							$item.notes:="Less than 1% of the values are unique"
							
						Else 
							$item.notes:=String:C10($vr_usageRatio; "#0.000")+"% of the values are unique"
					End case 
					If ($progHdl>0)
						Progress QUIT($progHdl)
						$progHdl:=0
					End if 
				End if 
			Else 
				$item.indexType:="None"
			End if 
			
			Case of 
				: ($dataClassAttribute.fieldType=Is text:K8:3)
					$item.type:="Text"
					
				: ($dataClassAttribute.fieldType=Is alpha field:K8:1)
					C_LONGINT:C283($tableNo; $fieldNo)
					$tableNo:=$tableInfo.tableNumber
					$fieldNo:=$dataClassAttribute.fieldNumber
					GET FIELD PROPERTIES:C258($tableNo; $fieldNo; $fieldType; $fieldLength)
					If ($fieldLength>0)
						$item.type:="Alpha ("+String:C10($fieldLength)+")"
					Else 
						$item.type:="Alpha (UUID)"
					End if 
					
				: ($dataClassAttribute.fieldType=Is boolean:K8:9)
					$item.type:="Boolean"
					
				: ($dataClassAttribute.fieldType=Is time:K8:8)
					$item.type:="Time"
					
				: ($dataClassAttribute.fieldType=Is date:K8:7)
					$item.type:="Date"
					
				: ($dataClassAttribute.fieldType=Is real:K8:4)
					$item.type:="Real"
					
				: ($dataClassAttribute.fieldType=Is longint:K8:6)
					$item.type:="Longint"
					
				: ($dataClassAttribute.fieldType=Is integer:K8:5)
					$item.type:="Integer"
					
				: ($dataClassAttribute.fieldType=Is BLOB:K8:12)
					$item.type:="BLOB"
					
				: ($dataClassAttribute.fieldType=Is object:K8:27)
					$item.type:="Object"
					
				: ($dataClassAttribute.fieldType=Is picture:K8:10)
					$item.type:="Picture"
					
				: ($dataClassAttribute.fieldType=Is integer 64 bits:K8:25)
					$item.type:="Integer 64bit"
					
				Else 
					$item.type:="** "+$dataClassAttribute.type
			End case 
			
			If (OnErr_GetLastError#0)
				LogEvent_Write(Current method name:C684+": error #"+String:C10(OnErr_GetLastError)\
					+" on field \""+$fieldNames{$j}+"\" --> "+JSON Stringify:C1217($dataClassAttribute; *))
			End if 
			
			$formObj.fullStructureList.push($item)
		End if 
		
	End for 
End for 
OnErr_Install_Handler

$formObj.fullStructureList:=$formObj.fullStructureList.orderBy("table asc, field asc")