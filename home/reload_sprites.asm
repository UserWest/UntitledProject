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

LoadMapAfterVersionChange:: ; this really needs to be broken down into just the relevant code for speed
	ldh a, [hLoadedROMBank]
	push af
	call DisableLCD
	call ResetMapVariables
	call LoadTextBoxTilePatterns
	ld a, 69 					 ; load wUniversalVariable with a special value so we
	ld [wUniversalVariable], a	 ; can leave LoadTilesetHeader before the player is moved
	
	call LoadMapHeader 			 	
	ld hl, wFontLoaded  ; this section is needed to reload the sprite sets
	ld a, [hl]			; it could be its own function, but nothing else will
	push af				; likely ever call it, copy/pasted from ReloadMapSpriteTilePatterns
	res 0, [hl]
	push hl
	xor a
	ld [wSpriteSetID], a
	call InitMapSprites
	pop hl
	pop af
	ld [hl], a
											; first time is to check collisions and move the
	call UpdateSprites			 			; player if needed.  We load all the data for
	call LoadScreenRelatedData	 			; CollisionCheckAfterVersionChange to check against
	call CollisionCheckAfterVersionChange	; and then we do it again
	
	call ResetMapVariables 		 ; round 2 is for showing the map, if we don't do this
	call LoadTextBoxTilePatterns ; twice sprites will maintain their poximity to the
	call LoadMapHeader			 ; player and then snap into position when the menu is
	call ClearVariable			 ; closed and frankly I don't like the way that looks,
	call InitMapSprites			 ; so we just do this stuff twice
	call LoadFontTilePatterns
	
	call LoadCurrentMapView
	call CopyMapViewToVRAM
	call EnableLCD
	pop af
	call BankswitchCommon
	ret