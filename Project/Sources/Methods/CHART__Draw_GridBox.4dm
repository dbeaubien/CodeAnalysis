//%attributes = {"invisible":true}
// CHART__Draw_GridBox
// 
// DESCRIPTION
//   Draws a rectangle and gride at the specified location.
//
#DECLARE($chartID : Text; $vl_gridBoxSize : Integer; $vt_title : Text)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 3; Count parameters:C259))
	var $vl_top; $vl_left; $vl_gridWidth; $vl_gridHeight : Integer
	$vl_top:=0
	$vl_left:=0
	$vl_gridWidth:=OT_GetLong($chartID; "gridWidth")
	$vl_gridHeight:=OT_GetLong($chartID; "gridHeight")
	
	var $vt_svgMasterRef : Text
	$vt_svgMasterRef:=CHART_SVG_GetMasterRef($chartID)
	
	// Create the group that will hold our grid
	var $vt_svgGridRef : Text
	$vt_svgGridRef:=SVG_New_group($vt_svgMasterRef)
	OT_PutText($chartID; "SVG gridRef"; $vt_svgGridRef)
	
	SVG_SET_TRANSFORM_TRANSLATE($vt_svgGridRef; 60; 25)  // move the zero point to the right and down a bit.
	
	var $vl_numRows; $vl_numCols : Integer
	$vl_numRows:=Int:C8($vl_gridHeight/$vl_gridBoxSize)+1
	$vl_numCols:=Int:C8($vl_gridWidth/$vl_gridBoxSize)+1
	
	// Draw the grid background rect
	var $tmpObjRef; $textID : Text
	$tmpObjRef:=SVG_New_rect($vt_svgGridRef; 0; 0; $vl_gridWidth; $vl_gridHeight; 0; 0; "black"; "linen"; 0.1)  // (parentSVGObject; x; y; width; height{; roundedX{; roundedY{; foregroundColor{; backgroundColor{; strokeWidth}}}}})
	
	// Draw the title
	var $x; $y : Integer
	$x:=Int:C8($vl_gridWidth/2)
	$y:=-23
	$vt_svgMasterRef:=CHART_SVG_GetGridRef($chartID)
	$textID:=SVG_New_text($vt_svgMasterRef; $vt_title; $X; $Y; "Arial"; 12; 1; 3; "black")
	
	// Horziontal Grid
	var $pos; $i : Integer
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
	
End if 
