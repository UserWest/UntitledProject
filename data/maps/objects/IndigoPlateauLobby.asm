IndigoPlateauLobby_Object:
	db $0 ; border block

	def_warp_events
	warp_event  7, 11, LAST_MAP, 1
	warp_event  8, 11, LAST_MAP, 2
	warp_event  8,  0, LORELEIS_ROOM, 1

	def_bg_events

	def_object_events
	object_event  7,  5, SPRITE_NURSE, YELLOW_VERSION, STAY, DOWN, 1 ; person
	object_event  7,  5, SPRITE_NURSE_RED, RED_OR_BLUE, STAY, DOWN, 1 ; person
	object_event  4,  9, SPRITE_GYM_GUIDE, ANY_VERSION, STAY, RIGHT, 2 ; person
	object_event  5,  1, SPRITE_COOLTRAINER_F, ANY_VERSION, STAY, DOWN, 3 ; person
	object_event  0,  5, SPRITE_CLERK, ANY_VERSION, STAY, RIGHT, 4 ; person
	object_event 13,  6, SPRITE_LINK_RECEPTIONIST, ANY_VERSION, STAY, DOWN, 5 ; person
	object_event  8,  5, SPRITE_CHANSEY, YELLOW_VERSION, STAY, DOWN, 6 ; person

	def_warps_to INDIGO_PLATEAU_LOBBY
