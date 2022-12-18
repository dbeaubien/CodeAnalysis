//%attributes = {}
//Doa_4DcommandsGet -> coll
//$0 collection des commandes 4D de la version courante, 
//  [ {name:libelleConstante;token:libelléToken} ]

// FROM DISCUSS FORUM: https://discuss.4d.com/t/formatted-method-code/14299/9

C_COLLECTION:C1488($0; $command_c)
$command_c:=New collection:C1472

C_LONGINT:C283($i_l)
C_TEXT:C284($nom_t; $token_t)
$i_l:=1
Repeat 
	$nom_t:=Command name:C538($i_l)
	If ($nom_t#"")
		$token_t:="C:"+String:C10($i_l)
		$command_c.push(New object:C1471("name"; $nom_t; "token"; $token_t))
	End if 
	$i_l:=$i_l+1
Until (ok=0)
//$test:=$command_c.query("cmde=ds")
$0:=$command_c
//_