//%attributes = {"invisible":true}
// Process_WaitUntilClosed
// 
// DESCRIPTION:
//   This method takes a process ID and returns once the
//   process has completed.
//
#DECLARE($procID : Integer)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	var $procName : Text
	var $procState : Integer
	var $procTime : Integer
	
	If ($procID>0)  // Added by: dani (2005.02.23 @ 10:10:37) - make sure it exists
		
		// Now wait for it to finish
		Repeat 
			DELAY PROCESS:C323(Current process:C322; 10)  // pause for the process to start
			// PROCESS PROPERTIES($procID;$procName;$procState;$procTime)
			$procState:=Process state:C330($procID)
		Until ($procState=Aborted:K13:1) | ($procState=Does not exist:K13:3)
	End if 
	
End if 

