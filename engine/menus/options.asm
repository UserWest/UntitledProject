DisplayOptionMenu_:
	call InitOptionsMenu
.optionMenuLoop
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	and START | B_BUTTON
	jr nz, .exitOptionMenu
	call OptionsControl
	jr c, .dpadDelay
	call GetOptionPointer
	jr c, .exitOptionMenu
.dpadDelay
	call OptionsMenu_UpdateCursorPosition
	call DelayFrame
	call DelayFrame
	call DelayFrame
	jr .optionMenuLoop
.exitOptionMenu
	ret

GetOptionPointer:
	ld a, [wOptionsCursorLocation]
	ld e, a
	ld d, $0
	ld hl, OptionMenuJumpTable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl ; jump to the function for the current highlighted option

OptionMenuJumpTable:
	dw OptionsMenu_TextSpeed
	dw OptionsMenu_BattleAnimations
	dw OptionsMenu_BattleStyle
	dw OptionsMenu_SpeakerSettings
	dw OptionsMenu_GBPrinterBrightness
	dw OptionsMenu_Debug
	dw OptionsMenu_Dummy
	dw OptionsMenu_Cancel

OptionsMenu_TextSpeed:
	call GetTextSpeed
	ldh a, [hJoy5]
	bit 4, a ; right
	jr nz, .pressedRight
	bit 5, a
	jr nz, .pressedLeft
	jr .nonePressed
.pressedRight
	ld a, c
	cp $2
	jr c, .increase
	ld c, $ff
.increase
	inc c
	ld a, e
	jr .save
.pressedLeft
	ld a, c
	and a
	jr nz, .decrease
	ld c, $3
.decrease
	dec c
	ld a, d
.save
	ld b, a
	ld a, [wOptions]
	and $f0
	or b
	ld [wOptions], a
.nonePressed
	ld b, $0
	ld hl, TextSpeedStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 14, 2
	call PlaceString
	and a
	ret

TextSpeedStringsPointerTable:
	dw FastText
	dw MidText
	dw SlowText

FastText:
	db "FAST@"
MidText:
	db "MID @"
SlowText:
	db "SLOW@"

GetTextSpeed:
	ld a, [wOptions]
	and $f
	cp $5
	jr z, .slowTextOption
	cp $1
	jr z, .fastTextOption
; mid text option
	ld c, $1
	lb de, 1, 5
	ret
.slowTextOption
	ld c, $2
	lb de, 3, 1
	ret
.fastTextOption
	ld c, $0
	lb de, 5, 3
	ret

OptionsMenu_BattleAnimations:
	ldh a, [hJoy5]
	and D_RIGHT | D_LEFT
	jr nz, .asm_41d33
	ld a, [wOptions]
	and $80 ; mask other bits
	jr .asm_41d3b
.asm_41d33
	ld a, [wOptions]
	xor $80
	ld [wOptions], a
.asm_41d3b
	ld bc, $0
	sla a
	rl c
	ld hl, AnimationOptionStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 14, 4
	call PlaceString
	and a
	ret

AnimationOptionStringsPointerTable:
	dw AnimationOnText
	dw AnimationOffText

AnimationOnText:
	db "ON @"
AnimationOffText:
	db "OFF@"

OptionsMenu_BattleStyle:
	ldh a, [hJoy5]
	and D_LEFT | D_RIGHT
	jr nz, .asm_41d6b
	ld a, [wOptions]
	and $40 ; mask other bits
	jr .asm_41d73
.asm_41d6b
	ld a, [wOptions]
	xor $40
	ld [wOptions], a
.asm_41d73
	ld bc, $0
	sla a
	sla a
	rl c
	ld hl, BattleStyleOptionStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 14, 6
	call PlaceString
	and a
	ret

BattleStyleOptionStringsPointerTable:
	dw BattleStyleShiftText
	dw BattleStyleSetText

BattleStyleShiftText:
	db "SHIFT@"
BattleStyleSetText:
	db "SET  @"

OptionsMenu_SpeakerSettings:
	ld a, [wOptions]
	and $30
	swap a
	ld c, a
	ldh a, [hJoy5]
	bit 4, a
	jr nz, .pressedRight
	bit 5, a
	jr nz, .pressedLeft
	jr .asm_41dca
