//%attributes = {}
//Xml_ToObject (refXML_t) -> obj
//conversion xml -> objet
//méthode ré entrante
//exemple d'appel :
//  $xml_t:=DOM Analyser source XML($path_t)
//  $out_o:=Xml_ToObject ($xml_t)
//  DOM FERMER XML($xml_t)
//posté sur http://forums.4d.fr/Post/FR/18847378/1/18847379#18847379
//http://www.utilities-online.info/xmltojson/#.WiQVbrZe4eP
//#TODO
//•Le site xmltojson ci-dessus est capable de faire xml -> json -> xml sans perte…
//  noter en particulier 
//  conservation des en-têtes xml
//  la conversion XML élément/attribut : propriété json sans/avec "-" en préfixe 

//µ Arnaud * 19/10/2019 * dot notation, collection remplace tableau objet,
//  bug lecture éléments tableau OK (tels que <note> dans .xlf 4d) corrigé
//© Arnaud * 29/12/2016

// FROM DISCUSS FORUM: https://discuss.4d.com/t/can-i-get-the-name-of-4d-constants-modifiers-or-key-codes/14810/13

#DECLARE($ref_xml : Text) : Object

var $count_l : Integer
var $i_l : Integer
var $j_l : Integer
var $k_l : Integer
var $nbAttribs_l : Integer
var $nbElementsEnfants_l : Integer
var $pos_l : Integer
var $nomElementCourant_t : Text
var $propriete_t : Text
var $refXMLcourant_t : Text
var $valeur_t : Text
var $valeurElementCourant_t : Text
var $element_o : Object
var $objEnfant_o : Object
var $out_o : Object
var $temp_o : Object
ARRAY LONGINT:C221($type_al; 0)
ARRAY TEXT:C222($nomElementEnfant_at; 0)
ARRAY TEXT:C222($prop_at; 0)
ARRAY TEXT:C222($refXMLenfant_at; 0)
var $nomFrereSuivant_t : Text
var $convertirNomNonConforme_b : Boolean
var $proprieteJson_t : Text

$out_o:=New object:C1471
$element_o:=New object:C1471
$convertirNomNonConforme_b:=True:C214
$refXMLcourant_t:=$ref_xml

DOM GET XML ELEMENT NAME:C730($refXMLcourant_t; $nomElementCourant_t)
DOM GET XML ELEMENT VALUE:C731($refXMLcourant_t; $valeurElementCourant_t)

$nbAttribs_l:=DOM Count XML attributes:C727($refXMLcourant_t)
If ($nbAttribs_l>0)
	For ($i_l; 1; $nbAttribs_l)
		DOM GET XML ATTRIBUTE BY INDEX:C729($refXMLcourant_t; $i_l; $propriete_t; $valeur_t)
		$element_o[$propriete_t]:=$valeur_t
	End for 
End if 

DOM GET XML CHILD NODES:C1081($refXMLcourant_t; $type_al; $refXMLenfant_at)
ARRAY TEXT:C222($nomElementEnfant_at; Size of array:C274($refXMLenfant_at))
For ($i_l; Size of array:C274($type_al); 1; -1)
	If ($type_al{$i_l}=XML ELEMENT:K45:20)  //11
		DOM GET XML ELEMENT NAME:C730($refXMLenfant_at{$i_l}; $nomElementEnfant_at{$i_l})
	Else   //autre, ignorer
		DELETE FROM ARRAY:C228($refXMLenfant_at; $i_l)
		DELETE FROM ARRAY:C228($nomElementEnfant_at; $i_l)
	End if 
End for 

$nbElementsEnfants_l:=Size of array:C274($nomElementEnfant_at)
If ($nbElementsEnfants_l>0)
	ARRAY OBJECT:C1221($element_ao; 0x0000)  //#TODO remplacer par collection
	
	For ($i_l; 1; $nbElementsEnfants_l)
		
		$propriete_t:=$nomElementEnfant_at{$i_l}
		$count_l:=Count in array:C907($nomElementEnfant_at; $propriete_t)
		$pos_l:=Find in array:C230($nomElementEnfant_at; $propriete_t; $i_l+1)
		$objEnfant_o:=Xml_ToObject($refXMLenfant_at{$i_l})
		ASSERT:C1129(Not:C34(OB Is empty:C1297($objEnfant_o)))
		OB GET PROPERTY NAMES:C1232($objEnfant_o; $prop_at; $type_al)
		
		For ($j_l; 1; Size of array:C274($prop_at))
			ASSERT:C1129($propriete_t=$prop_at{1})
			If ($count_l>1)  //in array
				$k_l:=Size of array:C274($element_ao)+1
				INSERT IN ARRAY:C227($element_ao; $k_l)
				$element_ao{$k_l}:=New object:C1471()
				$element_ao{$k_l}[$propriete_t]:=$objEnfant_o[$propriete_t]
				If ($pos_l<1)  //last in array
					var $temp_c : Collection
					$temp_c:=New collection:C1472
					For ($k_l; 1; Size of array:C274($element_ao))
						$temp_c.push($element_ao{$k_l}[$propriete_t])
					End for 
					$element_o[$propriete_t]:=$temp_c
					CLEAR VARIABLE:C89($temp_c)
					CLEAR VARIABLE:C89($element_ao)
				End if 
			Else   //not in array
				If (Position:C15("."; $propriete_t; *)>0) & ($convertirNomNonConforme_b)  //la propriété contient un point
					$proprieteJson_t:=Replace string:C233($propriete_t; "."; "__"; *)
				Else 
					$proprieteJson_t:=$propriete_t
				End if 
				$element_o[$proprieteJson_t]:=$objEnfant_o[$propriete_t]
			End if 
		End for 
	End for 
End if 

If (OB Is empty:C1297($element_o))
	$out_o[$nomElementCourant_t]:=$valeurElementCourant_t
Else 
	$out_o[$nomElementCourant_t]:=$element_o
End if 

return $out_o