ViridianMart_Object:
	db $0 ; border block

	def_warp_events
	warp_event  3,  7, LAST_MAP, 2
	warp_event  4,  7, LAST_MAP, 2

	def_bg_events

	def_object_events
	object_event  0,  5, SPRITE_CLERK, ANY_VERSION, STAY, RIGHT, 1 ; person
	object_event  5,  5, SPRITE_YOUNGSTER, ANY_VERSION, WALK, UP_DOWN, 2 ; person
	object_event  3,  3, SPRITE_COOLTRAINER_M, ANY_VERSION, STAY, NONE, 3 ; person

	def_warps_to VIRIDIAN_MART
