//%attributes = {"invisible":true}
// DateTime_GetYearWeekNr (date{; format}) : formatedStr
// DateTime_GetYearWeekNr (date{; text}) : text
// 
// DESCRIPTION
//   Returns the year + week number
//   Please note that this is different from the system used in the US
//   the format is optional, by default it is "YYYY - week wk".
//    "yyyy" is replaced with the year
//    "wk" is replaced with the week
//
C_DATE:C307($1; $vd_theDate)
C_TEXT:C284($2; $vt_theFormat)  // OPTIONAL
C_TEXT:C284($0; $vt_formattedStr)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (03/14/13)
// ----------------------------------------------------

$vt_formattedStr:=""
If (DEV_ASSERT_PARMCOUNT_RANGE(Current method name:C684; 1; 2; Count parameters:C259))
	$vd_theDate:=$1
	If (Count parameters:C259>=2)
		$vt_theFormat:=$2
	End if 
	If ($vt_theFormat="")
		$vt_theFormat:="YYYY - week wk"
	End if 
	
	If ($vd_theDate#!00-00-00!)
		// According to ISO 8601 the week starts at monday (not sunday)
		// So calculate the date of this week's thursday
		C_DATE:C307($vd_dateofTheThursday)
		C_LONGINT:C283($vl_yearNo)
		If (Day number:C114($vd_theDate)>=Monday:K10:13)
			$vd_dateofTheThursday:=$vd_theDate+5-Day number:C114($vd_theDate)
		Else 
			$vd_dateofTheThursday:=$vd_theDate-3
		End if 
		$vl_yearNo:=Year of:C25($vd_dateofTheThursday)
		
		
		// Calculate the number of days between the thursday and January 1st
		C_LONGINT:C283($vl_numDaysBetween)
		$vl_numDaysBetween:=$vd_dateofTheThursday-Add to date:C393(!00-00-00!; Year of:C25($vd_dateofTheThursday); 1; 1)
		
		// Calculate the number of weeks
		C_LONGINT:C283($vl_weekNo)
		$vl_weekNo:=$vl_numDaysBetween\7+1
		
		// Replace th string
		$vt_formattedStr:=Replace string:C233($vt_theFormat; "YYYY"; String:C10($vl_yearNo; "0000"))
		$vt_formattedStr:=Replace string:C233($vt_formattedStr; "wk"; String:C10($vl_weekNo; "00"))
	End if 
	
End if   // ASSERT
$0:=$vt_formattedStr