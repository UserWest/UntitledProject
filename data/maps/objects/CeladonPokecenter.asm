CeladonPokecenter_Object:
	db $0 ; border block

	def_warp_events
	warp_event  3,  7, LAST_MAP, 6
	warp_event  4,  7, LAST_MAP, 6

	def_bg_events

	def_object_events
	object_event  3,  1, SPRITE_NURSE, YELLOW_VERSION, STAY, DOWN, 1 ; person
	object_event  3,  1, SPRITE_NURSE_RED, RED_OR_BLUE, STAY, DOWN, 1 ; person
	object_event  7,  3, SPRITE_GENTLEMAN, YELLOW_VERSION, STAY, DOWN, 2 ; YELLOW
	object_event  7,  3, SPRITE_GENTLEMAN, RED_OR_BLUE, WALK, LEFT_RIGHT, 2 ; RED
	object_event 10,  5, SPRITE_BEAUTY, ANY_VERSION, WALK, ANY_DIR, 3 ; person
	object_event 11,  2, SPRITE_LINK_RECEPTIONIST, ANY_VERSION, STAY, DOWN, 4 ; person
	object_event  4,  1, SPRITE_CHANSEY, YELLOW_VERSION, STAY, DOWN, 5 ; person

	def_warps_to CELADON_POKECENTER
