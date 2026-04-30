//%attributes = {"invisible":true}
// Host_GetAssetInfo_GetFormProp
//   
// DESCRIPTION
//   Returns a list of table forms.
//
#DECLARE($vl_tableNo : Integer\
; $vt_formName : Text\
; $vp_formWidth : Pointer\
; $vp_formHeight : Pointer\
; $vp_numPages : Pointer\
; $vp_formFixedWidth : Pointer\
; $vp_formFixedHeight : Pointer\
; $vp_title : Pointer)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=8)

var $vl_formWidth; $vl_formHeight; $vl_numPages : Integer
var $vb_formFixedWidth; $vb_formFixedHeight : Boolean
var $vt_title : Text

If ($vl_tableNo>0)
	FORM GET PROPERTIES:C674(Table:C252($vl_tableNo)->; $vt_formName; $vl_formWidth; $vl_formHeight; $vl_numPages; $vb_formFixedWidth; $vb_formFixedHeight; $vt_title)
	If (OnErr_GetLastError#0)
		LogEvent_Write(" Error occured trying to get table form \""+$vt_formName+"\" on table ["+Table name:C256($vl_tableNo)+"].")
	End if 
Else 
	FORM GET PROPERTIES:C674($vt_formName; $vl_formWidth; $vl_formHeight; $vl_numPages; $vb_formFixedWidth; $vb_formFixedHeight; $vt_title)
	If (OnErr_GetLastError#0)
		LogEvent_Write(" Error occured trying to get project form \""+$vt_formName+"\".")
	End if 
End if 

// Return the results
$vp_formWidth->:=$vl_formWidth
$vp_formHeight->:=$vl_formHeight
$vp_numPages->:=$vl_numPages
$vp_formFixedWidth->:=$vb_formFixedWidth
$vp_formFixedHeight->:=$vb_formFixedHeight
$vp_title->:=$vt_title
