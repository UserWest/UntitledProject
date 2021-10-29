ViridianCity_Object:
	db $f ; border block

	def_warp_events
	warp_event 23, 25, VIRIDIAN_POKECENTER, 1
	warp_event 29, 19, VIRIDIAN_MART, 1
	warp_event 21, 15, VIRIDIAN_SCHOOL_HOUSE, 1
	warp_event 21,  9, VIRIDIAN_NICKNAME_HOUSE, 1
	warp_event 32,  7, VIRIDIAN_GYM, 1

	def_bg_events
	bg_event 17, 17, 9 ; ViridianCityText8
	bg_event 19,  1, 10 ; ViridianCityText9
	bg_event 21, 29, 11 ; ViridianCityText10
	bg_event 30, 19, 12 ; MartSignText
	bg_event 24, 25, 13 ; PokeCenterSignText
	bg_event 27,  7, 14 ; ViridianCityText13

	def_object_events
	object_event 13, 20, SPRITE_YOUNGSTER, ANY_VERSION, WALK, ANY_DIR, 1 ; person above lake
	object_event 30,  8, SPRITE_GAMBLER, ANY_VERSION, STAY, NONE, 2 ; person next to gym
	object_event 30, 25, SPRITE_YOUNGSTER, ANY_VERSION, WALK, ANY_DIR, 3 ; person 2 catepillars
	object_event 17,  9, SPRITE_GIRL, ANY_VERSION, STAY, RIGHT, 4 ; person
	object_event 18,  9, SPRITE_GAMBLER_ASLEEP, ANY_VERSION, STAY, NONE, 5 ; person
	object_event  6, 23, SPRITE_FISHER, ANY_VERSION, STAY, DOWN, 6 ; person
	object_event 17,  5, SPRITE_GAMBLER, ANY_VERSION, WALK, LEFT_RIGHT, 7 ; person
	object_event 18,  9, SPRITE_GAMBLER, ANY_VERSION, STAY, NONE, 8

	def_warps_to VIRIDIAN_CITY
