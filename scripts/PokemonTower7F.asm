PokemonTower7F_Script:
	call EnableAutoTextBoxDrawing
	ld hl, PokemonTower7TrainerHeaders
	ld de, PokemonTower7F_ScriptPointers
	ld a, [wPokemonTower7FCurScript]
	call ExecuteCurMapScriptInTable
	ld [wPokemonTower7FCurScript], a
	ret

PokemonTower7Script_ResetScripts:
	xor a
	ld [wJoyIgnore], a
PokemonTower7Script_ChangeScript:
	ld [wPokemonTower7FCurScript], a
	ld [wCurMapScript], a
	ret

PokemonTower7F_ScriptPointers:
	dw PokemonTower7Script0
	dw DisplayEnemyTrainerTextAndStartBattle
	dw PokemonTower7EndTrainerBattle
	dw PokemonTower7Script1
	dw PokemonTower7Script2
	dw PokemonTower7Script3
	dw PokemonTower7Script4
	dw PokemonTower7Script5
	dw PokemonTower7Script6
	dw PokemonTower7Script7
	dw PokemonTower7Script8
	dw PokemonTower7Script9
	dw PokemonTower7Script10
	dw PokemonTower7Script11
	dw PokemonTower7Script_HideRocket

PokemonTower7EndTrainerBattle:
	ld hl, wFlags_0xcd60
	res 0, [hl]
	ld a, [wIsInBattle]
	cp $ff
	jp z, PokemonTower7Script_ResetScripts
	call EndTrainerBattle
	ld a, $f0
	ld [wJoyIgnore], a
	ld a, [wSpriteIndex]
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	call PokemonTower7Script_TrainerWalksAway
	ld a, $e
	ld [wPokemonTower7FCurScript], a
	ld [wCurMapScript], a
	ret

PokemonTower7Script_HideRocket:
	ld a, [wd730]
	bit 0, a
	ret nz

	ld a, [wUniversalVariable]
	ld [wMissableObjectIndex], a   ; remove missable object
	predef HideObject
	xor a
	ld [wUniversalVariable], a ; wipe the variable, no need for ClearVariable here
	ld [wSpriteIndex], a
	ld [wTrainerHeaderFlagBit], a
	ld [wUnusedDA38], a
	ld [wPokemonTower7FCurScript], a
	ld [wCurMapScript], a
	ret

PokemonTower7Script0:
	xor a
	ld [wJoyIgnore], a
	call CheckForYellowVersion
	jp nz, CheckFightingMapTrainers
	CheckEvent EVENT_BEAT_POKEMONTOWER_7_JESSIE_AND_JAMES
	jp z, PokemonTower7Script_JessieAndJamesFightTrigger
	ret

PokemonTower7Script_JessieAndJamesFightTrigger:
	ld a, [wYCoord]
	cp $c
	ret nz
	ResetEvent EVENT_POKEMONTOWER_7_PLAYER_LOCATION
	ld a, [wXCoord]
	cp $a
	jr z, .asm_60d47
	cp $b
	ret nz
	SetEvent EVENT_POKEMONTOWER_7_PLAYER_LOCATION
.asm_60d47
	call StopAllMusic
	ld c, BANK(Music_MeetJessieJames)
	ld a, MUSIC_MEET_JESSIE_JAMES
	call PlayMusic
	xor a
	ldh [hJoyHeld], a
	ld a, ~(A_BUTTON | B_BUTTON)
	ld [wJoyIgnore], a
	ld a, HS_POKEMON_TOWER_7F_JESSIE
	call PokemonTower7Script_60eaf
	ld a, HS_POKEMON_TOWER_7F_JAMES
	call PokemonTower7Script_60eaf
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld a, $7
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, $3
	call PokemonTower7Script_ChangeScript
	ret

PokemonTower7MovementData_60d7a:
	db $4
PokemonTower7MovementData_60d7b:
	db $4
	db $4
	db $4
	db $FF

PokemonTower7Script1:
	ld de, PokemonTower7MovementData_60d7b
	CheckEvent EVENT_POKEMONTOWER_7_PLAYER_LOCATION
	jr z, .asm_60d8c
	ld de, PokemonTower7MovementData_60d7a
.asm_60d8c
	ld a, $5
	ldh [hSpriteIndexOrTextID], a
	call MoveSprite
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, $4
	call PokemonTower7Script_ChangeScript
	ret

PokemonTower7Script2:
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, [wd730]
	bit 0, a
	ret nz
PokemonTower7Script3:
	ld a, SPRITE_FACING_DOWN
	ld [wSprite05StateData1FacingDirection], a
	CheckEvent EVENT_POKEMONTOWER_7_PLAYER_LOCATION
	jr z, .asm_60dba
	ld a, SPRITE_FACING_RIGHT
	ld [wSprite05StateData1FacingDirection], a
.asm_60dba
	ld a, $2
	ld [wSprite05StateData1MovementStatus], a
PokemonTower7Script4:
	ld de, PokemonTower7MovementData_60d7a
	CheckEvent EVENT_POKEMONTOWER_7_PLAYER_LOCATION
	jr z, .asm_60dcc
	ld de, PokemonTower7MovementData_60d7b