.pressedRight
	ld a, c
	inc a
	and $3
	jr .asm_41dba
.pressedLeft
	ld a, c
	dec a
	and $3
.asm_41dba
	ld c, a
	swap a
	ld b, a
	xor a
	ldh [rNR51], a
	ld a, [wOptions]
	and $cf
	or b
	ld [wOptions], a
.asm_41dca
	ld b, $0
	ld hl, SpeakerOptionStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 8, 8
	call PlaceString
	and a
	ret

SpeakerOptionStringsPointerTable:
	dw MonoSoundText
	dw Earphone1SoundText
	dw Earphone2SoundText
	dw Earphone3SoundText

MonoSoundText:
	db "MONO     @"
Earphone1SoundText:
	db "EARPHONE1@"
Earphone2SoundText:
	db "EARPHONE2@"
Earphone3SoundText:
	db "EARPHONE3@"

OptionsMenu_GBPrinterBrightness:
	call Func_41e7b
	ldh a, [hJoy5]
	bit 4, a
	jr nz, .pressedRight
	bit 5, a
	jr nz, .pressedLeft
	jr .nonePressed
.pressedRight
	ld a, c
	cp $4
	jr c, .increase
	ld c, $ff
.increase
	inc c
	ld a, e
	jr .save
.pressedLeft
	ld a, c
	and a
	jr nz, .decrease
	ld c, $5
.decrease
	dec c
	ld a, d
.save
	ld b, a
	ld [wPrinterSettings], a
.nonePressed
	ld b, $0
	ld hl, GBPrinterOptionStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 8, 10
	call PlaceString
	and a
	ret

GBPrinterOptionStringsPointerTable:
	dw LightestPrintText
	dw LighterPrintText
	dw NormalPrintText
	dw DarkerPrintText
	dw DarkestPrintText

LightestPrintText:
	db "LIGHTEST@"
LighterPrintText:
	db "LIGHTER @"
NormalPrintText:
	db "NORMAL  @"
DarkerPrintText:
	db "DARKER  @"
DarkestPrintText:
	db "DARKEST @"

Func_41e7b:
	ld a, [wPrinterSettings]
	and a
	jr z, .asm_41e93
	cp $20
	jr z, .asm_41e99
	cp $60
	jr z, .asm_41e9f
	cp $7f
	jr z, .asm_41ea5
	ld c, $2
	lb de, $20, $60
	ret
.asm_41e93
	ld c, $0
	lb de, $7f, $20
	ret
.asm_41e99
	ld c, $1
	lb de, $0, $40
	ret
.asm_41e9f
	ld c, $3
	lb de, $40, $7f
	ret
.asm_41ea5
	ld c, $4
	lb de, $60, $0
	ret

OptionsMenu_Dummy:
	and a
	ret

OptionsMenu_Cancel:
	ldh a, [hJoy5]
	and A_BUTTON
	jr nz, .pressedCancel
	and a
	ret
.pressedCancel
	scf
	ret

OptionsControl:
	ld hl, wOptionsCursorLocation
	ldh a, [hJoy5]
	cp D_DOWN
	jr z, .pressedDown
	cp D_UP
	jr z, .pressedUp
	and a
	ret
.pressedDown
	ld a, [hl]
	cp $7
	jr nz, .doNotWrapAround
	ld [hl], $0
	scf
	ret
.doNotWrapAround
	cp $5
	jr c, .regularIncrement
	ld [hl], $6
.regularIncrement
	inc [hl]
	scf
	ret
.pressedUp
	ld a, [hl]
	cp $7
	jr nz, .doNotMoveCursorToPrintOption
	ld [hl], $5
	scf
	ret
.doNotMoveCursorToPrintOption
	and a
	jr nz, .regularDecrement
	ld [hl], $8
.regularDecrement
	dec [hl]
	scf
	ret

OptionsMenu_UpdateCursorPosition:
	hlcoord 1, 1
	ld de, SCREEN_WIDTH
	ld c, 16
.loop
	ld [hl], " "
	add hl, de
	dec c
	jr nz, .loop
	hlcoord 1, 2
	ld bc, SCREEN_WIDTH * 2
	ld a, [wOptionsCursorLocation]
	call AddNTimes
	ld [hl], "▶"
	ret

