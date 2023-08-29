//%attributes = {"invisible":true}
// Explorer_ApplyMethodFilter (formObj)
// 
// DESCRIPTION
//   Manipulated the hidden col array for the explorer window list box
//
C_OBJECT:C1216($1; $formObj)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (12/22/2016)
//   Mod: DB (02/22/2017) - Add method attribute checks
//   Mod by: Dani Beaubien (12/19/2020) - Converted to new way
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
If (Count parameters:C259=1)
	$formObj:=$1
End if 

C_TEXT:C284($vt_onErrorMethod)
$vt_onErrorMethod:=Method called on error:C704
OnErr_ClearError
ON ERR CALL:C155("OnErr_GENERIC_Quiet")

C_TEXT:C284(vSearch)

C_BOOLEAN:C305($doHideMethod_DB; $doHideMethod_PF; $doHideMethod_TF; $doHideMethod_Trigger; $doHideMethod_P)
$doHideMethod_DB:=(Pref_GetPrefString("EXPLORE HideMethod Database")="1")
$doHideMethod_PF:=(Pref_GetPrefString("EXPLORE HideMethod ProjectForm")="1")
$doHideMethod_TF:=(Pref_GetPrefString("EXPLORE HideMethod TableForm")="1")
$doHideMethod_Trigger:=(Pref_GetPrefString("EXPLORE HideMethod Trigger")="1")
$doHideMethod_P:=(Pref_GetPrefString("EXPLORE HideMethod Project")="1")

C_BOOLEAN:C305($doHideThreadSafe; $doHideThreadSafe_NOT; $doHideThreadSafe_Indifferent)
$doHideThreadSafe:=(Pref_GetPrefString("EXPLORE HideMethod PreemptiveCapable")="1")  // Mod: DB (05/31/2017)
$doHideThreadSafe_NOT:=(Pref_GetPrefString("EXPLORE HideMethod PreemptiveInCapable")="1")  // Mod: DB (05/31/2017)
$doHideThreadSafe_Indifferent:=(Pref_GetPrefString("EXPLORE HideMethod PreemptiveIndifferent")="1")  // Mod: DB (05/31/2017)

// Method attribute checks
C_BOOLEAN:C305($onlyShowSharedMethods; $onlyShowServerMethods; $onlyShowWebMethods)
$onlyShowSharedMethods:=(Pref_GetPrefString("EXPLORE OnlyShowShared")="1")  //   Mod: DB (02/22/2017)
$onlyShowServerMethods:=(Pref_GetPrefString("EXPLORE OnlyShowServerExecute")="1")  //   Mod: DB (02/22/2017)
$onlyShowWebMethods:=(Pref_GetPrefString("EXPLORE OnlyShowWeb")="1")  //   Mod: DB (02/22/2017)


// Determine the last mod date
C_LONGINT:C283($vl_modLastDayCount; $vl_dts)
$vl_modLastDayCount:=Num:C11(Pref_GetPrefString("EXPLORE LastMod DayCount"))
If ($vl_modLastDayCount>0)
	C_DATE:C307($vd_date)
	$vd_date:=Add to date:C393(CurrentDate; 0; 0; 1-$vl_modLastDayCount)
	$vl_dts:=TS_FromDateTime($vd_date; ?00:00:00?)
End if 

// Apply filter
C_OBJECT:C1216($methodDetails)
For each ($methodDetails; $formObj.fullList)
	
	Case of 
		: ($doHideMethod_P) & ($methodDetails.name#"[@")
			$methodDetails.doHideRow:=True:C214
			
		: ($doHideMethod_DB) & ($methodDetails.name="[DatabaseMethod]@")
			$methodDetails.doHideRow:=True:C214
			
		: ($doHideMethod_PF) & ($methodDetails.name="[ProjectForm]@")
			$methodDetails.doHideRow:=True:C214
			
		: ($doHideMethod_TF) & ($methodDetails.name="[TableForm]@")
			$methodDetails.doHideRow:=True:C214
			
		: ($doHideMethod_Trigger) & ($methodDetails.name="[trigger]@")
			$methodDetails.doHideRow:=True:C214
			
		: ($vl_dts>$methodDetails.lastSavedTS)
			$methodDetails.doHideRow:=True:C214
			
		: (vSearch#"") & ($methodDetails.name#(vSearch+"@"))
			$methodDetails.doHideRow:=True:C214
			
		Else   // row is still visible, do the rest of the checks
			$methodDetails.doHideRow:=False:C215
			
			// Method attribute checks
			C_OBJECT:C1216($vo_methodAttributes)
			OnErr_ClearError
			
			If (Method_GetTypeFromPath($methodDetails.path)="project method")
				METHOD GET ATTRIBUTES:C1334($methodDetails.path; $vo_methodAttributes; *)
			Else   // define the object if no attributes
				$vo_methodAttributes:=New object:C1471
				$vo_methodAttributes.publishedWeb:=False:C215
				$vo_methodAttributes.executedOnServer:=False:C215
				$vo_methodAttributes.shared:=False:C215
				$vo_methodAttributes.preemptive:="indifferent"
			End if 
			// "preemptive" = "indifferent", "capable", "incapable"
			// "publishedWeb" = true or false
			// "executedOnServer" = true or false
			// "shared" = true or false
			
			If ($doHideThreadSafe)
				If (String:C10($vo_methodAttributes.preemptive)="capable")
					$methodDetails.doHideRow:=True:C214
				End if 
			End if 
			
			If ($doHideThreadSafe_NOT) & (Not:C34($methodDetails.doHideRow))
				If (String:C10($vo_methodAttributes.preemptive)="incapable") | ($methodDetails.name="[@")
					$methodDetails.doHideRow:=True:C214
				End if 
			End if 
			
			If ($doHideThreadSafe_Indifferent) & (Not:C34($methodDetails.doHideRow))
				If (String:C10($vo_methodAttributes.preemptive)="indifferent") | ($methodDetails.name="[@")
					$methodDetails.doHideRow:=True:C214
				End if 
			End if 
			
			Case of 
				: ($methodDetails.doHideRow=True:C214)
					// NOP
					
				: ($methodDetails.name="[@") & \
					($onlyShowSharedMethods | $onlyShowServerMethods | $onlyShowWebMethods)
					$methodDetails.doHideRow:=True:C214
					
					
				: ($onlyShowWebMethods)
					If (OB Get:C1224($vo_methodAttributes; "publishedWeb"; Is boolean:K8:9)=False:C215)
						$methodDetails.doHideRow:=True:C214
					End if 
					
				: ($onlyShowSharedMethods)
					If (OB Get:C1224($vo_methodAttributes; "shared"; Is boolean:K8:9)=False:C215)
						$methodDetails.doHideRow:=True:C214
					End if 
					
				: ($onlyShowServerMethods)
					If (OB Get:C1224($vo_methodAttributes; "executedOnServer"; Is boolean:K8:9)=False:C215)
						$methodDetails.doHideRow:=True:C214
					End if 
					
			End case 
	End case 
	
	
End for each 

$formObj.filteredList:=$formObj.fullList.query("doHideRow = :1"; False:C215)

ON ERR CALL:C155($vt_onErrorMethod)