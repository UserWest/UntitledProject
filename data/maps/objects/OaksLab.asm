OaksLabRB_Object:
OaksLab_Object:
	db $3 ; border block

	def_warp_events
	warp_event  4, 11, LAST_MAP, 3
	warp_event  5, 11, LAST_MAP, 3

	def_bg_events
	bg_event 4, 0, 13 ; PushStartText
	bg_event 5, 0, 14 ; SaveOptionText
	bg_event 0, 1, 15 ; DisplayOakLabEmailText
	bg_event 1, 1, 15 ; DisplayOakLabEmailText

	def_object_events
	object_event  4,  3, SPRITE_BLUE, ANY_VERSION, STAY, NONE, 1, OPP_RIVAL1, 1
	object_event  6,  3, SPRITE_POKE_BALL, RED_OR_BLUE, STAY, NONE, 10 ; left ball
	object_event  7,  3, SPRITE_POKE_BALL, RED_OR_BLUE, STAY, NONE, 2 ; middle ball
	object_event  8,  3, SPRITE_POKE_BALL, RED_OR_BLUE, STAY, NONE, 11 ; right ball
	object_event  0,  0, SPRITE_NONE, YELLOW_VERSION, STAY, NONE, 0 ; filler
	object_event  0,  0, SPRITE_NONE, YELLOW_VERSION, STAY, NONE, 0 ; filler
	object_event  0,  0, SPRITE_NONE, YELLOW_VERSION, STAY, NONE, 0 ; filler
	object_event  0,  0, SPRITE_NONE, RED_OR_BLUE, STAY, NONE, 0 ; filler
	object_event  7,  3, SPRITE_POKE_BALL, YELLOW_VERSION, STAY, NONE, 2 ; eevee ball
	object_event  5,  2, SPRITE_OAK, ANY_VERSION, STAY, DOWN, 3 ; person
	object_event  2,  1, SPRITE_POKEDEX, ANY_VERSION, STAY, NONE, 4 ; person
	object_event  3,  1, SPRITE_POKEDEX, ANY_VERSION, STAY, NONE, 4 ; person
	object_event  5, 10, SPRITE_OAK, ANY_VERSION, STAY, UP, 6 ; person
	object_event  1,  9, SPRITE_GIRL, ANY_VERSION, WALK, UP_DOWN, 7 ; person
	object_event  2, 10, SPRITE_SCIENTIST, ANY_VERSION, STAY, NONE, 8 ; person
	object_event  8, 10, SPRITE_SCIENTIST, ANY_VERSION, STAY, NONE, 9 ; person

	def_warps_to OAKS_LAB
