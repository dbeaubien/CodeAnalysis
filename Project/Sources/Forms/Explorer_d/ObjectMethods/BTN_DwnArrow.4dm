
C_LONGINT:C283($highlightedRow)
$highlightedRow:=selectedMethodPos

C_LONGINT:C283($numRowsInList)
$numRowsInList:=Form:C1466.filteredList.length

If ($highlightedRow<$numRowsInList)
	$highlightedRow:=$highlightedRow+1
	LISTBOX SELECT ROW:C912(*; "methodList"; 0; lk remove from selection:K53:3)
	LISTBOX SELECT ROW:C912(*; "methodList"; $highlightedRow; lk add to selection:K53:2)
	OBJECT SET SCROLL POSITION:C906(*; "methodList"; $highlightedRow)
End if 
