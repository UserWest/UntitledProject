OaksLabRB_Script:
	CheckEvent EVENT_PALLET_AFTER_GETTING_POKEBALLS_2
	call nz, OaksLabRBScript_1d076
	ld a, TRUE
	ld [wAutoTextBoxDrawingControl], a
	xor a
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld hl, OaksLabRB_ScriptPointers
	ld a, [wOaksLabCurScript]
	jp CallFunctionInTable

OaksLabRB_ScriptPointers:
	dw BeforeOakReturnsAndShowEntryOak
	dw OakEntersLab
	dw HideEntryOakAndShowNormalOak
	dw MovePlayerUp
	dw SetEventAndSwitchMusic
	dw OaksLabRBScript5
	dw OaksLabRBScript6
	dw OaksLabScript7
	dw OaksLabRBScript8
	dw OaksLabRBScript9
	dw OaksLabNoScript
	dw OaksLabNoScript
	dw OaksLabRBScript12
	dw OaksLabScript13
	dw OaksLabScript14
	dw OaksLabRBScript15
	dw OaksLabRBScript16
	dw OaksLabNoScript
	dw OaksLabNoScript
	dw OaksLabScript19
	dw OaksLabScript20
	dw OaksLabScript21
	dw OaksLabNoScript ;OaksLabRBScript18
	
OaksLabRBScript5:
	ld a, $fc
	ld [wJoyIgnore], a
	ld a, 21
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	call Delay3
	ld a, 22
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	call Delay3
	ld a, 23
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	call Delay3
	ld a, 24
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_OAK_ASKED_TO_CHOOSE_MON
	xor a
	ld [wJoyIgnore], a

	ld a, 6
	ld [wOaksLabCurScript], a
	ret

OaksLabRBScript6:
	ld a, [wYCoord]
	cp 6
	ret nz
	ld a, $5
	ldh [hSpriteIndex], a
	xor a ; SPRITE_FACING_DOWN
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	ld a, $1
	ldh [hSpriteIndex], a
	xor a
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	call UpdateSprites
	ld a, 16
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
	ld a, D_UP
	ld [wSimulatedJoypadStatesEnd], a
	call StartSimulatingJoypadStates
	ld a, PLAYER_DIR_UP
	ld [wPlayerMovingDirection], a

	ld a, 7
	ld [wOaksLabCurScript], a
	ret

OaksLabRBScript8:
	ld a, [wPlayerStarter]
	cp STARTER_CHARMANDER
	jr z, .Charmander
	cp STARTER_SQUIRTLE
	jr z, .Squirtle
	jr .Bulbasaur
.Charmander
	ld de, .MiddleBallMovement1
	ld a, [wYCoord]
	cp 4 ; is the player standing below the table?
	jr z, .moveBlue
	ld de, .MiddleBallMovement2
	jr .moveBlue

.MiddleBallMovement1
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_UP
	db -1 ; end

.MiddleBallMovement2
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db -1 ; end

.Squirtle
	ld de, .RightBallMovement1
	ld a, [wYCoord]
	cp 4 ; is the player standing below the table?
	jr z, .moveBlue
	ld de, .RightBallMovement2
	jr .moveBlue

.RightBallMovement1
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_UP
	db -1 ; end

.RightBallMovement2
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db -1 ; end

.Bulbasaur
	ld de, .LeftBallMovement1
	ld a, [wXCoord]
	cp 9 ; is the player standing to the right of the table?
	jr nz, .moveBlue
	push hl
	ld a, $1
	ldh [hSpriteIndex], a
	ld a, SPRITESTATEDATA1_YPIXELS
	ldh [hSpriteDataOffset], a
	call GetPointerWithinSpriteStateData1
	push hl
	ld [hl], $4c ; SPRITESTATEDATA1_YPIXELS
	inc hl
	inc hl
	ld [hl], $0 ; SPRITESTATEDATA1_XPIXELS
	pop hl
	inc h
	ld [hl], 8 ; SPRITESTATEDATA2_MAPY
	inc hl
	ld [hl], 9 ; SPRITESTATEDATA2_MAPX
	ld de, .LeftBallMovement2 ; the rival is not currently onscreen, so account for that
	pop hl
	jr .moveBlue

