OaksLab_Script:
	CheckEvent EVENT_PALLET_AFTER_GETTING_POKEBALLS_2
	call nz, OaksLabScript_1d076
	ld a, TRUE
	ld [wAutoTextBoxDrawingControl], a
	xor a
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld hl, OaksLab_ScriptPointers
	ld a, [wOaksLabCurScript]
	jp CallFunctionInTable

OaksLab_ScriptPointers:
	dw BeforeOakReturnsAndShowEntryOak
	dw OakEntersLab
	dw HideEntryOakAndShowNormalOak
	dw MovePlayerUp
	dw SetEventAndSwitchMusic
	dw OaksLabScript5
	dw OaksLabScript6
	dw OaksLabScript7
	dw RivalPushesPlayer
	dw RivalTakesEevee
	dw PlayerWalksBackToOak
	dw OaksLabScript11
	dw OaksLabScript12
	dw OaksLabScript13
	dw OaksLabScript14
	dw OaksLabScript15
	dw OaksLabScript16
	dw OaksLabScript17
	dw OaksLabScript18
	dw OaksLabScript19
	dw OaksLabScript20
	dw OaksLabScript21
	dw OaksLabNoScript

BeforeOakReturnsAndShowEntryOak:
	CheckEvent EVENT_OAK_APPEARED_IN_PALLET
	ret z
	ld a, [wNPCMovementScriptFunctionNum]
	and a
	ret nz
	ld a, HS_OAKS_LAB_OAK_2
	ld [wMissableObjectIndex], a
	predef ShowObject
	ld hl, wd72e
	res 4, [hl]

	ld a, 1
	ld [wOaksLabCurScript], a
	ret

OakEntersLab:
	ld a, $9
	ldh [hSpriteIndex], a
	ld de, OakEntryMovement
	call MoveSprite

	ld a, 2
	ld [wOaksLabCurScript], a
	ret

OakEntryMovement:
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db -1 ; end

HideEntryOakAndShowNormalOak:
	ld a, [wd730]
	bit 0, a
	ret nz
	ld a, HS_OAKS_LAB_OAK_2
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_OAKS_LAB_OAK_1
	ld [wMissableObjectIndex], a
	predef ShowObject

	ld a, 3
	ld [wOaksLabCurScript], a
	ret

MovePlayerUp:
	call Delay3
	ld hl, wSimulatedJoypadStatesEnd
	ld de, PlayerEntryMovementRLE
	call DecodeRLEList
	dec a
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
	ld a, $1
	ldh [hSpriteIndex], a
	xor a
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	ld a, $5
	ldh [hSpriteIndex], a
	xor a
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay

	ld a, 4
	ld [wOaksLabCurScript], a
	ret

PlayerEntryMovementRLE:
	db D_UP, 8
	db -1 ; end

SetEventAndSwitchMusic:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	SetEvent EVENT_FOLLOWED_OAK_INTO_LAB
	SetEvent EVENT_FOLLOWED_OAK_INTO_LAB_2
	ld a, $1
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_UP
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	call UpdateSprites ;used in red and blue not sure if important
	ld hl, wFlags_D733
	res 1, [hl]
	call PlayDefaultMusic

	ld a, 5
	ld [wOaksLabCurScript], a
	ret

OaksLabScript5:
	SetEvent EVENT_OAK_ASKED_TO_CHOOSE_MON
	ld a, $fc
	ld [wJoyIgnore], a
	ld a, 19
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	call Delay3
	ld a, 20
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	call Delay3
	ld a, $2
	ld [wSprite01StateData1MovementStatus], a
	ld a, SPRITE_FACING_UP
	ld [wSprite01StateData1FacingDirection], a
	ld a, 21
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	call Delay3
	ld a, 22
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	xor a
	ld [wJoyIgnore], a

	ld a, 6
	ld [wOaksLabCurScript], a
	ret

