GetTrainerInformation::
	call GetTrainerName
	ld a, [wLinkState]
	and a
	jr nz, .linkBattle
	ld a, BANK(TrainerPicAndMoneyPointers)
	call BankswitchHome
	ld a, [wTrainerClass]
	dec a
	ld hl, TrainerPicAndMoneyPointers
	ld bc, $5
	call AddNTimes
	ld de, wTrainerPicPointer
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	ld de, wTrainerBaseMoney
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	call IsFightingJessieJames
	call BankswitchBack
	homejp CheckForVersionPicSwap
.linkBattle
	ld hl, wTrainerPicPointer
	call CheckForYellowVersion
	ld de, RedRBPicFront
	jr nz, .gotRedPic
	ld de, RedPicFront
.gotRedPic
	ld [hl], e
	inc hl
	ld [hl], d
	ret

IsFightingJessieJames:: ; JessieJamesPic was moved to another bank to fit Rival1RBPic in the
	ld a, [wTrainerClass] ; original, this is important for intro based stuff using the rival pic
	cp ROCKET
	ret nz
	ld a, [wTrainerNo]
	cp $2a
	ret c
	ld de, JessieJamesPic
	cp $2e
	jr c, .dummy
	ld de, JessieJamesPic ; possibly meant to add another pic
.dummy
	ld a, USE_RED_OR_BLUE_GRAPHICS	; Set up for a check later in _LoadTrainerPic we can switch to the
	ld [wUniversalVariable], a		; appropriate bank, variable is wiped in _ScrollTrainerPicAfterBattle
	ld hl, wTrainerPicPointer  		; and HandleBlackOut
	ld a, e
	ld [hli], a
	ld [hl], d
	ret

GetTrainerName::
	farjp GetTrainerName_
