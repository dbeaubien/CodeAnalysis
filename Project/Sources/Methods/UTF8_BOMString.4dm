//%attributes = {"invisible":true}
// UTF8_BOMString (folderDestination)
//
// DESCRIPTION
//   Returns the BOM string for UTF8.
//
C_BLOB:C604($0)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (07/05/2013)
// ----------------------------------------------------

// This is the UTF-8 Byte Order Mark (BOM).  It will be inserted into the
// saved method to ensure the file is recognized as UTF-8.
SET BLOB SIZE:C606($bom_b; 3)
$bom_b{0}:=239  // EF (UTF-8)
$bom_b{1}:=187  // BB (UTF-8)
$bom_b{2}:=191  // BF (UTF-8)

$0:=$bom_b