InitOptionsMenu:
	hlcoord 0, 0
	lb bc, SCREEN_HEIGHT - 2, SCREEN_WIDTH - 2
	call TextBoxBorder
	hlcoord 2, 2
	ld de, AllOptionsText
	call PlaceString
	hlcoord 2, 16
	ld de, OptionMenuCancelText
	call PlaceString
	xor a
	ld [wOptionsCursorLocation], a
	ld c, 6 ; the number of options to loop through
.loop
	push bc
	call GetOptionPointer ; updates the next option
	pop bc
	ld hl, wOptionsCursorLocation
	inc [hl] ; moves the cursor for the highlighted option
	dec c
	jr nz, .loop
	xor a
	ld [wOptionsCursorLocation], a
	inc a
	ldh [hAutoBGTransferEnabled], a
	call Delay3
	ret

AllOptionsText:
	db "TEXT SPEED :"
	next "ANIMATION  :"
	next "BATTLESTYLE:"
	next "SOUND:"
	next "PRINT:"
	next "DEBUG:@"

OptionMenuCancelText:
	db "CANCEL@"

DisplayVersionMenu:
;draw menu
	hlcoord 0, 0
	lb bc, SCREEN_HEIGHT - 2, SCREEN_WIDTH - 2
	call TextBoxBorder
	hlcoord 2, 2
	ld de, VersionMenuText
	call PlaceString
	hlcoord 2, 16
	ld de, OptionMenuCancelText
	call PlaceString
	ld a, [wCurVersion]
	ld [wUniversalVariable], a
	cp YELLOW_VERSION
	jr z, .isYellow
	cp BLUE_VERSION
	jr z, .isBlue
	ld a, 0 ;red
	jr .gotCurrentVersion
.isBlue
	ld a, 1
	jr .gotCurrentVersion
.isYellow
	ld a, 2
.gotCurrentVersion
	ld [wVersionCursorLocation], a
	inc a
	ldh [hAutoBGTransferEnabled], a
	call Delay3
.optionMenuLoop
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	and START | B_BUTTON
	jr nz, .exitVersionMenu
	ldh a, [hJoy5]
	and A_BUTTON
	jr nz, .selectVersion
	call VersionControl
	jr c, .dpadDelay
.dpadDelay
	call VersionMenu_UpdateCursorPosition
	call DelayFrame
	call DelayFrame
	call DelayFrame
	jr .optionMenuLoop
.selectVersion
	ld a, [wVersionCursorLocation]
	cp 0
	jr z, .choseRedVersion
	cp 1
	jr z, .choseBlueVersion
	cp 2
	jr z, .choseYellowVersion
	jr .exitVersionMenu
	
.choseRedVersion	
	ld a, RED_VERSION
	jr .loadNewVersion
.choseBlueVersion
	ld a, BLUE_VERSION
	jr .loadNewVersion
.choseYellowVersion
	ld a, YELLOW_VERSION
.loadNewVersion	
	ld [wCurVersion], a
	ld a, [wUniversalVariable] ; contains the version from before we opened the menu
	ld b, a
	ld a, [wCurVersion]
	cp b
	jr z, .exitVersionMenu
	ld b, SET_PAL_DEFAULT
	predef DontSkipRunPaletteCommand
	call DoVersionChange
	ld a, SFX_PRESS_AB
	call PlaySound
	ret
	
.exitVersionMenu
	call LoadScreenTilesFromBuffer2
	call LoadTextBoxTilePatterns
	call UpdateSprites
	ret

VersionMenuText:
	db "SELECT A VERSION:"
	next " "
	next "RED VERSION"
	next "BLUE VERSION"
	next "YELLOW VERSION@"

VersionControl:
	ld hl, wVersionCursorLocation
	ldh a, [hJoy5]
	cp D_DOWN
	jr z, .pressedDown
	cp D_UP
	jr z, .pressedUp
	and a
	ret
.pressedDown
	ld a, [hl]
	cp $5
	jr nz, .doNotWrapAround
	ld [hl], $0
	scf
	ret
.doNotWrapAround
	cp $2
	jr c, .regularIncrement
	ld [hl], $4
.regularIncrement
	inc [hl]
	scf
	ret
