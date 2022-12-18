//   Mod: DB (02/22/2017) - Export grid
//   Mod by: Dani Beaubien (12/30/2020) - Updatecd to use the Form object

ARRAY TEXT:C222($at_headers; 0)
APPEND TO ARRAY:C911($at_headers; "Method")
APPEND TO ARRAY:C911($at_headers; "Lines of Code")
APPEND TO ARRAY:C911($at_headers; "Lines of Comments")
APPEND TO ARRAY:C911($at_headers; "Lines that are Blank")
APPEND TO ARRAY:C911($at_headers; "Cyclomatic Complexity")
APPEND TO ARRAY:C911($at_headers; "Max Nesting Level")
APPEND TO ARRAY:C911($at_headers; "Called by Methods")
APPEND TO ARRAY:C911($at_headers; "Last Saved")

C_TEXT:C284($vt_fileName)
$vt_fileName:="Analysis Results"
$vt_fileName:=$vt_fileName+Date2String(Current date:C33; " YYYY-MM-DD")
$vt_fileName:=$vt_fileName+Time2String(Current time:C178; " 24hh.mm.ss")
$vt_fileName:=$vt_fileName+".csv"

C_TEXT:C284($vt_filePath)
$vt_filePath:=CodeAnalysis__GetDestFolder+$vt_fileName

// Setup temp arrays
ARRAY TEXT:C222($at_method; 0)
ARRAY LONGINT:C221($al_CodeLns; 0)
ARRAY LONGINT:C221($al_CmntLns; 0)
ARRAY LONGINT:C221($al_BlnkLns; 0)
ARRAY LONGINT:C221($al_CC; 0)
ARRAY LONGINT:C221($al_maxNest; 0)
ARRAY LONGINT:C221($al_Called; 0)
ARRAY TEXT:C222($at_DTS; 0)

C_OBJECT:C1216($row)
For each ($row; Form:C1466.filteredList)
	APPEND TO ARRAY:C911($at_method; $row.name)
	APPEND TO ARRAY:C911($al_CodeLns; $row.numCodeLines)
	APPEND TO ARRAY:C911($al_CmntLns; $row.numCommentLines)
	APPEND TO ARRAY:C911($al_BlnkLns; $row.numBlankLines)
	APPEND TO ARRAY:C911($al_CC; $row.codeComplexity)
	APPEND TO ARRAY:C911($al_maxNest; $row.nestedLevels)
	APPEND TO ARRAY:C911($al_Called; $row.numTimesCalled)
	APPEND TO ARRAY:C911($at_DTS; $row.lastSavedStr)
End for each 

File_Delete($vt_filePath)
File_ExportArrays2CSV($vt_filePath; ->$at_headers; ->$at_method; ->$al_CodeLns; ->$al_CmntLns; ->$al_BlnkLns; ->$al_CC; ->$al_maxNest; ->$al_Called; ->$at_DTS)

CONFIRM:C162("Filtered results saved to \""+$vt_fileName+"\" in the default folder."; "OK"; "Show on Disk")
If (OK=0)
	SHOW ON DISK:C922($vt_filePath)
End if 