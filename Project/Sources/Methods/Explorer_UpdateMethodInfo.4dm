//%attributes = {"invisible":true}
// Explorer_UpdateMethodInfo (formObj{; methodPath, updateToDo})
//
// DESCRIPTION
//   
//
var $1; $formObj : Object
var $2; $methodPath : Text  // OPTIONAL
var $3; $updateToDo : Text  // OPTIONAL
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (01/23/2021)
// ----------------------------------------------------
ASSERT:C1129((Count parameters:C259=1) | (Count parameters:C259=3))
$formObj:=$1
If (Count parameters:C259=3)
	$methodPath:=$2
	$updateToDo:=$3
End if 

var hdr0; hdr1; hdr2; hdr3; hdr4; hdr5; hdr6; hdr7; hdr8; hdr9; hdr10; hdr_dts : Integer
var vt_ftr1 : Text
var ftrText1; ftrText2; ftrText3; ftrText4; ftrText5; ftrText6; ftrText7; ftrText8 : Text
vt_ftr1:="Average"

var MethodStatsMasterObj : Object  // defined in MethodStats__Init
MethodStats__Init

var $i : Integer
ARRAY TEXT:C222($methodObjNames; 0)
var $methodStatsObj; $explorerRowObj : Object
var $matchingMethodsList : Collection
Case of 
	: ($methodPath="")  // reload everything fresh
		$formObj.fullList:=New collection:C1472
		$formObj.filteredList:=$formObj.fullList
		Method_GetMethodObjNames(->$methodObjNames)
		For ($i; 1; Size of array:C274($methodObjNames))
			$methodStatsObj:=MethodStatsMasterObj[$methodObjNames{$i}]
			$explorerRowObj:=New object:C1471
			Explorer__MethodStatsToExlprRow($methodStatsObj; $explorerRowObj)
			$formObj.fullList.push($explorerRowObj)
		End for 
		
		
	: ($updateToDo="update")
		$methodStatsObj:=MethodStatsMasterObj[$methodPath]
		$matchingMethodsList:=$formObj.fullList.query("path = :1"; $methodPath)
		If ($matchingMethodsList.length=1)
			$explorerRowObj:=$matchingMethodsList[0]
			Explorer__MethodStatsToExlprRow($methodStatsObj; $explorerRowObj)
		End if 
		
		
	: ($updateToDo="add")
		$methodStatsObj:=MethodStatsMasterObj[$methodPath]
		$matchingMethodsList:=$formObj.fullList.query("path = :1"; $methodPath)
		If ($matchingMethodsList.length=0)
			$explorerRowObj:=New object:C1471
			$formObj.fullList.push($explorerRowObj)
		End if 
		If ($matchingMethodsList.length=1)
			$explorerRowObj:=$matchingMethodsList[0]
		End if 
		Explorer__MethodStatsToExlprRow($methodStatsObj; $explorerRowObj)
		$formObj.fullList:=$formObj.fullList.orderBy("path")
		
		
	: ($updateToDo="delete")
		$matchingMethodsList:=$formObj.fullList.query("path = :1"; $methodPath)
		If ($matchingMethodsList.length=1)
			$explorerRowObj:=$matchingMethodsList[0]
			$i:=$formObj.fullList.indexOf($explorerRowObj)
			If ($i>=0)
				$formObj.fullList:=$formObj.fullList.remove($i; 1)
			End if 
		End if 
		
End case 