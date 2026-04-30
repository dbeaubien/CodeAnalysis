
CONFIRM:C162("Are you sure you want to clear all the 4D Project Method Comments in your structure?"; Localized string:C991("Btn_Cancel"); Localized string:C991("Btn_ClearAll"))
If (OK=0)
	
	var $progHdl : Integer
	var $vg_icon : Picture
	$progHdl:=Progress New
	
	READ PICTURE FILE:C678(LibraryImage_GetPlatformPath("Progress_Write.png"); $vg_icon)
	Progress SET ICON($progHdl; $vg_icon)
	Progress SET TITLE($progHdl; "Clearing 4D Method Comments..."; -1; ""; True:C214)
	
	
	var $vt_emptyComment : Text
	$vt_emptyComment:=""
	
	ARRAY TEXT:C222($at_methodNames; 0)
	METHOD GET PATHS:C1163(Path project method:K72:1; $at_methodNames; *)
	var $i : Integer
	For ($i; 1; Size of array:C274($at_methodNames))
		METHOD SET COMMENTS:C1193($at_methodNames{$i}; $vt_emptyComment; *)
		Progress SET MESSAGE($progHdl; $at_methodNames{$i})
		Progress SET PROGRESS($progHdl; $i/Size of array:C274($at_methodNames))
	End for 
	
	Progress QUIT($progHdl)
	
End if 
