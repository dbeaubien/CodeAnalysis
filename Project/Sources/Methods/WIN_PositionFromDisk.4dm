//%attributes = {"invisible":true}
// WIN_PositionFromDisk
// 
// Description
//   ** MacOS Pre X can only handle file names up to 32 characters **
//   Project method WinPos_FromDisk (windowName;minWIdth; minHeight)
//
#DECLARE($WindowName : Text\
; $minWidth : Integer\
; $minHeight : Integer\
; $modifier : Text)
// ----------------------------------------------------
$WindowName:=Substring:C12($WindowName; 1; 22)  //So it is not too long
$WindowName:="Win_"+$WindowName+".4VR"

var WIN_left_l; WIN_top_l; WIN_right_l; WIN_bottom_l : Integer

If (Test path name:C476(<>SYS_PrefsFolder_t+$WindowName)>0)  // test if file exists
	LOAD VARIABLES:C74(<>SYS_PrefsFolder_t+$WindowName; WIN_left_l; WIN_top_l; WIN_right_l; WIN_bottom_l)
	If ((WIN_bottom_l-WIN_top_l)<$minHeight)
		WIN_bottom_l:=WIN_top_l+$minHeight
	End if 
	If ((WIN_right_l-WIN_left_l)<$minWidth)
		WIN_right_l:=WIN_left_l+$minWidth
	End if 
	If ($modifier#"") & ($modifier#"notOpenYet")
		SET WINDOW RECT:C444(WIN_left_l; WIN_top_l; WIN_right_l; WIN_bottom_l)
	End if 
	
Else 
	If ((WIN_left_l+WIN_top_l+WIN_right_l+WIN_bottom_l)=0)
		WIN_left_l:=0
		WIN_top_l:=20
		WIN_right_l:=WIN_left_l+64
		WIN_bottom_l:=WIN_top_l+64
	End if 
End if 
//