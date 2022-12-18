//%attributes = {"invisible":true}
// CODE_doDiffOnFolder (diffCollection)
// CODE_doDiffOnFolder (collection)
//
// DESCRIPTION
//   Scans for differences between the structure and the
//   folder specified by <>_DIFF_PathToFileOnDisk.
//
C_COLLECTION:C1488($1; $diffCollection)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (10/01/2012)
//   Mod by: Dani Beaubien (10/03/2012) - Handle the saved files as UTF-8
//   Mod by: Dani Beaubien (10/04/2012) - Suppress based on user preference
//   Mod by: Dani Beaubien (10/25/2012) - Added support for ignoringMultipleSpaces and IngoringCase.
//   Mod by: Dani Beaubien (11/02/2012) - Use 4D v13 Progress bar
//   Mod by: Dani Beaubien (06/22/2013) - Added some error handling
//   Mod by: Dani Beaubien (09/28/2013) - Improved how the method paths are shown
//   Mod: DB (11/10/2014) - Refactored
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
$diffCollection:=$1

C_TEXT:C284(<>_DIFF_PathToFileOnDisk)

C_TEXT:C284($vt_srcFldr)
$vt_srcFldr:=<>_DIFF_PathToFileOnDisk
<>_DIFF_PathToFileOnDisk:=""

OnErr_Install_Handler("OnErr_GENERIC")
OnErr_ClearError

C_BOOLEAN:C305($vb_ignoreAttributeLine; $vb_ignoreMultipleSpaces; $vb_ignoreCase; $vb_ignoreBlankLines)
C_BOOLEAN:C305($vb_noStructOnly; $vb_noDiskOnly)
ARRAY TEXT:C222(at_XTRA_ignoreNames; 0)  // List of file/folder names to ignore on disk
If (True:C214)  // grab preferences
	$vb_ignoreAttributeLine:=(Pref_GetPrefString("DIFF Ignore Attribute Line"; "0")="1")
	$vb_ignoreMultipleSpaces:=(Num:C11(Pref_GetPrefString("DIFF ignoreMultipleSpaces"; ""))=1)
	$vb_ignoreCase:=(Num:C11(Pref_GetPrefString("DIFF ignoreCase"; ""))=1)
	$vb_ignoreBlankLines:=(Num:C11(Pref_GetPrefString("DIFF ignoreBlankLines"; ""))=1)
	$vb_noStructOnly:=(Pref_GetPrefString("DIFF Suppress Structure Only"; "0")="1")
	$vb_noDiskOnly:=(Pref_GetPrefString("DIFF Suppress Disk Only"; "0")="1")
	
	Pref_GetPrefTextArray("FileFolderNamesToIgnore"; ->at_XTRA_ignoreNames)
End if 

C_LONGINT:C283($progHdl)
If (True:C214)  // setup progress bar
	$progHdl:=Progress New
	
	C_PICTURE:C286($vg_icon)
	READ PICTURE FILE:C678(LibraryImage_GetPlatformPath("Progress_Compare.png"); $vg_icon)
	Progress SET ICON($progHdl; $vg_icon)
	Progress SET TITLE($progHdl; "Analysing for Method Differences"; -1; "Initializing..."; True:C214)
End if 


ARRAY TEXT:C222(at_methodNames; 0)
ARRAY TEXT:C222(at_methodNames_FileSafe; 0)
MethodScan_LoadMethodNames(->at_methodNames; ->at_methodNames_FileSafe)

ARRAY TEXT:C222($at_internalMethod_MD5; Size of array:C274(at_methodNames))
ARRAY TEXT:C222($at_externalMethod_MD5; Size of array:C274(at_methodNames))
ARRAY TEXT:C222($at_externalFilePath; Size of array:C274(at_methodNames))



Progress SET MESSAGE($progHdl; "Step 1 of 3: Generating digests on structure methods...")
If (True:C214)
	C_LONGINT:C283($i)
	For ($i; 1; Size of array:C274(at_methodNames))
		$at_internalMethod_MD5{$i}:=Digest_GetForMethod(at_methodNames{$i}; $vb_ignoreAttributeLine; $vb_ignoreCase; $vb_ignoreMultipleSpaces; $vb_ignoreBlankLines)
		Progress SET PROGRESS($progHdl; $i/Size of array:C274(at_methodNames))
	End for 
End if 



