//%attributes = {"invisible":true,"shared":true,"preemptive":"incapable"}
// CA_EventHandler ()
//
// DESCRIPTION
//   Option Space opens the explorer window.
//
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (03/06/2021)
// ----------------------------------------------------

// https://doc.4d.com/4Dv18/4D/18.4/ON-EVENT-CALL.301-5232720.en.html

If (KeyCode=202) & (Not:C34(Is compiled mode:C492(*)))  //Option-Space
	FILTER EVENT:C321
	CA_ShowExplorer
End if 
