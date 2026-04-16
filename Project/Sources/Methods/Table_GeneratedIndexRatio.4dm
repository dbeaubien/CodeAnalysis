//%attributes = {"invisible":true}
// Table_GeneratedIndexRatio ()
// 
// DESCRIPTION
//   Generates a text file that contains the ratio between
//   unique values vs the # of recs in a table.
//
//   Used to determine the type of index a particular field
//   should have.
//
// ----------------------------------------------------

// identify candidate fields for cluster indexes - more speed, smaller indexes, etc.

var $t; $maxTable; $f; $maxField; $fieldtype; $fieldLength : Integer
var $key : Text
var $indexed; $unique : Boolean

ARRAY TEXT:C222($aText; 0)
ARRAY LONGINT:C221($aiLongInt; 0)
ARRAY REAL:C219($arReals; 0)
ARRAY DATE:C224($addates; 0)

Open window:C153(100; 100; 500; 500)

var $vl_fileName; $vt_docName : Text
var $docref : Time
$vl_fileName:=File_GetFolderName(Structure file:C489(*))+Date2String(Current date:C33; "yyyy-mm-dd")+" index ratios.csv"
$docref:=Create document:C266($vl_fileName)
If (OK=1)
	$vt_docName:=Document
	$maxTable:=Last table number:C254
	
	var $line : Text
	$line:="Fields that are indexed and do not require unique values"+Char:C90(Carriage return:K15:38)
	$line:=$line+"The closer to 1 the more likely a cluster B-Tree index should be used."+Char:C90(Carriage return:K15:38)
	$line:=$line+"Ratio =  Num Distinct Values / Num Recs in Table"+(Char:C90(Carriage return:K15:38)*2)
	SEND PACKET:C103($docref; $line)
	
	var $iNumRecs; $iNumDistinct : Integer
	var $fname : Text
	For ($t; 1; $maxTable)
		If (Is table number valid:C999($t))  //v673 tms updated for v11
			var $tName : Text
			$tName:=Table name:C256($t)
			ALL RECORDS:C47(Table:C252($t)->)
			$iNumRecs:=Records in table:C83(Table:C252($t)->)
			$line:="["+$tName+"] Table # "+String:C10($t; "###0")+" Records in table = "+String:C10($iNumRecs; "#######0")+Char:C90(Carriage return:K15:38)
			SEND PACKET:C103($docref; $line)
			$maxField:=Last field number:C255($t)
			For ($f; 1; $maxField)
				MESSAGE:C88(" table "+String:C10($t)+", field "+String:C10($f))
				
				If (Is field number valid:C1000($t; $f))
					GET FIELD PROPERTIES:C258($t; $f; $fieldtype; $fieldLength; $indexed; $unique)
					$fname:=Field name:C257(Field:C253($t; $f))
					If (($indexed) & Not:C34($unique))
						ON ERR CALL:C155("ERROR_Generic")
						Case of 
							: (($fieldtype=Is alpha field:K8:1) | ($fieldtype=Is text:K8:3))
								DISTINCT VALUES:C339(Field:C253($t; $f)->; $aText)
								$iNumDistinct:=Size of array:C274($aText)
								ARRAY TEXT:C222($aText; 0)
								
							: (($fieldtype=Is integer:K8:5) | ($fieldtype=Is longint:K8:6) | ($fieldtype=Is time:K8:8))
								DISTINCT VALUES:C339(Field:C253($t; $f)->; $aiLongInt)
								$iNumDistinct:=Size of array:C274($aiLongInt)
								ARRAY LONGINT:C221($aiLongInt; 0)
								
							: ($fieldtype=Is real:K8:4)
								DISTINCT VALUES:C339(Field:C253($t; $f)->; $arReals)
								$iNumDistinct:=Size of array:C274($arReals)
								ARRAY REAL:C219($arReals; 0)
								
							: (($fieldtype=Is date:K8:7))
								DISTINCT VALUES:C339(Field:C253($t; $f)->; $addates)
								$iNumDistinct:=Size of array:C274($addates)
								ARRAY DATE:C224($addates; 0)
								
							Else 
								$iNumDistinct:=$iNumRecs
						End case 
						
						ON ERR CALL:C155("")
						$key:=String:C10($t; "000")+String:C10($f; "000")
						
						$line:="["+$tName+"]"+$fName+","+String:C10($iNumDistinct/$iNumRecs; "0.000000")+Char:C90(Carriage return:K15:38)
						SEND PACKET:C103($docref; $line)
					End if 
				End if 
			End for 
			SEND PACKET:C103($docref; (Char:C90(Carriage return:K15:38)*2))
			REDUCE SELECTION:C351(Table:C252($t)->; 0)
		End if 
		
	End for 
	
	CLOSE DOCUMENT:C267($docref)
	SHOW ON DISK:C922($vt_docName)
End if 

CLOSE WINDOW:C154
ALERT:C41("analysis completed!")
