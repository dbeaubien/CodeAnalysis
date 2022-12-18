//%attributes = {"invisible":true}
// STR_TrimExcessSpaces
// 
// DESCRIPTION
//   Removes any beginning / trailing spaces from the string
//   Need to take care not to remove any spaces that are "inside" the string
//
// PARAMETERS:
C_TEXT:C284($1; $vt_srcTxt)
//
// RETURNS:
C_TEXT:C284($0)
// ----------------------------------------------------
// CALLED BY
//   
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien & GJ Algot, 09/04/98
// ----------------------------------------------------

$vt_srcTxt:=""
If (1=Count parameters:C259)
	$vt_srcTxt:=STR_Remove_Leading_Spaces($1)
	$vt_srcTxt:=STR_Remove_Trailing_Spaces($vt_srcTxt)
End if   // ASSERT
$0:=$vt_srcTxt