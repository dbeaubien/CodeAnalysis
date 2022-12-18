



If (FORM Get current page:C276=1)  // on DIFF tab
	C_LONGINT:C283($selectedRow)
	$selectedRow:=currentSelectedDiffMethod
	
	
	C_LONGINT:C283($rowHeight)
	$rowHeight:=LISTBOX Get rows height:C836(*; "ListBox_diffs"; lk pixels:K53:22)
	
	C_LONGINT:C283($left; $top; $right; $bottom; $ListBoxheight)
	OBJECT GET COORDINATES:C663(*; "ListBox_diffs"; $left; $top; $right; $bottom)
	$ListBoxheight:=$bottom-$top
	$ListBoxheight:=$ListBoxheight-LISTBOX Get property:C917(*; "ListBox_diffs"; _o_lk header height:K53:5)
	$ListBoxheight:=$ListBoxheight-LISTBOX Get property:C917(*; "ListBox_diffs"; _o_lk footer height:K53:21)
	
	C_LONGINT:C283($rowsShown)
	$rowsShown:=Int:C8($ListBoxheight/$rowHeight)
	
	C_LONGINT:C283($numRowsAbove)
	$numRowsAbove:=(LISTBOX Get property:C917(*; "ListBox_diffs"; _o_lk ver scrollbar position:K53:11)/$rowHeight)
	
	C_LONGINT:C283($rowAtTopOfScreen)
	$rowAtTopOfScreen:=$numRowsAbove+1
	
	LISTBOX SELECT ROW:C912(*; "ListBox_diffs"; 0; lk remove from selection:K53:3)
	If ($rowAtTopOfScreen=$selectedRow) | (($rowAtTopOfScreen+1)=$selectedRow)
		$selectedRow:=$rowAtTopOfScreen-$rowsShown+1
	Else 
		$selectedRow:=$rowAtTopOfScreen
	End if 
	If ($selectedRow<1)
		$selectedRow:=1
	End if 
	
	LISTBOX SELECT ROW:C912(*; "ListBox_diffs"; $selectedRow; lk add to selection:K53:2)
	OBJECT SET SCROLL POSITION:C906(*; "ListBox_diffs"; $selectedRow)
End if 