//%attributes = {"invisible":true}
// CHART_Draw ( charID )
// CHART_Draw ( longint )
// 
// DESCRIPTION
//   Performs all the SVG calls to define the SVG
//   graphic.
//
C_TEXT:C284($1; $chartID)
// ----------------------------------------------------
// CALLED BY
//   
// ----------------------------------------------------
// HISTORY
//   Created by: DB (03/23/11)
//   Mod: DB (08/08/2012) - Add support for area lines
//   Mod by: Dani Beaubien (09/01/2013) - Addressed an issue if there was only one day
//   Mod: DB (12/06/2013) - 2278 - Support y-axis ranges and increments
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$chartID:=$1
	
	//LOG_INFO ("   a1")
	
	// Get the size of the "grid"
	C_LONGINT:C283($vl_gridWidth; $vl_gridHeight)
	$vl_gridWidth:=OT_GetLong($chartID; "gridWidth")
	$vl_gridHeight:=OT_GetLong($chartID; "gridHeight")
	
	C_LONGINT:C283($vl_numLines; $i; $vl_lineNo; $vl_numItems; $pos)
	$vl_numLines:=OT_GetLong($chartID; "dataLines Count")
	
	C_LONGINT:C283($vl_xAxisDataType)
	$vl_xAxisDataType:=OT_GetLong($chartID; "horzAxisDataType")
	
	// Figure out the min and max values across all lines
	C_TEXT:C284($vt_graphType)
	C_DATE:C307($vd_minDate; $vd_maxDate)
	C_LONGINT:C283($vl_minNumber; $vl_maxNumber)
	C_REAL:C285($vr_min; $vr_max)
	If ($vl_numLines>0)
		C_BOOLEAN:C305($vb_firstValueSet)  // Flag to prime our min/max values
		$vb_firstValueSet:=False:C215
		$vl_minNumber:=MAXLONG:K35:2  // some large longint
		$vl_maxNumber:=0-MAXLONG:K35:2
		$vd_minDate:=!2500-12-31!  // some large date
		$vd_maxDate:=!00-00-00!
		$vr_min:=MAXLONG:K35:2
		$vr_max:=-MAXLONG:K35:2
		ARRAY DATE:C224($ad_datesArray; 0)
		ARRAY LONGINT:C221($al_numbersArray; 0)
		ARRAY REAL:C219($ar_valuesArray; 0)
		For ($vl_lineNo; 1; $vl_numLines)
			
			$vt_graphType:=OT_GetText($chartID; "dataLine "+String:C10($vl_lineNo)+".type")
			Case of 
				: ($vt_graphType="numberedValues") | ($vt_graphType="numberedAreaLine")
					OT_GetArray($chartID; "dataLine "+String:C10($vl_lineNo)+".xAxis_numbers"; ->$al_numbersArray)  // get the sorted array
					OT_GetArray($chartID; "dataLine "+String:C10($vl_lineNo)+".yAxis_values"; ->$ar_valuesArray)
					
					$vl_minNumber:=NUM_GetMinLong($vl_minNumber; $al_numbersArray{1})
					$vl_maxNumber:=NUM_GetMaxLong($vl_maxNumber; $al_numbersArray{Size of array:C274($al_numbersArray)})
					If ($vl_minNumber=$vl_maxNumber)  // Ensure that there is more than one value on the x axis
						$vl_minNumber:=$vl_minNumber-1
						$vl_maxNumber:=$vl_maxNumber+2
					End if 
					
					
				: ($vt_graphType="datedValues") | ($vt_graphType="datedAreaLine")
					OT_GetArray($chartID; "dataLine "+String:C10($vl_lineNo)+".xAxis_dates"; ->$ad_datesArray)  // get the sorted array
					OT_GetArray($chartID; "dataLine "+String:C10($vl_lineNo)+".yAxis_values"; ->$ar_valuesArray)
					
					If ($ad_datesArray{1}<$vd_minDate)  // get the min
						$vd_minDate:=$ad_datesArray{1}
					End if 
					If ($ad_datesArray{Size of array:C274($ad_datesArray)}>$vd_maxDate)  // get the max
						$vd_maxDate:=$ad_datesArray{Size of array:C274($ad_datesArray)}
					End if 
					If ($vd_minDate=$vd_maxDate)  // Ensure that there is more than one date on the x axis
						$vd_minDate:=$vd_minDate-1
						$vd_maxDate:=$vd_minDate+2
					End if 
					
					
				: ($vt_graphType="trendline")
					ARRAY REAL:C219($ar_valuesArray; 2)
					$ar_valuesArray{1}:=OT_GetLong($chartID; "dataLine "+String:C10($vl_lineNo)+".startValue")
					$ar_valuesArray{2}:=OT_GetLong($chartID; "dataLine "+String:C10($vl_lineNo)+".endValue")
			End case 
			
			SORT ARRAY:C229($ar_valuesArray; >)
			$vr_min:=NUM_GetMinReal($ar_valuesArray{1}; $vr_min)
			$vr_max:=NUM_GetMaxReal($ar_valuesArray{Size of array:C274($ar_valuesArray)}; $vr_max)
		End for 
	End if 
	
	//   Mod: DB (12/06/2013) - Task 2278 - Support y-axis min/max
	If (OT_GetLong($chartID; "minVerticalHeight_isSet")=1)
		$vr_min:=OT_GetLong($chartID; "minVerticalHeight")
	End if 
	If (OT_GetLong($chartID; "maxVerticalHeight_isSet")=1)
		$vr_max:=OT_GetLong($chartID; "maxVerticalHeight")
	End if 
	
	//   Mod: DB (03/27/2014) - Force the min and max to differ
	If ($vr_max=$vr_min)
		$vr_max:=$vr_min+1
	End if 
	
	// Build up our full list of dates for the horz line
	// Need to know how many "cols" we have
	Case of 
		: ($vl_xAxisDataType=Is date:K8:7)
			ARRAY DATE:C224($ad_horz_rawDates; ($vd_maxDate-$vd_minDate)+1)
			For ($i; 1; Size of array:C274($ad_horz_rawDates))
				$ad_horz_rawDates{$i}:=Add to date:C393($vd_minDate; 0; 0; $i-1)
			End for 
			
		: ($vl_xAxisDataType=Is longint:K8:6)
			ARRAY LONGINT:C221($al_horz_rawNumbers; ($vl_maxNumber-$vl_minNumber)+1)
			For ($i; 1; Size of array:C274($al_horz_rawNumbers))
				$al_horz_rawNumbers{$i}:=$vl_minNumber+($i-1)
			End for 
	End case 
	
	
	C_REAL:C285($vr_scaleFactor)
	$vr_scaleFactor:=$vl_gridHeight/($vr_max-$vr_min)
	
	//   Mod: DB (12/06/2013) - 2278 - Support y-axis ranges and increments
	// If the gap between the max and min is large enough, round to whole #s
	C_BOOLEAN:C305($vb_useWholeNumbers)
	C_REAL:C285($vr_yAxis_LabelInc; $vr_yAxis_GraphOffsetInc)
	If (OT_GetReal($chartID; "verticalAxisIncrement")#0)
		$vr_yAxis_LabelInc:=OT_GetReal($chartID; "verticalAxisIncrement")
		$vr_yAxis_GraphOffsetInc:=$vl_gridHeight/(($vr_max-$vr_min)/$vr_yAxis_LabelInc)
	Else 
		$vr_yAxis_LabelInc:=($vr_max-$vr_min/($vl_gridHeight/10))  // what does that convert to on the graph axis
		$vr_yAxis_GraphOffsetInc:=$vl_gridHeight/(($vr_max-$vr_min)/$vr_yAxis_LabelInc)
	End if 
	If ($vr_yAxis_LabelInc=Int:C8($vr_yAxis_LabelInc))
		$vb_useWholeNumbers:=True:C214
	End if 
	
	//   Mod by: Dani Beaubien (11/21/2014) - FORCE TO BE WHOLE #s
	$vb_useWholeNumbers:=True:C214
	
	//LOG_INFO ("   c1")
	
	//   Mod: DB (12/06/2013) - Add drawing the grid here
	C_LONGINT:C283($vl_gridBoxSize)
	C_TEXT:C284($vt_title)
	$vl_gridBoxSize:=Int:C8($vl_gridHeight/10)
	//CHART__Draw_GridBox ($chartID;$vl_gridBoxSize;$vt_title)
	CHART__Draw_GridBox($chartID; $vr_yAxis_GraphOffsetInc; $vt_title)
	
	//LOG_INFO ("   d1")
	
	C_TEXT:C284($vt_svgGridRef)
	$vt_svgGridRef:=CHART_SVG_GetGridRef($chartID)
	
	
	// Draw each line
	C_TEXT:C284($vt_lineColour)
	ARRAY DATE:C224($ad_datesArray; 0)
	ARRAY LONGINT:C221($al_numbersArray; 0)
	ARRAY REAL:C219($ar_valuesArray; 0)
	For ($vl_lineNo; 1; $vl_numLines)
		$vt_graphType:=OT_GetText($chartID; "dataLine "+String:C10($vl_lineNo)+".type")
		Case of 
			: ($vt_graphType="numberedValues") | ($vt_graphType="numberedAreaLine")
				OT_GetArray($chartID; "dataLine "+String:C10($vl_lineNo)+".xAxis_numbers"; ->$al_numbersArray)  // get the sorted array
				OT_GetArray($chartID; "dataLine "+String:C10($vl_lineNo)+".yAxis_values"; ->$ar_valuesArray)
				
			: ($vt_graphType="datedValues") | ($vt_graphType="datedAreaLine")
				OT_GetArray($chartID; "dataLine "+String:C10($vl_lineNo)+".xAxis_dates"; ->$ad_datesArray)  // get the sorted array
				OT_GetArray($chartID; "dataLine "+String:C10($vl_lineNo)+".yAxis_values"; ->$ar_valuesArray)
				
			: ($vt_graphType="trendline")
				ARRAY REAL:C219($ar_valuesArray; 2)
				$ar_valuesArray{1}:=OT_GetLong($chartID; "dataLine "+String:C10($vl_lineNo)+".startValue")
				$ar_valuesArray{2}:=OT_GetLong($chartID; "dataLine "+String:C10($vl_lineNo)+".endValue")
				
				Case of 
					: ($vl_xAxisDataType=Is longint:K8:6)
						ARRAY LONGINT:C221($al_numbersArray; 2)
						$al_numbersArray{1}:=$vl_minNumber
						$al_numbersArray{2}:=$vl_maxNumber
						
					: ($vl_xAxisDataType=Is date:K8:7)
						ARRAY DATE:C224($ad_datesArray; 2)
						$ad_datesArray{1}:=$vd_minDate
						$ad_datesArray{2}:=$vd_maxDate
						
				End case 
		End case 
		
		$vt_lineColour:=OT_GetText($chartID; "dataLine "+String:C10($vl_lineNo)+".lineColour")
		
		$vl_numItems:=Size of array:C274($ar_valuesArray)
		
		// Define our polygon line elements
		ARRAY REAL:C219($tX; $vl_numItems)
		ARRAY REAL:C219($tY; $vl_numItems)
		C_POINTER:C301($vp_xAxisArrPtr; $vp_xAxisRawValuesArrPtr)
		Case of 
			: ($vl_xAxisDataType=Is date:K8:7)
				$vp_xAxisArrPtr:=->$ad_datesArray
				$vp_xAxisRawValuesArrPtr:=->$ad_horz_rawDates
				
			: ($vl_xAxisDataType=Is longint:K8:6)
				$vp_xAxisArrPtr:=->$al_numbersArray
				$vp_xAxisRawValuesArrPtr:=->$al_horz_rawNumbers
		End case 
		For ($i; 1; $vl_numItems)
			$pos:=Find in array:C230($vp_xAxisRawValuesArrPtr->; $vp_xAxisArrPtr->{$i})
			
			If ($pos<1)
				TRACE:C157
			End if 
			$tX{$i}:=($vl_gridWidth/(Size of array:C274($vp_xAxisRawValuesArrPtr->)-1))*($pos-1)  // horz position
			$tY{$i}:=$vl_gridHeight-($vr_scaleFactor*($ar_valuesArray{$i}-$vr_min))  // vertical position
		End for 
		
		C_TEXT:C284($tmpObjRef)
		If ($vt_graphType="@areaLine")
			INSERT IN ARRAY:C227($tX; 1)
			INSERT IN ARRAY:C227($tY; 1)
			$tX{1}:=$tX{2}
			$tY{1}:=$vl_gridHeight
			APPEND TO ARRAY:C911($tX; $tX{Size of array:C274($tX)})
			APPEND TO ARRAY:C911($tY; $vl_gridHeight)
			APPEND TO ARRAY:C911($tX; $tX{1})
			APPEND TO ARRAY:C911($tY; $vl_gridHeight)
			
			$tmpObjRef:=SVG_New_polyline_by_arrays($vt_svgGridRef; ->$tX; ->$tY; "lightgrey"; $vt_lineColour; 1)  //  (parentSVGObject; xArrayPointer; yArrayPointer{; foregroundColor{; backgroundColor{; strokeWidth}}})
			
		Else 
			$tmpObjRef:=SVG_New_polyline_by_arrays($vt_svgGridRef; ->$tX; ->$tY; $vt_lineColour; "none"; 1)  //  (parentSVGObject; xArrayPointer; yArrayPointer{; foregroundColor{; backgroundColor{; strokeWidth}}})
		End if 
		
		C_TEXT:C284($vt_indicatorShape)
		$vt_indicatorShape:=OT_GetText($chartID; "dataLine "+String:C10($vl_lineNo)+".indicator")
		If ($vt_indicatorShape#"none")
			C_TEXT:C284($vt_indicatorColour)
			C_LONGINT:C283($vl_indicatorWidth)
			$vl_indicatorWidth:=OT_GetLong($chartID; "dataLine "+String:C10($vl_lineNo)+".indicatorWidth")
			$vt_indicatorColour:=OT_GetText($chartID; "dataLine "+String:C10($vl_lineNo)+".indicatorColour")
			
			If ($vt_graphType="@areaLine")  // Account for skipping the first item
				$vl_numItems:=$vl_numItems+1
			End if 
			
			For ($i; 1; $vl_numItems)
				If ($vt_graphType#"@areaLine") | ($i>1)
					CHART__Draw_Indicator($vt_svgGridRef; $tX{$i}; $tY{$i}; $vt_indicatorShape; $vl_indicatorWidth; $vt_indicatorColour)
				End if 
			End for 
		End if 
		
	End for 
	
	//LOG_INFO ("   e1")
	
	// Draw out X axis and Y axis value labels
	If ($vl_numLines>0)
		Case of 
			: ($vl_xAxisDataType=Is date:K8:7)
				$vl_numItems:=$vd_maxDate-$vd_minDate+1
			: ($vl_xAxisDataType=Is longint:K8:6)
				$vl_numItems:=$vl_maxNumber-$vl_minNumber+1
		End case 
		ARRAY REAL:C219($tX; $vl_numItems)
		ARRAY REAL:C219($tY; $vl_numItems)
		
		
		// # Draw the labels along the X axis
		C_TEXT:C284($vt_dateFormat; $textID)
		C_LONGINT:C283($vl_lastDrawnPos)
		$vt_dateFormat:=OT_GetText($chartID; "horzDateLabelFormat")  //   Mod: DB (06/29/2011)
		$vl_lastDrawnPos:=10000
		For ($i; 1; $vl_numItems)
			$tX{$i}:=($vl_gridWidth/($vl_numItems-1))*($i-1)+15
			$tY{$i}:=$vl_gridHeight-10
			If (Abs:C99($vl_lastDrawnPos-$tX{$i})>20)
				$vl_lastDrawnPos:=$tX{$i}
				
				Case of 
					: ($vl_xAxisDataType=Is date:K8:7)
						$textID:=SVG_New_text($vt_svgGridRef; Date2String(Add to date:C393($vd_minDate; 0; 0; $i-1); $vt_dateFormat); $tX{$i}; $tY{$i}; "Arial"; 12; 1; 4; "black"; 315)
					: ($vl_xAxisDataType=Is longint:K8:6)
						$textID:=SVG_New_text($vt_svgGridRef; String:C10($vl_minNumber+$i-1); $tX{$i}; $tY{$i}; "Arial"; 12; 1; 4; "black"; 315)
				End case 
				
				//  (parentSVGObject; text{; x{; y{; font{; size{; style{; alignment{; color{; rotation{; lineSpacing{; stretching}}}}}}}}}})
			End if 
		End for 
		
		
		
		// # Draw the labels along the Y axis
		C_REAL:C285($vr_curLabelValue)
		C_TEXT:C284($vt_theValue)
		$vr_curLabelValue:=$vr_max
		//LOG_INFO ("      $vl_gridHeight="+String($vl_gridHeight))
		//LOG_INFO ("      $vr_yAxis_GraphOffsetInc="+String($vr_yAxis_GraphOffsetInc))
		$pos:=0
		While ($pos<=$vl_gridHeight)
			If ($vb_useWholeNumbers)
				$vt_theValue:=String:C10($vr_curLabelValue; "#########0")
			Else 
				$vt_theValue:=String:C10($vr_curLabelValue; "#########0.00")
			End if 
			$textID:=SVG_New_text($vt_svgGridRef; $vt_theValue; -7; $pos-8; "Arial"; 10; Plain:K14:1; 4; "black")
			//  (parentSVGObject; text{; x{; y{; font{; size{; style{; alignment{; color{; rotation{; lineSpacing{; stretching}}}}}}}}}})
			
			$pos:=$pos+$vr_yAxis_GraphOffsetInc
			$vr_curLabelValue:=$vr_curLabelValue-$vr_yAxis_LabelInc
		End while 
		
		
		
		// # Draw the series legend and labels
		If (OT_GetText($chartID; "seriesLegend_ShowLabels")="Yes")
			Array_Empty(->$tX)
			Array_Empty(->$tY)
			APPEND TO ARRAY:C911($tX; $vl_gridWidth+10)
			APPEND TO ARRAY:C911($tY; 55)
			
			APPEND TO ARRAY:C911($tX; $vl_gridWidth+OT_GetLong($chartID; "seriesLegend_width")+20)
			APPEND TO ARRAY:C911($tY; $tY{1})
			
			APPEND TO ARRAY:C911($tX; $tX{2})
			APPEND TO ARRAY:C911($tY; $tY{1}+($vl_numLines*20)+10)
			
			APPEND TO ARRAY:C911($tX; $tX{1})
			APPEND TO ARRAY:C911($tY; $tY{3})
			
			APPEND TO ARRAY:C911($tX; $tX{1})
			APPEND TO ARRAY:C911($tY; $tY{1})
			
			$tmpObjRef:=SVG_New_polyline_by_arrays($vt_svgGridRef; ->$tX; ->$tY; "lightgrey"; "none"; 1)
			
			// Setup for the legend lines
			Array_Empty(->$tX)
			Array_Empty(->$tY)
			APPEND TO ARRAY:C911($tX; $vl_gridWidth+20)
			APPEND TO ARRAY:C911($tY; 0)  // set in the loop
			
			APPEND TO ARRAY:C911($tX; $tX{1}+10)
			APPEND TO ARRAY:C911($tY; 0)  // set in the loop
			
			C_TEXT:C284($vt_theLabel)
			For ($i; 1; $vl_numLines)
				$vt_theLabel:=OT_GetText($chartID; "dataLine "+String:C10($i)+".seriesLabel")
				$textID:=SVG_New_text($vt_svgGridRef; $vt_theLabel; $vl_gridWidth+40; 40+($i*20); "Arial"; 12; Plain:K14:1; 1; "black")
				
				$tY{1}:=40+($i*20)+10
				$tY{2}:=$tY{1}
				
				$vt_lineColour:=OT_GetText($chartID; "dataLine "+String:C10($I)+".lineColour")
				$tmpObjRef:=SVG_New_polyline_by_arrays($vt_svgGridRef; ->$tX; ->$tY; $vt_lineColour; "none"; 1)
			End for 
		End if 
		
	End if 
	
	//LOG_INFO ("   f1")
	
End if   // ASSERT
