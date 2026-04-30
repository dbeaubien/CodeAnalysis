//%attributes = {"invisible":true,"preemptive":"capable"}
// Method_GetTypeFromPath (methodPath) : type
//
// DESCRIPTION
//   Returns the type of method based on the method path.
//
#DECLARE($methodPath : Text)->$typeOfMethod : Text
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)

Case of 
	: ($methodPath="[class]@")
		$typeOfMethod:="class method"
		
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
