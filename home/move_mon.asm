; Copies [hl, bc) to [de, de + bc - hl).
; In other words, the source data is from hl up to but not including bc,
; and the destination is de.
CopyDataUntil::
	ld a, [hli]
	ld [de], a
	inc de
	ld a, h
	cp b
	jr nz, CopyDataUntil
	ld a, l
	cp c
	jr nz, CopyDataUntil
	ret

; Function to remove a pokemon from the party or the current box.
; wWhichPokemon determines the pokemon.
; [wRemoveMonFromBox] == 0 specifies the party.
; [wRemoveMonFromBox] != 0 specifies the current box.
RemovePokemon::
	jpfar _RemovePokemon

AddPartyMon::
	push hl
	push de
	push bc
	farcall _AddPartyMon
	pop bc
	pop de
	pop hl
	ret

; calculates all 5 stats of current mon and writes them to [de]
CalcStats::
	ld c, $0
.statsLoop
	inc c
	call CalcStat
	ldh a, [hMultiplicand+1]
	ld [de], a
	inc de
	ldh a, [hMultiplicand+2]
	ld [de], a
	inc de
	ld a, c
	cp NUM_STATS
	jr nz, .statsLoop
	ret

CalcStat::
	homejp _CalcStat

AddEnemyMonToPlayerParty::
	homejp_sf _AddEnemyMonToPlayerParty

MoveMon::
	homejp_sf _MoveMon
