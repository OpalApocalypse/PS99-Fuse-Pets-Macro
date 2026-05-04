#SingleInstance Force
#MaxThreadsPerHotkey 2

;============================================================
; USER SETTINGS
;============================================================

; Optional default pet name shown in the UI.
; Leave blank if you want users to type the pet name each time.
DefaultPetName =

;------------------------------
; Main click coordinates
;------------------------------

SearchBarX = 1287
SearchBarY = 254

FirstPostShiftClickX = 707
FirstPostShiftClickY = 714

SecondPostShiftClickX = 999
SecondPostShiftClickY = 704

;------------------------------
; Slot grid coordinates
;------------------------------

Slot11X = 909
Slot11Y = 382

Slot12X = 1061
Slot12Y = 382

Slot13X = 1219
Slot13Y = 379

Slot14X = 1355
Slot14Y = 379

Slot21X = 915
Slot21Y = 534

Slot22X = 1048
Slot22Y = 537

Slot23X = 1213
Slot23Y = 543

Slot24X = 1364
Slot24Y = 537

Slot31X = 909
Slot31Y = 692

Slot32X = 1058
Slot32Y = 686

Slot33X = 1213
Slot33Y = 683

Slot34X = 1361
Slot34Y = 686

;------------------------------
; Timing settings
; Lower values are faster.
; Increase these if clicks fail to register.
;------------------------------

DelayAfterSearchClick = 100
DelayAfterSearchText = 100
DelayAfterShiftClick = 50
DelayAfterClick1 = 1250
DelayAfterClick2 = 550

;------------------------------
; Mouse movement settings
; MouseMove speed: 0 is instant. Higher numbers are slower.
;------------------------------

InstantMoveSpeed = 0
PrimeMoveSpeed = 3
EngageMoveSpeed = 2

; Pre-move distance before search/slot clicks.
EngageOffsetDistance = 8

; Pre-move distance before the two final clicks.
SmallMoveOffset = 8

ClickSettleDelay = 30
EngageSettleDelay = 60
SmallMoveSettleDelay = 40

;------------------------------
; Keyboard/input settings
;------------------------------

MouseDelay = 20
KeyDelay = 0
PressDuration = 0

ShiftHoldBeforeClick = 120
ShiftHoldAfterClick = 120
ShiftReleaseSettleDelay = 25

; How often long sleeps check whether F2 was pressed.
StopCheckInterval = 25

;------------------------------
; Counter overlay settings
; Transparency: 0 is invisible, 255 is fully solid.
;------------------------------

CounterOpacity = 155
CounterWidth = 150
CounterHeight = 40
CounterXOffsetFromRight = 170
CounterY = 20

;============================================================
; END USER SETTINGS
;============================================================


isRunning = 0
FusionCount = 0

CoordModeSetting = Screen

SelectedX = %Slot12X%
SelectedY = %Slot12Y%
LastSlotControl = Slot12

CoordMode, Mouse, %CoordModeSetting%
SendMode, Event
SetMouseDelay, %MouseDelay%
SetKeyDelay, %KeyDelay%, %PressDuration%

Gosub, BuildGui
Gosub, BuildCounterGui

Return


F1::
	Gosub, StartMacro
Return


F2::
	Gosub, StopMacro
Return


BuildGui:
	Gui, Margin, 20, 12

	Gui, Font, s12 Bold
	Gui, Add, Text, x20 ym w360 Center, PS99 Fuse Pets! Macro

	Gui, Font, s9 Norm
	Gui, Add, Text, x20 y+15 w360 Center, How to Use:
	Gui, Add, Text, x20 y+4 w360 Center, 1. Search the name of the pet, e.g. "Angelus"
	Gui, Add, Text, x20 y+4 w360 Center, 2. In the Menu, where slot does it appear at? Click that box below.

	Gui, Add, Text, x20 y+15 w360 Center, Pet Name:
	Gui, Add, Edit, x70 y+4 w260 vPetName Center, %DefaultPetName%

	Gui, Add, Text, x20 y+15 w360 0x10

	Gui, Add, Button, x95 y+18 w45 h35 vSlot11 gSelectSlot
	Gui, Add, Button, x+10 yp w45 h35 vSlot12 gSelectSlot
	Gui, Add, Button, x+10 yp w45 h35 vSlot13 gSelectSlot
	Gui, Add, Button, x+10 yp w45 h35 vSlot14 gSelectSlot

	Gui, Add, Button, x95 y+10 w45 h35 vSlot21 gSelectSlot
	Gui, Add, Button, x+10 yp w45 h35 vSlot22 gSelectSlot
	Gui, Add, Button, x+10 yp w45 h35 vSlot23 gSelectSlot
	Gui, Add, Button, x+10 yp w45 h35 vSlot24 gSelectSlot

	Gui, Add, Button, x95 y+10 w45 h35 vSlot31 gSelectSlot
	Gui, Add, Button, x+10 yp w45 h35 vSlot32 gSelectSlot
	Gui, Add, Button, x+10 yp w45 h35 vSlot33 gSelectSlot
	Gui, Add, Button, x+10 yp w45 h35 vSlot34 gSelectSlot

	GuiControl,, Slot12, X

	Gui, Add, Text, x20 y+12 w360 Center vSelectedSlotText, Selected: Row 1, Box 2

	Gui, Add, Button, x100 y+15 w95 h28 gStartButton, Start - F1
	Gui, Add, Button, x+10 yp w95 h28 gStopButton, Stop - F2

	Gui, Font, s8 Norm
	Gui, Add, Text, x20 y+15 w360 Center, Made by Opal (Cinnamowopal)

	Gui, Font, s8 Underline cBlue
	Gui, Add, Text, x20 y+4 w360 Center gOpenGithub, github.com/OpalApocalypse

	Gui, Show, x20 y20 AutoSize, PS99 Fuse Pets! Macro
