//%attributes = {"invisible":true}
// File_isDifferent (file1, file2) : isDifferent
// File_isDifferent (text, text) : boolean
//
// DESCRIPTION
//   Returns true if the two files differ.
//
C_TEXT:C284($1; $filePath_SRC)
C_TEXT:C284($2; $filePath_DST)
C_BOOLEAN:C305($0; $filesAreDifferent)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (07/16/2017)
// ----------------------------------------------------

$filesAreDifferent:=False:C215  // assumption is that they are the same
If (Asserted:C1132(Count parameters:C259=2))
	$filePath_SRC:=$1
	$filePath_DST:=$2
	
	If (File_DoesExist($filePath_SRC) & File_DoesExist($filePath_DST))
		C_BOOLEAN:C305($vb_isLocked; $vb_isInvisble)
		C_DATE:C307($createdDate; $modDate)
		C_TIME:C306($createdTime; $modTime)
		
		C_TEXT:C284($fileCompareStr_SRC)
		GET DOCUMENT PROPERTIES:C477($filePath_SRC; $vb_isLocked; $vb_isInvisble; $createdDate; $createdTime; $modDate; $modTime)
		$fileCompareStr_SRC:=String:C10(TS_FromDateTime($createdDate; $createdTime))
		$fileCompareStr_SRC:=$fileCompareStr_SRC+"."+String:C10(TS_FromDateTime($modDate; $modTime))
		$fileCompareStr_SRC:=$fileCompareStr_SRC+"."+String:C10(Num:C11($vb_isLocked))+"."+String:C10(Num:C11($vb_isInvisble))
		
		C_TEXT:C284($fileCompareStr_DST)
		GET DOCUMENT PROPERTIES:C477($filePath_DST; $vb_isLocked; $vb_isInvisble; $createdDate; $createdTime; $modDate; $modTime)
		$fileCompareStr_DST:=String:C10(TS_FromDateTime($createdDate; $createdTime))
		$fileCompareStr_DST:=$fileCompareStr_DST+"."+String:C10(TS_FromDateTime($modDate; $modTime))
		$fileCompareStr_DST:=$fileCompareStr_DST+"."+String:C10(Num:C11($vb_isLocked))+"."+String:C10(Num:C11($vb_isInvisble))
		
		If ($fileCompareStr_SRC#$fileCompareStr_DST)
			If (Not:C34($filesAreDifferent))
				If (Get document size:C479($filePath_SRC)#Get document size:C479($filePath_DST))
					$filesAreDifferent:=True:C214
				End if 
			End if 
			
			If (Not:C34($filesAreDifferent))
				If (Digest_GetForFile($filePath_SRC)#Digest_GetForFile($filePath_DST))
					$filesAreDifferent:=True:C214
				End if 
			End if 
		End if 
		
	Else 
		$filesAreDifferent:=True:C214
	End if 
	
End if 
$0:=$filesAreDifferent