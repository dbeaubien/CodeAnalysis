Class constructor
	This:C1470._project_folder_platformPath:=This:C1470._project_folder()
	This:C1470._raw_log:=""
	This:C1470._parsed_log:=Null:C1517
	
	
Function Ask_Git_for_Log()
	This:C1470._raw_log:=This:C1470._get_log_from_git()
	
	
Function Parse_Log()
	This:C1470._parsed_log:=This:C1470._parse_git_log(This:C1470._raw_log)
	
	
Function Get_Commit_Count($4D_method_path : Text)->$num_git_commits : Integer
	var $matches : Collection
	$matches:=This:C1470._parsed_log.query("method_path=:1"; $4D_method_path)
	If ($matches.length>0)
		$num_git_commits:=$matches[0].num_commits
	End if 
	
	
/******** PRIVATE FUNCTIONS ********/
Function _process_line($line : Text; $parsed_log : Collection)
	var $git_file_path : Text
	var $parsed_line : Object
	var $line_parts; $matches : Collection
	$line_parts:=Split string:C1554($line; "\t")
	If ($line_parts.length=3)
		$git_file_path:=$line_parts[2]
		
		var $first_part; $last_part; $actual_git_path : Text
		var $git_path_parts_collection : Collection
		$git_path_parts_collection:=Split string:C1554($git_file_path; "/")
		$last_part:=$git_path_parts_collection[$git_path_parts_collection.length-1]
		
		If ($last_part="{@ => @}")
