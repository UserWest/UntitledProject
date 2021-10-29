PewterNidoranHouse_Object:
	db $a ; border block

	def_warp_events
	warp_event  2,  7, LAST_MAP, 4
	warp_event  3,  7, LAST_MAP, 4

	def_bg_events

	def_object_events
	object_event  4,  5, SPRITE_MONSTER, ANY_VERSION, STAY, LEFT, 1 ; person
	object_event  3,  5, SPRITE_LITTLE_BOY, ANY_VERSION, STAY, RIGHT, 2 ; person
	object_event  1,  2, SPRITE_MIDDLE_AGED_MAN, ANY_VERSION, STAY, NONE, 3 ; person

	def_warps_to PEWTER_NIDORAN_HOUSE
