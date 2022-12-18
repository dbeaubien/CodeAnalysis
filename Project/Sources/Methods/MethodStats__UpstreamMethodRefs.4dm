//%attributes = {}
// MethodStats__UpstreamMethodRefs ()
//
// DESCRIPTION
//   Scans the process var "MethodStatsMasterObj" and 
//   refreshes all the "upstream_methods" references
//   for each of the methods.
//
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (08/09/2020)
// ----------------------------------------------------

C_OBJECT:C1216(MethodStatsMasterObj)
MethodStats__Init

ARRAY TEXT:C222($objProperties; 0)
ARRAY LONGINT:C221($objPropertiesType; 0)
OB GET PROPERTY NAMES:C1232(MethodStatsMasterObj; $objProperties; $objPropertiesType)

C_OBJECT:C1216($upstreamLinks)
$upstreamLinks:=New object:C1471

C_LONGINT:C283($i)
C_TEXT:C284($currentMethod; $downstreamMethod)
For ($i; 1; Size of array:C274($objProperties))
	If ($objPropertiesType{$i}=Is object:K8:27)
		$currentMethod:=$objProperties{$i}
		
		Use (MethodStatsMasterObj[$currentMethod].references)
			MethodStatsMasterObj[$currentMethod].references.upstream_methods:=New shared collection:C1527  // clear anything that is there
		End use 
		
		C_TEXT:C284($downstreamMethod)
		For each ($downstreamMethod; MethodStatsMasterObj[$currentMethod].references.downstream_methods)
			If ($upstreamLinks[$downstreamMethod]=Null:C1517)
				$upstreamLinks[$downstreamMethod]:=New collection:C1472
			End if 
			$upstreamLinks[$downstreamMethod].push($currentMethod)
		End for each 
	End if 
End for 

OnErr_Install_Handler("OnErr_GENERIC")
// Update each upstream reference
ARRAY TEXT:C222($objProperties; 0)
OB GET PROPERTY NAMES:C1232($upstreamLinks; $objProperties; $objPropertiesType)
For ($i; 1; Size of array:C274($objProperties))
	OnErr_ClearError
	If ($objPropertiesType{$i}=Is collection:K8:32)
		If (MethodStatsMasterObj[$objProperties{$i}]#Null:C1517)
			Use (MethodStatsMasterObj[$objProperties{$i}].references)
				OB_CopyCollection($upstreamLinks[$objProperties{$i}].distinct(); MethodStatsMasterObj[$objProperties{$i}].references.upstream_methods)
			End use 
		End if 
	End if 
	If (OnErr_GetLastError#0)
		LogEvent_Write(Current method name:C684+": error happened on method '"+$objProperties{$i}+"'.")
	End if 
End for 
OnErr_Install_Handler