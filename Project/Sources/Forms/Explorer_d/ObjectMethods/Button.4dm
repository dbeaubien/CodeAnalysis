
var $git : cs:C1710.Git_InfoGatherer
$git:=cs:C1710.Git_InfoGatherer.new()
$git.Ask_Git_for_Log()
$git.Parse_Log()

var $row : Object
For each ($row; Form:C1466.fullList)
	//SET TEXT TO PASTEBOARD(JSON Stringify($row; *))
	$row.numGitCommits:=$git.Get_Commit_Count($row.path)
End for each 

Form:C1466.filteredList:=Form:C1466.filteredList
