//%attributes = {"invisible":true,"preemptive":"incapable"}

ABORT:C156
var $vl_size : Integer
var $vt : Text
$vl_size:=20
$vt:="refresh.svg"
$vt:="folder-Outline.svg"
$vt:="chart-bar.svg"
$vt:="information-outline.svg"
$vt:="question.svg"

//$vl_size:=18
//$vt:="download.svg"
//$vt:="screen-full.svg"
//$vt:="cog.svg"

var $srcPicture; buttonPicture : Picture
var $fileName; $fileName2 : Text
$fileName:=Get 4D folder:C485(Current resources folder:K5:16)+"images"+Folder separator:K24:12+"src"+Folder separator:K24:12+$vt
$fileName2:=Get 4D folder:C485(Current resources folder:K5:16)+"images"+Folder separator:K24:12+$vt+"_"+String:C10($vl_size)+"_4d.png"


If (File_DoesExist($fileName))
	READ PICTURE FILE:C678($fileName; $srcPicture; *)
	SET PICTURE TO PASTEBOARD:C521($srcPicture)
	
	buttonPicture:=Pic_make_4stateIcon($srcPicture; $vl_size)
	
	
	var $fileRef : Time
	File_Delete($fileName2)
	WRITE PICTURE FILE:C680($fileName2; buttonPicture; ".png")
	If (File_DoesExist($fileName2))
		SHOW ON DISK:C922($fileName2)
	Else 
		ALERT:C41("fail")
	End if 
End if 

ABORT:C156
CA_ShowQuickLauncher
CA_ShowAnalysisWindow

//ARRAY TEXT($at_tokens;0)
//$vt_aLine:="ARRAY($at_tokens)"
//$vt_aLine:="ARRAY TEXT($at_tokens;0)"
//  //$vt_aLine:="TokenizeCodeLine ($vt_aLine;->$at_tokens)"
//  //$vt_aLine:="For ($i;1;Size of array($at_tokens);2)"
//  //$vt_aLine:="BEEP  //    This is a test * 6"
//  //$vt_aLine:="BEEP  //This is a test"
//$vt_aLine:="$test:=5.06*Size of array($at_tokens) // A Word"
//  //$vt_aLine:="$test:=3*6/5+2-1 // A Word"
//$vt_aLine:="$test:=\"A Small String.\""
//  //$vt_aLine:="// If (True | False)"
//  //$vt_aLine:="If (True | False)"
//  //$vt_aLine:="If (True << False >> GUBER < 1 > 2) // guest"
//  //$vt_aLine:="$t:=(((34 ?+ 56) ?- 45) ?? 66)+4-3 ^| 78 | True // guest"
//$vt_aLine:="If ($2=$3)"
//
//$vt_aLine:=" // This is a comment"
//
//Tokenize_LineOfCode ($vt_aLine;->$at_tokens)

// SELECT * from _USER_TABLES
// SELECT * from _USER_COLUMNS
// SELECT * from _USER_INDEXES
// SELECT * from _USER_IND_COLUMNS
// SELECT * from _USER_CONSTRAINTS
// SELECT * from _USER_CONS_COLUMNS
// SELECT * from _USER_SCHEMAS

//Begin SQL
//ALTER TABLE Table_1 ADD Field_9_Bit BIT;
//ALTER TABLE Table_1 ADD Field_10_BitVaring BIT VARYING;
//ALTER TABLE Table_1 ADD Field_11_Clob CLOB;
//ALTER TABLE Table_1 ADD Field_12_Duration DURATION;
//ALTER TABLE Table_1 ADD Field_13_Interval INTERVAL;
//End SQL

var $vt_fileFolder : Text
$vt_fileFolder:=Folder_ParentName(Folder_ParentName(Structure file:C489))
$vt_fileFolder:=$vt_fileFolder+"Structure Definition.json"
Structure_SaveStructDefn2Folder($vt_fileFolder)
SHOW ON DISK:C922($vt_fileFolder)

//var $vb_noResult: Boolean
//C_LONGINT(vl_tmpLongint)
//EXECUTE METHOD("CodeAnalysis_GetAssetInfo";$vb_noResult;"MethodVersion";->vl_tmpLongint)  // CodeAnalysis_GetAssetInfo("MethodVersion";->vl_tmpLongint)

If (False:C215)
	ARRAY LONGINT:C221(picRefs; 0)
	ARRAY TEXT:C222(picNames; 0)
	CodeAnalysis_GetAssetInfoCOPY("GetListOfPicts"; ->picRefs; ->picNames)
	//PICTURE LIBRARY LIST(picRefs;picNames)
	
	var $somePicture : Picture
	CodeAnalysis_GetAssetInfoCOPY("GetPict"; ->picRefs{1}; ->$somePicture)
	//GET PICTURE FROM LIBRARY(picRefs{1};$somePicture)
	
	var $vl_sizeInBytes : Integer
	$vl_sizeInBytes:=Picture size:C356($somePicture)
	
	var $width; $height; $hOffset; $vOffset; $mode : Integer
	PICTURE PROPERTIES:C457($somePicture; $width; $height; $hOffset; $vOffset; $mode)
	
	ARRAY TEXT:C222($arrKeywords; 0)
	GET PICTURE KEYWORDS:C1142($somePicture; $arrKeywords; *)  // distinct list of keywords
	
	var $source_in_x : Blob
	var $vt_digest : Text
	PICTURE TO BLOB:C692($somePicture; $source_in_x; ".gif")
	$vt_digest:=Generate digest:C1147($source_in_x; MD5 digest:K66:1)
End if 
