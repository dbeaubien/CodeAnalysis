//%attributes = {"invisible":true}
// ----------------------------------------------------
// User name (OS): jcraig
// Date and time: 01/28/05, 15:21:31
// ----------------------------------------------------
// Method: Util_SaveWindowPosition
// Description
// 
//
// Parameters
// ----------------------------------------------------
//  $1:
//  $2:
// ----------------------------------------------------
//  Returns:
// ----------------------------------------------------
//  History:  `
C_TEXT:C284($1; $ToWhere)
C_TEXT:C284($2; $WIN_vt_layoutName)
//
$ToWhere:=$1
$WIN_vt_layoutName:=$2
//Left, Top, Right, Bottom

//
//# Test if User wants to Save Window position
If (Shift down:C543) | (True:C214)
	C_LONGINT:C283($windowLeft_l; $windowTop_l; $windowRight_l; $windowBottom_l)
	GET WINDOW RECT:C443($windowLeft_l; $windowTop_l; $windowRight_l; $windowBottom_l)
	//
	//GET WINDOW RECT(vWindowLeft;vWindowTop;vWindowRight;vWindowBottom)
	//
	//# Save to Disk
	If ($ToWhere="Disk")
		$WIN_vt_layoutName:=Substring:C12($WIN_vt_layoutName; 1; 22)
		
		SAVE VARIABLES:C75(<>SYS_PrefsFolder_t+"Win_"+$WIN_vt_layoutName+".4VR"; $windowLeft_l; $windowTop_l; $windowRight_l; $windowBottom_l)
		//
		//# Save to user's Preference Record
	Else 
		//
		//GET WINDOW RECT($aWindowRect{1};$aWindowRect{2};$aWindowRect{3};$aWindowRect{4})
		
		//If (OT ItemExists(<>PREF_vL_OT_UserPref;"WindowPosition."+$WIN_vt_layoutName)#0)
		//OT_CreateChild(<>PREF_vL_OT_UserPref;"WindowPosition")
		//End if 
		//OT_LongInt_Put(<>PREF_vL_OT_UserPref;"WindowPosition."+$WIN_vt_layoutName+".Left";$windowLeft_l)
		//OT_LongInt_Put(<>PREF_vL_OT_UserPref;"WindowPosition."+$WIN_vt_layoutName+".Top";$windowTop_l)
		//OT_LongInt_Put(<>PREF_vL_OT_UserPref;"WindowPosition."+$WIN_vt_layoutName+".Right";$windowRight_l)
		//OT_LongInt_Put(<>PREF_vL_OT_UserPref;"WindowPosition."+$WIN_vt_layoutName+".Bottom";$windowBottom_l)
		
	End if 
	
	//
End if 