/*
Need to handle file renames.
			
Examples:
0 3 Project/Sources/Forms/Explorer_d/ObjectMethods/{BTN_Analysis7.4dm => BTN_RefreshFields.4dm}
0 0 Project/Sources/Forms/Explorer_d/ObjectMethods/{BTN_Analysis1.4dm => BTN_RefreshTables.4dm}
*/
			$last_part:=Substring:C12($last_part; 2; Length:C16($last_part)-2)  // Strip the "{" and "}"
			
			var $pos : Integer
			$pos:=Position:C15(" => "; $last_part)
			$first_part:=Substring:C12($last_part; 1; $pos-1)
			$last_part:=Substring:C12($last_part; $pos+4)
			
			$git_path_parts_collection[$git_path_parts_collection.length-1]:=$first_part
			$git_file_path:=$git_path_parts_collection.join("/")
			
			$git_path_parts_collection[$git_path_parts_collection.length-1]:=$last_part
			$actual_git_path:=$git_path_parts_collection.join("/")
		Else 
			$actual_git_path:=$git_file_path
		End if 
		
		If ($git_file_path="@/Project/Sources/@.4dm") | ($git_file_path="Project/Sources/@.4dm")
			$matches:=$parsed_log.query("git_file_path=:1"; $git_file_path)
			If ($matches.length>=1)
				$parsed_line:=$matches[0]
				If ($parsed_line.git_file_path#$actual_git_path)
					$parsed_line.git_file_path:=$actual_git_path
					$parsed_line.method_path:=This:C1470._get_4D_method_path($actual_git_path)
				End if 
				
			Else 
				$parsed_line:=New object:C1471
				$parsed_line.git_file_path:=$actual_git_path
				$parsed_line.method_path:=This:C1470._get_4D_method_path($actual_git_path)
				$parsed_line.num_lines_added:=0
				$parsed_line.num_lines_removed:=0
				$parsed_line.num_commits:=0
				$parsed_log.push($parsed_line)
			End if 
			
			$parsed_line.num_lines_added:=Num:C11($line_parts[0])
			$parsed_line.num_lines_removed:=Num:C11($line_parts[1])
			$parsed_line.num_commits:=$parsed_line.num_commits+1
		End if 
	End if 
	
	
Function _parse_git_log($raw_log : Text)->$parsed_log : Collection
	var $line : Text
	$parsed_log:=New collection:C1472
	For each ($line; Split string:C1554($raw_log; "\n").reverse())
		Case of 
			: ($line="")
			: ($line="    @")
			: ($line="commit@")
			: ($line="Merge:@")
			: ($line="Author:@")
			: ($line="Date:@")
			Else 
				This:C1470._process_line($line; $parsed_log)
		End case 
	End for each 
	$parsed_log:=$parsed_log.orderBy("num_commits desc")
	
	
Function _get_log_from_git()->$raw_log : Text
	var $in; $raw_log : Text
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_CURRENT_DIRECTORY"; This:C1470._project_folder_platformPath)
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")
	LAUNCH EXTERNAL PROCESS:C811("git log --numstat"; $in; $raw_log)
	
	
Function _project_folder()->$folder_platformPath : Text
	var $project : 4D:C1709.Folder
	$project:=File:C1566(Structure file:C489(*); fk platform path:K87:2).parent
	If ($project.name="Project")
		$folder_platformPath:=$project.platformPath
	End if 
	
	
Function _get_4D_method_path($git_file_path : Text)->$4D_method_path : Text
	var $git_path_parts_collection : Collection
	
	$git_file_path:=This:C1470._get_right_of($git_file_path; "Project/Sources/")
	$git_path_parts_collection:=Split string:C1554($git_file_path; "/")
	
	Case of 
		: ($git_file_path="DatabaseMethods/@")
			$git_path_parts_collection[0]:="[databaseMethod]"
			$4D_method_path:=$git_path_parts_collection.join("/")
			
		: ($git_file_path="Classes/@")
			$git_path_parts_collection[0]:="[class]"
			$4D_method_path:=$git_path_parts_collection.join("/")
			
		: ($git_file_path="Triggers/@")
			var $table_no : Integer
			$git_path_parts_collection[0]:="[trigger]"
			$table_no:=Num:C11(Replace string:C233($git_path_parts_collection[1]; "Table_"; ""))
			$git_path_parts_collection[1]:=Table name:C256($table_no)
			$4D_method_path:=$git_path_parts_collection.join("/")
			
		: ($git_file_path="Methods/@")
			$4D_method_path:=This:C1470._get_right_of($git_file_path; "Methods/")
			
		: ($git_file_path="TableForms/@/ObjectMethods/@")
			$git_path_parts_collection[0]:="[tableForm]"
			$git_path_parts_collection[1]:="Table_"+$git_path_parts_collection[1]
			$git_path_parts_collection.remove(3; 1)
			$4D_method_path:=$git_path_parts_collection.join("/")
			
		: ($git_file_path="TableForms/@/method.4dm")
			$git_path_parts_collection[0]:="[tableForm]"
			$git_path_parts_collection[1]:="Table_"+$git_path_parts_collection[1]
			$git_path_parts_collection[$git_path_parts_collection.length-1]:="{formMethod}"
			$4D_method_path:=$git_path_parts_collection.join("/")
			
		: ($git_file_path="Forms/@/method.4dm")
			$git_path_parts_collection[0]:="[projectForm]"
			$git_path_parts_collection[$git_path_parts_collection.length-1]:="{formMethod}"
			$4D_method_path:=$git_path_parts_collection.join("/")
			
		: ($git_file_path="Forms/@/ObjectMethods/@")
			$git_path_parts_collection[0]:="[projectForm]"
			$git_path_parts_collection.remove(2; 1)
			$4D_method_path:=$git_path_parts_collection.join("/")
			
		Else 
			$4D_method_path:=$git_file_path
	End case 
	
	If ($4D_method_path="@.4dm")
		$4D_method_path:=Substring:C12($4D_method_path; 1; Length:C16($4D_method_path)-4)
	End if 
	
	
Function _get_right_of($input : Text; $pivot : Text)->$output : Text
	var $position : Integer
	$position:=Position:C15($pivot; $input)
	$output:=Substring:C12($input; $position+Length:C16($pivot))