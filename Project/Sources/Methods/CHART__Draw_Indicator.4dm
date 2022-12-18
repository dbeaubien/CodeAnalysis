//%attributes = {"invisible":true}
// CHART__Draw_Indicator (SVGref; xCenterPos; yCenterPos; type; width; colour)
// CHART__Draw_Indicator (text; longint; longint; text; longint; text)
// 
// DESCRIPTION
//   Draws the indicator at the point specified.
//
// PARAMETERS:
C_TEXT:C284($1; $vt_svgRef)
C_LONGINT:C283($2; $vl_xCenterPos)
C_LONGINT:C283($3; $vl_yCenterPos)
C_TEXT:C284($4; $vt_indicatorShape)
C_LONGINT:C283($5; $vl_width)
C_TEXT:C284($6; $vt_lineColour)
// RETURNS:
//   none
// ----------------------------------------------------
// CALLED BY
//   
// ----------------------------------------------------
// HISTORY
//   Created by: DB (06/07/11)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 6; Count parameters:C259))
	$vt_svgRef:=$1
	$vl_xCenterPos:=$2
	$vl_yCenterPos:=$3
	$vt_indicatorShape:=$4
	$vl_width:=$5
	$vt_lineColour:=$6
	
	C_TEXT:C284($tmpObjRef)
	Case of 
		: ($vt_indicatorShape="circle")
			$tmpObjRef:=SVG_New_circle($vt_svgRef; $vl_xCenterPos; $vl_yCenterPos; $vl_width; $vt_lineColour; "white"; 1)  // linewidth of 1
			
			
		: ($vt_indicatorShape="square")
			C_LONGINT:C283($vl_left; $vl_top; $vl_height)
			$vl_left:=$vl_xCenterPos-Int:C8($vl_width/2)
			$vl_top:=$vl_yCenterPos-Int:C8($vl_width/2)
			$vl_height:=$vl_width
			$tmpObjRef:=SVG_New_rect($vt_svgRef; $vl_left; $vl_top; $vl_width; $vl_height; 0; 0; $vt_lineColour; "white"; 1)
			
			
		: ($vt_indicatorShape="triangle")
			ARRAY LONGINT:C221($tX; 4)
			ARRAY LONGINT:C221($tY; 4)
			$tX{1}:=$vl_xCenterPos-Int:C8($vl_width/2)
			$tY{1}:=$vl_yCenterPos+Int:C8($vl_width/2)
			
			$tX{2}:=$vl_xCenterPos
			$tY{2}:=$vl_yCenterPos-Int:C8($vl_width/2)
			
			$tX{3}:=$vl_xCenterPos+Int:C8($vl_width/2)
			$tY{3}:=$vl_yCenterPos+Int:C8($vl_width/2)
			
			$tX{4}:=$tX{1}
			$tY{4}:=$tY{1}
			
			$tmpObjRef:=SVG_New_polyline_by_arrays($vt_svgRef; ->$tX; ->$tY; $vt_lineColour; "white"; 1)  //  (parentSVGObject; xArrayPointer; yArrayPointer{; foregroundColor{; backgroundColor{; strokeWidth}}})
			
		Else 
			// NOP
	End case 
End if 