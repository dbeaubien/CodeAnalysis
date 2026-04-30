//%attributes = {"invisible":true}
// Spell_GetPathToUserDictationary () : pathToUserDictionary
//
// DESCRIPTION
//   Returns the path to the current custom user dictionary.
//
#DECLARE()->$vt_thePath : Text
// ----------------------------------------------------
$vt_thePath:=""

var $vl_curLangCode : Integer
$vl_curLangCode:=SPELL Get current dictionary:C1205  //196608 for example

$vt_thePath:=Get 4D folder:C485(Active 4D Folder:K5:10)+"UserDictionary"+String:C10($vl_curLangCode)+".dic"
