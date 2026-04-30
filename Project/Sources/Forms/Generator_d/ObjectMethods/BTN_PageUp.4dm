



If (FORM Get current page:C276=1)  // on DIFF tab
	var $selectedRow : Integer
	$selectedRow:=currentSelectedDiffMethod
	
	
	var $rowHeight : Integer
	$rowHeight:=LISTBOX Get rows height:C836(*; "ListBox_diffs"; lk pixels:K53:22)
	
	var $left; $top; $right; $bottom; $ListBoxheight : Integer
	OBJECT GET COORDINATES:C663(*; "ListBox_diffs"; $left; $top; $right; $bottom)
	$ListBoxheight:=$bottom-$top
	$ListBoxheight:=$ListBoxheight-LISTBOX Get headers height:C1144(*; "ListBox_diffs"; lk pixels:K53:22)
	$ListBoxheight:=$ListBoxheight-LISTBOX Get headers height:C1144(*; "ListBox_diffs"; lk pixels:K53:22)
	
	var $rowsShown : Integer
	$rowsShown:=Int:C8($ListBoxheight/$rowHeight)
	
	var $numRowsAbove; $scroll_position : Integer
	OBJECT GET SCROLL POSITION:C1114(*; "ListBox_diffs"; $scroll_position)
	$numRowsAbove:=($scroll_position/$rowHeight)
	
	var $rowAtTopOfScreen : Integer
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