RedsHouse1F_Script:
	call EnableAutoTextBoxDrawing
	ret

RedsHouse1F_TextPointers:
	dw RedsHouse1FMomText
	dw RedsHouse1FTVText

RedsHouse1FMomText:
	text_asm
	callfar Func_f1b73
	jp TextScriptEnd

RedsHouse1FTVText:
	text_asm
;	call IsStarterPikachuInThisBox
	jr nc, .fail
	ld hl, TestSuccess
	call PrintText
	jr .done
.fail
	ld hl, TestFailure
	call PrintText
.done
	jp TextScriptEnd

Original_RedsHouse1FTVText:
	text_asm
	ld a, 11
	ld [wCurrentBoxNum], a
	callfar Func_f1bc4
	jp TextScriptEnd

TestSuccess:
	text_far _TestSuccess
	text_end
	
TestFailure:
	text_far _TestFailure
	text_end

_TestSuccess::
	text "Pika in box"
	prompt

_TestFailure::
	text "Pika not in box"
	prompt