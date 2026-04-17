//%attributes = {"invisible":true}
// (PM) UnitTest_ShowDialog

var $window : Integer

$window:=Open form window:C675("UnitTest_Dialog"; Plain window:K34:13; Horizontally centered:K39:1; Vertically centered:K39:4)
DIALOG:C40("UnitTest_Dialog")
CLOSE WINDOW:C154($window)
