//%attributes = {"invisible":true}
// Semaphore_Release
// 
#DECLARE($semaphore_name : Text)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
ASSERT:C1129($semaphore_name#"")

// NOTE: The other side of "Semaphore_Grab" method

CLEAR SEMAPHORE:C144($semaphore_name)