.LeftBallMovement1
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_RIGHT
.LeftBallMovement2
	db NPC_MOVEMENT_RIGHT
	db -1 ; end

.moveBlue
	ld a, $1
	ldh [hSpriteIndex], a
	call MoveSprite

	ld a, 9
	ld [wOaksLabCurScript], a
	ret

OaksLabRBScript9:
	ld a, [wd730]
	bit 0, a
	ret nz
	ld a, $fc
	ld [wJoyIgnore], a
	ld a, $1
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_UP
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	ld a, 17
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, [wRivalStarterBallSpriteIndex]
	cp $2
	jr nz, .rivalDidNotChoseBall1
	ld a, HS_STARTER_BALL_1
	jr .hideBallAndContinue
.rivalDidNotChoseBall1
	cp $3
	jr nz, .rivalChoseBall3
	ld a, HS_STARTER_BALL_2
	jr .hideBallAndContinue
.rivalChoseBall3
	ld a, HS_STARTER_BALL_3
.hideBallAndContinue
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_EEVEE_BALL
	ld [wMissableObjectIndex], a
	predef HideObject
	call Delay3
	ld a, [wRivalStarterTemp]
	ld [wRivalStarter], a
	ld [wcf91], a
	ld [wd11e], a
	call GetMonName
	ld a, $1
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_UP
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	ld a, 18
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_GOT_STARTER
	xor a
	ld [wJoyIgnore], a

	ld a, 12
	ld [wOaksLabCurScript], a
	ret

OaksLabRBScript12: ; Text Mismatch, OaksLabScript12
	ld a, [wYCoord]
	cp 6
	ret nz
	ld a, $1
	ldh [hSpriteIndex], a
	xor a ; SPRITE_FACING_DOWN
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	ld a, PLAYER_DIR_UP
	ld [wPlayerMovingDirection], a
	ld c, BANK(Music_MeetRival)
	ld a, MUSIC_MEET_RIVAL
	call PlayMusic
	ld a, 19
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, $1
	ldh [hNPCPlayerRelativePosPerspective], a
	ld a, $1
	swap a
	ldh [hNPCSpriteOffset], a
	predef CalcPositionOfPlayerRelativeToNPC
	ldh a, [hNPCPlayerYDistance]
	dec a
	ldh [hNPCPlayerYDistance], a
	predef FindPathToPlayer
	ld de, wNPCMovementDirections2
	ld a, $1
	ldh [hSpriteIndex], a
	call MoveSprite

	ld a, [wRivalStarter]
	cp RIVAL_STARTER_JOLTEON
	jr nz, .notEevee
	ld a, RIVAL_STARTER_JOLTEON
	jr .done
.notEevee
	cp CHARMANDER
	jr nz, .notCharmander
	ld a, RIVAL_STARTER_CHARMANDER
	jr .done
.notCharmander
	cp SQUIRTLE
	jr nz, .notSquirtle
	ld a, RIVAL_STARTER_SQUIRTLE
	jr .done
.notSquirtle
	; IS BULBASAUR
	ld a, RIVAL_STARTER_BULBASAUR
.done
	ld [wRivalStarter], a
	
	ld a, 13
	ld [wOaksLabCurScript], a
	ret

OaksLabRBScript15:
	ld c, 20
	call DelayFrames
	ld a, 20
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	farcall Music_RivalAlternateStart
	ld a, $1
	ldh [hSpriteIndex], a
	ld de, .RivalExitMovement
	call MoveSprite
	ld a, [wXCoord]
	cp 4
	; move left or right depending on where the player is standing
	jr nz, .moveLeft
	ld a, NPC_MOVEMENT_RIGHT
	jr .next
.moveLeft
	ld a, NPC_MOVEMENT_LEFT
.next
	ld [wNPCMovementDirections], a

	ld a, 16
	ld [wOaksLabCurScript], a
	ret


.RivalExitMovement
	db NPC_CHANGE_FACING
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

