//%attributes = {"invisible":true}
// CODE_Analysis2 ()
// 
// DESCRIPTION
//   Refreshes the stored stats
//
// ----------------------------------------------------
// HISTORY
//   Created by: DB (12/29/2016)
// ----------------------------------------------------

C_TEXT:C284($vt_msg)
$vt_msg:="Updating statistics for modified methods..."

C_BOOLEAN:C305($vb_doFullRefresh)
If (Macintosh option down:C545) | (Windows Alt down:C563)
	CONFIRM:C162("Please confirm if you want to recalculate the statistics for all the methods or only those modified since the last refresh.\r\rNote: Doing them all will take more time."; "Update Modified"; "Recalculate All")
	If (OK=0)
		$vb_doFullRefresh:=True:C214
		$vt_msg:="Determining statistics for all methods..."
	End if 
End if 

If ($vb_doFullRefresh)
	MethodStats_RecalculateAll
Else 
	MethodStats__LoadFromDisk  // FORCES the method stats to be reloaded from disk
	MethodStats_RecalculateModified
End if 
