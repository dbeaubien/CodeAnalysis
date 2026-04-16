//%attributes = {"invisible":true}
// ExportDocs___OutputModuleAsHTML (root Folder; progressBarID)
//
// DESCRIPTION
//   Outputs the modules to HTML files.
//
#DECLARE($rootFolder : Text; $progHdl : Integer)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	var $moduleRootFolder : Text
	$moduleRootFolder:=$rootFolder+"Modules"+Folder separator:K24:12
	Folder_VerifyExistance($moduleRootFolder)
	
	var MethodStatsMasterObj : Object
	MethodStats__Init  // defines MethodStatsMasterObj
	
	ARRAY TEXT:C222($methodObjNames; 0)
	Method_GetMethodObjNames(->$methodObjNames; True:C214)
	
	var $hasModules : Boolean
	If (True:C214)  // Determine if there are modules
		var $i : Integer
		For ($i; 1; Size of array:C274($methodObjNames))
			If (MethodStatsMasterObj[$methodObjNames{$i}].in_module#"")
				$hasModules:=True:C214
				$i:=Size of array:C274($methodObjNames)+1  // Break the loop
			End if 
		End for 
	End if 
	
	var $templateHTML : Text
	If ($hasModules)  // Load the HTML Template
		var $templateSourceFolder : Text
		$templateSourceFolder:=Get 4D folder:C485(Current resources folder:K5:16)+"HTML Tempates"+Folder separator:K24:12
		
		$templateHTML:=""
		If (File_DoesExist($templateSourceFolder+"module-template.html"))  // Load the HTML Template
			$templateHTML:=Document to text:C1236($templateSourceFolder+"module-template.html")
		End if 
	End if 
	
	If ($templateHTML#"")  // Save the method files to disk
		var $j : Integer
		var $methodObj : Object
		var $previousMethodModule; $buffer : Text
		$previousMethodModule:=Char:C90(Escape:K15:39)  // use some totally bogus value that will not match anything
		For ($i; 1; Size of array:C274($methodObjNames))
			$methodObj:=MethodStatsMasterObj[$methodObjNames{$i}]
			
			If ($previousMethodModule#$methodObj.in_module) & ($methodObj.in_module#"")
				$previousMethodModule:=$methodObj.in_module
				
				$buffer:=$templateHTML
				$buffer:=Replace string:C233($buffer; "###PageTitle###"; "Module: "+$methodObj.in_module)
				$buffer:=Replace string:C233($buffer; "###MethodNameAndParms###"; $methodObj.in_module)
				
				var $fileRef : Time
				$fileRef:=Create document:C266($moduleRootFolder+Replace string:C233($methodObj.in_module; "/"; "-")+".html")
				If (OK=1)
					
					var $methodBufferOther : Text
					var $methodObjOther : Object
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