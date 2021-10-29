ViridianSchoolHouse_Object:
	db $a ; border block

	def_warp_events
	warp_event  2,  7, LAST_MAP, 3
	warp_event  3,  7, LAST_MAP, 3

	def_bg_events

	def_object_events
	object_event  3,  5, SPRITE_BRUNETTE_GIRL, ANY_VERSION, STAY, UP, 1 ; person
	object_event  4,  1, SPRITE_COOLTRAINER_F, ANY_VERSION, STAY, DOWN, 2 ; person
	object_event  4,  5, SPRITE_LITTLE_GIRL, YELLOW_VERSION, STAY, UP, 3 ; person

	def_warps_to VIRIDIAN_SCHOOL_HOUSE
