

If (FORM Get current page:C276=1)  // on DIFF tab
	var $selectedRow : Integer
	$selectedRow:=currentSelectedDiffMethod
	
	If ($selectedRow<Form:C1466.methodsWithDifference.length)
		var $vl_rowHeight : Integer
		$vl_rowHeight:=LISTBOX Get rows height:C836(*; "ListBox_diffs"; lk pixels:K53:22)
		
		var $vl_left; $vl_top; $vl_right; $vl_bottom; $vl_ListBoxheight : Integer
		OBJECT GET COORDINATES:C663(*; "ListBox_diffs"; $vl_left; $vl_top; $vl_right; $vl_bottom)
		$vl_ListBoxheight:=$vl_bottom-$vl_top
		$vl_ListBoxheight:=$vl_ListBoxheight-LISTBOX Get headers height:C1144(*; "ListBox_diffs"; lk pixels:K53:22)
		$vl_ListBoxheight:=$vl_ListBoxheight-LISTBOX Get footers height:C1146(*; "ListBox_diffs"; lk pixels:K53:22)
		
		var $vl_rowsShown : Integer
		$vl_rowsShown:=Int:C8($vl_ListBoxheight/$vl_rowHeight)
		
		var $vl_numRowsAbove; $scroll_position : Integer
		OBJECT GET SCROLL POSITION:C1114(*; "ListBox_diffs"; $scroll_position)
		$vl_numRowsAbove:=($scroll_position/$vl_rowHeight)
		
		var $vl_rowAtTopOfScreen : Integer
		$vl_rowAtTopOfScreen:=$vl_numRowsAbove+1
		
		var $vl_rowAtBottomOfScreen : Integer
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