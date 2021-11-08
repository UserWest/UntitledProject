SaffronCity_Script:
	call EnableAutoTextBoxDrawing
	ld hl, SaffronCity_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable
	
SaffronCity_ScriptPointers:
	dw SaffronCityScript0
	dw SaffronCityScript1

SaffronCityScript1:
	ret

SaffronCityScript0:
	SetEvent EVENT_RESCUED_MR_FUJI
	CheckEvent EVENT_BEAT_SILPH_CO_GIOVANNI
	jr nz, .done
	CheckEvent EVENT_RESCUED_MR_FUJI
	jr nz, .hideOrMoveSilphGuard
.done
	ld a, 1
	ld [wCurMapScript], a
	ret

.hideOrMoveSilphGuard
	call CheckForYellowVersion
	jr z, .hideSilphGuard
	
	ld de, wSprite14StateData2MapX ; Data for silph rocket guard x coord
	ld a, 23 ; new x coord
	ld [de], a
	
	ld a, HS_SAFFRON_CITY_SILPH_GUARD ;Show the guard in r/b
	ld [wMissableObjectIndex], a
	predef ShowObject
	jr .done
	
.hideSilphGuard
	ld a, HS_SAFFRON_CITY_SILPH_GUARD ;Hide the guard in yellow
	ld [wMissableObjectIndex], a
	predef HideObject
	jr .done

SaffronCity_TextPointers:
	dw SaffronCityText1
	dw SaffronCityText2
	dw SaffronCityText3
	dw SaffronCityText4
	dw SaffronCityText5
	dw SaffronCityText6
	dw SaffronCityText7
	dw SaffronCityText8
	dw SaffronCityText9
	dw SaffronCityText10
	dw SaffronCityText11
	dw SaffronCityText12
	dw SaffronCityText13
	dw SaffronCityText14
	dw SaffronCityText15
	dw SaffronCityText16
	dw SaffronCityText17
	dw SaffronCityText18
	dw MartSignText
	dw SaffronCityText20
	dw SaffronCityText21
	dw SaffronCityText22
	dw PokeCenterSignText
	dw SaffronCityText24
	dw SaffronCityText25

SaffronCityText1:
	text_far _SaffronCityText1
	text_end

SaffronCityText2:
	text_far _SaffronCityText2
	text_end

SaffronCityText3:
	text_far _SaffronCityText3
	text_end

SaffronCityText4:
	text_far _SaffronCityText4
	text_end

SaffronCityText5:
	text_far _SaffronCityText5
	text_end

SaffronCityText6:
	text_far _SaffronCityText6
	text_end

SaffronCityText7:
	text_far _SaffronCityText7
	text_end

SaffronCityText8:
	text_far _SaffronCityText8
	text_end

SaffronCityText9:
	text_far _SaffronCityText9
	text_end

SaffronCityText10:
	text_far _SaffronCityText10
	text_end

SaffronCityText11:
	text_far _SaffronCityText11
	text_end

SaffronCityText12:
	text_far _SaffronCityText12
	sound_cry_pidgeot
	text_end

SaffronCityText13:
	text_far _SaffronCityText13
	text_end

SaffronCityText14:
	text_asm
	CheckEvent EVENT_RESCUED_MR_FUJI
	jr nz, .savedFuji
	ld hl, SilphGuardBeforeSavingFuji
	jr .printText
.savedFuji
	ld hl, SilphGuardAfterSavingFuji
.printText
	call PrintText
	jp TextScriptEnd

SilphGuardBeforeSavingFuji:
	text_far _SaffronCityText14
	text_end

SilphGuardAfterSavingFuji:
	text_far _SaffronCityText15
	text_end
	
SaffronCityText15:
	text_far _SaffronCityText15
	text_end

SaffronCityText16:
	text_far _SaffronCityText16
	text_end

SaffronCityText17:
	text_far _SaffronCityText17
	text_end

SaffronCityText18:
	text_far _SaffronCityText18
	text_end

SaffronCityText20:
	text_far _SaffronCityText20
	text_end

SaffronCityText21:
	text_far _SaffronCityText21
	text_end

SaffronCityText22:
	text_far _SaffronCityText22
	text_end

SaffronCityText24:
	text_far _SaffronCityText24
	text_end

SaffronCityText25:
	text_far _SaffronCityText25
	text_end
