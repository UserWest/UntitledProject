PewterGym_Object:
	db $3 ; border block

	def_warp_events
	warp_event  4, 13, LAST_MAP, 3
	warp_event  5, 13, LAST_MAP, 3

	def_bg_events

	def_object_events
	object_event  4,  1, SPRITE_SUPER_NERD, YELLOW_VERSION, STAY, DOWN, 1, OPP_BROCK, 1
	object_event  4,  1, SPRITE_SUPER_NERD, RED_OR_BLUE, STAY, DOWN, 1, OPP_BROCK, 2
	object_event  3,  6, SPRITE_COOLTRAINER_M, YELLOW_VERSION, STAY, RIGHT, 2, OPP_JR_TRAINER_M, 1
	object_event  3,  6, SPRITE_COOLTRAINER_M, RED_OR_BLUE, STAY, RIGHT, 2, OPP_JR_TRAINER_M, 11
	object_event  7, 10, SPRITE_GYM_GUIDE, ANY_VERSION, STAY, DOWN, 3 ; person

	def_warps_to PEWTER_GYM
