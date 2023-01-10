//%attributes = {"invisible":true,"preemptive":"capable"}
// MethodStats__RefreshTotals ()
//
// DESCRIPTION
//   Updates the totals and high level summary #s
//   for the methodStats in Storage.
//
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (12/20/2020)
// ----------------------------------------------------

C_OBJECT:C1216($statSummaryCounts)
$statSummaryCounts:=New shared object:C1526

Use ($statSummaryCounts)
	$statSummaryCounts.numGitCommits:=0
	$statSummaryCounts.numCodeLines:=0
	$statSummaryCounts.numCommentLines:=0
	$statSummaryCounts.numBlankLines:=0
	$statSummaryCounts.numLines:=0
	
	$statSummaryCounts.numTriggerMethods:=0
	$statSummaryCounts.numDatabaseMethods:=0
	$statSummaryCounts.numProjectFormMethods:=0
	$statSummaryCounts.numTableFormMethods:=0
	$statSummaryCounts.numProjectMethods:=0
	$statSummaryCounts.numMethods:=0
	
	If (Storage:C1525.methodStats#Null:C1517)
		ARRAY TEXT:C222($tagsArr; 0)
		OB GET PROPERTY NAMES:C1232(Storage:C1525.methodStats; $tagsArr)
		
		C_LONGINT:C283($i)
		C_OBJECT:C1216($methodStatObject)
		For ($i; 1; Size of array:C274($tagsArr))
			If (Value type:C1509(Storage:C1525.methodStats[$tagsArr{$i}])=Is object:K8:27)
				$methodStatObject:=Storage:C1525.methodStats[$tagsArr{$i}]
				$statSummaryCounts.numCodeLines:=$statSummaryCounts.numCodeLines+$methodStatObject.line_counts.lines
				$statSummaryCounts.numCommentLines:=$statSummaryCounts.numCommentLines+$methodStatObject.line_counts.comments
				$statSummaryCounts.numBlankLines:=$statSummaryCounts.numBlankLines+$methodStatObject.line_counts.blank
				
				Case of 
					: ($methodStatObject.path="[trigger]@")
						$statSummaryCounts.numTriggerMethods:=$statSummaryCounts.numTriggerMethods+1
						
					: ($methodStatObject.path="[databaseMethod]@")
						$statSummaryCounts.numDatabaseMethods:=$statSummaryCounts.numDatabaseMethods+1
						
					: ($methodStatObject.path="[projectForm]@")
						$statSummaryCounts.numProjectFormMethods:=$statSummaryCounts.numProjectFormMethods+1
						
					: ($methodStatObject.path="[tableForm]@")
						$statSummaryCounts.numTableFormMethods:=$statSummaryCounts.numTableFormMethods+1
						
					Else 
						$statSummaryCounts.numProjectMethods:=$statSummaryCounts.numProjectMethods+1
				End case 
				
			End if 
		End for 
	End if 
	
	$statSummaryCounts.numLines:=$statSummaryCounts.numCodeLines\
		+$statSummaryCounts.numCommentLines\
		+$statSummaryCounts.numBlankLines
	
	$statSummaryCounts.numMethods:=$statSummaryCounts.numTriggerMethods\
		+$statSummaryCounts.numDatabaseMethods\
		+$statSummaryCounts.numProjectFormMethods\
		+$statSummaryCounts.numTableFormMethods\
		+$statSummaryCounts.numProjectMethods
	
End use 

Use (Storage:C1525)
	Storage:C1525.methodStatsSummary:=$statSummaryCounts
End use 