.pressedUp
	ld a, [hl]
	cp $5
	jr nz, .doNotMoveCursorToYellow
	ld [hl], $2
	scf
	ret
.doNotMoveCursorToYellow
	and a
	jr nz, .regularDecrement
	ld [hl], $6
.regularDecrement
	dec [hl]
	scf
	ret
	
VersionMenu_UpdateCursorPosition:
	hlcoord 1, 1
	ld de, SCREEN_WIDTH
	ld c, 16
.loop
	ld [hl], " "
	add hl, de
	dec c
	jr nz, .loop
	hlcoord 1, 6
	ld bc, SCREEN_WIDTH * 2
	ld a, [wVersionCursorLocation]
	call AddNTimes
	ld [hl], "▶"
	ret









































OptionsMenu_Debug:
	call GetCurrentDebugValue
	ldh a, [hJoy5]
	bit 4, a ; right
	jr nz, .pressedRight
	bit 5, a
	jr nz, .pressedLeft
	jr .nonePressed
.pressedRight
	ld a, c
	cp $5 ; total number of options-1
	jr c, .increase
	ld c, $ff
.increase
	inc c
	ld a, e
	jr .save
.pressedLeft
	ld a, c
	and a
	jr nz, .decrease
	ld c, $6 ; total number of options
.decrease
	dec c
	ld a, d
.save
	ld b, a
	ld a, [wRivalStarter] ; Value being debugged
	and $f0
	or b
	ld [wRivalStarter], a ; Value being debugged
.nonePressed
	ld b, $0
	ld hl, DebugStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 8, 12
	call PlaceString
	and a
	ret

DebugStringsPointerTable:
	dw DebugText1
	dw DebugText2
	dw DebugText3
	dw DebugText4
	dw DebugText5
	dw DebugText6

DebugText1:
	db "JOLTEON   @"
DebugText2:
	db "FLAREON   @"
DebugText3:
	db "VAPOREON  @"
DebugText4:
	db "SQUIRTLE  @"
DebugText5:
	db "BULBASAUR @"
DebugText6:
	db "CHARMANDER@"

GetCurrentDebugValue:
	ld a, [wRivalStarter] ; Value being debugged
	
	
	cp RIVAL_STARTER_JOLTEON
	jr z, .debug1
	cp RIVAL_STARTER_FLAREON
	jr z, .debug2
	cp RIVAL_STARTER_VAPOREON
	jr z, .debug3
	cp RIVAL_STARTER_SQUIRTLE
	jr z, .debug4
	cp RIVAL_STARTER_BULBASAUR
	jr z, .debug5
	
; Following are in reverse order
; fallthrough for final option
	ld c, $5
	lb de, RIVAL_STARTER_BULBASAUR, RIVAL_STARTER_FLAREON
	ld a, RIVAL_STARTER_CHARMANDER
	ld [wRivalStarter], a ; Value being debugged
	ret
.debug5
	ld c, $4
	lb de, RIVAL_STARTER_SQUIRTLE, RIVAL_STARTER_CHARMANDER
	ld a, RIVAL_STARTER_BULBASAUR
	ld [wRivalStarter], a ; Value being debugged
	ret
.debug4
	ld c, $3
	lb de, RIVAL_STARTER_VAPOREON, RIVAL_STARTER_BULBASAUR
	ld a, RIVAL_STARTER_SQUIRTLE
	ld [wRivalStarter], a ; Value being debugged
	ret
.debug3
	ld c, $2
	lb de, RIVAL_STARTER_FLAREON, RIVAL_STARTER_SQUIRTLE
	ld a, RIVAL_STARTER_VAPOREON
	ld [wRivalStarter], a ; Value being debugged
	ret
.debug2
	ld c, $1
	lb de, RIVAL_STARTER_JOLTEON, RIVAL_STARTER_VAPOREON
	ld a, RIVAL_STARTER_FLAREON
	ld [wRivalStarter], a ; Value being debugged
	ret
.debug1
	ld c, $0
	lb de, RIVAL_STARTER_CHARMANDER, RIVAL_STARTER_FLAREON
	ld a, RIVAL_STARTER_JOLTEON
	ld [wRivalStarter], a ; Value being debugged
	ret
