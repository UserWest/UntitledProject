PalletTown_Script:
	CheckEvent EVENT_GOT_POKEBALLS_FROM_OAK
	jr z, .next
	SetEvent EVENT_PALLET_AFTER_GETTING_POKEBALLS
.next
	call EnableAutoTextBoxDrawing
	ld hl, PalletTown_ScriptPointers
	ld a, [wPalletTownCurScript]
	jp CallFunctionInTable

PalletTown_ScriptPointers:
	dw PalletTownScript0
	dw PalletTownScript1
	dw PalletTownScript2
	dw PalletTownScript3
	dw PalletTownScript4
	dw PalletTownScript5
	dw PalletTownScript6
	dw PalletTownScript7
	dw PalletTownScript8
	dw PalletTownScript9
	dw PalletTownRedScript1
	dw PalletTownRedScript2
	dw PalletTownRedScript3
	dw PalletTownRedScript4

PalletTownScript0:
	CheckEvent EVENT_FOLLOWED_OAK_INTO_LAB
	ret nz
	call CheckForYellowVersion
	jr z, .yellow
	ld a, [wYCoord]
	cp 1 ; is player near north exit?
	ret nz
	jr .redStopForOak
.yellow
	ld a, [wYCoord]
	cp 0 ; is player at north exit?
	ret nz
	ResetEvent EVENT_PLAYER_AT_RIGHT_EXIT_TO_PALLET_TOWN
	ld a, [wXCoord]
	cp 10
	jr z, .yellowStopForOak
	SetEventReuseHL EVENT_PLAYER_AT_RIGHT_EXIT_TO_PALLET_TOWN
.yellowStopForOak
	xor a
	ldh [hJoyHeld], a
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, PLAYER_DIR_UP
	ld [wPlayerMovingDirection], a
	call StopAllMusic
	ld a, BANK(Music_MeetProfOak)
	ld c, a
	ld a, MUSIC_MEET_PROF_OAK ; "oak appears" music
	call PlayMusic
	SetEvent EVENT_OAK_APPEARED_IN_PALLET

	; trigger the next script
	ld a, 1
	ld [wPalletTownCurScript], a
	ret
.redStopForOak
	xor a
	ldh [hJoyHeld], a
	ld a, PLAYER_DIR_DOWN
	ld [wPlayerMovingDirection], a
	ld a, SFX_STOP_ALL_MUSIC
	call PlaySound
	ld a, BANK(Music_MeetProfOak)
	ld c, a
	ld a, MUSIC_MEET_PROF_OAK ; "oak appears" music
	call PlayMusic
	ld a, $FC
	ld [wJoyIgnore], a
	SetEvent EVENT_OAK_APPEARED_IN_PALLET

	; trigger the next script
	ld a, 10
	ld [wPalletTownCurScript], a
	ret


PalletTownScript1:
	ld a, ~(A_BUTTON | B_BUTTON)
	ld [wJoyIgnore], a
	xor a
	ld [wcf0d], a
	ld a, 1
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, $FF
	ld [wJoyIgnore], a
	ld hl, wSprite01StateData2MapY
	ld a, 8
	ld [hli], a ; SPRITESTATEDATA2_MAPY
	ld a, 14
	ld [hl], a ; SPRITESTATEDATA2_MAPX
	ld a, HS_PALLET_TOWN_OAK
	ld [wMissableObjectIndex], a
	predef ShowObject
	; trigger the next script
	ld a, $2
	ld [wSprite01StateData1MovementStatus], a
	ld a, SPRITE_FACING_UP
	ld [wSprite01StateData1FacingDirection], a
	ld a, 2
	ld [wPalletTownCurScript], a
	ret

