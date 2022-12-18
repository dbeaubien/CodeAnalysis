
If (Form:C1466.methodsWithDifference.length>0)
	C_TEXT:C284($saveToFilePath)
	$saveToFilePath:=Select document:C905(1234; "txt"; "Save Results as:"; File name entry:K24:17+Use sheet window:K24:11)
	If (OK=1)
		$saveToFilePath:=Document
		
		C_TEXT:C284($results)
		$results:="Method Path\tDescription\tPath\r"
		C_OBJECT:C1216($row)
		For each ($row; Form:C1466.methodsWithDifference)
			$results:=$results+$row.methodName+"\t"+$row.description+"\t"+Replace string:C233($row.methodPathOnDisk; vt_lastDIFFCheck_Folder; "")+"\r"
		End for each 
		
		TEXT TO DOCUMENT:C1237($saveToFilePath; $results)
		SHOW ON DISK:C922($saveToFilePath)
	End if 
	
Else 
	ALERT:C41("Nothing to save")
End if 