OaksLabRBScript16:
	ld a, [wd730]
	bit 0, a
	jr nz, .checkRivalPosition
	ld a, HS_OAKS_LAB_RIVAL
	ld [wMissableObjectIndex], a
	predef HideObject
	xor a
	ld [wJoyIgnore], a
	call PlayDefaultMusic ; reset to map music
	call EnablePikachuOverworldSpriteDrawing
	ld a, 22
	ld [wOaksLabCurScript], a
	jr .done
; make the player keep facing the rival as he walks away
.checkRivalPosition
	ld a, [wNPCNumScriptedSteps]
	cp $5
	jr nz, .turnPlayerDown
	ld a, [wXCoord]
	cp 4
	jr nz, .turnPlayerLeft
	ld a, SPRITE_FACING_RIGHT
	ld [wSpritePlayerStateData1FacingDirection], a
	jr .done
.turnPlayerLeft
	ld a, SPRITE_FACING_LEFT
	ld [wSpritePlayerStateData1FacingDirection], a
	jr .done
.turnPlayerDown
	cp $4
	ret nz
	xor a ; ld a, SPRITE_FACING_DOWN
	ld [wSpritePlayerStateData1FacingDirection], a
.done
	ret


OaksLabRBScript19: ; can't combine wierd function in yellow, text mismatch OaksLabScript19
	xor a
	ldh [hJoyHeld], a
	call EnableAutoTextBoxDrawing
	ld a, SFX_STOP_ALL_MUSIC
	ld [wNewSoundID], a
	call PlaySound
	farcall Music_RivalAlternateStart
	ld a, 25
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	call OaksLabScript_1c8b9
	ld a, HS_OAKS_LAB_RIVAL
	ld [wMissableObjectIndex], a
	predef ShowObject
	ld a, [wNPCMovementDirections2Index]
	ld [wSavedNPCMovementDirections2Index], a
	ld b, 0
	ld c, a
	ld hl, wNPCMovementDirections2
	ld a, NPC_MOVEMENT_UP
	call FillMemory
	ld [hl], $ff
	ld a, $1
	ldh [hSpriteIndex], a
	ld de, wNPCMovementDirections2
	call MoveSprite
	ld a, 20
	ld [wOaksLabCurScript], a
	ret

OaksLabRBScript_1d076:
	ld hl, OaksLabRB_TextPointers2
	ld a, l
	ld [wMapTextPtr], a
	ld a, h
	ld [wMapTextPtr + 1], a
	ret

OaksLabRB_TextPointers:
	dw OaksLabRBRivalText   ; 4,  3, SPRITE_BLUE
	dw OaksLabSquirtleBall  ; 7,  3, SPRITE_POKE_BALL, middle
	dw OaksLabRBProfOakText ; 5,  2, SPRITE_OAK, stands at top
	dw OaksLabPokedexOnTableText         ; 2,  1, SPRITE_POKEDEX
	dw OaksLabPokedexOnTableTextCopy     ; 3,  1, SPRITE_POKEDEX
	dw OaksLabUnviewableText; 5, 10, SPRITE_OAK, walks into lab
	dw OaksLabGirlText      ; 1,  9, SPRITE_GIRL, oak is great
	dw OaksLabAideText      ; 2, 10, SPRITE_SCIENTIST, oaks aide
	dw OaksLabAideTextCopy  ; 8, 10, SPRITE_SCIENTIST, oaks aide
	dw OaksLabCharmanderBall; 6,  3, SPRITE_POKE_BALL, left
	dw OaksLabBulbasaurBall ; 8,  3, SPRITE_POKE_BALL, right
	dw OaksLabUnviewableText ; avoided on purpose, strange bug doesnt like the number 12
	dw OaksLabPushStartText
	dw OaksLabDisplayOakLabRightPoster
	dw OaksLabEmailText
	dw OaksLabDontGoAway
	dw OaksLabRivalPickingMonText
	dw OaksLabRBRivalReceivedMonText
	dw OaksLabRBRivalChallengeText
	dw OaksLabText12 ; toughen up text
	dw OaksLabText13 ; I'm fed up with waiting
	dw OaksLabRBChooseMonText
	dw OaksLabText15 ; what about me?!
	dw OaksLabRBBePatientText
	dw OaksLabRBText21 ; Gramps!
	dw OaksLabRBText22 ; what did you call me for
	dw OaksLabRBText23 ; I have a request of you two
	dw OaksLabText22 ; oak describes pokedex
	dw OaksLabText23 ; take these with you
	dw OaksLabText24 ; To make a complete...
	dw OaksLabText25 ; leave it all to me gramps!

	