OaksLabScript6:
	ld a, [wYCoord]
	cp 6
	ret nz
	ld a, $3
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

OaksLabScript7:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3

	ld a, 6
	ld [wOaksLabCurScript], a
	ret

RivalPushesPlayer:
	ld a, 1
	ldh [hSpriteIndexOrTextID], a
	ld de, .RivalPushesPlayerAwayFromEeveeBall
	call MoveSprite
	ld a, 9
	ld [wOaksLabCurScript], a
	ret

.RivalPushesPlayerAwayFromEeveeBall
	db $00
	db $07
	db $07
	db $07
	db $FF

RivalTakesEevee:
	ld a, [wd730]
	bit 0, a
	jr nz, .asm_1c564
	ld a, HS_EEVEE_BALL
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_STARTER_BALL_1
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_STARTER_BALL_3
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, $1
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_UP
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	ld a, RIVAL_STARTER_JOLTEON
	ld [wRivalStarter], a
	ld a, EEVEE
	ld [wd11e], a
	call GetMonName
	ld a, $FF ^ (A_BUTTON | B_BUTTON)
	ld [wJoyIgnore], a
	ld a, 23
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID

	ld a, 10
	ld [wOaksLabCurScript], a
	ret

.asm_1c564
	ld a, [wYCoord]
	cp 4
	ret nz
	ld a, [wNPCNumScriptedSteps]
	cp 1
	ret nz
	ld a, PLAYER_DIR_LEFT
	ld [wPlayerMovingDirection], a
	ld a, $2
	ld [wSimulatedJoypadStatesIndex], a
	ld a, D_RIGHT
	ld [wSimulatedJoypadStatesEnd], a
	ld [wSimulatedJoypadStatesEnd + 1], a
	jp StartSimulatingJoypadStates

PlayerWalksBackToOak:
	ld a, [wYCoord]
	cp 4
	jr z, .asm_1c599
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
	ld a, D_LEFT
	ld [wSimulatedJoypadStatesEnd], a
	jr .asm_1c5a6

.asm_1c599
	ld hl, wSimulatedJoypadStatesEnd
	ld de, OaksLabRLE_PlayerWalksToOak
	call DecodeRLEList
	dec a
	ld [wSimulatedJoypadStatesIndex], a
.asm_1c5a6
	call StartSimulatingJoypadStates
	ld a, 11
	ld [wOaksLabCurScript], a
	ret

OaksLabRLE_PlayerWalksToOak:
	db D_UP, 2
	db D_LEFT, 3
	db D_DOWN, 1
	db D_LEFT, 1
	db $FF

OaksLabScript11:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	ld a, 24
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	xor a
	ld [wJoyIgnore], a

	ld a, 12
	ld [wOaksLabCurScript], a
	ret

OaksLabScript12:
	ld a, [wYCoord]
	cp 6
	ret nz
	ld a, PLAYER_DIR_UP
	ld [wPlayerMovingDirection], a
	ld a, $1
	ldh [hSpriteIndex], a
	xor a ; SPRITE_FACING_DOWN
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	ld c, BANK(Music_MeetRival)
	ld a, MUSIC_MEET_RIVAL
	call PlayMusic
	ld a, 17
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, $1
	ldh [hNPCPlayerRelativePosPerspective], a
	ld a, $1
	swap a
	ldh [hNPCPlayerYDistance], a
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
	cp BULBASAUR
	jr nz, .mustBeEevee
	ld a, RIVAL_STARTER_BULBASAUR
.done
	ld [wRivalStarter], a
	
.mustBeEevee	
	ld a, 13
	ld [wOaksLabCurScript], a
	ret

OaksLabScript13:
	ld a, [wd730]
	bit 0, a
	ret nz

	; define which team rival uses, and fight it
	ld a, OPP_RIVAL1
	ld [wCurOpponent], a
	ld a, [wRivalStarter]
	cp RIVAL_STARTER_JOLTEON ; adjust vs other options
	jr z, .adjustForEevee
	sub 2
