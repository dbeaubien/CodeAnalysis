//%attributes = {"invisible":true}
// MethodStats__Init ({clearAllStats})
// 
// DESCRIPTION
//   Initializes all the arrays used for method statistics.
//   By default, the stats are persisted.
//
#DECLARE($doForceToClearAllStats : Boolean)  // If set, then the arrays will be empty
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259<=1)

Tokenize__Init
Structure__Init

var $clearStorage : Boolean
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
var vt_LastRefreshStr : Text
vt_LastRefreshStr:=Pref_GetPrefString("vt_LastRefreshStr"; "unknown")

var MethodStatsMasterObj : Object
MethodStatsMasterObj:=Storage:C1525.methodStats