//%attributes = {"invisible":true}
// ----------------------------------------------------
// METHOD: WIN_PositionHasBeenSaved
// 
// DESCRIPTION:
//   Returns true if the passed layout name has size parameters
//   stored on the local computer.
//
C_TEXT:C284($1; $WIN_vt_layoutName)  //   $1: layout name
C_TEXT:C284($2; $vT_ToWhere)  //   $2: "Disk";"UserPrefs"
C_BOOLEAN:C305($0; $WIN_vf_doesExist)
// ----------------------------------------------------
// MODIFICATION HISTORY:
// Added by: jcraig (1/28/05) - 
// ----------------------------------------------------

C_LONGINT:C283($vL_Exists)
$WIN_vf_doesExist:=False:C215

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	
	$WIN_vt_layoutName:=$1
	$vT_ToWhere:=$2
	Case of 
		: (Macintosh option down:C545) | (Windows Alt down:C563)
			$WIN_vf_doesExist:=False:C215
			
		: ($vT_ToWhere="Disk")
			$WIN_vt_layoutName:=Substring:C12($WIN_vt_layoutName; 1; 22)  //So it is not too long
			$WIN_vt_layoutName:="Win_"+$WIN_vt_layoutName+".4VR"
			//
			$vL_Exists:=Test path name:C476(<>SYS_PrefsFolder_t+$WIN_vt_layoutName)
			If ($vL_Exists=Is a document:K24:1)
				$WIN_vf_doesExist:=True:C214
			End if 
			
		: ($vT_ToWhere="UserPrefs")
			//If (OT ItemExists(<>PREF_vL_OT_UserPref;"WindowPosition."+$WIN_vt_layoutName)#0)
			//vWindowLeft:=OT_GetLong(<>PREF_vL_OT_UserPref;"WindowPosition."+$WIN_vt_layoutName+".Left")
			//vWindowTop:=OT_GetLong(<>PREF_vL_OT_UserPref;"WindowPosition."+$WIN_vt_layoutName+".Top")
			//vWindowRight:=OT_GetLong(<>PREF_vL_OT_UserPref;"WindowPosition."+$WIN_vt_layoutName+".Right")
			//vWindowBottom:=OT_GetLong(<>PREF_vL_OT_UserPref;"WindowPosition."+$WIN_vt_layoutName+".Bottom")
			//
			//$WIN_vf_doesExist:=True
			//End if 
			
	End case 
End if   // ASSERT

$0:=$WIN_vf_doesExist