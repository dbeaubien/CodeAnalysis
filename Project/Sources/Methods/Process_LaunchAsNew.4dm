//%attributes = {"invisible":true}
// Process_LaunchAsNew (methodName; processName{; stackByteSize}) : inNewProcess
// Process_LaunchAsNew (text; text{; longing}) : boolean
//
// DESCRIPTION
//   Launches the specified process as a new process.
//   The process, unless specified, defaults to a stack size of 256k.
//   If the process is already running it is sent to the front.
//
C_BOOLEAN:C305($0; $go_b)
C_TEXT:C284($1; $methodName_t)
C_TEXT:C284($2; $newProcessName_t)
C_LONGINT:C283($3; $vl_stackSize)  // OPTIONAL: 256k default
// ----------------------------------------------------
// HISTORY
//   Created by Dave Batton on Nov 19, 2003
// ----------------------------------------------------

$go_b:=False:C215
If (DEV_ASSERT_PARMCOUNT_RANGE(Current method name:C684; 2; 3; Count parameters:C259))
	$methodName_t:=$1
	$newProcessName_t:=$2
	If (Count parameters:C259>=3)
		$vl_stackSize:=$3
	Else 
		$vl_stackSize:=1024*256
	End if 
	
	C_TEXT:C284($currentProcessName_t)
	C_LONGINT:C283($processState_i; $processTime_i; $processNumber_i)
	
	PROCESS PROPERTIES:C336(Current process:C322; $currentProcessName_t; $processState_i; $processTime_i)
	
	Case of 
		: ($currentProcessName_t=$newProcessName_t)  //& (Not(Fnd_Gen_ProcessLaunched_b))
			BRING TO FRONT:C326(Process number:C372($newProcessName_t))
			POST OUTSIDE CALL:C329(Process number:C372($newProcessName_t))
			$go_b:=True:C214
			
		: (Process number:C372($newProcessName_t)>0)
			BRING TO FRONT:C326(Process number:C372($newProcessName_t))
			RESUME PROCESS:C320(Process number:C372($newProcessName_t))
			POST OUTSIDE CALL:C329(Process number:C372($newProcessName_t))
			$go_b:=False:C215
			
		: ($newProcessName_t#$currentProcessName_t)  // This is not in its own process
			$processNumber_i:=New process:C317($methodName_t; $vl_stackSize; $newProcessName_t)
			$go_b:=False:C215
			
		Else 
			TRACE:C157
	End case 
End if   // ASSERT

$0:=$go_b