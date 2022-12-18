//%attributes = {"invisible":true}
// Semaphore_WaitUntilGrabbed (semaphoreName {;delayTicksBetweenChecks})
// Semaphore_WaitUntilGrabbed (text {;longint})
// 
// DESCRIPTION
//   A generic method that will "grab" the specified semaphore, 
//   if it is locked, then it will wait until it is free.
// 
C_TEXT:C284($1)
C_LONGINT:C283($2; $vl_theDelayBetweenChecks)  // OPTIONAL, default to 5 ticks
// ----------------------------------------------------
// HISTORY:
//   Created by DB on (2006.01.11 @ 14:41:55)
// ----------------------------------------------------

// NOTE: The other side of "Semaphore_Release" method
If (DEV_ASSERT_PARMCOUNT_RANGE(Current method name:C684; 1; 2; Count parameters:C259))
	If (Count parameters:C259>=2)
		$vl_theDelayBetweenChecks:=$2
	End if 
	If ($vl_theDelayBetweenChecks<=0)
		$vl_theDelayBetweenChecks:=5
	End if 
	
	C_TIME:C306($vh_startTime; $vh_notifyTIme)
	$vh_startTime:=Current time:C178
	$vh_notifyTIme:=$vh_startTime+10  // add 10 seconds
	
	// Keep trying until we get the semaphore locked
	C_LONGINT:C283($vl_count)
	$vl_count:=0  // Added: DB (2006.07.06 @ 17:06:58) -  
	While (Semaphore:C143($1))
		IDLE:C311
		DELAY PROCESS:C323(Current process:C322; $vl_theDelayBetweenChecks)
		
		// Added: DB (2006.07.06 @ 17:07:05) -  output some debugging information
		$vl_count:=$vl_count+1
		If (Current time:C178>$vh_notifyTIme)
			$vl_count:=0
		End if 
	End while 
	
	C_BOOLEAN:C305($wasGrabbed)
	$wasGrabbed:=Not:C34(Semaphore:C143($1))
End if   // ASSERT
