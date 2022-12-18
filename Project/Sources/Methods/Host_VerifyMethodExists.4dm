//%attributes = {"invisible":true}
// Host_VerifyMethodExists (projectMethodName{; forceLoad})
// Host_VerifyMethodExists (text{; boolean})
//
// DESCRIPTION
//   Checks to make sure that the method exists in the
//   host database. If it does not, then it adds it. The 
//   method code is retrieved from the component resources.
//
C_TEXT:C284($1; $vt_projectMethodName)
C_BOOLEAN:C305($2; $vb_forceMethodUpdate)  // OPTIONAL
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (11/01/2012)
//   Modified by: Dani Beaubien (6/26/13) - Provide a mechanism to force a reloading of a method
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT_RANGE(Current method name:C684; 1; 2; Count parameters:C259))
	$vt_projectMethodName:=$1
	If (Count parameters:C259>=2)  // Modified by: Dani Beaubien (6/26/13)
		$vb_forceMethodUpdate:=$2
	End if 
	
	If (Structure file:C489(*)#Structure file:C489)  // Are we running locally?
		C_TEXT:C284($vt_currentOnErrorMethod)
		$vt_currentOnErrorMethod:=Method called on error:C704
		OnErr_ClearError
		ON ERR CALL:C155("OnErr_GENERIC_Quiet")  //   Mod by: Dani Beaubien (01/23/2016) - Use a quiet variant of error trapping
		
		// Determine if the method exists
		C_DATE:C307($vd_modDate)
		C_TIME:C306($vh_modTime)
		METHOD GET MODIFICATION DATE:C1170($vt_projectMethodName; $vd_modDate; $vh_modTime; *)
		If (OnErr_GetLastError#0) | ($vb_forceMethodUpdate)  // Get error if method does not exist
			C_TEXT:C284($root_t)
			$root_t:=Get 4D folder:C485(Current resources folder:K5:16)+"4D Methods"+Folder separator:K24:12
			
			//   Mod: DB (03/28/2014)
			C_LONGINT:C283($vl_Err)
			$vl_Err:=Method_LoadFromFile($vt_projectMethodName; $root_t+$vt_projectMethodName+".txt")
		End if 
		
		OnErr_ClearError
		ON ERR CALL:C155($vt_currentOnErrorMethod)
	End if 
End if   // ASSERT

