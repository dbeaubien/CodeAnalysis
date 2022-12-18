//%attributes = {"invisible":true}
// Explorer_MetaInfoFunction_Struc () : metaInfo
//
// DESCRIPTION
//   Structure meta function for the Explorer window
//
C_OBJECT:C1216($0; $metaInfo)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (01/23/2021)
// ----------------------------------------------------


// Reference: https://developer.4d.com/docs/18/en/FormObjects/propertiesText.html#meta-info-expression

$metaInfo:=New object:C1471
If (This:C1470.isIndexed) | (This:C1470.isPrimaryKey)
	$metaInfo.cell:=New object:C1471("ColumnName"; New object:C1471)
	$metaInfo.cell.ColumnName.fontWeight:="bold"
	If (This:C1470.isPrimaryKey)
		$metaInfo.cell.ColumnName.textDecoration:="underline"
	End if 
End if 

If (This:C1470.indexType="n/a") | (This:C1470.indexType="None")
	$metaInfo.cell:=New object:C1471("ColumnIndexType"; New object:C1471)
	$metaInfo.cell.ColumnIndexType.fontStyle:="italic"
	$metaInfo.cell.ColumnIndexType.stroke:="#9f9f9f"
End if 

//$metaInfo.fontWeight:="bold"
//$metaInfo.fontStyle:="italic"

$0:=$metaInfo