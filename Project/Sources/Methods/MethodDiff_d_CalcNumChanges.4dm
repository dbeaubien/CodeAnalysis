//%attributes = {"invisible":true}
// MethodDiff_d_CalcNumChanges (backgroundColorArray) : numChangesCount
// MethodDiff_d_CalcNumChanges (array) : longint
//
// DESCRIPTION
//   Calculate the # of changes based on the rows that
//   that have a background colour.
//
C_POINTER:C301($1; $vp_backgroundColorArrayPtr)
C_LONGINT:C283($0; $vl_count)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (10/30/2012)
// ----------------------------------------------------

$vl_count:=0
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$vp_backgroundColorArrayPtr:=$1
	
	C_LONGINT:C283($vl_noChangeColour)
	$vl_noChangeColour:=0x00FFFFFF
	
	
	// Figure out the # of changes
	If (Size of array:C274($vp_backgroundColorArrayPtr->)>0)
		If ($vp_backgroundColorArrayPtr->{1}#$vl_noChangeColour)  // starts with a change
			$vl_count:=1
		End if 
		
		C_LONGINT:C283($vl_currentColour)  // Used to track how long a change is lasting
		$vl_currentColour:=$vp_backgroundColorArrayPtr->{1}
		C_LONGINT:C283($i)
		For ($i; 2; Size of array:C274($vp_backgroundColorArrayPtr->))
			If ($vp_backgroundColorArrayPtr->{$i}#$vl_currentColour)  // start of a change
				
				// only count when the new color is NOT the "No change" colour
				If ($vp_backgroundColorArrayPtr->{$i}#$vl_noChangeColour)
					$vl_count:=$vl_count+1
				End if 
				
				$vl_currentColour:=$vp_backgroundColorArrayPtr->{$i}
			End if 
			
			//If (($vp_backgroundColorArrayPtr->{$i-1}=$vl_noChangeColour) & ($vp_backgroundColorArrayPtr->{$i}#$vl_noChangeColour))  // start of a change
			//$vl_count:=$vl_count+1
			//End if 
		End for 
		
	End if 
	
End if   // ASSERT
$0:=$vl_count