OaksLabRB_TextPointers2:
	dw OaksLabRBRivalText   ; 4,  3, SPRITE_BLUE
	dw OaksLabSquirtleBall  ; 7,  3, SPRITE_POKE_BALL, middle
	dw OaksLabRBProfOakText ; 5,  2, SPRITE_OAK, stands at top
	dw OaksLabPokedexOnTableText         ; 2,  1, SPRITE_POKEDEX
	dw OaksLabPokedexOnTableTextCopy     ; 3,  1, SPRITE_POKEDEX
	dw OaksLabUnviewableText; 5, 10, SPRITE_OAK, walks into lab
	dw OaksLabGirlText      ; 1,  9, SPRITE_GIRL, oak is great
	dw OaksLabAideText      ; 2, 10, SPRITE_SCIENTIST, oaks aide
	dw OaksLabAideTextCopy  ; 8, 10, SPRITE_SCIENTIST, oaks aide
	dw OaksLabCharmanderBall; 6,  3, SPRITE_POKE_BALL, left
	dw OaksLabBulbasaurBall ; 8,  3, SPRITE_POKE_BALL, right
	dw OaksLabUnviewableText
	dw OaksLabPushStartText
	dw OaksLabDisplayOakLabRightPoster
	dw OaksLabEmailText

OaksLabRBRivalText:
	text_asm
	CheckEvent EVENT_FOLLOWED_OAK_INTO_LAB_2
	jr nz, .beforeChooseMon
	ld hl, OaksLabRBGaryText1
	call PrintText
	jr .done
.beforeChooseMon
	bit 2, a
	jr nz, .afterChooseMon
	ld hl, OaksLabRBText40
	call PrintText
	jr .done
.afterChooseMon
	ld hl, OaksLabRBText41
	call PrintText
.done
	jp TextScriptEnd

OaksLabRBGaryText1:
	text_far _OaksLabRBGaryText1
	text_end

OaksLabRBText40:
	text_far _OaksLabRBText40
	text_end

OaksLabRBText41:
	text_far _OaksLabRBText41
	text_end

OaksLabCharmanderBall:
	text_asm
	ld a, STARTER_SQUIRTLE
	ld [wRivalStarterTemp], a
	ld a, $3
	ld [wRivalStarterBallSpriteIndex], a
	ld a, STARTER_CHARMANDER
	ld b, $2
	jr OaksLabRBScript_1d133

OaksLabSquirtleBall:
	text_asm
	ld a, STARTER_BULBASAUR
	ld [wRivalStarterTemp], a
	ld a, $4
	ld [wRivalStarterBallSpriteIndex], a
	ld a, STARTER_SQUIRTLE
	ld b, $3
	jr OaksLabRBScript_1d133

OaksLabBulbasaurBall:
	text_asm
	ld a, STARTER_CHARMANDER
	ld [wRivalStarterTemp], a
	ld a, $2
	ld [wRivalStarterBallSpriteIndex], a
	ld a, STARTER_BULBASAUR
	ld b, $4

OaksLabRBScript_1d133:
	ld [wcf91], a
	ld [wd11e], a
	ld a, b
	ld [wSpriteIndex], a
	CheckEvent EVENT_GOT_STARTER
	jp nz, OaksLabRBScript_1d22d
	CheckEventReuseA EVENT_OAK_ASKED_TO_CHOOSE_MON
	jr nz, OaksLabRBScript_1d157
	ld hl, OaksLabRBText39
	call PrintText
	jp TextScriptEnd

OaksLabRBText39:
	text_far _OaksLabRBText39
	text_end

