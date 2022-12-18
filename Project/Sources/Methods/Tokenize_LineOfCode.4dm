//%attributes = {"invisible":true}
// Tokenize_LineOfCode (localLine; tokensArrPtr; previousLineInfo) : currentLineInfo
//
// DESCRIPTION
//   Tokenizes a single line of code.
//
C_TEXT:C284($1; $localLine)  // line to be parsed 
C_POINTER:C301($2; $tokensArrPtr)  // ->array text, to be filled with the tokens 
C_OBJECT:C1216($3; $previousLineInfo)
C_OBJECT:C1216($0; $currentLineInfo)
// ----------------------------------------------------
// HISTORY
//   Mod by: Dani Beaubien (03/14/2021)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259>=2)
ASSERT:C1129(Count parameters:C259<=3)
$localLine:=$1
$tokensArrPtr:=$2
If (Count parameters:C259=3)
	$previousLineInfo:=$3
Else 
	$previousLineInfo:=New object:C1471
End if 
$currentLineInfo:=New object:C1471
$currentLineInfo.isCodeLine:=False:C215
$currentLineInfo.isCommentLine:=False:C215
$currentLineInfo.isBlankLine:=False:C215


Logging_Method_START(Current method name:C684)
ARRAY TEXT:C222($tokensArrPtr->; 0)

If ($localLine="//@") | ($localLine="/*@*/")
	APPEND TO ARRAY:C911($tokensArrPtr->; $localLine)
	
