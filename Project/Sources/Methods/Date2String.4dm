//%attributes = {"invisible":true}
// Method: Date2String ( date {; formatStr} ) : formated date as string
// Method: Date2String ( date {; text} ) : text
//
// DESCRIPTION
//   This method converts the date into a string as dictated by the
//   optional format string. If the format string is not specified then
//   it defaults to "mm/dd/yyyy".
//
//   If a date of !00/00/00! is passed then a blank string is returned.
//
//   The following is the text that is converted by the format string
//   "mm" is converted to a two digit month
//   "dd" is converted to a two digit day
//   "yyyy" is converted to a four digit year
//   "yy" is converted to a two digit year
//   "month" is converted to the full month name
//   "mon" is converted to an abbreviated month name
//   "day" is converted to the full day name
//
C_DATE:C307($1; $date2Convert)  // date to format
C_TEXT:C284($2)  // format to convert date to
C_TEXT:C284($0; $dateString)  // formated date as string
// ----------------------------------------------------
// HISTORY
//   1999/02/28   DB   Created
//   2000/03/21   DB   Modified to include the new header formating
// ===============================================================

C_LONGINT:C283($Day; $Month; $Year; $WeekDay)
$date2Convert:=$1
If (Count parameters:C259>=2)
	$dateString:=$2
End if 

If ($dateString="")
	$dateString:="mm/dd/yyyy"
End if 

If ($date2Convert=!00-00-00!)  // return blank string if date !00/00/00!
	$dateString:=""
	
Else 
	$Day:=Day of:C23($date2Convert)
	$Month:=Month of:C24($date2Convert)
	$Year:=Year of:C25($date2Convert)
	$WeekDay:=Day number:C114($date2Convert)
	
	C_TEXT:C284($DayStr; $DayStr2; $MonthStr)
	$DayStr:=String:C10($Day)
	$DayStr2:=String:C10($Day; "00")
	$MonthStr:=String:C10($Month; "00")
	
	// Put the year in the string
	$dateString:=Replace string:C233($dateString; "yyyy"; String:C10($Year))
	$dateString:=Replace string:C233($dateString; "yy"; String:C10(Mod:C98($Year; 100); "00"))
	
	// Put the Month in the string
	$dateString:=Replace string:C233($dateString; "mm"; $MonthStr)
	Case of 
		: ($Month=1)
			$dateString:=Replace string:C233($dateString; "Month"; "January")
			$dateString:=Replace string:C233($dateString; "Mon"; "Jan")
		: ($Month=2)
			$dateString:=Replace string:C233($dateString; "Month"; "February")
			$dateString:=Replace string:C233($dateString; "Mon"; "Feb")
		: ($Month=3)
			$dateString:=Replace string:C233($dateString; "Month"; "March")
			$dateString:=Replace string:C233($dateString; "Mon"; "Mar")
		: ($Month=4)
			$dateString:=Replace string:C233($dateString; "Month"; "April")
			$dateString:=Replace string:C233($dateString; "Mon"; "Apr")
		: ($Month=5)
			$dateString:=Replace string:C233($dateString; "Month"; "May")
			$dateString:=Replace string:C233($dateString; "Mon"; "May")
		: ($Month=6)
			$dateString:=Replace string:C233($dateString; "Month"; "June")
			$dateString:=Replace string:C233($dateString; "Mon"; "Jun")
		: ($Month=7)
			$dateString:=Replace string:C233($dateString; "Month"; "July")
			$dateString:=Replace string:C233($dateString; "Mon"; "Jul")
		: ($Month=8)
			$dateString:=Replace string:C233($dateString; "Month"; "August")
			$dateString:=Replace string:C233($dateString; "Mon"; "Aug")
		: ($Month=9)
			$dateString:=Replace string:C233($dateString; "Month"; "September")
			$dateString:=Replace string:C233($dateString; "Mon"; "Sep")
		: ($Month=10)
			$dateString:=Replace string:C233($dateString; "Month"; "October")
			$dateString:=Replace string:C233($dateString; "Mon"; "Oct")
		: ($Month=11)
			$dateString:=Replace string:C233($dateString; "Month"; "November")
			$dateString:=Replace string:C233($dateString; "Mon"; "Nov")
		: ($Month=12)
			$dateString:=Replace string:C233($dateString; "Month"; "December")
			$dateString:=Replace string:C233($dateString; "Mon"; "Dec")
	End case 
	
	Case of 
		: ($WeekDay=1)
			$dateString:=Replace string:C233($dateString; "dayShort"; "Sun")
			$dateString:=Replace string:C233($dateString; "day"; "Sunday")
		: ($WeekDay=2)
			$dateString:=Replace string:C233($dateString; "dayShort"; "Mon")
			$dateString:=Replace string:C233($dateString; "day"; "Monday")
		: ($WeekDay=3)
			$dateString:=Replace string:C233($dateString; "dayShort"; "Tue")
			$dateString:=Replace string:C233($dateString; "day"; "Tuesday")
		: ($WeekDay=4)
			$dateString:=Replace string:C233($dateString; "dayShort"; "Wed")
			$dateString:=Replace string:C233($dateString; "day"; "Wednesday")
		: ($WeekDay=5)
			$dateString:=Replace string:C233($dateString; "dayShort"; "Thu")
			$dateString:=Replace string:C233($dateString; "day"; "Thursday")
		: ($WeekDay=6)
			$dateString:=Replace string:C233($dateString; "dayShort"; "Fri")
			$dateString:=Replace string:C233($dateString; "day"; "Friday")
		: ($WeekDay=7)
			$dateString:=Replace string:C233($dateString; "dayShort"; "Sat")
			$dateString:=Replace string:C233($dateString; "day"; "Saturday")
	End case 
	
	// Put the day in the string
	$dateString:=Replace string:C233($dateString; "d1"; $DayStr)
	$dateString:=Replace string:C233($dateString; "dd"; $DayStr2)
	
End if 

$0:=$dateString

//#End method