OaksLabRBScript_1d157:
	ld a, $5
	ldh [hSpriteIndex], a
	ld a, SPRITESTATEDATA1_FACINGDIRECTION
	ldh [hSpriteDataOffset], a
	call GetPointerWithinSpriteStateData1
	ld [hl], SPRITE_FACING_DOWN
	ld a, $1
	ldh [hSpriteIndex], a
	ld a, SPRITESTATEDATA1_FACINGDIRECTION
	ldh [hSpriteDataOffset], a
	call GetPointerWithinSpriteStateData1
	ld [hl], SPRITE_FACING_RIGHT
	ld hl, wd730
	set 6, [hl]
	predef StarterDex
	ld hl, wd730
	res 6, [hl]
	call ReloadMapData
	ld c, 10
	call DelayFrames
	ld a, [wSpriteIndex]
	cp $2
	jr z, OaksLabRBLookAtCharmander
	cp $3
	jr z, OaksLabRBLookAtSquirtle
	jr OaksLabRBLookAtBulbasaur

OaksLabRBLookAtCharmander:
	ld hl, OaksLabRBCharmanderText
	jr OaksLabRBMonChoiceMenu
OaksLabRBCharmanderText:
	text_far _OaksLabRBCharmanderText
	text_end

OaksLabRBLookAtSquirtle:
	ld hl, OaksLabRBSquirtleText
	jr OaksLabRBMonChoiceMenu
OaksLabRBSquirtleText:
	text_far _OaksLabRBSquirtleText
	text_end

OaksLabRBLookAtBulbasaur:
	ld hl, OaksLabRBBulbasaurText
	jr OaksLabRBMonChoiceMenu
OaksLabRBBulbasaurText:
	text_far _OaksLabRBBulbasaurText
	text_end

OaksLabRBMonChoiceMenu:
	call PrintText
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	call YesNoChoice ; yes/no menu
	ld a, [wCurrentMenuItem]
	and a
	jr nz, OaksLabRBMonChoiceEnd
	ld a, [wcf91]
	ld [wPlayerStarter], a
	ld [wd11e], a
	call GetMonName
	ld a, [wSpriteIndex]
	cp $2
	jr nz, .asm_1d1db
	ld a, HS_STARTER_BALL_1
	jr .asm_1d1e5
.asm_1d1db
	cp $3
	jr nz, .asm_1d1e3
	ld a, HS_STARTER_BALL_2
	jr .asm_1d1e5
.asm_1d1e3
	ld a, HS_STARTER_BALL_3
.asm_1d1e5
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld hl, OaksLabRBMonEnergeticText
	call PrintText
	ld hl, OaksLabRecievedText
	call PrintText
	xor a ; PLAYER_PARTY_DATA
	ld [wMonDataLocation], a
	ld a, 5
	ld [wCurEnemyLVL], a
	ld a, [wcf91]
	ld [wd11e], a
	call AddPartyMon
	ld a, LIGHT_BALL_GSC
	ld [wPartyMon1CatchRate], a
	ld hl, wd72e
	set 3, [hl]
	ld a, $fc
	ld [wJoyIgnore], a
	ld a, 8
	ld [wOaksLabCurScript], a
OaksLabRBMonChoiceEnd:
	jp TextScriptEnd

OaksLabRBMonEnergeticText:
	text_far _OaksLabRBMonEnergeticText
	text_end

OaksLabRBScript_1d22d:
	ld a, $5
	ldh [hSpriteIndex], a
	ld a, SPRITESTATEDATA1_FACINGDIRECTION
	ldh [hSpriteDataOffset], a
	call GetPointerWithinSpriteStateData1
	ld [hl], SPRITE_FACING_DOWN
	ld hl, OaksLabRBLastMonText
	call PrintText
	jp TextScriptEnd

OaksLabRBLastMonText:
	text_far _OaksLabRBLastMonText
	text_end

OaksLabRBProfOakText:
	text_asm
	CheckEvent EVENT_PALLET_AFTER_GETTING_POKEBALLS
	jr nz, .asm_1d266
	ld hl, wPokedexOwned
	ld b, wPokedexOwnedEnd - wPokedexOwned
	call CountSetBits
	ld a, [wNumSetBits]
	cp 2
	jr c, .asm_1d279
	CheckEvent EVENT_GOT_POKEDEX
	jr z, .asm_1d279
.asm_1d266
	ld hl, OaksLabText_1ca9f
	call PrintText
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	predef DisplayDexRating
	jp .asm_1d2ed
