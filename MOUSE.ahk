; Functions related to the mouse.

; Grab the tooltip(s) shown onscreen. Based on http://www.autohotkey.com/board/topic/53672-get-the-text-content-of-a-tool-tip-window/?p=336440
MOUSE_GetTooltipText() {
	outText := ""
	
	; Allow partial matching on ahk_class. (tooltips_class32, WindowsForms10.tooltips_class32.app.0.2bf8098_r13_ad1 so far)
	SetTitleMatchMode, RegEx
	WinGet, winIDs, LIST, ahk_class tooltips_class32
	SetTitleMatchMode, 1
	
	Loop, %winIDs% {
		currID := winIDs%A_Index%
		ControlGetText, tooltipText, , ahk_id %currID%
		if(tooltipText != "")
			outText .= tooltipText "`n"
	}
	StringTrimRight, outText, outText, 1
	
	return outText
}

MOUSE_ClickUsingMode(x = "", y = "", mouseCoordMode = "") {
	; Store the old mouse position to move back to once we're finished.
	MouseGetPos, prevX, prevY
	
	; Plug in the new mouse CoordMode.
	origCoordMode := A_CoordModeMouse
	CoordMode, Mouse, % mouseCoordMode
	
	; DEBUG.popup("io", "clickUsingMode", "X", x, "Y", y, "CoordMode", mouseCoordMode)
	Click, %x%, %y%
	
	; Restore default mouse CoordMode.
	CoordMode, Mouse, % origCoordMode
	
	; Move the mouse back to its former position.
	MouseMove, prevX, prevY
}
