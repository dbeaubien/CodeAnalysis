//%attributes = {"invisible":true}
// Methods_GetNames (methodNamesArrPtr)
// 
// DESCRIPTION
//   Loads the method names.
//   Method Preferences are recognized.
//
#DECLARE($ap_methodNamesArrPtr : Pointer)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)

METHOD GET PATHS:C1163(Path all objects:K72:16; $ap_methodNamesArrPtr->; *)
SORT ARRAY:C229($ap_methodNamesArrPtr->; >)

MethodScan__StripCompilerMeths($ap_methodNamesArrPtr)