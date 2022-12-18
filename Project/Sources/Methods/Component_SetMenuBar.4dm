//%attributes = {"invisible":true}
// Component_SetMenuBar
// 
// DESCRIPTION
//   Creates and sets the menu bar.
//
// ----------------------------------------------------
// CALLED BY
//   "Generator_d" project form
//   "Preferences_d" project form
// ----------------------------------------------------
// HISTORY
//   Created by: DB (09/17/12)
//   Mod: DB (06/27/2013) - Added menu item for API docs
//   Mod: DB (02/25/2017) - Updated menus, added items for the various windows
//   Mod: DB (03/07/2017) - Added shortcut for Preferences
// ----------------------------------------------------


C_TEXT:C284($_Menu_MenuBar_s; $_Menu_FileMenu_s; $_Menu_EditMenu_s)
//C_BOOLEAN(_LB_MenuBar_init)
//If (Not(_LB_MenuBar_init))
//_LB_MenuBar_init:=True
ARRAY LONGINT:C221($pluginNumbers_al; 0)
ARRAY TEXT:C222($pluginNames_at; 0)

If (True:C214)  // # File Menu
	$_Menu_FileMenu_s:=Create menu:C408
	
	APPEND MENU ITEM:C411($_Menu_FileMenu_s; "About Component...")
	SET MENU ITEM METHOD:C982($_Menu_FileMenu_s; -1; "Component_About_Menu")
	
	APPEND MENU ITEM:C411($_Menu_FileMenu_s; "(-")  // Separator line
	
	APPEND MENU ITEM:C411($_Menu_FileMenu_s; "Preferences...")
	SET MENU ITEM METHOD:C982($_Menu_FileMenu_s; -1; "Component_PrefsDialog_Menu")
	SET MENU ITEM SHORTCUT:C423($_Menu_FileMenu_s; -1; ","; Command key mask:K16:1)  //   Mod: DB (03/07/2017)
	//SET MENU ITEM PROPERTY($_Menu_FileMenu_s;-1;Start a New Process;1)  // Turn this on
	
	APPEND MENU ITEM:C411($_Menu_FileMenu_s; "(-")  // Separator line
	
	APPEND MENU ITEM:C411($_Menu_FileMenu_s; "Open Explorer...")  //   Mod: DB (02/25/2017)
	SET MENU ITEM METHOD:C982($_Menu_FileMenu_s; -1; "Component_Explorer_Menu")  //   Mod: DB (02/25/2017)
	
	APPEND MENU ITEM:C411($_Menu_FileMenu_s; "Open Code Analysis...")  //   Mod: DB (02/25/2017)
	SET MENU ITEM METHOD:C982($_Menu_FileMenu_s; -1; "Component_CA_Window_Menu")  //   Mod: DB (02/25/2017)
	
	APPEND MENU ITEM:C411($_Menu_FileMenu_s; "Quick Launcher...")  //   Mod: DB (02/25/2017)
	SET MENU ITEM METHOD:C982($_Menu_FileMenu_s; -1; "CA_ShowQuickLauncher")  //   Mod: DB (02/25/2017)
	
	APPEND MENU ITEM:C411($_Menu_FileMenu_s; "Run Unit Tests...")  //   Mod: DB (04/07/2017)
	SET MENU ITEM METHOD:C982($_Menu_FileMenu_s; -1; "UnitTest_RunAll")  //   Mod: DB (04/07/2017)
	
	APPEND MENU ITEM:C411($_Menu_FileMenu_s; "(-")  // Separator line
	
	APPEND MENU ITEM:C411($_Menu_FileMenu_s; "Show Release Notes...")
	SET MENU ITEM METHOD:C982($_Menu_FileMenu_s; -1; "Component_DocDialog_Menu")
	
	APPEND MENU ITEM:C411($_Menu_FileMenu_s; "Show API Documentation...")  // Mod by: Dani Beaubien (06/27/2013)
	SET MENU ITEM METHOD:C982($_Menu_FileMenu_s; -1; "Component_APIDialog_Menu")  // Mod by: Dani Beaubien (06/27/2013)
	
	If (Structure file:C489=Structure file:C489(*))
		APPEND MENU ITEM:C411($_Menu_FileMenu_s; "(-")  // Separator line
		APPEND MENU ITEM:C411($_Menu_FileMenu_s; "Quit")
		SET MENU ITEM METHOD:C982($_Menu_FileMenu_s; -1; "Component_Quit_Menu")
	End if 