.asm_60dcc
	ld a, $6
	ldh [hSpriteIndexOrTextID], a
	call MoveSprite
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, $7
	call PokemonTower7Script_ChangeScript
	ret
PokemonTower7Script5:
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, [wd730]
	bit 0, a
	ret nz
PokemonTower7Script6:
	ld a, $2
	ld [wSprite06StateData1MovementStatus], a
	ld a, SPRITE_FACING_LEFT
	ld [wSprite06StateData1FacingDirection], a
	CheckEvent EVENT_POKEMONTOWER_7_PLAYER_LOCATION
	jr z, .asm_60dff
	ld a, SPRITE_FACING_DOWN
	ld [wSprite06StateData1FacingDirection], a
.asm_60dff
	call Delay3
	ld a, ~(A_BUTTON | B_BUTTON)
	ld [wJoyIgnore], a
	ld a, $8
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
PokemonTower7Script7:
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, PokemonTower7JessieJamesEndBattleText
	ld de, PokemonTower7JessieJamesEndBattleText
	call SaveEndBattleTextPointers
	ld a, OPP_ROCKET
	ld [wCurOpponent], a
	ld a, $2c
	ld [wTrainerNo], a
	xor a
	ldh [hJoyHeld], a
	ld [wJoyIgnore], a
	ld a, $a
	call PokemonTower7Script_ChangeScript
	ret

PokemonTower7Script8:
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, [wIsInBattle]
	cp $ff
	jp z, PokemonTower7Script_ResetScripts
	ld a, $2
	ld [wSprite05StateData1MovementStatus], a
	ld [wSprite06StateData1MovementStatus], a
	xor a
	ld [wSprite05StateData1FacingDirection], a
	ld [wSprite06StateData1FacingDirection], a
	ld a, ~(A_BUTTON | B_BUTTON)
	ld [wJoyIgnore], a
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld a, $9
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	xor a
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	call StopAllMusic
	ld c, BANK(Music_MeetJessieJames)
	ld a, MUSIC_MEET_JESSIE_JAMES
	call PlayMusic
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, $b
	call PokemonTower7Script_ChangeScript
	ret

PokemonTower7Script9:
	ld a, $ff
	ld [wJoyIgnore], a
	call GBFadeOutToBlack
	ld a, HS_POKEMON_TOWER_7F_JESSIE
	call PokemonTower7Script_60ebe
	ld a, HS_POKEMON_TOWER_7F_JAMES
	call PokemonTower7Script_60ebe
	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack
	ld a, $c
	call PokemonTower7Script_ChangeScript
	ret

PokemonTower7Script10:
	call PlayDefaultMusic
	xor a
	ldh [hJoyHeld], a
	ld [wJoyIgnore], a
	SetEvent EVENT_BEAT_MT_MOON_3_JESSIE_AND_JAMES
	SetEvent EVENT_BEAT_ROCKET_HIDEOUT_4_JESSIE_AND_JAMES
	SetEvent EVENT_BEAT_POKEMONTOWER_7_JESSIE_AND_JAMES
	ld a, $0
	call PokemonTower7Script_ChangeScript
	ret

PokemonTower7Script_60eaf:
	ld [wMissableObjectIndex], a
	predef ShowObject
	call UpdateSprites
	call Delay3
	ret

PokemonTower7Script_60ebe:
	ld [wMissableObjectIndex], a
	predef HideObject
	ret

PokemonTower7Script11:
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, HS_POKEMON_TOWER_7F_MR_FUJI
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, SPRITE_FACING_UP
	ld [wSpritePlayerStateData1FacingDirection], a
	ld a, MR_FUJIS_HOUSE
	ldh [hWarpDestinationMap], a
	ld a, $1
	ld [wDestinationWarpID], a
	ld a, LAVENDER_TOWN
	ld [wLastMap], a
	ld hl, wd72d
	set 3, [hl]
	ld a, $0
	ld [wPokemonTower7FCurScript], a
	ret

PokemonTower7F_TextPointers:
	dw PokemonTower7TrainerText0
	dw PokemonTower7TrainerText1
	dw PokemonTower7TrainerText2
	dw PokemonTower7Text1
	dw PokemonTower7Text2
	dw PokemonTower7Text3
	dw PokemonTower7Text4
	dw PokemonTower7Text5
	dw PokemonTower7Text6

PokemonTower7Script_TrainerWalksAway:
	ld hl, CoordsData_60de3
	ld a, [wSpriteIndex]
	dec a
	swap a
	ld d, $0
	ld e, a
	add hl, de
	ld a, [wYCoord]
	ld b, a
	ld a, [wXCoord]
	ld c, a
.loop
	ld a, [hli]
	cp b
	jr nz, .asm_60dde
	ld a, [hli]
	cp c
	jr nz, .asm_60ddf
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ld a, [wSpriteIndex]
	ldh [hSpriteIndex], a
	jp MoveSprite
.asm_60dde
	inc hl
