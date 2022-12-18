//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method: Process_WaitUntilOpen
//
// Description:
//   Waits for until the process is running OR the max time has passed.
// ----------------------------------------------------
// Parameters:
C_LONGINT:C283($1; $vl_processID)  //    $1: Process Number
C_LONGINT:C283($2; $vl_tickCountOffset)  //    $2: Max time (ticks) to wait (default to 10 minutes)
//    
// Returns:
C_BOOLEAN:C305($0; $vF_Flag)  //    Boolean success/failure (timeout)
// ----------------------------------------------------
// HISTORY:
//   Added: john.craig (8/6/04 @ 13:49:27) - 
//   Mod by: dani (2005.02.01 @ 14:48:24) - rewote and improved clarity and simplicity
// ----------------------------------------------------
$vF_Flag:=False:C215

If (DEV_ASSERT_PARMCOUNT_RANGE(Current method name:C684; 1; 2; Count parameters:C259))
	$vl_processID:=$1
	If (Count parameters:C259=2)
		$vl_tickCountOffset:=$2
	Else 
		$vl_tickCountOffset:=(60*60)*10  // default to 10 minutes
	End if 
	
	C_LONGINT:C283($vl_startTickCount)
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
	
End if   // ASSERT

$0:=$vF_Flag
