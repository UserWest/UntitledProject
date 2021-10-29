CeruleanMelaniesHouse_Object:
	db $a ; border block

	def_warp_events
	warp_event  2,  7, LAST_MAP, 2
	warp_event  3,  7, LAST_MAP, 2

	def_bg_events

	def_object_events
	object_event  3,  1, SPRITE_GIRL, YELLOW_VERSION, STAY, DOWN, 1 ; person
	object_event  4,  1, SPRITE_BULBASAUR, YELLOW_VERSION, STAY, DOWN, 2 ; person
	object_event  1,  4, SPRITE_ODDISH, YELLOW_VERSION, STAY, NONE, 3 ; person
	object_event  5,  3, SPRITE_SANDSHREW, YELLOW_VERSION, STAY, LEFT, 4 ; person
	object_event  5,  4, SPRITE_GRANNY, RED_OR_BLUE,  STAY, LEFT, 5 ; person
	object_event  1,  2, SPRITE_GAMBLER, RED_OR_BLUE,  STAY, NONE, 6 ; person
	
	def_warps_to CERULEAN_MELANIES_HOUSE
