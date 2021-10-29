FanClubPicture1:
	call CheckForYellowVersion
	jr nz, .listenPolitely
	ld a, RAPIDASH
	ld [wcf91], a
	call DisplayMonFrontSpriteInBox
	call EnableAutoTextBoxDrawing
	tx_pre FanClubPicture1Text
	ret
.listenPolitely
	call EnableAutoTextBoxDrawing
	tx_pre LetsListenPolitelyText
	ret
	
FanClubPicture1Text::
	text_far _FanClubPicture1Text
	text_end

LetsListenPolitelyText::
	text_far _LetsListenPolitelyText
	text_end

FanClubPicture2:
	call CheckForYellowVersion
	jr nz, .bragRightBack
	ld a, FEAROW
	ld [wcf91], a
	call DisplayMonFrontSpriteInBox
	call EnableAutoTextBoxDrawing
	tx_pre FanClubPicture2Text
	ret
.bragRightBack
	call EnableAutoTextBoxDrawing
	tx_pre BragRightBackText
	ret

FanClubPicture2Text::
	text_far _FanClubPicture2Text
	text_end

BragRightBackText::
	text_far _BragRightBackText
	text_end
	