.adjustForEevee
	ld [wTrainerNo], a
	ld a, $1
	ld [wSpriteIndex], a
	call GetSpritePosition1
	ld hl, OaksLabRivalDefeatedText
	ld de, OaksLabRivalBeatYouText
	call SaveEndBattleTextPointers
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	xor a
	ld [wJoyIgnore], a
	ld a, PLAYER_DIR_UP
	ld [wPlayerMovingDirection], a
	ld a, 14
	ld [wOaksLabCurScript], a
	ret

OaksLabScript14:
	ld a, $ff
	ld [wJoyIgnore], a
	
	ld a, [wRivalStarter]
	cp EEVEE
	jr nz, .NotEevee
	; If you beat your rival here, his Eevee will evolve into
	; Jolteon if you beat him on Route 22, or Flareon if you
	; skip or lose that battle.
	; Otherwise, it will evolve into Vaporeon.
	ld a, [wBattleResult]
	and a
	ld b, RIVAL_STARTER_VAPOREON
	jr nz, .got_rival_starter
	ld b, RIVAL_STARTER_FLAREON
.got_rival_starter
	ld a, b
	ld [wRivalStarter], a
.NotEevee
	ld a, $ff ^ (A_BUTTON | B_BUTTON)
	ld [wJoyIgnore], a
	ld a, PLAYER_DIR_UP
	ld [wPlayerMovingDirection], a
	call UpdateSprites
	ld a, $1
	ld [wSpriteIndex], a
	call SetSpritePosition1
	ld a, $2
	ld [wSprite01StateData1MovementStatus], a
	xor a
	ld [wSprite01StateData1FacingDirection], a
	predef HealParty
	SetEvent EVENT_BATTLED_RIVAL_IN_OAKS_LAB
	ld a, [wPlayerStarter]
	ld [wStarterChoice], a ; stored so oak can reference this after the champ battle
	ld a, 15
	ld [wOaksLabCurScript], a
	ret

OaksLabScript15:
	ld c, 20
	call DelayFrames
	ld a, 18
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	farcall Music_RivalAlternateStart
	ld a, $1
	ldh [hSpriteIndex], a
	ld de, .OaksLabMovement_RivalWalksOut1
	call MoveSprite
	ld a, [wXCoord]
	cp 4
	jr nz, .asm_1c6bb
	ld a, NPC_MOVEMENT_RIGHT
	jr .asm_1c6bd

.asm_1c6bb
	ld a, NPC_MOVEMENT_LEFT
.asm_1c6bd
	ld [wNPCMovementDirections], a
	ld a, 16
	ld [wOaksLabCurScript], a
	ret

.OaksLabMovement_RivalWalksOut1
	db NPC_CHANGE_FACING
	db NPC_MOVEMENT_DOWN
	db $04
	db $04
	db $04
	db $04
	db $04
	db -1 ; end

OaksLabScript16:
	ld a, [wd730]
	bit 0, a
	jr nz, .checkRivalPosition
	ld a, $ff ^ (A_BUTTON | B_BUTTON)
	ld [wJoyIgnore], a
	ld a, HS_OAKS_LAB_RIVAL
	ld [wMissableObjectIndex], a
	predef HideObject
	call PlayDefaultMusic
	ld a, 17
	ld [wOaksLabCurScript], a
	ret
; make the player keep facing the rival as he walks away
.checkRivalPosition
	ld a, [wNPCNumScriptedSteps]
	cp $5
	jr nz, .turnPlayerDown
	ld a, [wXCoord]
	cp 4
	jr nz, .turnPlayerLeft
	ld a, SPRITE_FACING_RIGHT
	jr .done
.turnPlayerLeft
	ld a, SPRITE_FACING_LEFT
	jr .done
.turnPlayerDown
	cp $4
	ret nz
	xor a ; ld a, SPRITE_FACING_DOWN
