//%attributes = {"invisible":true,"shared":true}
// CA_SaveFormProperties (tableNo, formName {;altFldr} ) : noResult
// CA_SaveFormProperties (longint, text {;text}) : boolean
//
// DESCRIPTION
//   Saves the form properties for the project/table form to file.
//   Needs to be called from the process that has the form open already.
//
//   If no folder is specified, then the folder as declared in the
//   component preferences will be used.
//
//   If a folder is specified, then that folder will be used as a destination
//   for the exported form properties JSON file. The component preferences will be ignored.
//   NOTE: The folder will be created if it does not exist.
//
C_LONGINT:C283($1; $vl_tableNo)  // Valid Table No. 0 means this is a project form.
C_TEXT:C284($2; $vt_formName)  // Project/table form name
C_TEXT:C284($3; $vt_rootFolder)  // OPTIONAL - specify the root folder to save the form properties to. The file name will be named by this method.
C_BOOLEAN:C305($0)  // Declared so that "EXECUTE METHOD IN SUBFORM" has a result.
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (11/02/2012)
//   Mod by: Dani Beaubien (11/05/2012) - Task 2159 - Convered to JSON
// ----------------------------------------------------

// NOTE: This method is shared with the host DB

If (Is compiled mode:C492(*))
	BEEP:C151
	ALERT:C41("This component can only be used in an uncompiled host database.")
	$0:=False:C215
	
Else 
	If (DEV_ASSERT_PARMCOUNT_RANGE(Current method name:C684; 2; 3; Count parameters:C259))
		$vl_tableNo:=$1
		$vt_formName:=$2
		If (Count parameters:C259>=3)
			$vt_rootFolder:=$3
		End if 
		
		// Build the root folder path to save the form properties to.
		C_TEXT:C284($vt_diskFilePath)
		If ($vt_rootFolder#"")
			$vt_diskFilePath:=$vt_rootFolder
			If ($vt_diskFilePath[[Length:C16($vt_diskFilePath)]]#Folder separator:K24:12)  // make sure the path ends in a folder
				$vt_diskFilePath:=$vt_diskFilePath+Folder separator:K24:12
			End if 
		Else 
			$vt_diskFilePath:=CodeAnalysis__GetDestFolder+Pref_GetPrefString("EXPRT2File Default Form Folder Name"; "Form Property Export")
			C_TEXT:C284(<>_CODEANALYSIS_FLDR_SUFFIX)  // Set by the "Export Form Properties" button
			$vt_diskFilePath:=$vt_diskFilePath+<>_CODEANALYSIS_FLDR_SUFFIX+Folder separator:K24:12
		End if 
		Folder_VerifyExistance($vt_diskFilePath)
		
		// Append the table name if a table form name
		If ($vl_tableNo>0)
			$vt_diskFilePath:=$vt_diskFilePath+Table name:C256($vl_tableNo)+Folder separator:K24:12
			Folder_VerifyExistance($vt_diskFilePath)
		End if 
		$vt_diskFilePath:=$vt_diskFilePath+$vt_formName+".json"
		
		// Save the form properties
		FormProperties_SaveToFile($vl_tableNo; $vt_formName; $vt_diskFilePath)
		
	End if   // ASSERT
	$0:=True:C214
End if 