PokemonFanClub_Object:
	db $d ; border block

	def_warp_events
	warp_event  2,  7, LAST_MAP, 2
	warp_event  3,  7, LAST_MAP, 2

	def_bg_events

	def_object_events
	object_event  6,  3, SPRITE_FISHER, ANY_VERSION, STAY, LEFT, 1 ; person
	object_event  1,  3, SPRITE_GIRL, ANY_VERSION, STAY, RIGHT, 2 ; person
	object_event  6,  4, SPRITE_CLEFAIRY, ANY_VERSION, STAY, LEFT, 3 ; person
	object_event  6,  4, SPRITE_FAIRY, ANY_VERSION, STAY, LEFT, 3 ; person
	object_event  1,  4, SPRITE_SEEL, ANY_VERSION, STAY, RIGHT, 4 ; person
	object_event  3,  1, SPRITE_GENTLEMAN, ANY_VERSION, STAY, DOWN, 5 ; person
	object_event  5,  1, SPRITE_LINK_RECEPTIONIST, ANY_VERSION, STAY, DOWN, 6 ; person

	def_warps_to POKEMON_FAN_CLUB
