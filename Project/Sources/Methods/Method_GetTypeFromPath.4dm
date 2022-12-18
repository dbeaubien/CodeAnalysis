//%attributes = {"invisible":true,"preemptive":"capable"}
// Method_GetTypeFromPath (methodPath) : type
//
// DESCRIPTION
//   Returns the type of method based on the method path.
//
C_TEXT:C284($1; $methodPath)
C_TEXT:C284($0; $typeOfMethod)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (01/30/2021)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
$methodPath:=$1

Case of 
	: ($methodPath="[projectForm]@")
		$typeOfMethod:="project form method"
		
	: ($methodPath="[tableForm]@")
		$typeOfMethod:="table form method"
		
	: ($methodPath="[databaseMethod]@")
		$typeOfMethod:="database method"
		
	: ($methodPath="[trigger]@")
		$typeOfMethod:="trigger method"
		
	Else 
		$typeOfMethod:="project method"
End case 

$0:=$typeOfMethod