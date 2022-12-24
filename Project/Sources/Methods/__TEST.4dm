//%attributes = {"preemptive":"capable"}
//Progress QUIT (0)

//_DIFF_ChangesText 

C_LONGINT:C283($vs; $ve; $time1; $time2)
//SHOW ON DISK(File_GetFolderName (Pref__GetFile2PrefFile ))
C_OBJECT:C1216(MethodStatsMasterObj)  // defined in MethodStats__Init
/* MethodStats__Init */

// Is a composite index
$table_no:=4
$field_no:=7
$p:=Field:C253($table_no; $field_no)
$index:=Structure_GetFieldIndexType($table_no; $field_no)

var $test : cs:C1710.model_TableInformation
$test:=cs:C1710.model_TableInformation.new()
$test.Refresh()


