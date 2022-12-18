//%attributes = {}
//Doa_controlFlowsGet -> coll
//$0 instruction de branchement du langage
//#TODO à gérer 
//  le ':' à l'intérieur de 'Au cas ou/Fin de cas'
//  le For each(Element_courant;Expression{;début{;fin}}){Until|While}(Expression_booléenne)}

// FROM DISCUSS FORUM: https://discuss.4d.com/t/formatted-method-code/14299/9

C_COLLECTION:C1488($0; $keyword_c)
$keyword_c:=New collection:C1472

If (Command name:C538(1)="Sum")  //en
	$keyword_c.push(New object:C1471("start"; "If"; "end"; "End if"; "else"; "Else"))
	$keyword_c.push(New object:C1471("start"; "Case of"; "end"; "End case"; "else"; "Else"; "branch"; ":"))
	$keyword_c.push(New object:C1471("start"; "For"; "end"; "End for"))
	$keyword_c.push(New object:C1471("start"; "While"; "end"; "End while"))
	$keyword_c.push(New object:C1471("start"; "Repeat"; "end"; "Until"))
	$keyword_c.push(New object:C1471("start"; "Begin SQL"; "end"; "End SQL"))
	$keyword_c.push(New object:C1471("start"; "For each"; "end"; "End for each"))
Else   //fr
	$keyword_c.push(New object:C1471("start"; "Si"; "end"; "Fin de si"; "else"; "Sinon"))
	$keyword_c.push(New object:C1471("start"; "Au cas ou"; "end"; "Fin de cas"; "else"; "Sinon"; "branch"; ":"))
	$keyword_c.push(New object:C1471("start"; "Boucle"; "end"; "Fin de boucle"))
	$keyword_c.push(New object:C1471("start"; "Tant que"; "end"; "Fin tant que"))
	$keyword_c.push(New object:C1471("start"; "Repeter"; "end"; "Jusque"))
	$keyword_c.push(New object:C1471("start"; "Debut SQL"; "end"; "Fin SQL"))
	$keyword_c.push(New object:C1471("start"; "Pour chaque"; "end"; "Fin de chaque"))
End if 
$0:=$keyword_c
//_
