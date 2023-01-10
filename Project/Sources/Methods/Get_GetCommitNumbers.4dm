//%attributes = {}
// Get_GetCommitNumbers () -> git_number_collection
// 
//
#DECLARE()->$parsed_log : Collection
// ----------------------------------------------------
$parsed_log:=New collection:C1472


// git log --numstat  > tt.txt
// git log --since=2020-01-01 --numstat  > tt.txt

var $cmd; $in; $out; $folder : Text
$folder:="Macintosh HD:Users:dbeaubien:Documents:ORD - Code Analysis (Github):CodeAnalysis:Project:"
$folder:="Macintosh HD:Users:dbeaubien:Documents:ORD - Code Analysis (Github):CodeAnalysis:"
SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_CURRENT_DIRECTORY"; $folder)
SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")

$cmd:="/bin/ls"
$cmd:="git log --numstat"
LAUNCH EXTERNAL PROCESS:C811($cmd; $in; $out)

//SET TEXT TO PASTEBOARD($out)

var $log_lines : Collection
$log_lines:=Split string:C1554($out; "\n")

var $line_parts; $matches : Collection
var $file_detail : Object
var $line; $file_path : Text
For each ($line; $log_lines)
	Case of 
		: ($line="")
		: ($line="    @")
		: ($line="commit@")
		: ($line="Merge:@")
		: ($line="Author:@")
		: ($line="Date:@")
		Else 
			$line_parts:=Split string:C1554($line; "\t")
			If ($line_parts.length=3)
				$file_path:=$line_parts[2]
				$matches:=$parsed_log.query("path=:1"; $file_path)
				If ($matches.length>=1)
					$file_detail:=$matches[0]
				Else 
					var $git_path_parts_collection : Collection
					$git_path_parts_collection:=Split string:C1554($file_path; "/")
					
					var $method_path : Text
					$method_path:="sdf"
					
					$file_detail:=New object:C1471
					$file_detail.method_path:=$method_path
					$file_detail.git_file_path:=$file_path
					$file_detail.num_lines_added:=0
					$file_detail.num_lines_removed:=0
					$file_detail.num_commits:=0
					$parsed_log.push($file_detail)
				End if 
				
				$file_detail.num_lines_added:=Num:C11($line_parts[0])
				$file_detail.num_lines_removed:=Num:C11($line_parts[1])
				$file_detail.num_commits:=$file_detail.num_commits+1
			Else 
				
			End if 
	End case 
	
End for each 
$parsed_log:=$parsed_log.orderBy("num_commits desc")

//SET TEXT TO PASTEBOARD(JSON Stringify($file_dictionary; *))