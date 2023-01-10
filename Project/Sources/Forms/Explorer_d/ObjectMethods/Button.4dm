
CONFIRM:C162("You are about to get a full log from git. This could take a few minutes.\r\rDo you wish to continue?"; "Continue"; "Cancel")
If (OK=1)
	var $progHdl : Integer
	$progHdl:=Progress New
	Progress SET TITLE($progHdl; "Fetching Log from Git..."; -1)
	Progress SET MESSAGE($progHdl; "asking git for log...")
	
	var $git : cs:C1710.Git_InfoGatherer
	$git:=cs:C1710.Git_InfoGatherer.new()
	$git.Ask_Git_for_Log()
	
	Progress SET MESSAGE($progHdl; "parsing log...")
	$git.Parse_Log()
	
	var $row : Object
	For each ($row; Form:C1466.fullList)
		//SET TEXT TO PASTEBOARD(JSON Stringify($row; *))
		$row.numGitCommits:=$git.Get_Commit_Count($row.path)
	End for each 
	
	Progress QUIT($progHdl)
	Form:C1466.filteredList:=Form:C1466.filteredList
End if 