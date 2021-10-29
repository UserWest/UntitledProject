SSAnne1FRooms_Object:
	db $c ; border block

	def_warp_events
	warp_event  0,  0, SS_ANNE_1F, 3
	warp_event 10,  0, SS_ANNE_1F, 4
	warp_event 20,  0, SS_ANNE_1F, 5
	warp_event  0, 10, SS_ANNE_1F, 6
	warp_event 10, 10, SS_ANNE_1F, 7
	warp_event 20, 10, SS_ANNE_1F, 8

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_GENTLEMAN, ANY_VERSION, STAY, LEFT, 1, OPP_GENTLEMAN, 1
	object_event 11,  4, SPRITE_GENTLEMAN, ANY_VERSION, STAY, UP, 2, OPP_GENTLEMAN, 2
	object_event 11, 14, SPRITE_YOUNGSTER, ANY_VERSION, STAY, UP, 3, OPP_YOUNGSTER, 8
	object_event 13, 11, SPRITE_COOLTRAINER_F, ANY_VERSION, STAY, LEFT, 4, OPP_LASS, 11
	object_event 22,  3, SPRITE_GIRL, ANY_VERSION, WALK, UP_DOWN, 5 ; person
	object_event  0, 14, SPRITE_MIDDLE_AGED_MAN, ANY_VERSION, STAY, NONE, 6 ; person
	object_event  2, 11, SPRITE_LITTLE_GIRL, ANY_VERSION, STAY, DOWN, 7 ; person
	object_event  3, 11, SPRITE_JIGGLYPUFF, YELLOW_VERSION, STAY, DOWN, 8 ; person
	object_event  3, 11, SPRITE_FAIRY, RED_OR_BLUE, STAY, DOWN, 8 ; person
	object_event 10, 13, SPRITE_GIRL, ANY_VERSION, STAY, RIGHT, 9 ; person
	object_event 12, 15, SPRITE_POKE_BALL, ANY_VERSION, STAY, NONE, 10, TM_BODY_SLAM
	object_event 21, 13, SPRITE_GENTLEMAN, ANY_VERSION, WALK, LEFT_RIGHT, 11 ; person

	def_warps_to SS_ANNE_1F_ROOMS
