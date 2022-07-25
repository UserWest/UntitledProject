_VersionChangeCheckCollision::
	jp CheckSpecialCases
.checkStartPos
	lb bc, 60, 64 ; y/x coords to be checked, in pixels, 16 pixels = 1 tile
	call CheckForSprite
	jr c, .checkNorth
	lda_coord 8, 9 ; tile the player is on
	ld c, a
	call IsTileWalkableOrSurfable
	jr nc, .done

.checkNorth	
	lb bc, 44, 64 ; y/x coords to be checked, in pixels, 16 pixels = 1 tile
	call CheckForSprite
	jr c, .checkEast
	lda_coord 8, 7 ; tile north of the player
	ld c, a
	call IsTileWalkableOrSurfable
	jr c, .checkEast
	jp MovePlayerNorth
	
.checkEast
	lb bc, 60, 80 ; y/x coords to be checked, in pixels, 16 pixels = 1 tile
	call CheckForSprite
	jr c, .checkSouth
	lda_coord 10, 9 ; tile east of the player
	ld c, a
	call IsTileWalkableOrSurfable
	jr c, .checkSouth
	jp MovePlayerEast
	
.checkSouth
	lb bc, 76, 64 ; y/x coords to be checked, in pixels, 16 pixels = 1 tile
	call CheckForSprite
	jr c, .checkWest
	lda_coord 8, 11 ; tile south of the player
	ld c, a
	call IsTileWalkableOrSurfable
	jr c, .checkWest
	jp MovePlayerSouth
	
.checkWest
	lb bc, 60, 48 ; y/x coords to be checked, in pixels, 16 pixels = 1 tile
	call CheckForSprite
	jr c, .checkNorthByTwo
	lda_coord 6, 9 ; tile west of the player
	ld c, a
	call IsTileWalkableOrSurfable
	jr c, .checkNorthByTwo
	jp MovePlayerWest
	
.checkNorthByTwo
	lb bc, 28, 64 ; y/x coords to be checked, in pixels, 16 pixels = 1 tile
	call CheckForSprite
	jr c, .done
	lda_coord 8, 5 ; 2 tiles north of the player
	ld c, a
	call IsTileWalkableOrSurfable; It shouldn't be possible for the player to get more stuck than this
	jr c, .done 		 	     ; this check is in case I'm wrong though, a player can at least load up
	call MovePlayerNorth	     ; the previous version and escape that way
	jp MovePlayerNorth	
	
.done
	ret

IsTileWalkableOrSurfable:
	push af
	ld a, [wWalkBikeSurfState]
	cp $02 ; surfing
	jr z, .surfTiles
	pop af
	jp IsTilePassable
	
.surfTiles
	pop af
	ld [wTileInFrontOfPlayer], a ;IsNextTileShoreOrWater checks this
	farcall IsNextTileShoreOrWater          ; As compared to IsTilePassable the carry flag is
	ccf		                                ; set backwards, just need to swap those around
	ret

CheckForSprite: ;copy/pasted from IsSpriteInFrontOfPlayer.doneCheckingDirection
	ld hl, wSprite01StateData1
	ld d, $f
.spriteLoop
	push hl
	ld a, [hli] ; image (0 if no sprite)
	and a
	jr z, .nextSprite
	inc l
	ld a, [hli] ; sprite visibility
	inc a
;	jr z, .nextSprite ;this check is always 0 when switching versions
	inc l
	ld a, [hli] ; Y location
	cp b
	jr nz, .nextSprite
	inc l
	ld a, [hl] ; X location
	cp c
	jr z, .foundSprite
.nextSprite
	pop hl
	ld a, l
	add $10
	ld l, a
	dec d
	jr nz, .spriteLoop
	xor a
	ret

.foundSprite
	pop hl
	scf
	ret

