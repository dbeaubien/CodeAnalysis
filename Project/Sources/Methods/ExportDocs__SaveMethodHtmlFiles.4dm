//%attributes = {"invisible":true}
// ExportDocs__SaveMethodHtmlFiles (root Folder; progressBarID)
// ExportDocs__SaveMethodHtmlFiles (text; longint)
//
// DESCRIPTION
//   Outputs each method's documentation to HTML files.
//
C_TEXT:C284($1; $rootFolder)
C_LONGINT:C283($2; $progressHdl)
// ----------------------------------------------------
// User name (OS): Dani Beaubien
// Date and time: 03/07/12, 12:22:56
//   Mod by: Dani Beaubien (10/02/2012) - Add support to limit to just methods viewable by the host DB
//   Mod by: Dani Beaubien (01/25/2013) - Use "pretty" method names in the output.
//   Mod by: Dani Beaubien (01/27/2021) - Refactored to use objects rather than arrays.
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=2)
$rootFolder:=$1
$progressHdl:=$2

C_BOOLEAN:C305($onlyExportSharedMethods)
C_TEXT:C284($methodRootFolder; $templateSourceFolder)
C_TEXT:C284($templateHTML)
If (True:C214)  // prep our vars
	$onlyExportSharedMethods:=(Pref_GetPrefString("HTML do Component View"; "0")="1")
	$templateSourceFolder:=Get 4D folder:C485(Current resources folder:K5:16)+"HTML Tempates"+Folder separator:K24:12
	$methodRootFolder:=$rootFolder+"Methods"+Folder separator:K24:12
	Folder_VerifyExistance($templateSourceFolder)
	Folder_VerifyExistance($methodRootFolder)
	
	If (File_DoesExist($templateSourceFolder+"method-template.html"))  // Load the HTML Template
		$templateHTML:=Document to text:C1236($templateSourceFolder+"method-template.html")
	End if 
End if 

MethodStats__Init  // Prep the vars
//MethodStats__UpstreamMethodRefs 

ARRAY TEXT:C222($methodObjNames; 0)
Method_GetMethodObjNames(->$methodObjNames; $onlyExportSharedMethods)

ARRAY TEXT:C222($at_otherMethodsCalledAsHTML; Size of array:C274($methodObjNames))
ARRAY TEXT:C222($at_calledByOtherMethodsAsHTML; Size of array:C274($methodObjNames))
If (True:C214)  // work out the hrefs for the upsteam/downstream methods
	C_OBJECT:C1216($methodObj)
	C_LONGINT:C283($i; $j)
	C_TEXT:C284($value)
	C_COLLECTION:C1488($hrefList)
	For ($i; 1; Size of array:C274($methodObjNames))
		$methodObj:=MethodStatsMasterObj[$methodObjNames{$i}]
		
		// # Loop through all the "calling" methods and generate href links for them
		$hrefList:=New collection:C1472
		For each ($value; $methodObj.references.upstream_methods)
			$hrefList.push(" <a href=\""+Replace string:C233($value; "/"; "-")+".html\">"+$value+"</a>")
		End for each 
		If ($hrefList.length=0)
			$hrefList.push(" none")
		End if 
		$at_calledByOtherMethodsAsHTML{$i}:=$hrefList.join(", "+Pref_GetEOL)
		
		// # Loop through all the "called" methods and generate href links for them
		$hrefList:=New collection:C1472
		For each ($value; $methodObj.references.downstream_methods)
			$hrefList.push(" <a href=\""+Replace string:C233($value; "/"; "-")+".html\">"+$value+"</a>")
		End for each 
		If ($hrefList.length=0)
			$hrefList.push(" none")
		End if 
		$at_otherMethodsCalledAsHTML{$i}:=$hrefList.join(", "+Pref_GetEOL)
	End for 
	
End if 

