//%attributes = {"invisible":true,"shared":true}
// MethodStats_RecalculateModified ()
// 
// DESCRIPTION
//   Forces the methods that have been recently modifed
//   to have their stored method statistics updated.
//
If (False:C215)
	// ----------------------------------------------------
	// HISTORY
	//   Created by: DB (12/17/2014)
	//   Mod: DB (12/14/2016) - Added code to make sure a full recalc works
	// ----------------------------------------------------
End if 
ASSERT:C1129(Count parameters:C259=0)
C_REAL:C285($vs)

C_COLLECTION:C1488($methodChangeNotification)
$methodChangeNotification:=New collection:C1472

<>TrackPerformance:=(Pref_GetGlobalPrefString("IsInLoggingMode"; "No")="Yes")
Logging_Method_START(Current method name:C684)
OnErr_ClearError
OnErr_Install_Handler("OnErr_GENERIC")

C_LONGINT:C283($progHdl)
C_REAL:C285($vr_startTime; $vr_lastUpdate)
$vr_startTime:=Milliseconds:C459

MethodStats__Init
LogEvent_Write("")  // BLANK LINE
LogEvent_Write(Str_DateTimeStamp+"\tSTART STATISTICS REFRESH")

C_BOOLEAN:C305($vb_changeWasMade)
$vb_changeWasMade:=False:C215

// Get the current list of method paths along with their last modified DTS
ARRAY TEXT:C222($at_tmpMethodNames; 0)
ARRAY LONGINT:C221($al_tmpMethodDTS; 0)
Methods_GetNamesAndDTS(->$at_tmpMethodNames; ->$al_tmpMethodDTS)

If (True:C214)  // Init the table and field arrays
	ARRAY TEXT:C222($at_TBL_tableNames; 0)
	ARRAY LONGINT:C221($al_TBL_tableNos; 0)
	ARRAY TEXT:C222($at_FLD_tableFieldNames; 0)
	ARRAY POINTER:C280($ap_FLD_fieldPtrs; 0)
	
	OB GET ARRAY:C1229(_STRUCT_ObjOfArrays; "tableNames"; $at_TBL_tableNames)
	OB GET ARRAY:C1229(_STRUCT_ObjOfArrays; "tableNos"; $al_TBL_tableNos)
	OB GET ARRAY:C1229(_STRUCT_ObjOfArrays; "tableFieldNames"; $at_FLD_tableFieldNames)
	OB GET ARRAY:C1229(_STRUCT_ObjOfArrays; "fieldPtrs"; $ap_FLD_fieldPtrs)
End if 

ARRAY TEXT:C222($at_projectMethodPaths; 0)
METHOD GET PATHS:C1163(Path project method:K72:1; $at_projectMethodPaths; *)

