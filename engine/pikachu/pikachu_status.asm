IsStarterPikachuInOurParty::
	ld a, [wPlayerStarter]
	cp PIKACHU
	jr nz, .starterIsNotPikachu
	call CheckForYellowVersion
	jp z, IsOurStarterInOurParty
.starterIsNotPikachu
	and a
	ret

IsOurStarterInOurParty::
	ld a, -1
	ld [wWhichPokemon], a
.loop
	ld a, [wWhichPokemon]
	inc a
	cp 6
	jr z, .noStarter
	ld [wWhichPokemon], a
	call IsThisPartymonOurStarter
	jr nc, .loop
	
	ld a, [wWhichPokemon]
	ld hl, wPartyMon1HP
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes
	ld a, [hli]
	or [hl]
	jr z, .noStarter
	scf
	ret

.noStarter
	and a
	ret

IsThisBoxmonStarterPikachu::
	ld a, [wPlayerStarter]
	cp PIKACHU
	jr nz, .starterIsNotPikachu
	call CheckForYellowVersion
	jr z, IsThisBoxmonOurStarter
.starterIsNotPikachu
	and a
	ret
	
IsThisBoxmonOurStarter::
	ld hl, wBoxMon1
	ld bc, wBoxMon1CatchRate - wBoxMon1
	push bc
	ld bc, wBoxMon2 - wBoxMon1
	ld de, wBoxMonOT
	jr StarterCheck

IsThisPartymonStarterPikachu::
	ld a, [wPlayerStarter]
	cp PIKACHU
	jr nz, .starterIsNotPikachu
	call CheckForYellowVersion
	jr z, IsThisPartymonOurStarter
.starterIsNotPikachu
	and a
	ret
	
IsThisPartymonOurStarter::
	ld hl, wPartyMon1
	ld bc, wPartyMon1CatchRate - wPartyMon1
	push bc
	ld bc, wPartyMon2 - wPartyMon1
	ld de, wPartyMonOT
StarterCheck:
	ld a, [wWhichPokemon]
	call AddNTimes
	call DoesMonHaveLightBall
	jr nz, .notPlayerStarter
	ld bc, wPartyMon1OTID - wPartyMon1
	add hl, bc
	ld a, [wPlayerID]
	cp [hl]
	jr nz, .notPlayerStarter
	inc hl
	ld a, [wPlayerID+1]
	cp [hl]
	jr nz, .notPlayerStarter
	ld h, d
	ld l, e
	ld a, [wWhichPokemon]
	ld bc, NAME_LENGTH
	call AddNTimes
	ld de, wPlayerName
	ld b, $6
.loop
	dec b
	jr z, .isPlayerStarter
	ld a, [de]
	inc de
	cp [hl]
	inc hl
	jr z, .loop
.notPlayerStarter
	pop bc
	and a
	ret

.isPlayerStarter
	pop bc
	scf
	ret

DoesMonHaveLightBall:
;	pop bc
	push hl
	ld bc, wPartyMon1CatchRate - wPartyMon1
	add hl, bc
	ld a, [hl]
	pop hl
;	push bc
	cp LIGHT_BALL_GSC
	ret

UpdatePikachuMoodAfterBattle::
; because d is always $82 at this function, it serves to
; ensure Pikachu's mood is at least 130 after battle
	push de
	call IsOurStarterInOurParty
	pop de
	ret nc
	ld a, d
	cp 128
	ld a, [wPikachuMood]
	jr c, .d_less_than_128 ; we never jump
	cp d
	jr c, .load_d_into_mood
	ret

.d_less_than_128
	cp d
	ret c
.load_d_into_mood
	ld a, d
	ld [wPikachuMood], a
	ret

CheckPikachuFaintedOrStatused::
; function to test if Pikachu is alive?
	xor a
	ld [wWhichPokemon], a
	ld hl, wPartyCount
.loop
	inc hl
	ld a, [hl]
	cp $ff
	jr z, .dead_or_not_in_party
	push hl
	call IsThisPartymonStarterPikachu
	pop hl
	jr nc, .next
	ld a, [wWhichPokemon]
	ld hl, wPartyMon1HP
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes
	ld a, [hli]
	or [hl]
	ld d, a
	inc hl
	inc hl
	ld a, [hl] ; status
	and a
	jr nz, .alive
	jr .dead_or_not_in_party

.next
	ld a, [wWhichPokemon]
	inc a
	ld [wWhichPokemon], a
	jr .loop

.alive
	scf
	ret

.dead_or_not_in_party
	and a
	ret

IsSurfingPikachuInThePlayersParty::
	ld hl, wPartySpecies
	ld de, wPartyMon1Moves
	ld bc, wPartyMonOT
	push hl
.loop
	pop hl
	ld a, [hli]
	push hl
	inc a
	jr z, .noSurfingPlayerPikachu
	cp STARTER_PIKACHU + 1
	jr nz, .curMonNotSurfingPlayerPikachu
	ld h, d
	ld l, e
	push hl
	push bc
	ld b, NUM_MOVES
.moveSearchLoop
	ld a, [hli]
	cp SURF
	jr z, .foundSurfingPikachu
	dec b
	jr nz, .moveSearchLoop
	pop bc
	pop hl
	jr .curMonNotSurfingPlayerPikachu

.foundSurfingPikachu
	pop bc
	pop hl
	inc hl
	inc hl
	inc hl
	inc hl
	ld a, [wPlayerID]
	cp [hl]
	jr nz, .curMonNotSurfingPlayerPikachu
	inc hl
	ld a, [wPlayerID+1]
	cp [hl]
	jr nz, .curMonNotSurfingPlayerPikachu
	push de
	push bc
	ld hl, wPlayerName
	ld d, $6
.nameCompareLoop
	dec d
	jr z, .foundSurfingPlayerPikachu
	ld a, [bc]
	inc bc
	cp [hl]
	inc hl
	jr z, .nameCompareLoop
	pop bc
	pop de
.curMonNotSurfingPlayerPikachu
	ld hl, wPartyMon2 - wPartyMon1
	add hl, de
	ld d, h
	ld e, l
	ld hl, NAME_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	jr .loop

.foundSurfingPlayerPikachu
	pop bc
	pop de
	pop hl
	scf
	ret

.noSurfingPlayerPikachu
	pop hl
	and a
	ret

IsSurfingPikachuInParty_::
; set bit 6 of wd472 if true
; also calls Func_3467, which is a bankswitch to IsStarterPikachuInOurParty
	ld a, [wd472]
	and $3f
	ld [wd472], a
	ld hl, wPartyMon1
	ld c, PARTY_LENGTH
	ld b, SURF
.loop
	ld a, [hl]
	cp STARTER_PIKACHU
	jr nz, .notPikachu
	push hl
	ld de, $8
	add hl, de
	ld a, [hli]
	cp b ; does pikachu have surf as one of its moves
	jr z, .hasSurf
	ld a, [hli]
	cp b
	jr z, .hasSurf
	ld a, [hli]
	cp b
	jr z, .hasSurf
	ld a, [hli]
	cp b
	jr nz, .noSurf
.hasSurf
	ld a, [wd472]
	set 6, a
	ld [wd472], a
.noSurf
	pop hl
.notPikachu
	ld de, wPartyMon2 - wPartyMon1
	add hl, de
	dec c
	jr nz, .loop
	call Func_3467
	ret
	
Func_3467::
	push hl
	push bc
	callfar IsStarterPikachuInOurParty
	pop bc
	pop hl
	ret nc
	ld a, [wd472]
	set 7, a
	ld [wd472], a
	ret