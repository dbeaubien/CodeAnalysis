//%attributes = {"invisible":true}
// Host_VerifyMethodExists (projectMethodName{; forceLoad})
//
// DESCRIPTION
//   Checks to make sure that the method exists in the
//   host database. If it does not, then it adds it. The 
//   method code is retrieved from the component resources.
//
#DECLARE($vt_projectMethodName : Text; $vb_forceMethodUpdate : Boolean)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT_RANGE(Current method name:C684; 1; 2; Count parameters:C259))
	If (Structure file:C489(*)#Structure file:C489)  // Are we running locally?
		var $vt_currentOnErrorMethod : Text
		$vt_currentOnErrorMethod:=Method called on error:C704
		OnErr_ClearError
		ON ERR CALL:C155("OnErr_GENERIC_Quiet")  //   Mod by: Dani Beaubien (01/23/2016) - Use a quiet variant of error trapping
		
		// Determine if the method exists
		var $vd_modDate : Date
		var $vh_modTime : Time
		METHOD GET MODIFICATION DATE:C1170($vt_projectMethodName; $vd_modDate; $vh_modTime; *)
		If (OnErr_GetLastError#0) | ($vb_forceMethodUpdate)  // Get error if method does not exist
			var $root_t : Text
			$root_t:=Get 4D folder:C485(Current resources folder:K5:16)+"4D Methods"+Folder separator:K24:12
			
			//   Mod: DB (03/28/2014)
			var $vl_Err : Integer
			$vl_Err:=Method_LoadFromFile($vt_projectMethodName; $root_t+$vt_projectMethodName+".txt")
		End if 
		
		OnErr_ClearError
		ON ERR CALL:C155($vt_currentOnErrorMethod)
	End if 
End if 

