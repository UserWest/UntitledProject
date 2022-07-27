CheckForYellowVersion::
	ld a, [wCurVersion]
	cp YELLOW_VERSION
	ret

ClearVariable::
	push af
	xor a
	ld [wUniversalVariable], a
	pop af
	ret

DoVersionChange:: ; this really needs to be broken down into just the relevant code rather than calls
	ldh a, [hLoadedROMBank]
	push af
	call DisableLCD
	call ResetMapVariables
	call LoadTextBoxTilePatterns
	ld a, VERSION_CHANGE_IN_PROGRESS ; load wUniversalVariable with a special value so we
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
	call LoadScreenRelatedData	 			; VersionChangeCheckCollision to check against
	call VersionChangeCheckCollision		; and then we do it again
	
	call ResetMapVariables 		 ; round 2 is for showing the map, if we don't do this
	call LoadTextBoxTilePatterns ; twice sprites will maintain their poximity to the
	call LoadMapHeader			 ; player and then snap into position when the menu is
	call ClearVariable			 ; closed and frankly I don't like the way that looks,
	call InitMapSprites			 ; so we just do this stuff twice
	
	ld hl, wCurrentMapScriptFlags ; This part will set the card key doors to reload
	set 5, [hl]
	set 6, [hl]
	
	call LoadFontTilePatterns
	call LoadCurrentMapView
	call CopyMapViewToVRAM
	call EnableLCD
	pop af
	jp BankswitchCommon

VersionChangeCheckCollision::
	farjp _VersionChangeCheckCollision