.done
	ld [wSpritePlayerStateData1FacingDirection], a
	ret

OaksLabScript17:
	ld a, [wPlayerStarter]
	cp STARTER_PIKACHU
	jr nz, OaksLabScript18.skipShowPika
; Pikachu comes out
	ld a, SPRITE_FACING_UP
	ld [wSpritePlayerStateData1FacingDirection], a
	ld a, $2
	ld [wPikachuSpawnState], a
	farcall SchedulePikachuSpawnForAfterText
	call EnablePikachuOverworldSpriteDrawing
	ld a, 32
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, 18
	ld [wOaksLabCurScript], a
	ret

OaksLabScript18:
	ld a, 33
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
.skipShowPika
	xor a
	ld [wJoyIgnore], a
	ld a, 22
	ld [wOaksLabCurScript], a
	ret

OaksLabScript19:
	xor a
	ldh [hJoyHeld], a
	call EnableAutoTextBoxDrawing
	call StopAllMusic
	farcall Music_RivalAlternateStart
	ld a, 25
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	callfar Func_f1be0
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

OaksLabScript_1c78e:
	ld a, $1
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_UP
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	ld a, $8
	ldh [hSpriteIndex], a
	xor a ; SPRITE_FACING_DOWN
	ldh [hSpriteFacingDirection], a
	jp SetSpriteFacingDirectionAndDelay

OaksLabScript20:
	ld a, [wd730]
	bit 0, a
	ret nz
	call EnableAutoTextBoxDrawing
	call PlayDefaultMusic
	ld a, $ff ^ (A_BUTTON | B_BUTTON)
	ld [wJoyIgnore], a
	call OaksLabScript_1c78e
	ld a, 26
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	call DelayFrame
	call OaksLabScript_1c78e
	ld a, 27
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	call DelayFrame
	call OaksLabScript_1c78e
	ld a, 28
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	call DelayFrame
	ld a, 29
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	call Delay3
	ld a, HS_POKEDEX_1
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_POKEDEX_2
	ld [wMissableObjectIndex], a
	predef HideObject
	call OaksLabScript_1c78e
	ld a, 30
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, $1
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_RIGHT
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	call Delay3
	ld a, 31
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_GOT_POKEDEX
	ld a, $1
	ld [wViridianCityCurScript], a
	SetEvent EVENT_OAK_GOT_PARCEL
	ld a, HS_LYING_OLD_MAN
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_OLD_MAN
	ld [wMissableObjectIndex], a
	predef ShowObject
	ld a, [wSavedNPCMovementDirections2Index]
	ld b, 0
	ld c, a
	ld hl, wNPCMovementDirections2
	xor a ; NPC_MOVEMENT_DOWN
	call FillMemory
	ld [hl], $ff
	call StopAllMusic
	farcall Music_RivalAlternateStart
	ld a, 1
	ldh [hSpriteIndexOrTextID], a
	ld de, wNPCMovementDirections2
	call MoveSprite
	ld a, 21
	ld [wOaksLabCurScript], a
	ret

OaksLabScript21:
	ld a, [wd730]
	bit 0, a
	ret nz
	call PlayDefaultMusic
	ld a, HS_OAKS_LAB_RIVAL
	ld [wMissableObjectIndex], a
	predef HideObject
	SetEvent EVENT_1ST_ROUTE22_RIVAL_BATTLE
	ResetEventReuseHL EVENT_2ND_ROUTE22_RIVAL_BATTLE
	SetEventReuseHL EVENT_ROUTE22_RIVAL_WANTS_BATTLE
	ld a, HS_ROUTE_22_RIVAL_1
	ld [wMissableObjectIndex], a
	predef ShowObject
	xor a
	ld [wJoyIgnore], a
	ld a, 22
	ld [wOaksLabCurScript], a
	ret

OaksLabNoScript:
	ret

