VermilionGym_Object:
	db $3 ; border block

	def_warp_events
	warp_event  4, 17, LAST_MAP, 4
	warp_event  5, 17, LAST_MAP, 4

	def_bg_events

	def_object_events
	object_event  5,  1, SPRITE_ROCKER, YELLOW_VERSION, STAY, DOWN, 1, OPP_LT_SURGE, 1
	object_event  5,  1, SPRITE_ROCKER, RED_OR_BLUE, STAY, DOWN, 1, OPP_LT_SURGE, 2
	object_event  9,  6, SPRITE_GENTLEMAN, YELLOW_VERSION, STAY, LEFT, 2, OPP_GENTLEMAN, 3
	object_event  9,  6, SPRITE_GENTLEMAN, RED_OR_BLUE, STAY, LEFT, 2, OPP_GENTLEMAN, 6
	object_event  3,  8, SPRITE_SUPER_NERD, YELLOW_VERSION, STAY, LEFT, 3, OPP_ROCKER, 1
	object_event  3,  8, SPRITE_SUPER_NERD, RED_OR_BLUE, STAY, LEFT, 3, OPP_ROCKER, 3
	object_event  0, 10, SPRITE_SAILOR, YELLOW_VERSION, STAY, RIGHT, 4, OPP_SAILOR, 8
	object_event  0, 10, SPRITE_SAILOR, RED_OR_BLUE, STAY, RIGHT, 4, OPP_SAILOR, 9
	object_event  4, 14, SPRITE_GYM_GUIDE, ANY_VERSION, STAY, DOWN, 5 ; person

	def_warps_to VERMILION_GYM
