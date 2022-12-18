//%attributes = {"invisible":true}
// Spell_GetPathToUserDictationary () : pathToUserDictionary
// Spell_GetPathToUserDictationary () : text
//
// DESCRIPTION
//   Returns the path to the current custom user dictionary.
//
C_TEXT:C284($0; $vt_thePath)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (01/26/2013)
// ----------------------------------------------------

$vt_thePath:=""

C_LONGINT:C283($vl_curLangCode)
$vl_curLangCode:=SPELL Get current dictionary:C1205  //196608 for example

$vt_thePath:=Get 4D folder:C485(Active 4D Folder:K5:10)+"UserDictionary"+String:C10($vl_curLangCode)+".dic"

$0:=$vt_thePath
