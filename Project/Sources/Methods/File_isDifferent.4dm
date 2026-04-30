//%attributes = {"invisible":true}
// File_isDifferent (file1, file2) : isDifferent
//
// DESCRIPTION
//   Returns true if the two files differ.
//
#DECLARE($filePath_SRC : Text; $filePath_DST : Text)->$filesAreDifferent : Boolean
// ----------------------------------------------------

$filesAreDifferent:=False:C215  // assumption is that they are the same
If (Asserted:C1132(Count parameters:C259=2))
	
	If (File_DoesExist($filePath_SRC) & File_DoesExist($filePath_DST))
		var $vb_isLocked; $vb_isInvisble : Boolean
		var $createdDate; $modDate : Date
		var $createdTime; $modTime : Time
		
		var $fileCompareStr_SRC : Text
		GET DOCUMENT PROPERTIES:C477($filePath_SRC; $vb_isLocked; $vb_isInvisble; $createdDate; $createdTime; $modDate; $modTime)
		$fileCompareStr_SRC:=String:C10(TS_FromDateTime($createdDate; $createdTime))
		$fileCompareStr_SRC:=$fileCompareStr_SRC+"."+String:C10(TS_FromDateTime($modDate; $modTime))
		$fileCompareStr_SRC:=$fileCompareStr_SRC+"."+String:C10(Num:C11($vb_isLocked))+"."+String:C10(Num:C11($vb_isInvisble))
		
		var $fileCompareStr_DST : Text
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
