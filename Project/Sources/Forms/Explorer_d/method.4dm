
// GOAL - Explorer window opens faster
// GOAL - Support multiple Explorer windows open at a time
// GOAL - Each explorer window can have it's own view configuration
// GOAL - Refresh automatically

C_BOOLEAN:C305($refreshFooter)
Case of 
		
	: (Form event code:C388=On Load:K2:1)
		Form:C1466.controller:=cs:C1710.form_Explorer.new(Form:C1466)
		Form:C1466.controller.FilterTableList("")
		Form:C1466.controller.FilterFieldList("")
		
		Form:C1466.currentTab:=1
		
		C_OBJECT:C1216(selectedMethodObj)
		C_LONGINT:C283(selectedMethodPos)
		
		Component_SetMenuBar
		MethodStats__Init  // Prep the vars
		MethodStats__UpstreamMethodRefs
		
		Explorer_UpdateMethodInfo(Form:C1466)
		Explorer_ApplyMethodFilter(Form:C1466)
		
		$refreshFooter:=True:C214
		
		// Reset the last mod day count
		Pref_SetPrefString("EXPLORE LastMod DayCount"; "0")
		Use (Storage:C1525.explorerWindow)
			Storage:C1525.explorerWindow.windowRef:=Current form window:C827
		End use 
		Form:C1466.controller.FocusOnSearchFieldOnPageNo(1)
		
		
	: (Form event code:C388=On Activate:K2:9)
		$refreshFooter:=True:C214
		Component_SetMenuBar
		Form:C1466.controller.FocusOnSearchFieldOnPageNo(FORM Get current page:C276)
		
		
	: (Form event code:C388=On Timer:K2:25)
		Form:C1466.controller.FocusOnSearchFieldOnPageNo(FORM Get current page:C276)
		SET TIMER:C645(0)  // clear timer
		
		
	: (Form event code:C388=On Outside Call:K2:11)
		MethodStats__Init  // Prep the vars 
		Explorer_UpdateMethodInfo(Form:C1466)
		Explorer_ApplyMethodFilter(Form:C1466)
		REDRAW WINDOW:C456
		
End case 

If ($refreshFooter) & (Form:C1466.filteredList#Null:C1517)
	C_REAL:C285($footerTotal2; $footerTotal3; $footerTotal4; $footerTotal5; $footerTotal6; $footerTotal7)
	$footerTotal2:=0
	$footerTotal3:=0
	$footerTotal4:=0
	$footerTotal5:=0
	$footerTotal6:=0
	$footerTotal7:=0
	
	C_OBJECT:C1216($methodDetails)
	For each ($methodDetails; Form:C1466.filteredList)
		$footerTotal2:=$footerTotal2+$methodDetails.numCodeLines
		$footerTotal3:=$footerTotal3+$methodDetails.numCommentLines
		$footerTotal4:=$footerTotal4+$methodDetails.numBlankLines
		$footerTotal5:=$footerTotal5+$methodDetails.codeComplexity
		$footerTotal6:=$footerTotal6+$methodDetails.nestedLevels
		$footerTotal7:=$footerTotal7+$methodDetails.numTimesCalled
	End for each 
	C_TEXT:C284(ftrText1; ftrText2; ftrText3; ftrText4; ftrText5; ftrText6; ftrText7; ftrText8)
	If (Form:C1466.filteredList.length>0)
		ftrText1:="Average"
		ftrText2:=String:C10($footerTotal2/Form:C1466.filteredList.length; "#####0.0")
		ftrText3:=String:C10($footerTotal3/Form:C1466.filteredList.length; "#####0.0")
		ftrText4:=String:C10($footerTotal4/Form:C1466.filteredList.length; "#####0.0")
		ftrText5:=String:C10($footerTotal5/Form:C1466.filteredList.length; "#####0.0")
		ftrText6:=String:C10($footerTotal6/Form:C1466.filteredList.length; "#####0.0")
		ftrText7:=String:C10($footerTotal7/Form:C1466.filteredList.length; "#####0.0")
	Else 
		ftrText1:=""
		ftrText2:=""
		ftrText3:=""
		ftrText4:=""
		ftrText5:=""
		ftrText6:=""
		ftrText7:=""
	End if 
	ftrText8:=""
End if 