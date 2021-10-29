; Compare strings, c bytes in length, at de and hl.
; Often used to compare big endian numbers in battle calculations.
StringCmp::
	ld a, [de]
	cp [hl]
	ret nz
	inc de
	inc hl
	dec c
	jr nz, StringCmp
	ret

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

;CheckForRedVersion::
;	ld a, [wCurVersion]
;	cp RED_VERSION
;	ret

;CheckForBlueVersion::
;	ld a, [wCurVersion]
;	cp BLUE_VERSION
;	ret