// Loop through and attempt to update the Complexity calc
C_LONGINT:C283($i; $pos)
C_BOOLEAN:C305($methodNeedsToBeRefreshed)
For ($i; 1; Size of array:C274($at_tmpMethodNames))
	// Open progress if more than 500 milliseconds have passed
	If (Abs:C99(Milliseconds:C459-$vr_startTime)>500) & ($progHdl=0)
		C_PICTURE:C286($vg_icon)
		READ PICTURE FILE:C678(LibraryImage_GetPlatformPath("Progress_Compare.png"); $vg_icon)
		$progHdl:=Progress New
		Progress SET TITLE($progHdl; "Analysing "+String:C10(Size of array:C274($at_tmpMethodNames); "###,###,##0")+" Methods..."; $i/Size of array:C274($at_tmpMethodNames); ""; True:C214)
		Progress SET ICON($progHdl; $vg_icon)
		$vr_lastUpdate:=Milliseconds:C459
	End if 
	
	Case of 
		: (MethodStatsMasterObj[$at_tmpMethodNames{$i}]=Null:C1517)  // not in storage yet
			$methodNeedsToBeRefreshed:=True:C214
			$methodChangeNotification.push(New object:C1471("path"; $at_tmpMethodNames{$i}; "action"; "add"))
			
		: (MethodStatsMasterObj[$at_tmpMethodNames{$i}].last_modified_dts#$al_tmpMethodDTS{$i})  // has been modified
			$methodNeedsToBeRefreshed:=True:C214
			$methodChangeNotification.push(New object:C1471("path"; $at_tmpMethodNames{$i}; "action"; "update"))
			
		Else 
			$methodNeedsToBeRefreshed:=False:C215
	End case 
	If ($methodNeedsToBeRefreshed)
		$vb_changeWasMade:=True:C214
		$vs:=Milliseconds:C459
		MethodStats__RefreshMethodObj($at_tmpMethodNames{$i}; ->$at_projectMethodPaths; _STRUCT_ObjOfArrays.tableList; _STRUCT_ObjOfArrays.fieldList)
		LogEvent_Write(Str_DateTimeStamp+"\t\""+$at_tmpMethodNames{$i}+"\" method stats ("+String:C10(Milliseconds:C459-$vs)+"ms)")
	End if 
	
	// Update progress if open and more than 300 milliseconds have passed
	If ($progHdl#0) & (Abs:C99(Milliseconds:C459-$vr_lastUpdate)>300)
		$vr_lastUpdate:=Milliseconds:C459
		Progress SET PROGRESS($progHdl; $i/Size of array:C274($at_tmpMethodNames))  //   Mod by: Dani Beaubien (04/29/2016)
		Progress SET MESSAGE($progHdl; String:C10($i; "###,###,##0")+": "+$at_tmpMethodNames{$i})
	End if 
End for 

// Look for any that need to be removed from what came from disk
ARRAY TEXT:C222($methodObjNames; 0)
Method_GetMethodObjNames(->$methodObjNames)
For ($i; 1; Size of array:C274($methodObjNames))
	If (Find in array:C230($at_tmpMethodNames; $methodObjNames{$i})<1)
		$vb_changeWasMade:=True:C214
		LogEvent_Write(Str_DateTimeStamp+"\tRemoving \""+$methodObjNames{$i}+"\" from local store")
		MethodStats__DeleteMethod(MethodStatsMasterObj[$methodObjNames{$i}].path)
		$methodChangeNotification.push(New object:C1471("path"; $methodObjNames{$i}; "action"; "delete"))
	End if 
End for 

// Check for changes in the "Shared" attribute, this doesn't modify the method
C_BOOLEAN:C305($projectMethodIsShared)
Use (MethodStatsMasterObj)
	For ($i; 1; Size of array:C274($at_tmpMethodNames))
		If ($at_tmpMethodNames{$i}="[@")
			MethodStatsMasterObj[$at_tmpMethodNames{$i}].is_shared:=False:C215
		Else 
			$projectMethodIsShared:=METHOD Get attribute:C1169($at_tmpMethodNames{$i}; Attribute shared:K72:10; *)
			If (MethodStatsMasterObj[$at_tmpMethodNames{$i}].is_shared#$projectMethodIsShared)
				$vb_changeWasMade:=True:C214
				MethodStatsMasterObj[$at_tmpMethodNames{$i}].is_shared:=$projectMethodIsShared
				$methodChangeNotification.push(New object:C1471("path"; $at_tmpMethodNames{$i}; "action"; "update"))
			End if 
		End if 
	End for 
End use 

If ($vb_changeWasMade)
	$vs:=Milliseconds:C459
	MethodStats__RefreshTotals
	LogEvent_Write(Str_DateTimeStamp+"\tUpdating totals ("+String:C10(Milliseconds:C459-$vs)+"ms)")
	
	$vs:=Milliseconds:C459
	MethodStats__UpstreamMethodRefs
	LogEvent_Write(Str_DateTimeStamp+"\tUpdating upstream ("+String:C10(Milliseconds:C459-$vs)+"ms)")
	
	$vs:=Milliseconds:C459
	MethodStats__SaveToDisk
	LogEvent_Write(Str_DateTimeStamp+"\tSaved to disk ("+String:C10(Milliseconds:C459-$vs)+"ms)")
	
	C_OBJECT:C1216($methodChange)
	For each ($methodChange; $methodChangeNotification)
		ExplorerWin_MethodUpdated($methodChange.path; $methodChange.action)
	End for each 
End if 


If ($progHdl#0)
	Progress QUIT($progHdl)
End if 

LogEvent_Write(Str_DateTimeStamp+"\tFINISH STATISTICS REFRESH ["+String:C10(Milliseconds:C459-$vr_startTime; "###,###,###,##0")+"ms]")
LogEvent_FlushCache

OnErr_ClearError  //   Mod by: Dani Beaubien (06/22/2013)
OnErr_Install_Handler


Logging_Method_STOP(Current method name:C684)
Logging_Method_ProfileStats2Log