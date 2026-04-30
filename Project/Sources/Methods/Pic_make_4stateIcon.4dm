//%attributes = {"invisible":true}
//  Pic_make_4stateIcon 
// Written by: Miyako 
// ------------------ 
// Method: Pic_make_4stateIcon (picture{;longint}) -> picture 
// $1 is a picture 
// $2 is the target size of the final icon -  will be square 
// $0 is a 4 state icon image made from that picture 
// Purpose: takes the picture in $1 and generates a new picture with 
// the original image and the 3 other icon states: 
//  1)normal / 2)clicked / 3)hover / 4)disabled 

// From
//   http://4d.1045681.n5.nabble.com/How-to-resize-PNG-images-for-button-icons-tt5747836.html#a5747886
//   https://github.com/miyako/4d-component-generate-icon

#DECLARE($normal : Picture; $target_image_size : Integer) : Picture

var $width; $height : Integer
var $click; $hover; $disabled : Picture
var $svg; $g; $image : Text
var $x; $y : Real

If (Count parameters:C259>1)
	PICTURE PROPERTIES:C457($normal; $width; $height)
	$x:=$target_image_size/$width
	$y:=$target_image_size/$height
	TRANSFORM PICTURE:C988($normal; Scale:K61:2; $x; $y)
End if 


$svg:=SVG_New
$g:=SVG_New_group($svg)
$image:=SVG_New_embedded_image($g; $normal)

//Click: add more bright
SVG_SET_BRIGHTNESS($g; 1.2)
$click:=SVG_Export_to_picture($svg)

//Hover: add more bright to previous image
SVG_SET_BRIGHTNESS($g; 1.35)
$hover:=SVG_Export_to_picture($svg)

//Disabled: reduce brightness and set grayscale
//SVG_SET_BRIGHTNESS ($g;0.7)
SVG_SET_OPACITY($g; 25)
$disabled:=SVG_Export_to_picture($svg)
TRANSFORM PICTURE:C988($disabled; Fade to grey scale:K61:6)

SVG_CLEAR($svg)

return $normal/$click/$hover/$disabled