MovePlayerNorth:
	ld a, [wYCoord] ;players current y coord
	dec a	;reduced by one
	ld [wYCoord], a	;reinserted

	ld a, [wYBlockCoord] ;players current position in block
	and a	; if its 0
	jr nz, .sameBlock ; we change blocks
	inc a	;otherwise make a 1 instead of zero
	ld [wYBlockCoord], a	; reinserted into block position
	ld hl, wCurrentTileBlockMapViewPointer	; which block is the player currently on
	ld a, [wCurMapWidth]	; load the current map width

	add MAP_BORDER * 2	; account for the border on either side
	ld b, a	; put it in b
	ld a, [hl]	;put block is the player currently on in a
	sub b ; move player up by 1 row of blocks
	ld [hli], a ;reinserted into block is the player currently on/ move to top bits of wCurrentTileBlockMapViewPointer
	jr nc, .done ; Was carry flag set?
	dec [hl]	; if so decrease top bits of wCurrentTileBlockMapViewPointer
	
	jr .done
.sameBlock ; jump here if current position in block is 1
	dec a ; make it zero instead
	ld [wYBlockCoord], a ; reinserted into block position
.done	
	ret

MovePlayerEast:
	ld a, [wXCoord]
	inc a
	ld [wXCoord], a

	ld a, [wXBlockCoord]
	and a
	jr z, .sameBlock
	dec a
	ld [wXBlockCoord], a
	ld hl, wCurrentTileBlockMapViewPointer

	inc [hl]
	
	jr .done
.sameBlock
	inc a
	ld [wXBlockCoord], a
.done	
	ret

MovePlayerSouth:
	ld a, [wYCoord]
	inc a
	ld [wYCoord], a

	ld a, [wYBlockCoord]
	and a
	jr z, .sameBlock
	dec a
	ld [wYBlockCoord], a
	ld hl, wCurrentTileBlockMapViewPointer
	ld a, [wCurMapWidth]

	add MAP_BORDER * 2
	ld b, a
	ld a, [hl]
	add b
	ld [hli], a
	jr nc, .done
	inc [hl]
	
	jr .done
.sameBlock
	inc a
	ld [wYBlockCoord], a
.done	
	ret

MovePlayerWest:
	ld a, [wXCoord]
	dec a
	ld [wXCoord], a

	ld a, [wXBlockCoord]
	and a
	jr nz, .sameBlock
	inc a
	ld [wXBlockCoord], a
	ld hl, wCurrentTileBlockMapViewPointer

	dec [hl]
	
	jr .done
.sameBlock
	dec a
	ld [wXBlockCoord], a
.done	
	ret

CheckSpecialCases:
	ld a, [wCurMap]
	cp OAKS_LAB
	jr z, .oaksLab
	cp ROUTE_19
	jr z, .route19
	cp SAFFRON_CITY
	jr z, .saffron

.continueCollisionCheck
	jp _VersionChangeCheckCollision.checkStartPos
.endCollisionCheck
	jp _VersionChangeCheckCollision.done

.oaksLab
	call CheckForYellowVersion
	jr nz, .continueCollisionCheck
			ld a, [wYCoord]
			cp 2
			jr nz, .continueCollisionCheck
				ld a, [wXCoord]
				cp 5
				jr c, .continueCollisionCheck
					call MovePlayerSouth
					call MovePlayerSouth
					jr .endCollisionCheck
.route19
	call CheckForYellowVersion
	jr nz, .continueCollisionCheck
		ld a, [wXCoord]
		cp 5
		jr z, .continueRoute19
		cp 4
		jr nz, .continueCollisionCheck
		.continueRoute19
			ld a, [wYCoord]
			cp 9
			jr nz, .continueCollisionCheck
				jp MovePlayerSouth
				jr .endCollisionCheck
.saffron
	ld a, [wXCoord]
	cp 18
	jr nz, .continueCollisionCheck
		ld a, [wYCoord]
		cp 22
		jr nz, .continueCollisionCheck
		jr .endCollisionCheck
