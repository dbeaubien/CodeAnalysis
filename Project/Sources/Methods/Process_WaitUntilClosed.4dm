//%attributes = {"invisible":true}
// ----------------------------------------------------
// METHOD: Process_WaitUntilClosed
// 
// DESCRIPTION:
//   This method takes a process ID and returns once the
//   process has completed.
// ----------------------------------------------------
// PARAMETERS:
C_LONGINT:C283($1; $procID)
// RETURNS:
//   none
// ----------------------------------------------------
// CALLED BY:
//   
// ----------------------------------------------------
// HISTORY:
//   Created: DB (11/09/2004)
//   Mod by: dani (2005.02.23 @ 10:10:44) - check to make sure the proc id is a good one
// ----------------------------------------------------


If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$procID:=$1
	
	C_TEXT:C284($procName)
	C_LONGINT:C283($procState)
	C_LONGINT:C283($procTime)
	
	If ($procID>0)  // Added by: dani (2005.02.23 @ 10:10:37) - make sure it exists
		
		// Now wait for it to finish
		Repeat 
			DELAY PROCESS:C323(Current process:C322; 10)  // pause for the process to start
			// PROCESS PROPERTIES($procID;$procName;$procState;$procTime)
			$procState:=Process state:C330($procID)
		Until ($procState=Aborted:K13:1) | ($procState=Does not exist:K13:3)
	End if 
	
End if   // ASSERT

