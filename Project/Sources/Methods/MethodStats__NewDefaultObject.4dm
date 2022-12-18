//%attributes = {}
// MethodStats__NewDefaultObject (methodPath) : methodStatObject
// MethodStats__NewDefaultObject (text) : object
//
// DESCRIPTION
//   Creates a new method stat object with all the fields
//   created with default values.
//
C_TEXT:C284($1; $methodPath)
C_OBJECT:C1216($2; $masterMethodObj)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (09/07/2019)
//   Mod by: Dani Beaubien (01/31/2021)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=2)
$methodPath:=$1
$masterMethodObj:=$2

Use ($masterMethodObj)
	$masterMethodObj[$methodPath]:=New shared object:C1526
End use 

C_OBJECT:C1216($methodStatObject)
$methodStatObject:=$masterMethodObj[$methodPath]

Use ($methodStatObject)
	// Method properties
	$methodStatObject.path:=$methodPath
	$methodStatObject.viewing_name:=Structure_FriendlyPathFromPath($methodPath)
	$methodStatObject.in_module:=Structure_ParentModuleFromPath($methodPath)
	$methodStatObject.is_shared:=False:C215  // Calcd in MethodStats_RecalculateModified
	$methodStatObject.documentation:=""
	$methodStatObject.parameters:=New shared object:C1526("maxParmNo"; 0)
	$methodStatObject.last_modified_dts:=0
	
	// Simple counts on each method
	$methodStatObject.line_counts:=New shared object:C1526
	Use ($methodStatObject.line_counts)
		$methodStatObject.line_counts.lines:=0
		$methodStatObject.line_counts.comments:=0
		$methodStatObject.line_counts.blank:=0
	End use 
	
	// Analysis metrics on each method
	$methodStatObject.analysis:=New shared object:C1526
	Use ($methodStatObject.analysis)
		$methodStatObject.analysis.complexity:=0
		$methodStatObject.analysis.max_nesting_level:=0
	End use 
	
	// Interactions of each method
	$methodStatObject.references:=New shared object:C1526
	Use ($methodStatObject.references)
		$methodStatObject.references.tables_used:=New shared collection:C1527
		$methodStatObject.references.fields_used:=New shared collection:C1527
		$methodStatObject.references.indexed_fields_used:=New shared collection:C1527
		$methodStatObject.references.upstream_methods:=New shared collection:C1527
		$methodStatObject.references.downstream_methods:=New shared collection:C1527
	End use 
End use 

