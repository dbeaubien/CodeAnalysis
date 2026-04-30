//%attributes = {"invisible":true}
// Util_SaveWindowPosition
//
#DECLARE($WIN_vt_layoutName : Text)
// ----------------------------------------------------
// $WIN_vt_layoutName --> Left, Top, Right, Bottom
ASSERT:C1129(Count parameters:C259=1)

var $windowLeft_l; $windowTop_l; $windowRight_l; $windowBottom_l : Integer
GET WINDOW RECT:C443($windowLeft_l; $windowTop_l; $windowRight_l; $windowBottom_l)

$WIN_vt_layoutName:=Substring:C12($WIN_vt_layoutName; 1; 22)

SAVE VARIABLES:C75(<>SYS_PrefsFolder_t+"Win_"+$WIN_vt_layoutName+".4VR"; $windowLeft_l; $windowTop_l; $windowRight_l; $windowBottom_l)
