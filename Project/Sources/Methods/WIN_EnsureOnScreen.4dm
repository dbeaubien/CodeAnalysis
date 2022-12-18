//%attributes = {"invisible":true}
// ----------------------------------------------------
// METHOD: WIN_EnsureOnScreen
// 
// DESCRIPTION:
//   This method checks to make sure that the frontmost window
//   is on screen and is not under the menu bar.
// ----------------------------------------------------
// PARAMETERS:
//   $1: window to check
// RETURNS:
//   none
// ----------------------------------------------------
// CALLED BY:
// 
// ----------------------------------------------------
// MODIFICATION HISTORY:
// Added by: jcraig (1/28/05) - 
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	C_LONGINT:C283($1; $WIN_vl_winRef)
	$WIN_vl_winRef:=$1
	
	C_BOOLEAN:C305($WIN_vl_isOnScreen)  // true if we are on screen
	C_LONGINT:C283($WIN_vl_offsetX; $WIN_vl_offsetY)
	C_LONGINT:C283($WIN_vl_left; $WIN_vl_top; $WIN_vl_right; $WIN_vl_bottom)
	C_LONGINT:C283($WIN_vl_screenLeft; $WIN_vl_screenTop; $WIN_vl_screenRight; $WIN_vl_screenBottom)
	C_LONGINT:C283($WIN_vl_screenNo)
	
	//
	$WIN_vl_isOnScreen:=False:C215
	//
	GET WINDOW RECT:C443($WIN_vl_left; $WIN_vl_top; $WIN_vl_right; $WIN_vl_bottom; $WIN_vl_winRef)
	
	
	//# loop through all the screens and see if the window is on one of them.
	
	For ($WIN_vl_screenNo; 1; Count screens:C437)
		//# get the coordinates of our screens
		SCREEN COORDINATES:C438($WIN_vl_screenLeft; $WIN_vl_screenTop; $WIN_vl_screenRight; $WIN_vl_screenBottom; $WIN_vl_screenNo)
		If ($WIN_vl_screenNo=Menu bar screen:C441)
			$WIN_vl_screenTop:=$WIN_vl_screenTop+(Menu bar height:C440+10)  // there is the window title to deal with as well
		End if 
		
		//# now lets figure out if we are in a screen
		If ($WIN_vl_left>=$WIN_vl_screenLeft) & ($WIN_vl_right<=$WIN_vl_screenRight)
			If ($WIN_vl_top>=$WIN_vl_screenTop) & ($WIN_vl_bottom<=$WIN_vl_screenBottom)
				$WIN_vl_isOnScreen:=True:C214
			End if 
		End if 
		
	End for 
	
	//# if it is not on screen, then move it
	If (Not:C34($WIN_vl_isOnScreen))
		SCREEN COORDINATES:C438($WIN_vl_screenLeft; $WIN_vl_screenTop; $WIN_vl_screenRight; $WIN_vl_screenBottom; Menu bar screen:C441)
		$WIN_vl_screenTop:=$WIN_vl_screenTop+Menu bar height:C440
		$WIN_vl_offsetX:=$WIN_vl_screenLeft-$WIN_vl_left+10
		$WIN_vl_offsetY:=$WIN_vl_screenTop-$WIN_vl_top+30
		
		$WIN_vl_left:=$WIN_vl_left+$WIN_vl_offsetX
		$WIN_vl_right:=$WIN_vl_right+$WIN_vl_offsetX
		$WIN_vl_top:=$WIN_vl_top+$WIN_vl_offsetY
		$WIN_vl_bottom:=$WIN_vl_bottom+$WIN_vl_offsetY
		
		If ($WIN_vl_bottom>$WIN_vl_screenBottom)
			$WIN_vl_bottom:=$WIN_vl_screenBottom-10
		End if 
		
		If ($WIN_vl_right>$WIN_vl_screenRight)
			$WIN_vl_right:=$WIN_vl_screenRight-10
		End if 
		
		SET WINDOW RECT:C444($WIN_vl_left; $WIN_vl_top; $WIN_vl_right; $WIN_vl_bottom; $WIN_vl_winRef)
	End if 
	//
End if   // ASSERT