End if 




If (True:C214)  // # Edit Menu
	$_Menu_EditMenu_s:=Create menu:C408
	
	APPEND MENU ITEM:C411($_Menu_EditMenu_s; "Undo")
	SET MENU ITEM PROPERTY:C973($_Menu_EditMenu_s; -1; Associated standard action name:K28:8; ak undo:K76:51)
	SET MENU ITEM SHORTCUT:C423($_Menu_EditMenu_s; -1; "Z"; Command key mask:K16:1)
	
	APPEND MENU ITEM:C411($_Menu_EditMenu_s; "(-")  // Separator line
	
	APPEND MENU ITEM:C411($_Menu_EditMenu_s; "Cut")
	SET MENU ITEM PROPERTY:C973($_Menu_EditMenu_s; -1; Associated standard action name:K28:8; ak cut:K76:53)
	SET MENU ITEM SHORTCUT:C423($_Menu_EditMenu_s; -1; "X"; Command key mask:K16:1)
	
	APPEND MENU ITEM:C411($_Menu_EditMenu_s; "Copy")
	SET MENU ITEM PROPERTY:C973($_Menu_EditMenu_s; -1; Associated standard action name:K28:8; ak copy:K76:54)
	SET MENU ITEM SHORTCUT:C423($_Menu_EditMenu_s; -1; "C"; Command key mask:K16:1)
	
	APPEND MENU ITEM:C411($_Menu_EditMenu_s; "Paste")
	SET MENU ITEM PROPERTY:C973($_Menu_EditMenu_s; -1; Associated standard action name:K28:8; ak paste:K76:55)
	SET MENU ITEM SHORTCUT:C423($_Menu_EditMenu_s; -1; "V"; Command key mask:K16:1)
	
	APPEND MENU ITEM:C411($_Menu_EditMenu_s; "Clear")
	SET MENU ITEM PROPERTY:C973($_Menu_EditMenu_s; -1; Associated standard action name:K28:8; ak clear:K76:56)
	
	APPEND MENU ITEM:C411($_Menu_EditMenu_s; "Select All")
	SET MENU ITEM PROPERTY:C973($_Menu_EditMenu_s; -1; Associated standard action name:K28:8; ak select all:K76:57)
	SET MENU ITEM SHORTCUT:C423($_Menu_EditMenu_s; -1; "A"; Command key mask:K16:1)
	
	APPEND MENU ITEM:C411($_Menu_EditMenu_s; "(-")  // Separator line
	APPEND MENU ITEM:C411($_Menu_EditMenu_s; "Show Clipboard")
	SET MENU ITEM PROPERTY:C973($_Menu_EditMenu_s; -1; Associated standard action name:K28:8; ak show clipboard:K76:58)
	//SET MENU ITEM METHOD($_Menu_EditMenu_s;-1;"_Menu_Preferences")
End if 



// # Create the full menu bar
$_Menu_MenuBar_s:=Create menu:C408
APPEND MENU ITEM:C411($_Menu_MenuBar_s; "File"; $_Menu_FileMenu_s)
APPEND MENU ITEM:C411($_Menu_MenuBar_s; "Edit"; $_Menu_EditMenu_s)

SET MENU BAR:C67($_Menu_MenuBar_s)

// # Clean up memory
RELEASE MENU:C978($_Menu_MenuBar_s)
RELEASE MENU:C978($_Menu_FileMenu_s)
RELEASE MENU:C978($_Menu_EditMenu_s)

//End if 