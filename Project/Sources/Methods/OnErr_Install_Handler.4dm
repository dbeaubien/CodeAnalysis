//%attributes = {"invisible":true}
// OnErr_Install_Handler ({errorHandlerMethodName})
//
// DESCRIPTION
//   If a errorHandlerMethodName is specified, then the
//   "ON ERR CALL" method is called with that value.
//
//   If no parms are passed, then the previous handler
//   is restored.
//
#DECLARE($errorHandlerMethodName : Text)
// ----------------------------------------------------

If (Asserted:C1132(Count parameters:C259<=1))
	var _OnErr_initd : Boolean
	If (Not:C34(_OnErr_initd))
		_OnErr_initd:=True:C214
		ARRAY TEXT:C222(_OnErr_methodStack; 0)
	End if 
	
	If ($errorHandlerMethodName#"")  // add new one to the stack
		OnErr_ClearError
		APPEND TO ARRAY:C911(_OnErr_methodStack; $errorHandlerMethodName)
		
	Else   // remove top item from stack, set the previous one
		
		If (Size of array:C274(_OnErr_methodStack)>0)  // reduce the stack by 1
			DELETE FROM ARRAY:C228(_OnErr_methodStack; Size of array:C274(_OnErr_methodStack); 1)
		End if 
		
		If (Size of array:C274(_OnErr_methodStack)>0)  // get the previous handler if there is one
			$errorHandlerMethodName:=_OnErr_methodStack{Size of array:C274(_OnErr_methodStack)}
		End if 
	End if 
	
	ON ERR CALL:C155($errorHandlerMethodName)
End if 