If (True:C214)  // # Save the method files to disk
	C_OBJECT:C1216($methodObj; $reference)
	C_COLLECTION:C1488($list)
	C_TEXT:C284($fileHTML; $methodHTML; $methodComment)
	For ($i; 1; Size of array:C274($methodObjNames))
		$methodObj:=MethodStatsMasterObj[$methodObjNames{$i}]
		
		$methodHTML:=""
		$methodHTML:=$methodHTML+MethodScan_MethodParmList_LONG($methodObj.path)
		$methodHTML:=$methodHTML+"<table width=100%><tr>"
		
		// ### LEFT COLUMN START
		$methodHTML:=$methodHTML+"<td valign=top>"
		
		// # Build the method header
		$methodHTML:=$methodHTML+"<div class=\"methodHeader\">"
		METHOD GET COMMENTS:C1189($methodObj.path; $methodComment; *)  // Add method comment (if there is one)
		Case of 
			: ($methodComment#"")  // Only output the 4d Project Method Comment
				$methodComment:=Replace string:C233($methodComment; " "; "&nbsp;")
				$methodHTML:=$methodHTML+$methodComment
				
			: (String:C10($methodObj.documentation)#"")  // Use the method's comments from code
				$methodComment:=Replace string:C233($methodObj.documentation; "//"; "")
				$methodComment:=Replace string:C233($methodComment; " "; "&nbsp;")
				$methodHTML:=$methodHTML+$methodComment
				
			Else 
				$methodHTML:=$methodHTML+"METHOD: "+STR_URLDecode($methodObj.path)  // Use "pretty" method names in the output.
		End case 
		$methodHTML:=$methodHTML+"</div><br/>"
		
		
		// ### LEFT COLUMN END
		$methodHTML:=$methodHTML+"</td>"
		
		
		If (Not:C34($onlyExportSharedMethods))  // ### RIGHT COLUMN START
			$methodHTML:=$methodHTML+"<td width=300px valign=top>"
			
			// # Line Counts
			$methodHTML:=$methodHTML+"<div class=\"methodCalls\">"
			$methodHTML:=$methodHTML+"<b>Method Stats</b>:"+Pref_GetEOL
			$methodHTML:=$methodHTML+STR_RightJustify(String:C10($methodObj.line_counts.lines); 6)+" lines of code"+Pref_GetEOL
			$methodHTML:=$methodHTML+STR_RightJustify(String:C10($methodObj.line_counts.comments); 6)+" comment lines"+Pref_GetEOL
			$methodHTML:=$methodHTML+STR_RightJustify(String:C10($methodObj.line_counts.blank); 6)+" blank lines"+Pref_GetEOL
			$methodHTML:=$methodHTML+STR_RightJustify(String:C10($methodObj.analysis.complexity); 6)+" Cyclomatic Complexity"+Pref_GetEOL
			$methodHTML:=$methodHTML+"</div><br/>"
			
			If (True:C214)  // # Method Callers / Called By
				$methodHTML:=$methodHTML+"<div class=\"methodCalls\">"
				$methodHTML:=$methodHTML+"This Method Calls:<br/>"+$at_otherMethodsCalledAsHTML{$i}
				$methodHTML:=$methodHTML+"<br/><br/>"
				$methodHTML:=$methodHTML+"This Method is Called by:<br/>"+$at_calledByOtherMethodsAsHTML{$i}
				$methodHTML:=$methodHTML+"</div><br/>"+Pref_GetEOL
			End if 
			
			If ($methodObjNames{$i}="__TEST")
				
			End if 
			
			If ($methodObj.references.tables_used.length>1)
				$list:=New collection:C1472
				For each ($reference; $methodObj.references.tables_used)
					$list.push($reference.tableName)
				End for each 
				$methodHTML:=$methodHTML+"<div class=\"methodCalls\">"
				$methodHTML:=$methodHTML+"<b>Tables Used</b>:"+Pref_GetEOL
				$methodHTML:=$methodHTML+$list.join("<br/>")
				$methodHTML:=$methodHTML+"</div><br/>"
			End if 
			If ($methodObj.references.fields_used.length>1)
				$list:=New collection:C1472
				For each ($reference; $methodObj.references.fields_used)
					$list.push($reference.fieldName)
				End for each 
				$methodHTML:=$methodHTML+"<div class=\"methodCalls\">"
				$methodHTML:=$methodHTML+"<b>Fields Used</b>:"+Pref_GetEOL
				$methodHTML:=$methodHTML+$list.join("<br/>")
				$methodHTML:=$methodHTML+"</div><br/>"
			End if 
			
			// ### RIGHT COLUMN END
			$methodHTML:=$methodHTML+"</td>"+Pref_GetEOL
			
		End if 
		$methodHTML:=$methodHTML+"</tr></table>"+Pref_GetEOL
		$methodHTML:=Replace string:C233($methodHTML; Pref_GetEOL; "<br/>")  //   Mod: DB (02/18/2014)
		
		
		C_TEXT:C284($fileHTML)
		If (True:C214)  // put the html file together
			$fileHTML:=$templateHTML
			$fileHTML:=Replace string:C233($fileHTML; "###PageTitle###"; "Method: "+$methodObj.path)
			$fileHTML:=Replace string:C233($fileHTML; "###MethodNameAndParms###"; $methodObjNames{$i}+MethodScan_MethodParmList_SHORT($methodObj.path))
			$fileHTML:=Replace string:C233($fileHTML; "###LastModBy###"; Date2String(TS_GetDate($methodObj.last_modified_dts))+" "+Time2String(TS_GetTime($methodObj.last_modified_dts)))
			
			$fileHTML:=Replace string:C233($fileHTML; "###MethodContent###"; $methodHTML)
		End if 
		
		If (True:C214)  // write the HTML to disk
			C_TIME:C306($fileRef)
			$fileRef:=Create document:C266($methodRootFolder+Replace string:C233($methodObj.path; "/"; "-")+".html")
			If (OK=1)
				SEND PACKET:C103($fileRef; $fileHTML)
				CLOSE DOCUMENT:C267($fileRef)
			End if 
		End if 
		
		If (Mod:C98($i; 17)=1)
			Progress SET PROGRESS($progressHdl; $i/Size of array:C274($methodObjNames))
		End if 
	End for 
End if 
