//%attributes = {"invisible":true}

//_DBG_Logging (True)
//_DBG_Clear 

C_BOOLEAN:C305($Success_b)
$Success_b:=True:C214

C_TEXT:C284($a; $b)

// test all changes
$a:="a,b,c,d,e,f,g,h,i,j,k,l"
$b:="0,1,2,3,4,5,6,7,8,9"
$Success_b:=_DIFF_TEST_DiffTestStrings($a; $b; "12.10.1.1*"; "All-changes")

//test all same
If ($Success_b)
	$a:="a,b,c,d,e,f,g,h,i,j,k,l"
	$b:=$a
	$Success_b:=_DIFF_TEST_DiffTestStrings($a; $b; ""; "All-same")
End if 

//test snake
If ($Success_b)
	$a:="a,b,c,d,e,f"
	$b:="b,c,d,e,f,x"
	$Success_b:=_DIFF_TEST_DiffTestStrings($a; $b; "1.0.1.1*0.1.7.6*"; "Snake")
End if 

//2002.09-repro
If ($Success_b)
	$a:="c1,a,c2,b,c,d,e,g,h,i,j,c3,k,l"
	$b:="C1,a,C2,b,c,d,e,I1,e,g,h,i,j,C3,k,I2,l"
	$Success_b:=_DIFF_TEST_DiffTestStrings($a; $b; "1.1.1.1*1.1.3.3*0.2.8.8*1.1.12.14*0.1.14.16*"; "repro20020920")
End if 

//2003.02-repro
If ($Success_b)
	$a:="F"
	$b:="0,F,1,2,3,4,5,6,7"
	$Success_b:=_DIFF_TEST_DiffTestStrings($a; $b; "0.1.1.1*0.7.2.3*"; "repro20030207")
End if 

//Muegel-repro
If ($Success_b)
	$a:="HELLO,WORLD"
	$b:=",,hello,,,,world,"
	$Success_b:=_DIFF_TEST_DiffTestStrings($a; $b; "2.8.1.1*"; "repro20030409")
End if 

//test some differences
If ($Success_b)
	$a:="a,b,-,c,d,e,f,f"
	$b:="a,b,x,c,e,f"
	$Success_b:=_DIFF_TEST_DiffTestStrings($a; $b; "1.1.3.3*1.0.5.5*1.0.8.7*"; "some-changes")
End if 

//long chain of repeats test failed
If ($Success_b)
	$a:="a,a,a,a,a,a,a,a,a,a"
	$b:="a,a,a,a,-,a,a,a,a,a"
	$Success_b:=_DIFF_TEST_DiffTestStrings($a; $b; "0.1.5.5*1.0.10.11*"; "long chain of repeats test failed")
End if 

//_DBG_ToClipboard 
//_DBG_Logging (False)

If ($Success_b)
	ALERT:C41("All tests passed.")
Else 
	ALERT:C41("Test failed.")
End if 