Else 
	Tokenize__Init
	
	C_LONGINT:C283($pos)
	If (Array_FindInSortedArray(->_CODELINE_original; ->$localLine; ->$pos))
		OB GET ARRAY:C1229(_CODELINE_tokenized{$pos}; "tokenizedLine"; $tokensArrPtr->)
		$currentLineInfo.isCommentLine:=True:C214
		
	Else 
		Logging_Method_START(Current method name:C684+" - INNER")
		
		// loop through the characters
		C_BOOLEAN:C305($vb_startQuotedText; $vb_startDate; $vb_startTime)
		C_BOOLEAN:C305($vb_startToken)
		C_BOOLEAN:C305($vb_inWhiteSpace)
		C_TEXT:C284($vt_curToken; $vt_trailingSpaces; $curChar; $nextChar; $prevChar; $prevPrevChar)
		C_LONGINT:C283($maxLen; $i; $index)
		$maxLen:=Length:C16($localLine)
		For ($i; 1; $maxLen)
			$curChar:=$localLine[[$i]]
			If ($i<$maxLen)
				$nextChar:=$localLine[[$i+1]]
			Else 
				$nextChar:=""
			End if 
			
			Case of 
				: ($vb_startDate)  // keep going until we get a closing !
					$vt_curToken:=$vt_curToken+$curChar
					If ($curChar="!")
						$vb_startDate:=False:C215
						APPEND TO ARRAY:C911($tokensArrPtr->; $vt_curToken)
						$vt_curToken:=""
					End if 
					
				: ($vb_startTime)  // keep going until we get a closing ?
					$vt_curToken:=$vt_curToken+$curChar
					If ($curChar="?")
						$vb_startTime:=False:C215
						APPEND TO ARRAY:C911($tokensArrPtr->; $vt_curToken)
						$vt_curToken:=""
					End if 
					
				: ($vb_startQuotedText)  // keep going until we get a closing quote
					$vt_curToken:=$vt_curToken+$curChar
					If ($curChar="\"")
						If ($i>1)
							$prevChar:=$localLine[[$i-1]]
						Else 
							$prevChar:=""
						End if 
						If ($i>2)
							$prevPrevChar:=$localLine[[$i-2]]
						Else 
							$prevPrevChar:=""
						End if 
						
						If ($prevChar#"\\") | ($prevPrevChar="\\")  // Make sure not a \", it is okay for it to be \\"
							$vb_startQuotedText:=False:C215
							APPEND TO ARRAY:C911($tokensArrPtr->; $vt_curToken)
							$vt_curToken:=""
						End if 
					End if 
					
				: ($curChar="\"")  // opening quote
					$vb_startQuotedText:=True:C214
					$vt_curToken:=$vt_curToken+$curChar
					
				: ($curChar="!")  // opening ! for a date value
					$vb_startDate:=True:C214
					$vt_curToken:=$vt_curToken+$curChar
					
				: ($curChar=" ")  // ignore whitespace outside of a token
					If ($vb_startToken)
						$vt_trailingSpaces:=$vt_trailingSpaces+" "
						//$vt_curToken:=$vt_curToken+$curChar
					End if 
					
				: ($curChar="{")  // {
					Tokenize_LineOfCode_AddToArrays($tokensArrPtr; $vt_curToken; "{")
					$vt_curToken:=""
					
				: ($curChar="}")  // }
					Tokenize_LineOfCode_AddToArrays($tokensArrPtr; $vt_curToken; "}")
					$vt_curToken:=""
					
				: ($curChar="(")  // (
					Tokenize_LineOfCode_AddToArrays($tokensArrPtr; $vt_curToken; "(")
					$vt_curToken:=""
					
				: ($curChar=")")  // )
					Tokenize_LineOfCode_AddToArrays($tokensArrPtr; $vt_curToken; ")")
					$vt_curToken:=""
					
				: ($curChar="[")  // [[
					If ($nextChar="[")
						$i:=$i+1
						Tokenize_LineOfCode_AddToArrays($tokensArrPtr; $vt_curToken; "[[")
						$vt_curToken:=""
					Else 
						$vt_curToken:=$vt_curToken+"["
					End if 
					
				: ($curChar="]")  // ]]
					If ($nextChar="]")
						$i:=$i+1
						Tokenize_LineOfCode_AddToArrays($tokensArrPtr; $vt_curToken; "]]")
						$vt_curToken:=""
					Else 
						$vt_curToken:=$vt_curToken+"]"
					End if 
					
				: ($curChar="/")  // // or / or /*
					Case of 
						: ($nextChar="*")  // test for "/*"
							$index:=Position:C15("*/"; $localLine; $i+1)
							If ($index<1)  // the rest of the line?
								$index:=Length:C16($localLine)
							End if 
							Tokenize_LineOfCode_AddToArrays($tokensArrPtr; $vt_curToken; Substring:C12($localLine; $i; ($index-$i)+2))
							$i:=$index+1
							
						: ($nextChar="/")  // test for "//"
							Tokenize_LineOfCode_AddToArrays($tokensArrPtr; $vt_curToken; Substring:C12($localLine; $i))
							$vt_curToken:=""
							$i:=Length:C16($localLine)+1  // abort loop
						Else   // Capture the "/"
							Tokenize_LineOfCode_AddToArrays($tokensArrPtr; $vt_curToken; "/")
							$vt_curToken:=""
					End case 
					
				: ($curChar=":")  // := or :
					If ($nextChar="=")  // test for ":="
						$i:=$i+1
						Tokenize_LineOfCode_AddToArrays($tokensArrPtr; $vt_curToken; ":=")
						$vt_curToken:=""
					Else   // test for ":"
						Tokenize_LineOfCode_AddToArrays($tokensArrPtr; $vt_curToken; ":")
						$vt_curToken:=""
					End if 
					
				: ($curChar="=")  // =
					Tokenize_LineOfCode_AddToArrays($tokensArrPtr; $vt_curToken; "=")
					$vt_curToken:=""
					
				: ($curChar="#")  // #
					Tokenize_LineOfCode_AddToArrays($tokensArrPtr; $vt_curToken; "#")
					$vt_curToken:=""
					
				: ($curChar="+")  // +
					Tokenize_LineOfCode_AddToArrays($tokensArrPtr; $vt_curToken; "+")
					$vt_curToken:=""
					
				: ($curChar="-")  // - or ->
					If ($nextChar=">")  // test for "->"
						$i:=$i+1
						Tokenize_LineOfCode_AddToArrays($tokensArrPtr; $vt_curToken; "->")
						$vt_curToken:=""
					Else 
						Tokenize_LineOfCode_AddToArrays($tokensArrPtr; $vt_curToken; "-")
						$vt_curToken:=""
					End if 
					
				: ($curChar="*")  // *, *+, */
					Case of 
						: ($nextChar="+")  // *+
							$i:=$i+1
							Tokenize_LineOfCode_AddToArrays($tokensArrPtr; $vt_curToken; "*+")
							$vt_curToken:=""
							
						: ($nextChar="/")  // */
							$i:=$i+1
							Tokenize_LineOfCode_AddToArrays($tokensArrPtr; $vt_curToken; "*/")
							$vt_curToken:=""
							
						Else 
							Tokenize_LineOfCode_AddToArrays($tokensArrPtr; $vt_curToken; "*")
							$vt_curToken:=""
					End case 
					
				: ($curChar="\\")  // "\"
					Tokenize_LineOfCode_AddToArrays($tokensArrPtr; $vt_curToken; "\\")
					$vt_curToken:=""
					
				: ($curChar="&")  // &
					Tokenize_LineOfCode_AddToArrays($tokensArrPtr; $vt_curToken; "&")
					$vt_curToken:=""
					
				: ($curChar="^")  // ^ or ^|
					If ($nextChar="|")  // ^|
						$i:=$i+1
						Tokenize_LineOfCode_AddToArrays($tokensArrPtr; $vt_curToken; "^|")
						$vt_curToken:=""
					Else 
						Tokenize_LineOfCode_AddToArrays($tokensArrPtr; $vt_curToken; "^")
						$vt_curToken:=""
					End if 
					
				: ($curChar=">")  // >, >=, >>
					Case of 
						: ($nextChar="=")  // test for ">="
							$i:=$i+1
							Tokenize_LineOfCode_AddToArrays($tokensArrPtr; $vt_curToken; ">=")
							$vt_curToken:=""
							
						: ($nextChar=">")  // test for ">>"
							$i:=$i+1
							Tokenize_LineOfCode_AddToArrays($tokensArrPtr; $vt_curToken; ">>")
							$vt_curToken:=""
							
						Else 
							Tokenize_LineOfCode_AddToArrays($tokensArrPtr; $vt_curToken; ">")
							$vt_curToken:=""
					End case 
					
				: ($curChar="<")  // <, <=, <<, <>
					Case of 
						: ($nextChar="=")  // test for "<="
							$i:=$i+1
							Tokenize_LineOfCode_AddToArrays($tokensArrPtr; $vt_curToken; "<=")
							$vt_curToken:=""
							
						: ($nextChar="<")  // test for "<<"
							$i:=$i+1
							Tokenize_LineOfCode_AddToArrays($tokensArrPtr; $vt_curToken; "<<")
							$vt_curToken:=""
							
						: ($nextChar=">")  // test for "<>"
							$i:=$i+1
							$vb_startToken:=True:C214
							$vt_curToken:="<>"
							$vt_trailingSpaces:=""
							
						Else 
							Tokenize_LineOfCode_AddToArrays($tokensArrPtr; $vt_curToken; "<")
							$vt_curToken:=""
					End case 
					
				: ($curChar="%")  // %
					Tokenize_LineOfCode_AddToArrays($tokensArrPtr; $vt_curToken; "%")
					$vt_curToken:=""
					
				: ($curChar="&")  // &
					Tokenize_LineOfCode_AddToArrays($tokensArrPtr; $vt_curToken; "&")
					$vt_curToken:=""
					
				: ($curChar="|")  // |
					Tokenize_LineOfCode_AddToArrays($tokensArrPtr; $vt_curToken; "|")
					$vt_curToken:=""
					
				: ($curChar="?")  // ?+, ?-, ??, ?date?
					Case of 
						: ($nextChar="+")
							$i:=$i+1
							Tokenize_LineOfCode_AddToArrays($tokensArrPtr; $vt_curToken; "?+")
							$vt_curToken:=""
							
						: ($nextChar="-")
							$i:=$i+1
							Tokenize_LineOfCode_AddToArrays($tokensArrPtr; $vt_curToken; "?-")
							$vt_curToken:=""
							
						: ($nextChar="?")
							$i:=$i+1
							Tokenize_LineOfCode_AddToArrays($tokensArrPtr; $vt_curToken; "??")
							$vt_curToken:=""
							
						Else 
							$vb_startTime:=True:C214
							$vt_curToken:=$vt_curToken+$curChar
					End case 
					
				: ($curChar=";")  // ;
					Tokenize_LineOfCode_AddToArrays($tokensArrPtr; $vt_curToken; ";")
					$vt_curToken:=""
					
				Else 
					If (Not:C34($vb_startToken))  // just starting a token, ignore any leading spaces
						$vb_startToken:=True:C214
						$vt_curToken:=$vt_curToken+$curChar
						$vt_trailingSpaces:=""
					Else 
						If ($vt_trailingSpaces#"")  // have a non space so add any added spaces
							$vt_curToken:=$vt_curToken+$vt_trailingSpaces+$curChar
							$vt_trailingSpaces:=""  // reset
						Else 
							$vt_curToken:=$vt_curToken+$curChar
						End if 
					End if 
			End case 
			
			If ($vt_curToken="") & ($vb_startToken)
				$vb_startToken:=False:C215
			End if 
		End for 
		Tokenize_LineOfCode_AddToArrays($tokensArrPtr; $vt_curToken)
		
		// Append to document
		C_OBJECT:C1216($vo_tokenizedArr)
		CLEAR VARIABLE:C89($vo_tokenizedArr)
		//$vo_tokenizedArr:=New object
		OB SET ARRAY:C1227($vo_tokenizedArr; "tokenizedLine"; $tokensArrPtr->)
		INSERT IN ARRAY:C227(_CODELINE_original; $pos)
		INSERT IN ARRAY:C227(_CODELINE_tokenized; $pos)
		_CODELINE_original{$pos}:=$localLine
		_CODELINE_tokenized{$pos}:=$vo_tokenizedArr
		
		Logging_Method_STOP(Current method name:C684+" - INNER")
	End if 
End if 

Logging_Method_STOP(Current method name:C684)
$0:=$currentLineInfo