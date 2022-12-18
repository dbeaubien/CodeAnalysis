//%attributes = {"invisible":true}
// (PM) UnitTest_AssertEqualArray
// Asserts whether two arrays are identical
// $1 = Pointer to expected array
// $2 = Pointer to actual array
// $3 = Failure message (optional)

C_POINTER:C301($1; $expected)
C_POINTER:C301($2; $actual)
C_TEXT:C284($3; $message)
C_BOOLEAN:C305($equal)
C_LONGINT:C283($index)

$expected:=$1
$actual:=$2

If (Count parameters:C259>=3)
	$message:=$3
End if 

$equal:=True:C214
Case of 
		
	: (Type:C295($expected->)#Type:C295($actual->))
		$equal:=False:C215
		If ($message="")
			$message:="AssertEqualArray Expected array of type "+String:C10(Type:C295($expected->))+" but got "+String:C10(Type:C295($actual->))
		End if 
		
	: (Size of array:C274($expected->)#Size of array:C274($actual->))
		$equal:=False:C215
		If ($message="")
			$message:="AssertEqualArray Expected array of size "+String:C10(Size of array:C274($expected->))+" but got "+String:C10(Size of array:C274($actual->))
		End if 
		
	Else 
		
		For ($index; 1; Size of array:C274($expected->))
			If ($expected->{$index}#$actual->{$index})
				$equal:=False:C215
				If ($message="")
					$message:="AssertEqualArray Arrays differ at item "+String:C10($index)
				End if 
				$index:=Size of array:C274($expected->)+1
			End if 
		End for 
		
End case 

UnitTest_Assert($equal; $message)
