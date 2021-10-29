; Copy the current map's sprites' tile patterns to VRAM again after they have
; been overwritten by other tile patterns.
ReloadMapSpriteTilePatterns::
	ld hl, wFontLoaded
	ld a, [hl]
	push af
	res 0, [hl]
	push hl
	xor a
	ld [wSpriteSetID], a
	call DisableLCD
	call InitMapSprites
	call EnableLCD
	pop hl
	pop af
	ld [hl], a
	call LoadPlayerSpriteGraphics
	call LoadFontTilePatterns
	jp UpdateSprites

LoadMapAfterVersionChange::
	ldh a, [hLoadedROMBank]
	push af
	call DisableLCD
	call ResetMapVariables
	call LoadTextBoxTilePatterns
	ld a, 69 ; load wUniversalVariable with a special value to leave
	ld [wUniversalVariable], a	; LoadTilesetHeader before player is moved
	call LoadMapHeader
	call ClearVariable ; Resets the variable so it doesn't affect future loads
	
	ld hl, wFontLoaded ;the important not crashy pieces of ReloadMapSpriteTilePatterns
	ld a, [hl]			; it could be its own function, but nothing else will
	push af				; likely ever call it
	res 0, [hl]
	push hl
	xor a
	ld [wSpriteSetID], a
	call InitMapSprites
	pop hl
	pop af
	ld [hl], a
	
	call LoadFontTilePatterns
	call LoadScreenRelatedData
	call CopyMapViewToVRAM
	call EnableLCD
	pop af
	call BankswitchCommon
	ret