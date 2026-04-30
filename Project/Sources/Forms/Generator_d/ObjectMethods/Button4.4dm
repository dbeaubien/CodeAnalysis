
CONFIRM:C162("Are you sure you want to update all the 4D Project Method Comments in your structure based on the first block of comments in each method?"; Localized string:C991("Btn_Cancel"); Localized string:C991("Btn_UpdateFromMethod"))
If (OK=0)
	MethodStats_RecalculateModified
	
	var $progHdl : Integer
	var $vg_icon : Picture
	$progHdl:=Progress New
	
	READ PICTURE FILE:C678(LibraryImage_GetPlatformPath("Progress_Write.png"); $vg_icon)
	Progress SET ICON($progHdl; $vg_icon)
	Progress SET TITLE($progHdl; "Updating 4D Method Comments..."; -1; ""; True:C214)
	
	ARRAY TEXT:C222($projectMethodPathsArr; 0)
	METHOD GET PATHS:C1163(Path project method:K72:1; $projectMethodPathsArr; *)
	
	var $i : Integer
	var $methodComment : Text
	For ($i; 1; Size of array:C274($projectMethodPathsArr))
		$methodComment:=MethodStatsMasterObj.documentation
		$methodComment:=Replace string:C233($methodComment; "//"; "")
		METHOD SET COMMENTS:C1193($projectMethodPathsArr{$i}; $methodComment; *)
		
		If (Mod:C98($i; 51)=1)
			Progress SET MESSAGE($progHdl; $projectMethodPathsArr{$i})
			Progress SET PROGRESS($progHdl; $i/Size of array:C274($projectMethodPathsArr))
		End if 
	End for 
	
	Progress QUIT($progHdl)
	
End if 
