

If (FORM Get current page:C276=1)  // on DIFF tab
	C_LONGINT:C283($selectedRow)
	$selectedRow:=currentSelectedDiffMethod
	
	If ($selectedRow<Form:C1466.methodsWithDifference.length)
		C_LONGINT:C283($vl_rowHeight)
		$vl_rowHeight:=LISTBOX Get rows height:C836(*; "ListBox_diffs"; lk pixels:K53:22)
		
		C_LONGINT:C283($vl_left; $vl_top; $vl_right; $vl_bottom; $vl_ListBoxheight)
		OBJECT GET COORDINATES:C663(*; "ListBox_diffs"; $vl_left; $vl_top; $vl_right; $vl_bottom)
		$vl_ListBoxheight:=$vl_bottom-$vl_top
		$vl_ListBoxheight:=$vl_ListBoxheight-LISTBOX Get property:C917(*; "ListBox_diffs"; _o_lk header height:K53:5)
		$vl_ListBoxheight:=$vl_ListBoxheight-LISTBOX Get property:C917(*; "ListBox_diffs"; _o_lk footer height:K53:21)
		
		C_LONGINT:C283($vl_rowsShown)
		$vl_rowsShown:=Int:C8($vl_ListBoxheight/$vl_rowHeight)
		
		C_LONGINT:C283($vl_numRowsAbove)
		$vl_numRowsAbove:=(LISTBOX Get property:C917(*; "ListBox_diffs"; _o_lk ver scrollbar position:K53:11)/$vl_rowHeight)
		
		C_LONGINT:C283($vl_rowAtTopOfScreen)
		$vl_rowAtTopOfScreen:=$vl_numRowsAbove+1
		
		C_LONGINT:C283($vl_rowAtBottomOfScreen)
		$vl_rowAtBottomOfScreen:=$vl_rowAtTopOfScreen+$vl_rowsShown
		
		LISTBOX SELECT ROW:C912(*; "ListBox_diffs"; 0; lk remove from selection:K53:3)
		If ($vl_rowAtBottomOfScreen=$selectedRow) | (($vl_rowAtBottomOfScreen-1)=$selectedRow)
			$selectedRow:=$vl_rowAtBottomOfScreen+$vl_rowsShown-1
		Else 
			$selectedRow:=$vl_rowAtBottomOfScreen
		End if 
		If ($selectedRow>Form:C1466.methodsWithDifference.length)
			$selectedRow:=Form:C1466.methodsWithDifference.length
		End if 
		
		LISTBOX SELECT ROW:C912(*; "ListBox_diffs"; $selectedRow; lk add to selection:K53:2)
		OBJECT SET SCROLL POSITION:C906(*; "ListBox_diffs"; $selectedRow)
		
	Else 
		//BEEP
	End if 
End if 