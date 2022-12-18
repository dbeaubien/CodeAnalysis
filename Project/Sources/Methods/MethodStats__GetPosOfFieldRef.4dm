//%attributes = {"invisible":true}
// MethodStats__GetPosOfFieldRef (tokenArrPtr; commandNo; curTokenPos) : $vl_posOfFieldReference
// MethodStats__GetPosOfFieldRef (pointer; longint) : longint
// 
// DESCRIPTION
//   
//
C_POINTER:C301($1; $ap_tokensArrPtr)
C_LONGINT:C283($2; $vl_commandNo)
C_LONGINT:C283($3; $vl_curTokenPos)
C_LONGINT:C283($0; $vl_posOfFieldReference)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (04/09/2017)
// ----------------------------------------------------

$vl_posOfFieldReference:=0
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 3; Count parameters:C259))
	$ap_tokensArrPtr:=$1
	$vl_commandNo:=$2
	$vl_curTokenPos:=$3
	
	// Try to interpret the tokens based on the command
	Case of 
		: ($vl_commandNo=277) | ($vl_commandNo=341)  // QUERY or QUERY SELECTION
			If (Size of array:C274($ap_tokensArrPtr->)>($vl_curTokenPos+6))
				If ($ap_tokensArrPtr->{$vl_curTokenPos+4}="[@")  // of form--> QUERY([Table_4];[Table_4]Filed_6_IndexPart1="asfd")
					$vl_posOfFieldReference:=$vl_curTokenPos+4  // location of field
				Else 
					If ($ap_tokensArrPtr->{$vl_curTokenPos+6}="[@")  // of form--> QUERY([Table_4]; & ;[Table_4]Field_3="asfd")
						$vl_posOfFieldReference:=$vl_curTokenPos+6  // location of field
					End if 
				End if 
			End if 
			
			
		: ($vl_commandNo=644) | ($vl_commandNo=1050)  // QUERY WITH ARRAY or QUERY SELECTION WITH ARRAY
			If (Size of array:C274($ap_tokensArrPtr->)>($vl_curTokenPos+4))
				If ($ap_tokensArrPtr->{$vl_curTokenPos+2}="[@")  // of form--> QUERY WITH ARRAY([Table_4]Filed_6_IndexPart1;$al_someArr)
					$vl_posOfFieldReference:=$vl_curTokenPos+2
				End if 
			End if 
			
			
		: ($vl_commandNo=339)  // DISTINCT VALUES
			If (Size of array:C274($ap_tokensArrPtr->)>($vl_curTokenPos+4))
				If ($ap_tokensArrPtr->{$vl_curTokenPos+2}="[@")  // of form--> DISTINCT VALUES([Table_4]Filed_6_IndexPart1;$al_someArr)
					$vl_posOfFieldReference:=$vl_curTokenPos+2
				End if 
			End if 
			
			
		: ($vl_commandNo=653)  // Find in field
			If (Size of array:C274($ap_tokensArrPtr->)>($vl_curTokenPos+2))
				If ($ap_tokensArrPtr->{$vl_curTokenPos+2}="[@")  // of form--> Find in field([Table_4]Filed_6_IndexPart1;"somevalue")
					$vl_posOfFieldReference:=$vl_curTokenPos+2
				End if 
			End if 
			
			
		: ($vl_commandNo=1)  // Sum
			If (Size of array:C274($ap_tokensArrPtr->)>($vl_curTokenPos+2))
				If ($ap_tokensArrPtr->{$vl_curTokenPos+2}="[@")  // of form--> Find in field([Table_4]Filed_6_IndexPart1;"somevalue")
					$vl_posOfFieldReference:=$vl_curTokenPos+2
				End if 
			End if 
			
			
		: ($vl_commandNo=3)  // Max
			If (Size of array:C274($ap_tokensArrPtr->)>($vl_curTokenPos+2))
				If ($ap_tokensArrPtr->{$vl_curTokenPos+2}="[@")  // of form--> Find in field([Table_4]Filed_6_IndexPart1;"somevalue")
					$vl_posOfFieldReference:=$vl_curTokenPos+2
				End if 
			End if 
			
			
		: ($vl_commandNo=4)  // Min
			If (Size of array:C274($ap_tokensArrPtr->)>($vl_curTokenPos+2))
				If ($ap_tokensArrPtr->{$vl_curTokenPos+2}="[@")  // of form--> Find in field([Table_4]Filed_6_IndexPart1;"somevalue")
					$vl_posOfFieldReference:=$vl_curTokenPos+2
				End if 
			End if 
			
	End case 
End if   // ASSERT
$0:=$vl_posOfFieldReference