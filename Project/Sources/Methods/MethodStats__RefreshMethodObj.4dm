//%attributes = {"invisible":true}
// MethodStats__RefreshMethodObj (methodPath; projectMethodNamesArr; tableList; fieldNamesArr) 
// MethodStats__RefreshMethodObj (text; pointer; pointer; pointer)
//
// DESCRIPTION
//   Refreshes the analaysis for the specified method.
//
C_TEXT:C284($1; $methodPath)
C_POINTER:C301($2; $projectMethodNamesArr)
C_COLLECTION:C1488($3; $tableList)
C_COLLECTION:C1488($4; $fieldList)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (03/29/2020)
// ----------------------------------------------------

Logging_Method_START(Current method name:C684)
ASSERT:C1129(Count parameters:C259=4)
$methodPath:=$1
$projectMethodNamesArr:=$2
$tableList:=$3
$fieldList:=$4

C_OBJECT:C1216(MethodStatsMasterObj)  // initalized by
MethodStats__Init

// Store away our current on error settings
C_TEXT:C284($onErrorMethod)
$onErrorMethod:=Method called on error:C704
OnErr_ClearError
ON ERR CALL:C155("OnErr_GENERIC")

C_TEXT:C284($theCode)
C_LONGINT:C283($err)
$theCode:=Method_GetNormalizedCode($methodPath)
If (OnErr_GetLastError=0)
	ARRAY TEXT:C222($methodLinesArr; 0)
	$theCode:=Replace string:C233($theCode; "\\\r"; "")  // Collapses lines that are "wrapped"
	Method_CodeToArray($theCode; ->$methodLinesArr; Pref_GetEOL)
	Array_TrimLeadingSpaces(->$methodLinesArr)
	
	If (MethodStatsMasterObj[$methodPath]=Null:C1517)
		$err:=MethodStats__AddMethod($methodPath)
	End if 
	
	If ($err=0)
		C_OBJECT:C1216($methodStatObject)
		$methodStatObject:=MethodStatsMasterObj[$methodPath]
		Use ($methodStatObject)
			$methodStatObject.documentation:=MethodLines_GetHeaderComment(->$methodLinesArr; Pref_GetEOL)
			$methodStatObject.last_modified_dts:=Method_GetLastModDTS($methodPath)
			
			Use ($methodStatObject.line_counts)
				$methodStatObject.line_counts.blank:=MethodLines_CountBlankLines(->$methodLinesArr)
				$methodStatObject.line_counts.comments:=MethodLines_CountCommentLines(->$methodLinesArr)
				$methodStatObject.line_counts.lines:=Size of array:C274($methodLinesArr)-$methodStatObject.line_counts.blank-$methodStatObject.line_counts.comments
				If ($methodLinesArr{1}="//%attributes@")
					$methodStatObject.line_counts.lines:=$methodStatObject.line_counts.lines-1
				End if 
			End use 
			
			C_LONGINT:C283($cyclomaticComplexity)
			C_COLLECTION:C1488($downstreamMethodsCol; $tablesUsedCol; $fieldsUsedCol; $indexedFieldsUsedCol)
			$cyclomaticComplexity:=1  // Always at least 1
			$downstreamMethodsCol:=$methodStatObject.references.downstream_methods
			$tablesUsedCol:=New collection:C1472
			$fieldsUsedCol:=New collection:C1472
			$indexedFieldsUsedCol:=New collection:C1472
			
			
			C_OBJECT:C1216($methodParameters)
			$methodParameters:=New object:C1471  // make sure this is an empty object
			C_LONGINT:C283($lineNo)
			C_OBJECT:C1216($previousLineInfo)
			$previousLineInfo:=New object:C1471  // make sure that this thing exists.
			For ($lineNo; 2; Size of array:C274($methodLinesArr))  // skip the first line, that is 4d attributes
				ARRAY TEXT:C222($methodLineTokensArr; 0)
				$previousLineInfo:=Tokenize_LineOfCode($methodLinesArr{$lineNo}; ->$methodLineTokensArr; $previousLineInfo)
				
				If ($methodLinesArr{$lineNo}="@[@")  // contains a reference to a table or field?
					MethodLine_PushStructureUsed(->$methodLineTokensArr; $tableList; $fieldList; $tablesUsedCol; $fieldsUsedCol; $indexedFieldsUsedCol)
				End if 
				
				Use ($downstreamMethodsCol)
					MethodLine_PushMethodsCalled(->$methodLineTokensArr; $projectMethodNamesArr; $downstreamMethodsCol)
				End use 
				
				$cyclomaticComplexity:=$cyclomaticComplexity+CyclomaticComplexity_CalcInc(->$methodLineTokensArr)
				MethodStats__GatherParmInfo(->$methodLineTokensArr; ->$methodParameters)
			End for 
			
			Use ($methodStatObject)
				OB_CopyObject($methodParameters; $methodStatObject.parameters)
			End use 
			
			If ($methodPath="[@")  // skip if not a project method
				$methodStatObject.is_shared:=False:C215
			Else 
				$methodStatObject.is_shared:=METHOD Get attribute:C1169($methodPath; Attribute shared:K72:10; *)
			End if 
			
			Use ($methodStatObject.analysis)
				$methodStatObject.analysis.max_nesting_level:=MethodStats__GetMaxNestingLevel(->$methodLinesArr)
				$methodStatObject.analysis.complexity:=$cyclomaticComplexity
			End use 
			Use ($methodStatObject.references.downstream_methods)
				OB_CopyCollection($downstreamMethodsCol.distinct(); $methodStatObject.references.downstream_methods)
			End use 
			Use ($methodStatObject.references)
				OB_CopyCollection($tablesUsedCol.orderBy("tableNo"); $methodStatObject.references.tables_used)
				OB_CopyCollection($fieldsUsedCol.orderBy("tableNo, fieldNo"); $methodStatObject.references.fields_used)
			End use 
			Use ($methodStatObject.references.indexed_fields_used)
				OB_CopyCollection($indexedFieldsUsedCol.distinct(); $methodStatObject.references.indexed_fields_used)
			End use 
		End use 
	End if 
End if 

C_LONGINT:C283($errorNo)
$errorNo:=OnErr_GetLastError
OnErr_ClearError
ON ERR CALL:C155($onErrorMethod)

Logging_Method_STOP(Current method name:C684)