CeruleanCity_Object:
	db $a ; border block

	def_warp_events
	warp_event 27, 11, CERULEAN_TRASHED_HOUSE, 1
	warp_event 13, 15, CERULEAN_MELANIES_HOUSE, 1
	warp_event 19, 17, CERULEAN_POKECENTER, 1
	warp_event 30, 19, CERULEAN_GYM, 1
	warp_event 13, 25, BIKE_SHOP, 1
	warp_event 25, 25, CERULEAN_MART, 1
	warp_event  4, 11, CERULEAN_CAVE_1F, 1
	warp_event 27,  9, CERULEAN_TRASHED_HOUSE, 3
	warp_event  9, 11, CERULEAN_BADGE_HOUSE, 2
	warp_event  9,  9, CERULEAN_BADGE_HOUSE, 1

	def_bg_events
	bg_event 23, 19, 12 ; CeruleanCityText12
	bg_event 17, 29, 13 ; CeruleanCityText13
	bg_event 26, 25, 14 ; MartSignText
	bg_event 20, 17, 15 ; PokeCenterSignText
	bg_event 11, 25, 16 ; CeruleanCityText16
	bg_event 27, 21, 17 ; CeruleanCityText17

	def_object_events
	object_event 20,  2, SPRITE_BLUE, ANY_VERSION, STAY, DOWN, 1 ; person
	object_event 30,  8, SPRITE_ROCKET, ANY_VERSION, STAY, NONE, 2, OPP_ROCKET, 5
	object_event 31, 20, SPRITE_COOLTRAINER_M, ANY_VERSION, STAY, DOWN, 3 ; person
	object_event 15, 18, SPRITE_SUPER_NERD, ANY_VERSION, WALK, UP_DOWN, 4 ; person
	object_event  9, 21, SPRITE_SUPER_NERD, ANY_VERSION, WALK, LEFT_RIGHT, 5 ; person
	object_event 28, 12, SPRITE_OFFICER_JENNY, YELLOW_VERSION, STAY, DOWN, 6 ; YELLOW
	object_event 28, 12, SPRITE_GUARD, RED_OR_BLUE, STAY, DOWN, 6 ; RED
	object_event 29, 26, SPRITE_COOLTRAINER_F, ANY_VERSION, STAY, LEFT, 7 ; person
	object_event 28, 26, SPRITE_POKE_BALL, YELLOW_VERSION, STAY, DOWN, 8 ; YELLOW
	object_event 28, 26, SPRITE_MONSTER, RED_OR_BLUE, STAY, DOWN, 8 ; SPRITE NOT IN SET
	object_event  9, 27, SPRITE_COOLTRAINER_F, ANY_VERSION, WALK, LEFT_RIGHT, 9 ; person
	object_event  4, 12, SPRITE_SUPER_NERD, ANY_VERSION, STAY, DOWN, 10 ; person
	object_event 27, 12, SPRITE_OFFICER_JENNY, YELLOW_VERSION, STAY, DOWN, 11 ; YELLOW
	object_event 27, 12, SPRITE_GUARD, RED_OR_BLUE, STAY, DOWN, 11 ; RED

	def_warps_to CERULEAN_CITY
