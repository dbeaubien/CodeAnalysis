//%attributes = {"invisible":true}
// CHART_Config_ShowSeriesLabels (chartID; showSeries{; width})
// 
// DESCRIPTION
//   If true, then the series labels will be displayed.
//
#DECLARE($chartID : Text\
; $vb_showSeriesLabels : Boolean\
; $vl_width : Integer)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT_RANGE(Current method name:C684; 2; 3; Count parameters:C259))
	If ($vl_width=0)
		$vl_width:=100
	End if 
	
	If ($vb_showSeriesLabels)
		OT_PutText($chartID; "seriesLegend_ShowLabels"; "Yes")
	Else 
		OT_PutText($chartID; "seriesLegend_ShowLabels"; "No")
	End if 
	
	OT_PutLong($chartID; "seriesLegend_width"; $vl_width)
End if 