OaksLabScript_RemoveParcel:
	ld hl, wBagItems
	ld bc, 0
.loop
	ld a, [hli]
	cp $ff
	ret z
	cp OAKS_PARCEL
	jr z, .foundParcel
	inc hl
	inc c
	jr .loop
.foundParcel
	ld hl, wNumBagItems
	ld a, c
	ld [wWhichPokemon], a
	ld a, 1
	ld [wItemQuantity], a
	jp RemoveItemFromInventory

OaksLabScript_1c8b9:
	ld a, $7c
	ldh [hSpriteScreenYCoord], a
	ld a, 8
	ldh [hSpriteMapXCoord], a
	ld a, [wYCoord]
	cp 3
	jr nz, .asm_1c8d3
	ld a, $4
	ld [wNPCMovementDirections2Index], a
	ld a, $30
	ld b, 11
	jr .asm_1c8f6
.asm_1c8d3
	cp 1
	jr nz, .asm_1c8e2
	ld a, $2
	ld [wNPCMovementDirections2Index], a
	ld a, $30
	ld b, 9
	jr .asm_1c8f6
.asm_1c8e2
	ld a, $3
	ld [wNPCMovementDirections2Index], a
	ld b, 10
	ld a, [wXCoord]
	cp 4
	jr nz, .asm_1c8f4
	ld a, $40
	jr .asm_1c8f6
.asm_1c8f4
	ld a, $20
.asm_1c8f6
	ldh [hSpriteScreenXCoord], a
	ld a, b
	ldh [hSpriteMapYCoord], a
	ld a, $1
	ld [wSpriteIndex], a
	jp SetSpritePosition1

OaksLabScript_1d076:
	ld hl, OaksLab_TextPointers2
	ld a, l
	ld [wMapTextPtr], a
	ld a, h
	ld [wMapTextPtr + 1], a
	ret

OaksLab_TextPointers:
	dw OaksLabText1
	dw OaksLabText2
	dw OaksLabText3
	dw OaksLabPokedexOnTableText
	dw OaksLabPokedexOnTableTextCopy
	dw OaksLabUnviewableText
	dw OaksLabGirlText
	dw OaksLabAideText
	dw OaksLabAideTextCopy
	dw OaksLabUnviewableText
	dw OaksLabUnviewableText
	dw OaksLabUnviewableText
	dw OaksLabPushStartText
	dw OaksLabDisplayOakLabRightPoster
	dw OaksLabEmailText
	dw OaksLabDontGoAway
	dw OaksLabText11
	dw OaksLabText12
	dw OaksLabText13
	dw OaksLabText14
	dw OaksLabText15
	dw OaksLabText16
	dw OaksLabText17
	dw OaksLabText18
	dw OaksLabText19
	dw OaksLabText20
	dw OaksLabText21
	dw OaksLabText22
	dw OaksLabText23
	dw OaksLabText24
	dw OaksLabText25
	dw OaksLabText26
	dw OaksLabText27

OaksLab_TextPointers2:
	dw OaksLabText1
	dw OaksLabText2
	dw OaksLabText3
	dw OaksLabPokedexOnTableText
	dw OaksLabPokedexOnTableTextCopy
	dw OaksLabUnviewableText
	dw OaksLabGirlText
	dw OaksLabAideText
	dw OaksLabAideTextCopy
	dw OaksLabUnviewableText
	dw OaksLabUnviewableText
	dw OaksLabUnviewableText
	dw OaksLabPushStartText
	dw OaksLabDisplayOakLabRightPoster
	dw OaksLabEmailText

OaksLabPushStartText:
	text_asm
	ld hl, OaksLabPushStartText_
	call PrintText
	jp TextScriptEnd
	
OaksLabEmailText:
	text_asm
	ld hl, OaksLabEmailText_
	call PrintText
	jp TextScriptEnd
	
OaksLabPushStartText_:
	text_far _PushStartText
	text_end
