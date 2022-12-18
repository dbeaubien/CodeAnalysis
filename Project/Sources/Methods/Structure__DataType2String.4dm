//%attributes = {"invisible":true}
// Structure__DataType2String (data type; short form)
// does the 4D DataType

C_TEXT:C284($0; $tmpTxt)
$tmpTxt:=""

C_LONGINT:C283($1; $dataType)
C_BOOLEAN:C305($2; $showShortForm)
$dataType:=$1
$showShortForm:=False:C215
If (Count parameters:C259=2)
	$showShortForm:=$2
End if 

Case of 
	: ($1=Is undefined:K8:13)
		$tmpTxt:="Undefined"
		
	: ($1=Is string var:K8:2)
		$tmpTxt:="String Var"
		
	: ($1=Is alpha field:K8:1)
		If ($showShortForm)
			$tmpTxt:="A"
		Else 
			$tmpTxt:="Alpha"
		End if 
		
	: ($1=Is text:K8:3)
		If ($showShortForm)
			$tmpTxt:="T"
		Else 
			$tmpTxt:="Text"
		End if 
		
	: ($1=Is picture:K8:10)
		$tmpTxt:="Picture"
		
	: ($1=Is date:K8:7)
		If ($showShortForm)
			$tmpTxt:="D"
		Else 
			$tmpTxt:="Date"
		End if 
		
	: ($1=Is BLOB:K8:12)
		$tmpTxt:="BLOB"
		
	: ($1=Is boolean:K8:9)
		If ($showShortForm)
			$tmpTxt:="B"
		Else 
			$tmpTxt:="Boolean"
		End if 
		
	: ($1=Is subtable:K8:11)
		$tmpTxt:="Subtable"
		
	: ($1=Is integer:K8:5)
		If ($showShortForm)
			$tmpTxt:="I16"
		Else 
			$tmpTxt:="Integer"
		End if 
		
	: ($1=Is longint:K8:6)
		If ($showShortForm)
			$tmpTxt:="I32"
		Else 
			$tmpTxt:="Longint"
		End if 
		
	: ($1=Is integer 64 bits:K8:25)  //   Mod: DB (07/12/2013)
		If ($showShortForm)
			$tmpTxt:="I64"
		Else 
			$tmpTxt:="64 bit Integer"
		End if 
		
	: ($1=_o_Is float:K8:26)
		$tmpTxt:="Float"
		
	: ($1=Is real:K8:4)
		$tmpTxt:="Real"
		
	: ($1=Is time:K8:8)
		$tmpTxt:="Time"
		
	: ($1=Is pointer:K8:14)
		$tmpTxt:="Pointer"
		
	: ($1=Is object:K8:27)
		$tmpTxt:="Object"
		
	Else 
		$tmpTxt:="4D DataType "+String:C10($1)
		TRACE:C157
End case 


$0:=$tmpTxt