.asm_1d279
	ld b, POKE_BALL
	call IsItemInBag
	jr nz, .asm_1d2e7
	CheckEvent EVENT_BEAT_ROUTE22_RIVAL_1ST_BATTLE
	jr nz, .asm_1d2d0
	CheckEvent EVENT_GOT_POKEDEX
	jr nz, .asm_1d2c8
	CheckEventReuseA EVENT_BATTLED_RIVAL_IN_OAKS_LAB
	jr nz, .asm_1d2a9
	ld a, [wd72e]
	bit 3, a
	jr nz, .asm_1d2a1
	ld hl, OaksLabRBText_1d2f0
	call PrintText
	jr .asm_1d2ed
.asm_1d2a1
	ld hl, OaksLabRBText_1d2f5
	call PrintText
	jr .asm_1d2ed
.asm_1d2a9
	ld b, OAKS_PARCEL
	call IsItemInBag
	jr nz, .asm_1d2b8
	ld hl, OaksLabRBText_1d2fa
	call PrintText
	jr .asm_1d2ed
.asm_1d2b8
	ld hl, OaksLabRBDeliverParcelText
	call PrintText
	call OaksLabScript_RemoveParcel
	ld a, 19
	ld [wOaksLabCurScript], a
	jr .asm_1d2ed
.asm_1d2c8
	ld hl, OaksLabRBAroundWorldText
	call PrintText
	jr .asm_1d2ed
.asm_1d2d0
	CheckAndSetEvent EVENT_GOT_POKEBALLS_FROM_OAK
	jr nz, .asm_1d2e7
	lb bc, POKE_BALL, 5
	call GiveItem
	ld hl, OaksLabRBGivePokeballsText
	call PrintText
	jr .asm_1d2ed
.asm_1d2e7
	ld hl, OaksLabPleaseVisitText
	call PrintText
.asm_1d2ed
	jp TextScriptEnd

OaksLabRBText_1d2f0:
	text_far _OaksLabRBText_1d2f0
	text_end

OaksLabRBText_1d2f5:
	text_far _OaksLabRBText_1d2f5
	text_end

OaksLabRBText_1d2fa:
	text_far _OaksLabRBText_1d2fa
	text_end

OaksLabRBDeliverParcelText:
	text_far _OaksLabDeliverParcelText1
	sound_get_key_item
	text_far _OaksLabRBDeliverParcelText2
	text_end

OaksLabRBAroundWorldText:
	text_far _OaksLabRBAroundWorldText
	text_end

OaksLabRBGivePokeballsText:
	text_far _OaksLabGivePokeballsText1
	sound_get_key_item
	text_far _OaksLabRBGivePokeballsText2
	text_end

OaksLabRBChooseMonText:
	text_asm
	ld hl, OaksLabRBChooseMonText_
	call PrintText
	jp TextScriptEnd

OaksLabRBChooseMonText_:
	text_far _OaksLabRBChooseMonText
	text_end

OaksLabRBBePatientText:
	text_asm
	ld hl, OaksLabRBBePatientText_
	call PrintText
	jp TextScriptEnd

OaksLabRBBePatientText_:
	text_far _OaksLabRBBePatientText
	text_end

OaksLabRivalPickingMonText:
	text_asm
	ld hl, OaksLabRBRivalPickingMonText_
	call PrintText
	jp TextScriptEnd

OaksLabRBRivalPickingMonText_:
	text_far _OaksLabRBRivalPickingMonText
	text_end

OaksLabRBRivalReceivedMonText:
	text_asm
	ld hl, OaksLabRBRivalReceivedMonText_
	call PrintText
	jp TextScriptEnd

OaksLabRBRivalReceivedMonText_:
	text_far _OaksLabRBRivalReceivedMonText
	sound_get_key_item
	text_end

OaksLabRBRivalChallengeText:
	text_asm
	ld hl, OaksLabRivalChallengeText
	call PrintText
	jp TextScriptEnd

OaksLabRBText21:
	text_far _OaksLabRBText21
	text_end

OaksLabRBText22:
	text_far _OaksLabRBText22
	text_end

OaksLabRBText23:
	text_far _OaksLabRBText23
	text_end
	