//%attributes = {}


var $git : cs:C1710.Git_InfoGatherer
$git:=cs:C1710.Git_InfoGatherer.new()
$git.Ask_Git_for_Log()
$git.Parse_Log()
$git.Get_Commit_Count()

SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($git._parsed_log; *))

var $git_number_collection : Collection
$git_number_collection:=Get_GetCommitNumbers

SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($git_number_collection; *))

BEEP:C151
ABORT:C156