OaksLabSaveOptionText_:
	text_far _SaveOptionText
	text_end
OaksLabEmailText_:
	text_far _OakLabEmailText
	text_end

OaksLabDisplayOakLabRightPoster:
	text_asm
	ld hl, wPokedexOwned
	ld b, wPokedexOwnedEnd - wPokedexOwned
	call CountSetBits
	ld a, [wNumSetBits]
	cp 2
	ld hl, OaksLabSaveOptionText
	jr c, .ownLessThanTwo
	; own two or more mon
	ld hl, OaksLabStrengthsAndWeaknessesText
.ownLessThanTwo
	call PrintText
	jp TextScriptEnd

OaksLabSaveOptionText::
	text_far _SaveOptionText
	text_end

OaksLabStrengthsAndWeaknessesText::
	text_far _StrengthsAndWeaknessesText
	text_end

OaksLabText1:
	text_asm
	CheckEvent EVENT_FOLLOWED_OAK_INTO_LAB_2
	jr nz, .beforeChooseMon
	ld hl, OaksLabGaryText1
	call PrintText
	jr .done
.beforeChooseMon
	CheckEventReuseA EVENT_GOT_STARTER
	jr nz, .afterChooseMon
	ld hl, OaksLabText40
	call PrintText
	jr .done
.afterChooseMon
	ld hl, OaksLabText41
	call PrintText
.done
	jp TextScriptEnd

OaksLabGaryText1:
	text_far _OaksLabGaryText1
	text_end

OaksLabText40:
	text_far _OaksLabText40
	text_end

OaksLabText41:
	text_far _OaksLabText41
	text_end

OaksLabText2:
	text_asm
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	CheckEvent EVENT_OAK_ASKED_TO_CHOOSE_MON
	jr nz, OaksLabScript_1c9ac
	ld a, $0
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld hl, OaksLabText39
	call PrintText
	jp TextScriptEnd

OaksLabText39:
	text_far _OaksLabText39
	text_end

OaksLabScript_1c9ac:
	ld a, $1
	ld [wEmotionBubbleSpriteIndex], a
	xor a ; EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
	ld a, 8
	ld [wOaksLabCurScript], a
	jp TextScriptEnd

OaksLabText3:
	text_asm
	CheckEvent EVENT_PALLET_AFTER_GETTING_POKEBALLS
	jr nz, .asm_1c9d9
	ld hl, wPokedexOwned
	ld b, wPokedexOwnedEnd - wPokedexOwned
	call CountSetBits
	ld a, [wNumSetBits]
	cp 2
	jr c, .asm_1c9ec
.asm_1c9d9
	ld hl, OaksLabText_1ca9f
	call PrintText
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	predef DisplayDexRating
	jp .asm_1ca6f
.asm_1c9ec
	ld b, POKE_BALL
	call IsItemInBag
	jp nz, .asm_1ca69
	ld hl, wPokedexOwned
	ld b, wPokedexOwnedEnd - wPokedexOwned
	call CountSetBits
	ld a, [wNumSetBits]
	cp 2
	jp nc, .asm_1ca69
	CheckEvent EVENT_BEAT_ROUTE22_RIVAL_1ST_BATTLE
	jr nz, .asm_1ca52
	CheckEvent EVENT_GOT_POKEDEX
	jr nz, .asm_1ca4a
	CheckEventReuseA EVENT_BATTLED_RIVAL_IN_OAKS_LAB
	jr nz, .asm_1ca2b
	ld a, [wd72e]
	bit 3, a
	jr nz, .asm_1ca23
	ld hl, OaksLabText_1ca72
	call PrintText
	jr .asm_1ca6f
.asm_1ca23
	ld hl, OaksLabText_1ca77
	call PrintText
	jr .asm_1ca6f