PalletTownScript2:
	call Delay3
	ld a, 0
	ld [wYCoord], a
	ld a, 1
	ldh [hNPCPlayerRelativePosPerspective], a
	ld a, 1
	swap a
	ldh [hNPCSpriteOffset], a
	predef CalcPositionOfPlayerRelativeToNPC
	ld hl, hNPCPlayerYDistance
	dec [hl]
	predef FindPathToPlayer ; load Oak's movement into wNPCMovementDirections2
	ld de, wNPCMovementDirections2
	ld a, 1 ; oak
	ldh [hSpriteIndex], a
	call MoveSprite

	; trigger the next script
	ld a, 3
	ld [wPalletTownCurScript], a
	ret

PalletTownScript3:
	ld a, [wd730]
	bit 0, a
	ret nz
	ld a, ~(A_BUTTON | B_BUTTON)
	ld [wJoyIgnore], a
	ld a, 1
	ld [wcf0d], a
	ld a, $2
	ld [wSprite01StateData1MovementStatus], a
	ld a, SPRITE_FACING_UP
	ld [wSprite01StateData1FacingDirection], a
	ld a, 1
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	; oak faces the horizontally adjacent patch of grass to face pikachu
	ld a, $FF
	ld [wJoyIgnore], a
	ld a, $2
	ld [wSprite01StateData1MovementStatus], a
	CheckEvent EVENT_PLAYER_AT_RIGHT_EXIT_TO_PALLET_TOWN
	ld a, SPRITE_FACING_RIGHT
	jr z, .asm_18f01
	ld a, SPRITE_FACING_LEFT
.asm_18f01
	ld [wSprite01StateData1FacingDirection], a

	; trigger the next script
	ld a, 4
	ld [wPalletTownCurScript], a
	ret

PalletTownScript4:
	; start the pikachu battle
	ld a, ~(A_BUTTON | B_BUTTON)
	ld [wJoyIgnore], a
	xor a
	ld [wListScrollOffset], a
	ld a, BATTLE_TYPE_PIKACHU
	ld [wBattleType], a
	ld a, STARTER_PIKACHU
	ld [wCurOpponent], a
	ld a, 5
	ld [wCurEnemyLVL], a

	; trigger the next script
	ld a, 5
	ld [wPalletTownCurScript], a
	ret

PalletTownScript5:
	ld a, $2
	ld [wcf0d], a
	ld a, $1
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, $2
	ld [wSprite01StateData1MovementStatus], a
	ld a, SPRITE_FACING_UP
	ld [wSprite01StateData1FacingDirection], a
	ld a, $8
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, $ff
	ld [wJoyIgnore], a

	; trigger the next script
	ld a, 6
	ld [wPalletTownCurScript], a
	ret

PalletTownScript6:
	xor a
	ld [wSpritePlayerStateData1FacingDirection], a
	ld a, $1
	ld [wSpriteIndex], a
	xor a
	ld [wNPCMovementScriptFunctionNum], a
	ld a, 1
	ld [wNPCMovementScriptPointerTableNum], a
	ldh a, [hLoadedROMBank]
	ld [wNPCMovementScriptBank], a

	; trigger the next script
	ld a, 7
	ld [wPalletTownCurScript], a
	ret

PalletTownScript7:
	ld a, [wNPCMovementScriptPointerTableNum]
	and a ; is the movement script over?
	ret nz

	; trigger the next script
	ld a, 8
	ld [wPalletTownCurScript], a
	ret

PalletTownRedScript1:
	xor a
	ld [wcf0d], a
	ld a, 1
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, $FF
	ld [wJoyIgnore], a
	ld a, HS_PALLET_TOWN_OAK
	ld [wMissableObjectIndex], a
	predef ShowObject

	; trigger the next script
	ld a, 11
	ld [wPalletTownCurScript], a
	ret

PalletTownRedScript2:
	ld a, 1
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_UP
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	call Delay3
	ld a, 1
	ld [wYCoord], a
	ld a, 1
	ldh [hNPCPlayerRelativePosPerspective], a
	ld a, 1
	swap a
	ldh [hNPCSpriteOffset], a
	predef CalcPositionOfPlayerRelativeToNPC
	ld hl, hNPCPlayerYDistance
	dec [hl]
	predef FindPathToPlayer ; load Oak's movement into wNPCMovementDirections2
	ld de, wNPCMovementDirections2
	ld a, 1 ; oak
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, $FF
	ld [wJoyIgnore], a

	; trigger the next script
	ld a, 12
	ld [wPalletTownCurScript], a
	ret

