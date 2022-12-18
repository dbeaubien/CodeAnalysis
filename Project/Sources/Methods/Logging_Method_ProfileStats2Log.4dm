//%attributes = {"invisible":true}
// Logging_Method_ProfileStats2Log () 
// 
// DESCRIPTION
//   This method dumps to a text variable contents of
//   the profile arrays
//
// ----------------------------------------------------
// CALLED BY
//   Logging_Method_DumpProfileStats
// ----------------------------------------------------
// HISTORY
//   Created by: DB (05/10/11)
//   Mod: DB (01/28/2014) - Added Total to output
//   Mod by: Dani Beaubien (03/28/2014) - Changed output to be "-"'s
// ----------------------------------------------------

Logging_Method__init

If (Size of array:C274(_LOGMETHOD_PROF_Method)>0)
	C_TEXT:C284($vt_buffer)
	$vt_buffer:=("-"*40)+"\r"
	$vt_buffer:=$vt_buffer+("-"*40)+"\r"
	$vt_buffer:=$vt_buffer+"METHOD NAME (LOCAL)\t"
	$vt_buffer:=$vt_buffer+"Call Count\t"
	$vt_buffer:=$vt_buffer+"Min (ms)\t"
	$vt_buffer:=$vt_buffer+"Avg (ms)\t"
	$vt_buffer:=$vt_buffer+"Max (ms)\t"
	$vt_buffer:=$vt_buffer+"Total (ms)\r"  //   Mod: DB (01/28/2014)
	$vt_buffer:=$vt_buffer+("-"*40)+"\r"
	
	SORT ARRAY:C229(_LOGMETHOD_PROF_Method; _LOGMETHOD_PROF_minTime; _LOGMETHOD_PROF_maxTime; _LOGMETHOD_PROF_totalTime; _LOGMETHOD_PROF_count)
	C_LONGINT:C283($i)
	For ($i; 1; Size of array:C274(_LOGMETHOD_PROF_Method))
		$vt_buffer:=$vt_buffer+_LOGMETHOD_PROF_Method{$i}+Char:C90(Tab:K15:37)
		$vt_buffer:=$vt_buffer+String:C10(_LOGMETHOD_PROF_count{$i})+Char:C90(Tab:K15:37)
		$vt_buffer:=$vt_buffer+String:C10(_LOGMETHOD_PROF_minTime{$i})+Char:C90(Tab:K15:37)
		If (_LOGMETHOD_PROF_totalTime{$i}>0)
			$vt_buffer:=$vt_buffer+String:C10(_LOGMETHOD_PROF_totalTime{$i}/_LOGMETHOD_PROF_count{$i}; "###,###,###,###,##0.00")+Char:C90(Tab:K15:37)
		Else 
			$vt_buffer:=$vt_buffer+"0"+Char:C90(Tab:K15:37)
		End if 
		$vt_buffer:=$vt_buffer+String:C10(_LOGMETHOD_PROF_maxTime{$i})+Char:C90(Tab:K15:37)
		$vt_buffer:=$vt_buffer+String:C10(_LOGMETHOD_PROF_totalTime{$i})+Char:C90(Carriage return:K15:38)  //   Mod: DB (01/28/2014)
	End for 
	
	$vt_buffer:=$vt_buffer+("-"*40)+"\r"
	LogEvent_Write("")  // BLANK LINE
	LogEvent_Write($vt_buffer)
	LogEvent_Write("")  // BLANK LINE
	LogEvent_FlushCache
End if 
