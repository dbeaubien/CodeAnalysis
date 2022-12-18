//%attributes = {"invisible":true}
// ExportDocs___OutputModuleAsHTML (root Folder; progressBarID)
// ExportDocs___OutputModuleAsHTML (text; longint)
//
// DESCRIPTION
//   Outputs the modules to HTML files.
//
C_TEXT:C284($1; $rootFolder)
C_LONGINT:C283($2; $progHdl)
// ----------------------------------------------------
//   Created by: Dani Beaubien (08/06/2013)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	$rootFolder:=$1
	$progHdl:=$2
	
	C_TEXT:C284($moduleRootFolder)
	$moduleRootFolder:=$rootFolder+"Modules"+Folder separator:K24:12
	Folder_VerifyExistance($moduleRootFolder)
	
	C_OBJECT:C1216(MethodStatsMasterObj)
	MethodStats__Init  // defines MethodStatsMasterObj
	
	ARRAY TEXT:C222($methodObjNames; 0)
	Method_GetMethodObjNames(->$methodObjNames; True:C214)
	
	C_BOOLEAN:C305($hasModules)
	If (True:C214)  // Determine if there are modules
		C_LONGINT:C283($i)
		For ($i; 1; Size of array:C274($methodObjNames))
			If (MethodStatsMasterObj[$methodObjNames{$i}].in_module#"")
				$hasModules:=True:C214
				$i:=Size of array:C274($methodObjNames)+1  // Break the loop
			End if 
		End for 
	End if 
	
	C_TEXT:C284($templateHTML)
	If ($hasModules)  // Load the HTML Template
		C_TEXT:C284($templateSourceFolder)
		$templateSourceFolder:=Get 4D folder:C485(Current resources folder:K5:16)+"HTML Tempates"+Folder separator:K24:12
		
		$templateHTML:=""
		If (File_DoesExist($templateSourceFolder+"module-template.html"))  // Load the HTML Template
			$templateHTML:=Document to text:C1236($templateSourceFolder+"module-template.html")
		End if 
	End if 
	
	If ($templateHTML#"")  // Save the method files to disk
		C_LONGINT:C283($j)
		C_OBJECT:C1216($methodObj)
		C_TEXT:C284($previousMethodModule; $buffer)
		$previousMethodModule:=Char:C90(Escape:K15:39)  // use some totally bogus value that will not match anything
		For ($i; 1; Size of array:C274($methodObjNames))
			$methodObj:=MethodStatsMasterObj[$methodObjNames{$i}]
			
			If ($previousMethodModule#$methodObj.in_module) & ($methodObj.in_module#"")
				$previousMethodModule:=$methodObj.in_module
				
				$buffer:=$templateHTML
				$buffer:=Replace string:C233($buffer; "###PageTitle###"; "Module: "+$methodObj.in_module)
				$buffer:=Replace string:C233($buffer; "###MethodNameAndParms###"; $methodObj.in_module)
				
				C_TIME:C306($fileRef)
				$fileRef:=Create document:C266($moduleRootFolder+Replace string:C233($methodObj.in_module; "/"; "-")+".html")
				If (OK=1)
					
					C_TEXT:C284($methodBufferOther)
					C_OBJECT:C1216($methodObjOther)
					$methodBufferOther:="<table width=100%>"
					For ($j; 1; Size of array:C274($methodObjNames))
						$methodObjOther:=MethodStatsMasterObj[$methodObjNames{$j}]
						
						If ($methodObjOther.in_module=$methodObj.in_module)  // part of the module?
							$methodBufferOther:=$methodBufferOther+"<tr><td>"
							$methodBufferOther:=$methodBufferOther+"<a href=\"../Methods/"+Replace string:C233($methodObjOther.path; "/"; "-")+".html\">"
							$methodBufferOther:=$methodBufferOther+STR_URLDecode($methodObjOther.path)+"</a>"+MethodScan_MethodParmList_SHORT($methodObjOther.path)
							$methodBufferOther:=$methodBufferOther+"</td></tr>"+Pref_GetEOL
						End if 
						
					End for 
					$methodBufferOther:=$methodBufferOther+"</table>"+Pref_GetEOL
					$buffer:=Replace string:C233($buffer; "###MethodContent###"; $methodBufferOther)
					
					SEND PACKET:C103($fileRef; $buffer)
					CLOSE DOCUMENT:C267($fileRef)
				End if 
			End if 
			
			Progress SET PROGRESS($progHdl; $i/Size of array:C274($methodObjNames))
		End for 
		
	End if 
End if 