Return


BuildCounterGui:
	CounterX := A_ScreenWidth - CounterXOffsetFromRight

	Gui, 2:+AlwaysOnTop -Caption +ToolWindow +LastFound
	Gui, 2:Color, 000000
	Gui, 2:Font, s11 Bold cFFFFFF
	Gui, 2:Add, Text, x12 y8 w125 h24 Center vFusionCounterText BackgroundTrans, Fusions: 0

	CounterGuiHwnd := WinExist()
	Gui, 2:Show, x%CounterX% y%CounterY% w%CounterWidth% h%CounterHeight% NoActivate, Fusion Counter
	WinSet, Transparent, %CounterOpacity%, ahk_id %CounterGuiHwnd%
Return


UpdateFusionCounter:
	GuiControl, 2:, FusionCounterText, Fusions: %FusionCount%
Return


OpenGithub:
	Run, https://github.com/OpalApocalypse
Return


StartButton:
	Gosub, StartMacro
Return


StopButton:
	Gosub, StopMacro
Return


SelectSlot:
	if LastSlotControl <>
	{
		GuiControl,, %LastSlotControl%, %A_Space%
	}

	LastSlotControl = %A_GuiControl%
	GuiControl,, %LastSlotControl%, X

	if A_GuiControl = Slot11
	{
		SelectedX = %Slot11X%
		SelectedY = %Slot11Y%
		SelectedSlotTextValue = Selected: Row 1, Box 1
	}
	else
	{
		if A_GuiControl = Slot12
		{
			SelectedX = %Slot12X%
			SelectedY = %Slot12Y%
			SelectedSlotTextValue = Selected: Row 1, Box 2
		}
		else
		{
			if A_GuiControl = Slot13
			{
				SelectedX = %Slot13X%
				SelectedY = %Slot13Y%
				SelectedSlotTextValue = Selected: Row 1, Box 3
			}
			else
			{
				if A_GuiControl = Slot14
				{
					SelectedX = %Slot14X%
					SelectedY = %Slot14Y%
					SelectedSlotTextValue = Selected: Row 1, Box 4
				}
				else
				{
					if A_GuiControl = Slot21
					{
						SelectedX = %Slot21X%
						SelectedY = %Slot21Y%
						SelectedSlotTextValue = Selected: Row 2, Box 1
					}
					else
					{
						if A_GuiControl = Slot22
						{
							SelectedX = %Slot22X%
							SelectedY = %Slot22Y%
							SelectedSlotTextValue = Selected: Row 2, Box 2
						}
						else
						{
							if A_GuiControl = Slot23
							{
								SelectedX = %Slot23X%
								SelectedY = %Slot23Y%
								SelectedSlotTextValue = Selected: Row 2, Box 3
							}
							else
							{
								if A_GuiControl = Slot24
								{
									SelectedX = %Slot24X%
									SelectedY = %Slot24Y%
									SelectedSlotTextValue = Selected: Row 2, Box 4
								}
								else
								{
									if A_GuiControl = Slot31
									{
										SelectedX = %Slot31X%
										SelectedY = %Slot31Y%
										SelectedSlotTextValue = Selected: Row 3, Box 1
									}
									else
									{
										if A_GuiControl = Slot32
										{
											SelectedX = %Slot32X%
											SelectedY = %Slot32Y%
											SelectedSlotTextValue = Selected: Row 3, Box 2
										}
										else
										{
											if A_GuiControl = Slot33
											{
												SelectedX = %Slot33X%
												SelectedY = %Slot33Y%
												SelectedSlotTextValue = Selected: Row 3, Box 3
											}
											else
											{
												if A_GuiControl = Slot34
												{
													SelectedX = %Slot34X%
													SelectedY = %Slot34Y%
													SelectedSlotTextValue = Selected: Row 3, Box 4
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}

	GuiControl,, SelectedSlotText, %SelectedSlotTextValue%
Return


StartMacro:
	if isRunning = 1
	{
		Return
	}

	Gui, Submit, NoHide

	if PetName =
	{
		MsgBox, 48, Missing Pet Name, Please enter a pet name before starting the macro.
		Return
	}

	if SelectedX =
	{
		MsgBox, 48, Missing Slot, Please click one of the slot boxes before starting the macro.
		Return
	}

	SearchText = %PetName%
	isRunning = 1

	Loop
	{
		if isRunning = 0
		{
			Break
		}

		ActionX = %SearchBarX%
		ActionY = %SearchBarY%
		PrimeMode = right
		Gosub, PerformNormalClick

		if isRunning = 0
		{
			Break
		}

		SleepDuration = %DelayAfterSearchClick%
		Gosub, StopAwareSleep

		if isRunning = 0
		{
			Break
		}

		Send, ^a
		Sleep, 20
		SendRaw, %SearchText%

		SleepDuration = %DelayAfterSearchText%
		Gosub, StopAwareSleep

		if isRunning = 0
		{
			Break
		}

		ActionX = %SelectedX%
		ActionY = %SelectedY%
		PrimeMode = right
		Gosub, PerformShiftClick

		if isRunning = 0
		{
			Break
		}

		SleepDuration = %DelayAfterShiftClick%
		Gosub, StopAwareSleep

		if isRunning = 0
		{
			Break
		}

		ActionX = %FirstPostShiftClickX%
		ActionY = %FirstPostShiftClickY%
		Gosub, PerformSmallMotionClick

		if isRunning = 0
		{
			Break
		}

		SleepDuration = %DelayAfterClick1%
		Gosub, StopAwareSleep

		if isRunning = 0
		{
			Break
		}

		ActionX = %SecondPostShiftClickX%
		ActionY = %SecondPostShiftClickY%
		Gosub, PerformSmallMotionClick

		if isRunning = 0
		{
			Break
		}

		FusionCount := FusionCount + 1
		Gosub, UpdateFusionCounter

		SleepDuration = %DelayAfterClick2%
		Gosub, StopAwareSleep
	}
Return


StopMacro:
	isRunning = 0
	Send, {LButton up}
	Send, {LShift up}
	ToolTip
Return


PerformNormalClick:
	Gosub, PerformEngageMove
	MouseClick, Left, %ActionX%, %ActionY%, 1, %InstantMoveSpeed%
	Sleep, 40
	Send, {LButton up}
Return


PerformShiftClick:
	Gosub, PerformClick1EngageMove

	Send, {LShift down}
	Sleep, %ShiftHoldBeforeClick%
	MouseClick, Left, %ActionX%, %ActionY%, 1, %InstantMoveSpeed%
	Sleep, %ShiftHoldAfterClick%
	Send, {LButton up}
	Sleep, 25
	Send, {LShift up}
	Sleep, %ShiftReleaseSettleDelay%
Return


PerformSmallMotionClick:
	PrimeX := ActionX + SmallMoveOffset
	PrimeY = %ActionY%

	MouseMove, %PrimeX%, %PrimeY%, %InstantMoveSpeed%
	Sleep, %SmallMoveSettleDelay%
	MouseMove, %ActionX%, %ActionY%, %EngageMoveSpeed%
	Sleep, %ClickSettleDelay%
	MouseClick, Left, %ActionX%, %ActionY%, 1, %InstantMoveSpeed%
	Sleep, 40
	Send, {LButton up}
Return


PerformClick1EngageMove:
	Offset = %EngageOffsetDistance%

	if PrimeMode = up
	{
		PrimeX = %ActionX%
		PrimeY := ActionY - Offset
	}
	else
	{
		PrimeX := ActionX + Offset
		PrimeY = %ActionY%
	}

	MouseMove, %PrimeX%, %PrimeY%, %PrimeMoveSpeed%
	Sleep, %EngageSettleDelay%
	MouseMove, %ActionX%, %ActionY%, %EngageMoveSpeed%
	Sleep, %ClickSettleDelay%
Return


PerformEngageMove:
	Offset = %EngageOffsetDistance%

	if PrimeMode = up
	{
		PrimeX = %ActionX%
		PrimeY := ActionY - Offset
	}
	else
	{
		PrimeX := ActionX + Offset
		PrimeY = %ActionY%
	}

	MouseMove, %PrimeX%, %PrimeY%, %InstantMoveSpeed%
	Sleep, %EngageSettleDelay%
	MouseMove, %ActionX%, %ActionY%, %EngageMoveSpeed%
	Sleep, %ClickSettleDelay%
Return


StopAwareSleep:
	Elapsed = 0

	Loop
	{
		if isRunning = 0
		{
			Break
		}

		if (Elapsed >= SleepDuration)
		{
			Break
		}

		Remaining := SleepDuration - Elapsed

		if (Remaining < StopCheckInterval)
		{
			SleepAmount := Remaining
		}
		else
		{
			SleepAmount := StopCheckInterval
		}

		Sleep, %SleepAmount%
		Elapsed := Elapsed + SleepAmount
	}
Return


GuiClose:
	Gosub, StopMacro
	ExitApp
Return


GuiEscape:
	Gosub, StopMacro
	ExitApp
Return