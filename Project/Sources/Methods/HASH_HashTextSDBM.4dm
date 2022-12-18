//%attributes = {"invisible":true}
If (False:C215)
	HASH_HashTextSDBM
	
	// Below is the original code in C from
	// http://www.partow.net/programming/hashfunctions/
	
	// unsigned int SDBMHash(char* str, unsigned int len)
	// {
	// 
	//    unsigned int hash = 0;
	//    unsigned int i    = 0;
	// 
	//    for(i = 0; i < len; str++, i++)
	//    {
	//       hash = (*str) + (hash << 6) + (hash << 16) - hash;
	//    }
	// 
	//    return (hash & 0x7FFFFFFF);
	// 
	// }
	// /* End Of SDBM Hash Function */
	
End if 

C_LONGINT:C283($0; $hash)
C_TEXT:C284($1; $str)

$str:=$1

$hash:=0  //    unsigned int hash = 0;

C_LONGINT:C283($len)
$len:=Length:C16($str)

// Note: 4D numbers strings from 1, not 0.
C_LONGINT:C283($i)  //    unsigned int i    = 0;
For ($i; 1; $len)  //    for(i = 0; i < len; str++, i++)
	
	//       hash = (*str) + (hash << 6) + (hash << 16) - hash;
	
	// The 4D interpreter and the 4D compiler do not always evaluate expressions
	// identically. In particular, precedence/order of evaluation can differ. With
	// correctly placed parenthesis, inconsistencies can be eliminated. As an example,
	// the following line of code works correctly compiled but not interpreted:
	
	//$hash:=(Ascii($str$i))+($hash<<6)+($hash<<16)-$hashBeforeMods
	
	//The code below works correctly and consistently interpreted and compiled:
	C_LONGINT:C283($hashBeforeMods)  // Track this as a distinct value to simpify dealing with differences in how 4D and C evaluate expressions.
	$hashBeforeMods:=$hash
	
	$hash:=(Character code:C91($str[[$i]]))
	$hash:=$hash+($hashBeforeMods << 6)
	$hash:=$hash+($hashBeforeMods << 16)
	$hash:=$hash-$hashBeforeMods
	
End for 

$0:=$hash & 0x7FFFFFFF  //    return (hash & 0x7FFFFFFF);


// End of method.
