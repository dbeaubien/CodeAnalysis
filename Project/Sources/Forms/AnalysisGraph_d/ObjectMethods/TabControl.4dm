
C_BOOLEAN:C305(<>_GraphIsInited)
If (Not:C34(<>_GraphIsInited))
	ARRAY PICTURE:C279(<>_Graphs; 1)
	ARRAY TEXT:C222(<>_Graphs_Label; 1)
	<>_Graphs_Label{1}:="no graphs"
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		ARRAY TEXT:C222(tabControl; 0)
		COPY ARRAY:C226(<>_Graphs_Label; tabControl)
		tabControl:=1  // Default
		
		
		//ARRAY TEXT($at_urls;0)
		//ARRAY BOOLEAN($ab_doAllow;0)
		
		//  // First disallow all 
		//APPEND TO ARRAY($at_urls;"*")  // all 
		//APPEND TO ARRAY($ab_doAllow;False)  // forbidden 
		
		//WA SET URL FILTERS(myWebArea;$at_urls;$ab_doAllow)
		
		
End case 

If (tabControl>0) & ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Clicked:K2:4))
	WA OPEN URL:C1020(myWebArea; Get 4D folder:C485(Current resources folder:K5:16)+"Graph_tabs"+Folder separator:K24:12+"tab_"+String:C10(tabControl)+".html")
End if 