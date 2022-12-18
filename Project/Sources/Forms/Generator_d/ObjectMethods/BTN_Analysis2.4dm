// Compare Folders button

ARRAY TEXT:C222(at_DIFF2_fileNames; 0)
ARRAY TEXT:C222(at_DIFF2_descriptions; 0)
ARRAY TEXT:C222(at_DIFF2_filePaths; 0)
ARRAY TEXT:C222(at_DIFF2_compareFilePaths; 0)

C_LONGINT:C283($i; $pos)
C_TEXT:C284($vt_pathToLocalFolder)
For ($i; 1; Size of array:C274(at_XTRA_relativePaths))
	If (at_XTRA_comparePathsFULL{$i}#"")
		$vt_pathToLocalFolder:=Folder_GetPathFrmRelativeToStct(at_XTRA_relativePaths{$i})
		
		If (Folder_DoesExist($vt_pathToLocalFolder) & Folder_DoesExist(at_XTRA_comparePathsFULL{$i}))
			ARRAY TEXT:C222($at_localFiles; 0)
			Folder_GetAllFilePaths($vt_pathToLocalFolder; ->$at_localFiles)
			C_LONGINT:C283($j)
			For ($j; 1; Size of array:C274($at_localFiles))  // Remove the "relative" part
				$at_localFiles{$j}:=Replace string:C233($at_localFiles{$j}; $vt_pathToLocalFolder; "")
			End for 
			
			ARRAY TEXT:C222($at_remoteFiles; 0)
			Folder_GetAllFilePaths(at_XTRA_comparePathsFULL{$i}; ->$at_remoteFiles)
			For ($j; 1; Size of array:C274($at_remoteFiles))  // Remove the "relative" part
				$at_remoteFiles{$j}:=Replace string:C233($at_remoteFiles{$j}; at_XTRA_comparePathsFULL{$i}; "")
			End for 
			
			// Look at the locals and compare to remote
			For ($j; Size of array:C274($at_localFiles); 1; -1)
				If ($at_localFiles{$j}#"@.DS_Store")
					$pos:=Find in array:C230($at_remoteFiles; $at_localFiles{$j})
					If ($pos<1)
						APPEND TO ARRAY:C911(at_DIFF2_fileNames; at_XTRA_relativePaths{$i}+$at_localFiles{$j})
						APPEND TO ARRAY:C911(at_DIFF2_descriptions; "Missing From Remote")
						APPEND TO ARRAY:C911(at_DIFF2_filePaths; $vt_pathToLocalFolder+$at_localFiles{$j})
						APPEND TO ARRAY:C911(at_DIFF2_compareFilePaths; at_XTRA_comparePathsFULL{$i}+$at_localFiles{$j})
						
					Else 
						
						If (Digest_GetForFile($vt_pathToLocalFolder+$at_localFiles{$j})#Digest_GetForFile(at_XTRA_comparePathsFULL{$i}+$at_localFiles{$j}))
							// Get the dates from the local file
							C_DATE:C307($vd_createdDate_SRC; $vd_modDate_SRC)
							C_TIME:C306($vh_createdTime_SRC; $vh_modTime_SRC)
							C_BOOLEAN:C305($vb_isLocked; $vb_isInvisble)
							GET DOCUMENT PROPERTIES:C477($vt_pathToLocalFolder+$at_localFiles{$j}; $vb_isLocked; $vb_isInvisble; $vd_createdDate_SRC; $vh_createdTime_SRC; $vd_modDate_SRC; $vh_modTime_SRC)
							C_LONGINT:C283($vl_created_SRC; $vl_mod_SRC)
							$vl_created_SRC:=TS_FromDateTime($vd_createdDate_SRC; $vh_createdTime_SRC)
							$vl_mod_SRC:=TS_FromDateTime($vd_modDate_SRC; $vh_modTime_SRC)
							
							// Get the dates from the remote file
							C_DATE:C307($vd_createdDate_DST; $vd_modDate_DST)
							C_TIME:C306($vh_createdTime_DST; $vh_modTime_DST)
							GET DOCUMENT PROPERTIES:C477(at_XTRA_comparePathsFULL{$i}+$at_localFiles{$j}; $vb_isLocked; $vb_isInvisble; $vd_createdDate_DST; $vh_createdTime_DST; $vd_modDate_DST; $vh_modTime_DST)
							C_LONGINT:C283($vl_created_DST; $vl_mod_DST)
							$vl_created_DST:=TS_FromDateTime($vd_createdDate_DST; $vh_createdTime_DST)
							$vl_mod_DST:=TS_FromDateTime($vd_modDate_DST; $vh_modTime_DST)
							
							C_BOOLEAN:C305($vb_localIsNewer; $vb_remoteIsNewer)
							$vb_localIsNewer:=False:C215
							$vb_remoteIsNewer:=False:C215
							Case of 
								: ($vl_created_DST<$vl_created_SRC) | ($vl_mod_DST<$vl_mod_SRC)
									$vb_localIsNewer:=True:C214
								: ($vl_created_DST>$vl_created_SRC) | ($vl_mod_DST>$vl_mod_SRC)
									$vb_remoteIsNewer:=True:C214
								Else 
									$vb_localIsNewer:=False:C215
									$vb_remoteIsNewer:=False:C215
							End case 
							
							If ($vb_localIsNewer | $vb_remoteIsNewer)
								APPEND TO ARRAY:C911(at_DIFF2_fileNames; at_XTRA_relativePaths{$i}+$at_localFiles{$j})
								If ($vb_localIsNewer)
									APPEND TO ARRAY:C911(at_DIFF2_descriptions; "Local Newer")
								Else 
									APPEND TO ARRAY:C911(at_DIFF2_descriptions; "Remote Newer")
								End if 
								APPEND TO ARRAY:C911(at_DIFF2_filePaths; $vt_pathToLocalFolder+$at_localFiles{$j})
								APPEND TO ARRAY:C911(at_DIFF2_compareFilePaths; at_XTRA_comparePathsFULL{$i}+$at_localFiles{$j})
							End if 
						End if 
						DELETE FROM ARRAY:C228($at_remoteFiles; $pos; 1)
					End if 
					
					DELETE FROM ARRAY:C228($at_localFiles; $j; 1)
					
				End if 
			End for 
			
			
			// Anything left is missing from the local copy
			For ($j; 1; Size of array:C274($at_remoteFiles))
				If ($at_remoteFiles{$j}#"@.DS_Store")
					APPEND TO ARRAY:C911(at_DIFF2_fileNames; at_XTRA_relativePaths{$i}+$at_remoteFiles{$j})
					APPEND TO ARRAY:C911(at_DIFF2_descriptions; "Missing From Local")
					APPEND TO ARRAY:C911(at_DIFF2_filePaths; "")
					APPEND TO ARRAY:C911(at_DIFF2_compareFilePaths; at_XTRA_comparePathsFULL{$i}+$at_remoteFiles{$j})
				End if 
			End for 
			
		End if 
	End if 
	
End for 

C_TEXT:C284($vt_header)
Case of 
	: (Size of array:C274(at_DIFF2_fileNames)>1)
		$vt_header:=String:C10(Size of array:C274(at_DIFF2_fileNames))+" Files that Differ"
	: (Size of array:C274(at_DIFF2_fileNames)=1)
		$vt_header:="File that Differs"
	Else 
		$vt_header:="Files that Differ"
		
		BEEP:C151
		ALERT:C41("There are no differences")
End case 
OBJECT SET TITLE:C194(*; "DIFF_HdrExtras2"; $vt_header)
