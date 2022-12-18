//%attributes = {"invisible":true,"shared":true}
// MethodStats_RecalculateAll ()
// 
// DESCRIPTION
//   Forces a recalc of all the stored method statistics
//
If (False:C215)
	// ----------------------------------------------------
	// HISTORY
	//   Created by: DB (12/17/2014)
	// ----------------------------------------------------
End if 
ASSERT:C1129(Count parameters:C259=0)

MethodStats__Init(True:C214)  // Forces the method stats to be initd and empty
MethodStats_RecalculateModified
