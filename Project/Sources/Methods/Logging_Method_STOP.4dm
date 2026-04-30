//%attributes = {"invisible":true}
// Logging_Method_STOP (methodName {;optionalText})
// 
// DESCRIPTION
//   Used to log leaving a method.
//
#DECLARE($method_name : Text; $extra : Text)
// ----------------------------------------------------

var $vt_FullMethodName; <>vt_ExportToResults : Text
$vt_FullMethodName:=$method_name
If ($extra#"")
	$vt_FullMethodName+=" ("+$extra+")"
End if 

//   Mod by: Dani Beaubien (02/16/2015) - To support flame graphs
var $vt_FullLocalMethodName : Text
var $i; $pos : Integer
$vt_FullLocalMethodName:=$vt_FullMethodName
For ($i; Size of array:C274(_LOGMETHOD_CallingStack)-1; 1; -1)
	$vt_FullLocalMethodName:=_LOGMETHOD_CallingStack{$i}+";"+$vt_FullLocalMethodName
End for 

Logging_Method__init

var $size : Integer
$size:=Size of array:C274(_LOGMETHOD_CallingStack)

If ($size>0)
	
	// # Make sure that the STOPPED method matches what is expected
	If ($method_name#_LOGMETHOD_CallingStack{$size}) | ($extra#_LOGMETHOD_ExtraText{$size})
		
		//   Mod: DB (01/28/2014) - Improved error checks
		var $vt_msg : Text
		$vt_msg:=" called with $1 = '"+$method_name+"'"
		If ($extra#"")
			$vt_msg:=$vt_msg+" and $2 = '"+$extra+"'"
		End if 
		$vt_msg:=$vt_msg+" but expecting $1 = '"+_LOGMETHOD_CallingStack{$size}+"'"
		If (_LOGMETHOD_ExtraText{$size}#"")
			$vt_msg:=$vt_msg+" and $2 = '"+_LOGMETHOD_ExtraText{$size}+"'"
		End if 
		<>vt_ExportToResults:=<>vt_ExportToResults+Current method name:C684+$vt_msg
		
		
		// Try to recover
		If ($size>1)
			If ($1=_LOGMETHOD_CallingStack{$size-1})  // does the item before this one match?
				// If so, then pull the "bad one" off.
				Array_SetSize($size-1; ->_LOGMETHOD_CallingStack; ->_LOGMETHOD_ExtraText; ->_LOGMETHOD_msStart; ->_LOGMETHOD_wasteTime)
				$size:=$size-1
				
				//If ($size>0)  //   Mod by: Dani Beaubien (02/16/2015) - To support a flame graph
				//$vt_FullLocalMethodName:=_LOGMETHOD_CallingStack{$size}+"."+$vt_FullLocalMethodName
				//End if 
			End if 
		End if 
	End if 
	
	
	var <>TrackPerformance : Boolean
	If (<>TrackPerformance)
		var $vl_msStop : Integer
		$vl_msStop:=Milliseconds:C459
		
		// # Track the time
		var $vl_timeToExecute : Integer
		$vl_timeToExecute:=$vl_msStop-_LOGMETHOD_msStart{$size}  // time between start & end
		$vl_timeToExecute:=$vl_timeToExecute-_LOGMETHOD_wasteTime{$size}  // remove the child method's time
		If ($size>1)  // add our execute time to the calling parent method
			_LOGMETHOD_wasteTime{$size-1}:=_LOGMETHOD_wasteTime{$size-1}+_LOGMETHOD_wasteTime{$size}  // add child method times
			_LOGMETHOD_wasteTime{$size-1}:=_LOGMETHOD_wasteTime{$size-1}+$vl_timeToExecute  // add current method times
		End if 
		
		
		// # Add our tracking info to our local arrays
		$pos:=Find in array:C230(_LOGMETHOD_PROF_Method; $vt_FullLocalMethodName)
		If ($pos<1)
			$pos:=Size of array:C274(_LOGMETHOD_PROF_Method)+1
			APPEND TO ARRAY:C911(_LOGMETHOD_PROF_Method; $vt_FullLocalMethodName)
			APPEND TO ARRAY:C911(_LOGMETHOD_PROF_minTime; $vl_timeToExecute)
			APPEND TO ARRAY:C911(_LOGMETHOD_PROF_maxTime; $vl_timeToExecute)
			APPEND TO ARRAY:C911(_LOGMETHOD_PROF_totalTime; $vl_timeToExecute)
			APPEND TO ARRAY:C911(_LOGMETHOD_PROF_count; 1)
			
		Else 
			If (_LOGMETHOD_PROF_minTime{$pos}>$vl_timeToExecute)
				_LOGMETHOD_PROF_minTime{$pos}:=$vl_timeToExecute
			End if 
			If (_LOGMETHOD_PROF_maxTime{$pos}<$vl_timeToExecute)
				_LOGMETHOD_PROF_maxTime{$pos}:=$vl_timeToExecute
			End if 
			_LOGMETHOD_PROF_totalTime{$pos}:=_LOGMETHOD_PROF_totalTime{$pos}+$vl_timeToExecute
			_LOGMETHOD_PROF_count{$pos}:=_LOGMETHOD_PROF_count{$pos}+1
		End if 
		
		
	End if 
	
	// Pull it off the list
	Array_SetSize($size-1; ->_LOGMETHOD_CallingStack; ->_LOGMETHOD_ExtraText; ->_LOGMETHOD_msStart; ->_LOGMETHOD_wasteTime)
End if 



// Deal with tab levels
__incrementLevel:=__incrementLevel-1
If (__incrementLevel<0)
	<>vt_ExportToResults:=<>vt_ExportToResults+Current method name:C684+" has and __incrementLevel of "+String:C10(__incrementLevel)
	__incrementLevel:=0
End if 