PalletTownRedScript3:
	ld a, [wd730]
	bit 0, a
	ret nz
	xor a ; ld a, SPRITE_FACING_DOWN
	ld [wSpritePlayerStateData1FacingDirection], a
	ld a, 1
	ld [wcf0d], a
	ld a, $FC
	ld [wJoyIgnore], a
	ld a, 1
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; set up movement script that causes the player to follow Oak to his lab
	ld a, $FF
	ld [wJoyIgnore], a
	ld a, 1
	ld [wSpriteIndex], a
	xor a
	ld [wNPCMovementScriptFunctionNum], a
	ld a, 1
	ld [wNPCMovementScriptPointerTableNum], a
	ldh a, [hLoadedROMBank]
	ld [wNPCMovementScriptBank], a

	; trigger the next script
	ld a, 13
	ld [wPalletTownCurScript], a
	ret

PalletTownRedScript4:
	ld a, [wNPCMovementScriptPointerTableNum]
	and a ; is the movement script over?
	ret nz

	; trigger the next script
	ld a, 8
	ld [wPalletTownCurScript], a
	ret

PalletTownScript8:
	CheckEvent EVENT_DAISY_WALKING
	jr nz, .next
	CheckBothEventsSet EVENT_GOT_TOWN_MAP, EVENT_ENTERED_BLUES_HOUSE, 1
	jr nz, .next
	SetEvent EVENT_DAISY_WALKING
	ld a, HS_DAISY_SITTING
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_DAISY_WALKING
	ld [wMissableObjectIndex], a
	predef_jump ShowObject
.next
	CheckEvent EVENT_GOT_POKEBALLS_FROM_OAK
	ret z
	SetEvent EVENT_PALLET_AFTER_GETTING_POKEBALLS_2
PalletTownScript9:
	ret

PalletTown_TextPointers:
	dw PalletTownText1
	dw PalletTownText2
	dw PalletTownText3
	dw PalletTownText4
	dw PalletTownText5
	dw PalletTownText6
	dw PalletTownText7
	dw PalletTownText8

PalletTownText1:
	text_asm
	ld a, [wcf0d]
	and a
	jr nz, .next
	ld a, 1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld hl, OakAppearsText
	jr .done
.next
	dec a
	jr nz, .asm_18fd3
	call CheckForYellowVersion
	ld hl, OakWalksUpRBText
	jr nz, .done
	ld hl, OakWalksUpText
	jr .done

.asm_18fd3
	ld hl, PalletTownText_19002
.done
	call PrintText
	jp TextScriptEnd

OakAppearsText:
	text_far _OakAppearsText
	text_asm
	ld c, 10
	call DelayFrames
	ld a, PLAYER_DIR_DOWN
	ld [wPlayerMovingDirection], a
	ld a, 0
	ld [wEmotionBubbleSpriteIndex], a ; player's sprite
	ld a, EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
	jp TextScriptEnd

OakWalksUpText:
	text_far _OakWalksUpText
	text_end

OakWalksUpRBText:
	text_far _OakWalksUpTextRed
	text_end

PalletTownText_19002:
	text_far _OakWhewText
	text_end

PalletTownText8:
	text_far _OakGrassText
	text_end

PalletTownText2: ; girl
	text_far _PalletTownText2
	text_end

PalletTownText3: ; fat man
	text_far _PalletTownText3
	text_end

PalletTownText4: ; sign by lab
	text_far _PalletTownText4
	text_end

PalletTownText5: ; sign by fence
	text_far _PalletTownText5
	text_end

PalletTownText6: ; sign by Red's house
	text_far _PalletTownText6
	text_end

PalletTownText7: ; sign by Blue's house
	text_far _PalletTownText7
	text_end
