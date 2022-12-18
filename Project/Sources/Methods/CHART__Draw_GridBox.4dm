//%attributes = {"invisible":true}
// ----------------------------------------------------
// METHOD: CHART__Draw_GridBox
// 
// DESCRIPTION
//   Draws a rectangle and gride at the specified location.
//
// PARAMETERS:
C_TEXT:C284($1; $chartID)
C_LONGINT:C283($2; $vl_gridBoxSize)
C_TEXT:C284($3; $vt_title)
//
// RETURNS:
//   none
// ----------------------------------------------------
// CALLED BY
//   CHART_CreateNewGraph 
// ----------------------------------------------------
// HISTORY
//   Created by: DB (03/21/11)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 3; Count parameters:C259))
	$chartID:=$1
	$vl_gridBoxSize:=$2
	$vt_title:=$3
	
	C_LONGINT:C283($vl_top; $vl_left; $vl_gridWidth; $vl_gridHeight)
	$vl_top:=0
	$vl_left:=0
	$vl_gridWidth:=OT_GetLong($chartID; "gridWidth")
	$vl_gridHeight:=OT_GetLong($chartID; "gridHeight")
	
	C_TEXT:C284($vt_svgMasterRef)
	$vt_svgMasterRef:=CHART_SVG_GetMasterRef($chartID)
	
	// Create the group that will hold our grid
	C_TEXT:C284($vt_svgGridRef)
	$vt_svgGridRef:=SVG_New_group($vt_svgMasterRef)
	OT_PutText($chartID; "SVG gridRef"; $vt_svgGridRef)
	
	SVG_SET_TRANSFORM_TRANSLATE($vt_svgGridRef; 60; 25)  // move the zero point to the right and down a bit.
	
	C_LONGINT:C283($vl_numRows; $vl_numCols)
	$vl_numRows:=Int:C8($vl_gridHeight/$vl_gridBoxSize)+1
	$vl_numCols:=Int:C8($vl_gridWidth/$vl_gridBoxSize)+1
	
	// Draw the grid background rect
	C_TEXT:C284($tmpObjRef; $textID)
	$tmpObjRef:=SVG_New_rect($vt_svgGridRef; 0; 0; $vl_gridWidth; $vl_gridHeight; 0; 0; "black"; "linen"; 0.1)  // (parentSVGObject; x; y; width; height{; roundedX{; roundedY{; foregroundColor{; backgroundColor{; strokeWidth}}}}})
	
	// Draw the title
	C_LONGINT:C283($x; $y)
	$x:=Int:C8($vl_gridWidth/2)
	$y:=-23
	C_TEXT:C284($vt_svgMasterRef)
	$vt_svgMasterRef:=CHART_SVG_GetGridRef($chartID)
	$textID:=SVG_New_text($vt_svgMasterRef; $vt_title; $X; $Y; "Arial"; 12; 1; 3; "black")
	
	// Horziontal Grid
	C_LONGINT:C283($pos; $i)
	$pos:=$vl_gridBoxSize
	For ($i; 1; ($vl_numRows-1))
		$tmpObjRef:=SVG_New_line($vt_svgGridRef; 1; $pos; $vl_gridWidth-1; $pos; "lightgray"; 1)  // (parentSVGObject; startX; startY; endX; endY{; color{; strokeWidth}})
		$pos:=$pos+$vl_gridBoxSize
	End for 
	
	// Vertical Grid
	$pos:=$vl_gridBoxSize
	For ($i; 1; ($vl_numCols-1))
		$tmpObjRef:=SVG_New_line($vt_svgGridRef; $pos; 1; $pos; $vl_gridHeight-1; "lightgray"; 1)  // (parentSVGObject; startX; startY; endX; endY{; color{; strokeWidth}})
		$pos:=$pos+$vl_gridBoxSize
	End for 
	
End if   // ASSERT
