//%attributes = {"invisible":true}
// Structure__DataType2String (data type; short form)
// does the 4D DataType
#DECLARE($dataType : Integer; $showShortForm : Boolean)->$tmpTxt : Text

$tmpTxt:=""


Case of 
	: ($dataType=Is undefined:K8:13)
		$tmpTxt:="Undefined"
		
	: ($dataType=Is string var:K8:2)
		$tmpTxt:="String Var"
		
	: ($dataType=Is alpha field:K8:1)
		If ($showShortForm)
			$tmpTxt:="A"
		Else 
			$tmpTxt:="Alpha"
		End if 
		
	: ($dataType=Is text:K8:3)
		If ($showShortForm)
			$tmpTxt:="T"
		Else 
			$tmpTxt:="Text"
		End if 
		
	: ($dataType=Is picture:K8:10)
		$tmpTxt:="Picture"
		
	: ($dataType=Is date:K8:7)
		If ($showShortForm)
			$tmpTxt:="D"
		Else 
			$tmpTxt:="Date"
		End if 
		
	: ($dataType=Is BLOB:K8:12)
		$tmpTxt:="BLOB"
		
	: ($dataType=Is boolean:K8:9)
		If ($showShortForm)
			$tmpTxt:="B"
		Else 
			$tmpTxt:="Boolean"
		End if 
		
	: ($dataType=Is subtable:K8:11)
		$tmpTxt:="Subtable"
		
	: ($dataType=Is integer:K8:5)
		If ($showShortForm)
			$tmpTxt:="I16"
		Else 
			$tmpTxt:="Integer"
		End if 
		
	: ($dataType=Is longint:K8:6)
		If ($showShortForm)
			$tmpTxt:="I32"
		Else 
			$tmpTxt:="Longint"
		End if 
		
	: ($dataType=Is integer 64 bits:K8:25)  //   Mod: DB (07/12/2013)
		If ($showShortForm)
			$tmpTxt:="I64"
		Else 
			$tmpTxt:="64 bit Integer"
		End if 
		
	: ($dataType=Is real:K8:4)
		$tmpTxt:="Real"
		
	: ($dataType=Is time:K8:8)
		$tmpTxt:="Time"
		
	: ($dataType=Is pointer:K8:14)
		$tmpTxt:="Pointer"
		
	: ($dataType=Is object:K8:27)
		$tmpTxt:="Object"
		
	Else 
		$tmpTxt:="4D DataType "+String:C10($dataType)
		TRACE:C157
End case 


$0:=$tmpTxt