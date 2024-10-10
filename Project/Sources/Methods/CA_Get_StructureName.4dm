//%attributes = {"invisible":true,"preemptive":"capable"}
// CA_Get_StructureName () : host_structure_filename
// 
// DESCRIPTION
//   This method returns the filename of the host
//   structure.
//
#DECLARE()->$host_structure_filename : Text
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=0)

If (Application type:C494=4D Remote mode:K5:5)
	$host_structure_filename:=Structure file:C489(*)
Else 
	var $structure : 4D:C1709.File
	$structure:=File:C1566(Structure file:C489(*); fk platform path:K87:2)
	$host_structure_filename:=$structure.name
End if 