//%attributes = {"invisible":true}
// Methods_GetNames (methodNamesArrPtr)
// Methods_GetNames (pointer)
// 
// DESCRIPTION
//   Loads the method names.
//   Method Preferences are recognized.
//
C_POINTER:C301($1; $ap_methodNamesArrPtr)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (01/15/2015)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
$ap_methodNamesArrPtr:=$1

METHOD GET PATHS:C1163(Path all objects:K72:16; $ap_methodNamesArrPtr->; *)
SORT ARRAY:C229($ap_methodNamesArrPtr->; >)

MethodScan__StripCompilerMeths($ap_methodNamesArrPtr)

