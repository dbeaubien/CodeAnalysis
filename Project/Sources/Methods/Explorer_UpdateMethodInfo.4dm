//%attributes = {"invisible":true}
// Explorer_UpdateMethodInfo (formObj{; methodPath, updateToDo})
//
// DESCRIPTION
//   
//
C_OBJECT:C1216($1; $formObj)
C_TEXT:C284($2; $methodPath)  // OPTIONAL
C_TEXT:C284($3; $updateToDo)  // OPTIONAL
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

C_LONGINT:C283(hdr0; hdr1; hdr2; hdr3; hdr4; hdr5; hdr6; hdr7; hdr8; hdr9; hdr10; hdr_dts)
C_TEXT:C284(vt_ftr1)
C_TEXT:C284(ftrText1; ftrText2; ftrText3; ftrText4; ftrText5; ftrText6; ftrText7; ftrText8)
vt_ftr1:="Average"

C_OBJECT:C1216(MethodStatsMasterObj)  // defined in MethodStats__Init
MethodStats__Init

C_LONGINT:C283($i)
ARRAY TEXT:C222($methodObjNames; 0)
C_OBJECT:C1216($methodStatsObj; $explorerRowObj)
C_COLLECTION:C1488($matchingMethodsList)
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