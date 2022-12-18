//%attributes = {"invisible":true}
// Host_GetAssetInfo_GetFormProp
//   
// DESCRIPTION
//   Returns a list of table forms.
//
C_LONGINT:C283($1; $vl_tableNo)
C_TEXT:C284($2; $vt_formName)
C_POINTER:C301($3; $vp_formWidth)
C_POINTER:C301($4; $vp_formHeight)
C_POINTER:C301($5; $vp_numPages)
C_POINTER:C301($6; $vp_formFixedWidth)
C_POINTER:C301($7; $vp_formFixedHeight)
C_POINTER:C301($8; $vp_title)
// ----------------------------------------------------
// CALLED BY
//   CODE_ExportProperties
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (07/02/2013)
//   Mod: DB (02/18/2014) - Use process vars rather than locals in the Execute Method call
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 8; Count parameters:C259))
	$vl_tableNo:=$1
	$vt_formName:=$2
	$vp_formWidth:=$3
	$vp_formHeight:=$4
	$vp_numPages:=$5
	$vp_formFixedWidth:=$6
	$vp_formFixedHeight:=$7
	$vp_title:=$8
	
	C_LONGINT:C283($vl_formWidth; $vl_formHeight; $vl_numPages)
	C_BOOLEAN:C305($vb_formFixedWidth; $vb_formFixedHeight)
	C_TEXT:C284($vt_title)
	
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
End if   // ASSERT
