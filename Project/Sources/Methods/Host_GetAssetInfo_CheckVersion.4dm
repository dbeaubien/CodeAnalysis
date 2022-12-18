//%attributes = {"invisible":true}
// Host_GetAssetInfo_CheckVersion
//   
// DESCRIPTION
//   Verifies the version of the GetAssetInfo method in the host database.
//
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (07/02/2013)
//   Mod: DB (10/23/2015) - Updated how we check
// ----------------------------------------------------

If (Structure file:C489(*)#Structure file:C489)  // Are we running locally?
	
	C_BOOLEAN:C305($vb_noResult)
	C_LONGINT:C283(vl_tmpLongint; vl_tmpLongint2)
	Host_VerifyMethodExists("CodeAnalysis_GetAssetInfo")  // Mod by Dani Beaubien (6/26/13)
	EXECUTE METHOD:C1007("CodeAnalysis_GetAssetInfo"; $vb_noResult; "MethodVersion"; ->vl_tmpLongint)  // CodeAnalysis_GetAssetInfo("MethodVersion";->al_tmpLongint)
	CodeAnalysis_GetAssetInfoCOPY("MethodVersion"; ->vl_tmpLongint2)  // Get it from the local method
	
	C_BOOLEAN:C305($vb_forceReload)
	If (vl_tmpLongint#vl_tmpLongint2)
		Host_VerifyMethodExists("CodeAnalysis_GetAssetInfo"; True:C214)
		$vb_forceReload:=True:C214
	End if 
End if 