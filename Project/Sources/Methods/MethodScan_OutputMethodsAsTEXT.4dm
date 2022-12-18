//%attributes = {"invisible":true}
// MethodScan_OutputMethodsAsTEXT (root Folder; progressBarID)
// MethodScan_OutputMethodsAsTEXT (text; longint)
//
// DESCRIPTION
//   Outputs the results of the method scan to HTML files.
//
C_TEXT:C284($1; $rootFolder)
C_LONGINT:C283($2; $progHdl)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (07/03/2012)
//   Mod: DB (10/03/2012) - Handle non project method paths
//   Mod: DB (01/26/2013) - Task 2169 - Address invalid windows characters
//   Mod: DB (11/09/2014) - Refactored method. Simplified the logic
//   Mod: DB (11/10/2014) - Only save those methods that differ from what is on disk already
//   Mod: DB (04/22/2015) - Added preference that will have the exported methods not nested
//   Mod by: Dani Beaubien (02/02/2021) - updated to use objects
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=2)
$rootFolder:=$1
$progHdl:=$2

OnErr_ClearError
OnErr_Install_Handler("OnErr_GENERIC")

// ### CHECK TO MAKE SURE THAT THE DIRECTORY IS WRITABLE
If (Folder_isWritable($rootFolder))
	C_BOOLEAN:C305($doIgnoreAttributeLine)
	C_BOOLEAN:C305($doIgnoreMultipleSpaces)
	C_BOOLEAN:C305($doIgnoreCase)
	C_BOOLEAN:C305($doIgnoreBlankLines)
	$doIgnoreAttributeLine:=(Pref_GetPrefString("DIFF Ignore Attribute Line"; "0")="1")
	$doIgnoreMultipleSpaces:=(Num:C11(Pref_GetPrefString("DIFF ignoreMultipleSpaces"; ""))=1)
	$doIgnoreCase:=(Num:C11(Pref_GetPrefString("DIFF ignoreCase"; ""))=1)
	$doIgnoreBlankLines:=(Num:C11(Pref_GetPrefString("DIFF ignoreBlankLines"; ""))=1)
	
	C_BOOLEAN:C305($doUseNestedFolders)  //   Mod: DB (04/22/2015) - Added by user request
	$doUseNestedFolders:=(Pref_GetPrefString("EXPRT2File DoNotNestMethods"; "1")#"1")
	
	ARRAY TEXT:C222($methodObjNames; 0)
	Method_GetMethodObjNames(->$methodObjNames)
	
	// # Figure out the destination file path for each method
	C_BOOLEAN:C305($isInModule)
	ARRAY TEXT:C222($methodFriendlyNameArr; Size of array:C274($methodObjNames))
	ARRAY TEXT:C222($methodFilePathArr; Size of array:C274($methodObjNames))
	C_OBJECT:C1216($methodObj)
	C_LONGINT:C283($i)
	For ($i; 1; Size of array:C274($methodObjNames))
		$methodObj:=MethodStatsMasterObj[$methodObjNames{$i}]
		$methodFilePathArr{$i}:=$rootFolder  // Default path
		$methodFriendlyNameArr{$i}:=$methodObjNames{$i}
		
		If ($doUseNestedFolders) & ($methodObj.in_module#"")  // Append the module name if there is one
			$methodFilePathArr{$i}:=$methodFilePathArr{$i}+$methodObj.in_module+Folder separator:K24:12
			
		Else 
			If (Position:C15("/"; $methodFriendlyNameArr{$i})>0)  // Handle non project method paths
				$methodFriendlyNameArr{$i}:=Convert path POSIX to system:C1107($methodFriendlyNameArr{$i}; *)  // Must pass the * because paths are encoded.
				If ($methodFriendlyNameArr{$i}[[1]]=Folder separator:K24:12)  // strip out this
					$methodFriendlyNameArr{$i}:=Substring:C12($methodFriendlyNameArr{$i}; 2)
				End if 
				$methodFilePathArr{$i}:=$methodFilePathArr{$i}+Folder_ParentName($methodFriendlyNameArr{$i})
			End if 
		End if 
		Folder_VerifyExistance($methodFilePathArr{$i})
		
		// Append the method name
		$methodFilePathArr{$i}:=$methodFilePathArr{$i}+File_MakeNameWindowsSafe(File_GetFileName($methodFriendlyNameArr{$i}))
	End for 
	
	
	
	// # Save the methods to disk
	C_LONGINT:C283($vl_numExported)
	C_TEXT:C284($vt_theCode; $vt_4dMethodDigest; $vt_MethodFileDigest)
	C_BLOB:C604($vx_theCode)
	C_TIME:C306($fileRef)
	For ($i; 1; Size of array:C274($methodObjNames))
		$methodObj:=MethodStatsMasterObj[$methodObjNames{$i}]
		
		// Grab the digest for the method
		If (File_DoesExist($methodFilePathArr{$i}+".txt"))
			$vt_4dMethodDigest:=Digest_GetForMethod($methodObj.path; $doIgnoreAttributeLine; $doIgnoreCase; $doIgnoreMultipleSpaces; $doIgnoreBlankLines)
			$vt_MethodFileDigest:=Digest_GetForFile($methodFilePathArr{$i}+".txt"; $doIgnoreAttributeLine; $doIgnoreCase; $doIgnoreMultipleSpaces; $doIgnoreBlankLines)
		Else 
			$vt_4dMethodDigest:="is"
			$vt_MethodFileDigest:="different"
		End if 
		
		If ($vt_4dMethodDigest#$vt_MethodFileDigest)  // Only export if there is a "diff"
			$vt_theCode:=Method_GetNormalizedCode($methodObj.path)
			
			$fileRef:=Create document:C266($methodFilePathArr{$i}+".txt")
			If (OK=1)
				CONVERT FROM TEXT:C1011($vt_theCode; "UTF-8"; $vx_theCode)  // Methods will be saved as UTF-8 so I need to convert the 4D Text (UTF-16) to UTF-8...
				SEND PACKET:C103($fileRef; UTF8_BOMString)  // Insert the BOM...
				SEND PACKET:C103($fileRef; $vx_theCode)
				CLOSE DOCUMENT:C267($fileRef)
				
				$vl_numExported:=$vl_numExported+1
				Progress SET PROGRESS($progHdl; $vl_numExported/Size of array:C274($methodObjNames))
			End if 
		End if 
	End for 
	
Else 
	BEEP:C151
	ALERT:C41("The export cannot be completed. The destination folder \""+$rootFolder+"\" is not writable.")
	
End if 


OnErr_ClearError
OnErr_Install_Handler