
If (FORM Get current page:C276=1)  // on DIFF tab
	C_LONGINT:C283($selectedRow)
	$selectedRow:=currentSelectedDiffMethod-1
	If ($selectedRow<=0)
		$selectedRow:=Form:C1466.methodsWithDifference.length
	End if 
	
	If ($selectedRow>0)
		LISTBOX SELECT ROW:C912(*; "ListBox_diffs"; 0; lk remove from selection:K53:3)
		LISTBOX SELECT ROW:C912(*; "ListBox_diffs"; $selectedRow; lk add to selection:K53:2)
		OBJECT SET SCROLL POSITION:C906(*; "ListBox_diffs"; $selectedRow)
	End if 
End if 