.asm_1ca2b
	ld b, OAKS_PARCEL
	call IsItemInBag
	jr nz, .asm_1ca3a
	ld a, [wPlayerStarter]
	cp STARTER_PIKACHU
	ld hl, OaksLabText_1ca7c
	jr z, .youShouldTalkToItText
	ld hl, OaksLabRBText_1d2fa
.youShouldTalkToItText
	call PrintText
	jr .asm_1ca6f
.asm_1ca3a
	ld hl, OaksLabDeliverParcelText
	call PrintText
	call OaksLabScript_RemoveParcel
	ld a, 19
	ld [wOaksLabCurScript], a
	jr .asm_1ca6f
.asm_1ca4a
	ld hl, OaksLabAroundWorldText
	call PrintText
	jr .asm_1ca6f
.asm_1ca52
	CheckAndSetEvent EVENT_GOT_POKEBALLS_FROM_OAK
	jr nz, .asm_1ca69
	lb bc, POKE_BALL, 5
	call GiveItem
	ld hl, OaksLabGivePokeballsText
	call PrintText
	jr .asm_1ca6f
.asm_1ca69
	ld hl, OaksLabPleaseVisitText
	call PrintText
.asm_1ca6f
	jp TextScriptEnd

OaksLabText_1ca72:
	text_far _OaksLabPikachuText
	text_end

OaksLabText_1ca77:
	text_far _OaksLabText_1d2f5
	text_end

OaksLabText_1ca7c:
	text_far _OaksLabText_1d2fa
	text_end

OaksLabDeliverParcelText:
	text_far _OaksLabDeliverParcelText1
	sound_get_key_item
	text_far _OaksLabDeliverParcelText2
	text_end

OaksLabAroundWorldText:
	text_far _OaksLabAroundWorldText
	text_end

OaksLabGivePokeballsText:
	text_far _OaksLabGivePokeballsText1
	sound_get_key_item
	text_far _OaksLabGivePokeballsText2
	text_end

OaksLabPleaseVisitText:
	text_far _OaksLabPleaseVisitText
	text_end

OaksLabText_1ca9f:
	text_far _OaksLabText_1d31d
	text_end

OaksLabPokedexOnTableText:
OaksLabPokedexOnTableTextCopy:
	text_asm
	ld hl, OaksLabText_1caae
	call PrintText
	jp TextScriptEnd

OaksLabText_1caae:
	text_far _OaksLabText_1d32c
	text_end

OaksLabUnviewableText:
	text_far _OaksLabText8
	text_end

OaksLabGirlText:
	text_asm
	ld hl, OaksLabText_1cac2
	call PrintText
	jp TextScriptEnd

OaksLabText_1cac2:
	text_far _OaksLabText_1d340
	text_end

OaksLabText13:
	text_asm
	ld hl, OaksLabRivalWaitingText
	call PrintText
	jp TextScriptEnd

OaksLabRivalWaitingText:
	text_far _OaksLabRivalWaitingText
	text_end

OaksLabText14:
	text_asm
	ld hl, OaksLabChooseMonText
	call PrintText
	jp TextScriptEnd

OaksLabChooseMonText:
	text_far _OaksLabChooseMonText
	text_end

OaksLabText15:
	text_asm
	ld hl, OaksLabRivalInterjectionText
	call PrintText
	jp TextScriptEnd

OaksLabRivalInterjectionText:
	text_far _OaksLabRivalInterjectionText
	text_end

OaksLabText16:
	text_asm
	ld hl, OaksLabBePatientText
	call PrintText
	jp TextScriptEnd

OaksLabBePatientText:
	text_far _OaksLabBePatientText
	text_end

OaksLabText17:
	text_asm
	ld hl, OaksLabRivalTakesText1
	call PrintText
	ld hl, OaksLabRivalTakesText2
	call PrintText
	ld hl, OaksLabRivalTakesText3
	call PrintText
	ld hl, OaksLabRivalTakesText4
	call PrintText
	ld hl, OaksLabRivalTakesText5
	call PrintText
	jp TextScriptEnd

