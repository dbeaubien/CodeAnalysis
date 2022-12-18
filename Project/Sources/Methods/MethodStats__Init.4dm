//%attributes = {"invisible":true}
// MethodStats__Init ({clearAllStats})
// MethodStats__Init ({boolean})
// 
// DESCRIPTION
//   Initializes all the arrays used for method statistics.
//   By default, the stats are persisted.
//
C_BOOLEAN:C305($1; $doForceToClearAllStats)  // If set, then the arrays will be empty
// ----------------------------------------------------
// HISTORY
//   Created by: DB (12/04/2014)
//   Mod by: Dani Beaubien (02/04/2021) - Converted to use objects
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259<=1)
If (Count parameters:C259>=1)
	$doForceToClearAllStats:=$1
Else 
	$doForceToClearAllStats:=False:C215
End if 

Tokenize__Init
Structure__Init

C_BOOLEAN:C305($clearStorage)
Case of 
	: ($doForceToClearAllStats)
		_MSTAT_init:=True:C214
		$clearStorage:=True:C214
		
	: (Storage:C1525.methodStats=Null:C1517)
		_MSTAT_init:=True:C214
		MethodStats__LoadFromDisk
		$clearStorage:=(Storage:C1525.methodStats=Null:C1517)
		
	Else 
		_MSTAT_init:=True:C214
		$clearStorage:=False:C215
End case 

If ($clearStorage)
	Use (Storage:C1525)
		Storage:C1525.methodStats:=New shared object:C1526("object_format_version"; 1)
	End use 
End if 

// Grab this from the preference
C_TEXT:C284(vt_LastRefreshStr)
vt_LastRefreshStr:=Pref_GetPrefString("vt_LastRefreshStr"; "unknown")

C_OBJECT:C1216(MethodStatsMasterObj)
MethodStatsMasterObj:=Storage:C1525.methodStats