.asm_60ddf
	inc hl
	inc hl
	jr .loop

CoordsData_60de3:
	map_coord_movement  9, 12, MovementData_60e13
	map_coord_movement 10, 11, MovementData_60e1b
	map_coord_movement 11, 11, MovementData_60e22
	map_coord_movement 12, 11, MovementData_60e22
	map_coord_movement 12, 10, MovementData_60e28
	map_coord_movement 11,  9, MovementData_60e30
	map_coord_movement 10,  9, MovementData_60e22
	map_coord_movement  9,  9, MovementData_60e22
	map_coord_movement  9,  8, MovementData_60e37
	map_coord_movement 10,  7, MovementData_60e22
	map_coord_movement 11,  7, MovementData_60e22
	map_coord_movement 12,  7, MovementData_60e22

MovementData_60e13:
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_LEFT
	db -1 ; end

MovementData_60e1b:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

MovementData_60e22:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

MovementData_60e28:
	db NPC_MOVEMENT_LEFT
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

MovementData_60e30:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_LEFT
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

MovementData_60e37:
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end
	
PokemonTower7TrainerHeaders:
	def_trainers
PokemonTower7TrainerHeader0:
	trainer EVENT_BEAT_POKEMONTOWER_7_TRAINER_0, 3, PokemonTower7BattleText1, PokemonTower7EndBattleText1, PokemonTower7AfterBattleText1
PokemonTower7TrainerHeader1:
	trainer EVENT_BEAT_POKEMONTOWER_7_TRAINER_1, 3, PokemonTower7BattleText2, PokemonTower7EndBattleText2, PokemonTower7AfterBattleText2
PokemonTower7TrainerHeader2:
	trainer EVENT_BEAT_POKEMONTOWER_7_TRAINER_2, 3, PokemonTower7BattleText3, PokemonTower7EndBattleText3, PokemonTower7AfterBattleText3
	db -1 ; end

PokemonTower7TrainerText0:
	text_asm
	ld a, HS_POKEMON_TOWER_7F_ROCKET_1
	ld [wUniversalVariable], a
	ld hl, PokemonTower7TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

PokemonTower7TrainerText1:
	text_asm
	ld a, HS_POKEMON_TOWER_7F_ROCKET_2
	ld [wUniversalVariable], a
	ld hl, PokemonTower7TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

PokemonTower7TrainerText2:
	text_asm
	ld a, HS_POKEMON_TOWER_7F_ROCKET_3
	ld [wUniversalVariable], a
	ld hl, PokemonTower7TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

PokemonTower7Text1:
PokemonTower7Text2:
	text_end

PokemonTower7Text4:
	text_far _PokemonTowerJessieJamesText1
	text_asm
	ld c, 10
	call DelayFrames
	ld a, PLAYER_DIR_UP
	ld [wPlayerMovingDirection], a
	ld a, $0
	ld [wEmotionBubbleSpriteIndex], a
	ld a, EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
	ld c, 20
	call DelayFrames
	jp TextScriptEnd

PokemonTower7Text5:
	text_far _PokemonTowerJessieJamesText2
	text_end

PokemonTower7JessieJamesEndBattleText:
	text_far _PokemonTowerJessieJamesText3
	text_end

PokemonTower7Text6:
	text_far _PokemonTowerJessieJamesText4
	text_asm
	ld c, 64
	call DelayFrames
	jp TextScriptEnd

PokemonTower7Text3:
	text_asm
	ld hl, PokemonTower7Text_60f75
	call PrintText
	SetEvent EVENT_RESCUED_MR_FUJI
	SetEvent EVENT_RESCUED_MR_FUJI_2
	ld a, HS_MR_FUJIS_HOUSE_MR_FUJI
	ld [wMissableObjectIndex], a
	predef ShowObject
	ld a, HS_SAFFRON_CITY_SILPH_GUARD
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_SAFFRON_CITY_F
	ld [wMissableObjectIndex], a
	predef ShowObject
	ld a, $d
	ld [wPokemonTower7FCurScript], a
	jp TextScriptEnd

PokemonTower7Text_60f75:
	text_far _TowerRescueFujiText
	text_end

PokemonTower7BattleText1:
	text_far _PokemonTower7BattleText1
	text_end

PokemonTower7EndBattleText1:
	text_far _PokemonTower7EndBattleText1
	text_end

PokemonTower7AfterBattleText1:
	text_far _PokemonTower7AfterBattleText1
	text_end

PokemonTower7BattleText2:
	text_far _PokemonTower7BattleText2
	text_end

PokemonTower7EndBattleText2:
	text_far _PokemonTower7EndBattleText2
	text_end

PokemonTower7AfterBattleText2:
	text_far _PokemonTower7AfterBattleText2
	text_end

PokemonTower7BattleText3:
	text_far _PokemonTower7BattleText3
	text_end

PokemonTower7EndBattleText3:
	text_far _PokemonTower7EndBattleText3
	text_end

PokemonTower7AfterBattleText3:
	text_far _PokemonTower7AfterBattleText3
	text_end