// Get digests on methods from File System
ARRAY TEXT:C222($at_files; 0)
C_TEXT:C284($vt_methodName; $vt_methodPath)
Folder_GetAllFilePaths($vt_srcFldr; ->$at_files; ->at_XTRA_ignoreNames)
Progress SET MESSAGE($progHdl; "Step 2 of 3: Generating digests on methods files...")
For ($i; 1; Size of array:C274($at_files))
	
	// # Figure out what "method" name we should use for it
	$vt_methodName:=File_GetFileName($at_files{$i})
	If ($vt_methodName="@.txt")  // Remove the ".txt" extension
		$vt_methodName:=Substring:C12($vt_methodName; 1; Length:C16($vt_methodName)-4)
	End if 
	
	// Get the relative path from the supplied source folder
	// Modified by: Dani Beaubien (8/8/13) - Search by the method path first, clean it up first
	$vt_methodPath:=Substring:C12($at_files{$i}; Length:C16($vt_srcFldr)+1)  // strip out the source folder from path
	$vt_methodPath:=Replace string:C233($vt_methodPath; Folder separator:K24:12; "/")
	$vt_methodPath:=Replace string:C233($vt_methodPath; "<"; "%3C")
	$vt_methodPath:=Replace string:C233($vt_methodPath; ">"; "%3E")
	If ($vt_methodPath="@.txt")
		$vt_methodPath:=Substring:C12($vt_methodPath; 1; Length:C16($vt_methodPath)-4)
	End if 
	If ($vt_methodPath="[@")
		//TRACE
		$vt_methodName:=$vt_methodPath
	End if 
	
	// Try to locate it in our arrays
	C_LONGINT:C283($pos)
	$pos:=Find in array:C230(at_methodNames; $vt_methodPath)
	If ($pos<1)  //   Mod by: Dani Beaubien (10/03/2012) - Try to search by just the method name
		$pos:=Find in array:C230(at_methodNames; $vt_methodName)
	End if 
	If ($pos<1)  // did not find it, then add it, is on disk only
		APPEND TO ARRAY:C911(at_methodNames; $vt_methodName)
		APPEND TO ARRAY:C911($at_internalMethod_MD5; "")
		APPEND TO ARRAY:C911($at_externalMethod_MD5; "")
		APPEND TO ARRAY:C911($at_externalFilePath; "")
		$pos:=Size of array:C274(at_methodNames)
	End if 
	
	
	$at_externalMethod_MD5{$pos}:=Digest_GetForFile($at_files{$i}; $vb_ignoreAttributeLine; $vb_ignoreCase; $vb_ignoreMultipleSpaces; $vb_ignoreBlankLines)  //   Mod: DB (11/10/2014)
	$at_externalFilePath{$pos}:=$at_files{$i}
	Progress SET PROGRESS($progHdl; $i/Size of array:C274($at_files))
End for 


// remove methods without changes
For ($i; Size of array:C274(at_methodNames); 1; -1)
	If ($at_externalMethod_MD5{$i}=$at_internalMethod_MD5{$i}) | (at_methodNames{$i}="@.DS_Store")
		DELETE FROM ARRAY:C228(at_methodNames; $i; 1)
		DELETE FROM ARRAY:C228($at_internalMethod_MD5; $i; 1)
		DELETE FROM ARRAY:C228($at_externalMethod_MD5; $i; 1)
		DELETE FROM ARRAY:C228($at_externalFilePath; $i; 1)
	End if 
End for 


// Put a description on the change
ARRAY TEXT:C222($diffDescriptionArr; Size of array:C274(at_methodNames))
C_BOOLEAN:C305($vb_deleteRow)
Progress SET MESSAGE($progHdl; "Step 3 of 3: Examining digests...")
For ($i; Size of array:C274(at_methodNames); 1; -1)
	$vb_deleteRow:=False:C215
	Case of 
		: ($at_externalMethod_MD5{$i}="")
			If ($vb_noStructOnly)
				$vb_deleteRow:=True:C214
			Else 
				$diffDescriptionArr{$i}:="Only in Structure"
			End if 
			
		: ($at_internalMethod_MD5{$i}="")
			If ($vb_noDiskOnly)
				$vb_deleteRow:=True:C214
			Else 
				$diffDescriptionArr{$i}:="Only on Disk"
			End if 
			
		Else 
			$diffDescriptionArr{$i}:="Methods differ"
	End case 
	
	If ($vb_deleteRow)
		DELETE FROM ARRAY:C228(at_methodNames; $i; 1)
		DELETE FROM ARRAY:C228($diffDescriptionArr; $i; 1)
		DELETE FROM ARRAY:C228($at_externalFilePath; $i; 1)
	End if 
	Progress SET PROGRESS($progHdl; $i/Size of array:C274(at_methodNames))
End for 

SORT ARRAY:C229(at_methodNames; $diffDescriptionArr; $at_externalFilePath; >)

C_OBJECT:C1216($diff)
For ($i; 1; Size of array:C274(at_methodNames))
	$diff:=New object:C1471
	$diff.methodName:=at_methodNames{$i}
	$diff.description:=$diffDescriptionArr{$i}
	$diff.methodPathOnDisk:=$at_externalFilePath{$i}
	$diff.methodFriendlyName:=at_methodNames{$i}
	If (Position:C15("%"; $diff.methodFriendlyName)>0)
		$diff.methodFriendlyName:=STR_URLDecode($diff.methodFriendlyName)
	End if 
	
	$diffCollection.push($diff)
End for 

Progress QUIT($progHdl)

OnErr_ClearError
OnErr_Install_Handler