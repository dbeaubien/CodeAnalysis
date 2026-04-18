//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method: Process_WaitUntilOpen
//
// Description:
//   Waits for until the process is running OR the max time has passed.
//
#DECLARE($vl_processID : Integer; $vl_tickCountOffset : Integer)->$vF_Flag : Boolean
// ----------------------------------------------------
$vF_Flag:=False:C215

If (DEV_ASSERT_PARMCOUNT_RANGE(Current method name:C684; 1; 2; Count parameters:C259))
	If (Count parameters:C259#2)
		$vl_tickCountOffset:=(60*60)*10  // default to 10 minutes
	End if 
	
	var $vl_startTickCount : Integer
	$vl_startTickCount:=Tickcount:C458
	
	// Loop through until we get time out or the process is running
	If ($vl_processID>0)
		Repeat 
			IDLE:C311
			If (Process state:C330($vl_processID)>=0)  // are we running?
				$vF_Flag:=True:C214
			Else 
				DELAY PROCESS:C323(Current process:C322; 1)  // give a bit of time for things to get going
				IDLE:C311
			End if 
		Until ($vF_Flag) | (($vl_startTickCount+$vl_tickCountOffset)<Tickcount:C458)
	End if 
	
End if 