OaksLabRivalTakesText1:
	text_far _OaksLabRivalTakesText1
	text_end

OaksLabRivalTakesText2:
	text_far _OaksLabRivalTakesText2
	sound_get_key_item
	text_end

OaksLabRivalTakesText3:
	text_far _OaksLabRivalTakesText3
	text_end

OaksLabRivalTakesText4:
	text_far _OaksLabRivalTakesText4
	text_end

OaksLabRivalTakesText5:
	text_far _OaksLabRivalTakesText5
	text_end

OaksLabText18:
	text_asm
	ld a, STARTER_PIKACHU
	ld [wPlayerStarter], a
	ld [wd11e], a
	call GetMonName
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld hl, OaksLabOakGivesText
	call PrintText
	ld hl, OaksLabRecievedText
	call PrintText
	xor a
	ld [wMonDataLocation], a
	ld a, 100
	ld [wCurEnemyLVL], a
	ld a, STARTER_PIKACHU
	ld [wd11e], a
	ld [wcf91], a
	call AddPartyMon
	ld a, LIGHT_BALL_GSC
	ld [wPartyMon1CatchRate], a
	call DisablePikachuOverworldSpriteDrawing
	SetEvent EVENT_GOT_STARTER
	ld hl, wd72e
	set 3, [hl]
	jp TextScriptEnd

OaksLabOakGivesText:
	text_far _OaksLabOakGivesText
	text_end

OaksLabRecievedText:
	text_far _OaksLabReceivedText
	sound_get_key_item
	text_end

OaksLabDontGoAway:
	text_asm
	ld hl, OaksLabLeavingText
	call PrintText
	jp TextScriptEnd

OaksLabLeavingText:
	text_far _OaksLabLeavingText
	text_end

OaksLabText11:
	text_asm
	ld hl, OaksLabRivalChallengeText
	call PrintText
	jp TextScriptEnd

OaksLabRivalChallengeText:
	text_far _OaksLabRivalChallengeText
	text_end

OaksLabRivalDefeatedText:
	text_far _OaksLabText_1d3be
	text_end

OaksLabRivalBeatYouText:
	text_far _OaksLabText_1d3c3
	text_end

OaksLabText12:
	text_asm
	ld hl, OaksLabRivalToughenUpText
	call PrintText
	jp TextScriptEnd

OaksLabRivalToughenUpText:
	text_far _OaksLabRivalToughenUpText
	text_end

OaksLabText26:
	text_asm
	ldpikacry e, PikachuCry2
	callfar PlayPikachuSoundClip
	ld hl, OaksLabPikachuDislikesPokeballsText1
	call PrintText
	jp TextScriptEnd

OaksLabPikachuDislikesPokeballsText1:
	text_far _OaksLabPikachuDislikesPokeballsText1
	text_end

OaksLabText27:
	text_asm
	ld hl, OaksLabPikachuDislikesPokeballsText2
	call PrintText
	jp TextScriptEnd

OaksLabPikachuDislikesPokeballsText2:
	text_far _OaksLabPikachuDislikesPokeballsText2
	text_end

OaksLabText19:
	text_far _OaksLabText21
	text_end

OaksLabText20:
	text_far _OaksLabText22
	text_end

OaksLabText21:
	text_far _OaksLabText23
	text_end

OaksLabText22:
	text_far _OaksLabText24
	text_end

OaksLabText23:
	text_far _OaksLabText25
	sound_get_key_item
	text_end

OaksLabText24:
	text_far _OaksLabText26
	text_end

OaksLabText25:
	text_far _OaksLabText27
	text_end

OaksLabAideText:
OaksLabAideTextCopy:
	text_asm
	ld hl, OaksLabText_1c31d
	call PrintText
	jp TextScriptEnd

OaksLabText_1c31d:
	text_far _OaksLabText_1d405
	text_end
