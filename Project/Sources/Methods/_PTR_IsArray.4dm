//%attributes = {"invisible":true}
// ----------------------------------------------------
// User name (OS): ddancy
// Date and time: 19/02/08, 22:09:51
// ----------------------------------------------------
// Method: _PTR_IsArray
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1; $Var_ptr)
C_BOOLEAN:C305($0; $IsArray_b)

$IsArray_b:=False:C215

If (Count parameters:C259>0)
	$Var_ptr:=$1
	
	If (Not:C34(Is nil pointer:C315($Var_ptr)))
		
		C_LONGINT:C283($Type_l)
		$Type_l:=Type:C295($Var_ptr->)
		
		$IsArray_b:=True:C214
		
		Case of 
			: ($Type_l=Boolean array:K8:21)
			: ($Type_l=Integer array:K8:18)
			: ($Type_l=LongInt array:K8:19)
			: ($Type_l=Real array:K8:17)
			: ($Type_l=Date array:K8:20)
				//: ($Type_l=Time array)
			: ($Type_l=String array:K8:15)
			: ($Type_l=Text array:K8:16)
			: ($Type_l=Picture array:K8:22)
				//: ($Type_l=BLOB array )
			: ($Type_l=Pointer array:K8:23)
			: ($Type_l=Array 2D:K8:24)
				
			Else 
				$IsArray_b:=False:C215
				
		End case 
		
	End if 
	
End if 

$0:=$IsArray_b

