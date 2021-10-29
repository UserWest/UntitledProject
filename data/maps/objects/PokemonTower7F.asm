PokemonTower7F_Object:
	db $1 ; border block

	def_warp_events
	warp_event  9, 16, POKEMON_TOWER_6F, 2

	def_bg_events

	def_object_events
	object_event  9, 11, SPRITE_ROCKET, RED_OR_BLUE, STAY, RIGHT, 1, OPP_ROCKET, 19
	object_event 12,  9, SPRITE_ROCKET, RED_OR_BLUE, STAY, LEFT, 2, OPP_ROCKET, 20
	object_event  9,  7, SPRITE_ROCKET, RED_OR_BLUE, STAY, RIGHT, 3, OPP_ROCKET, 21
	
	object_event  0,  0, SPRITE_NONE, YELLOW_VERSION, STAY, NONE, 0 ; Filler object
	object_event  0,  0, SPRITE_NONE, YELLOW_VERSION, STAY, NONE, 0 ; Filler object
	object_event  0,  0, SPRITE_NONE, YELLOW_VERSION, STAY, NONE, 0 ; Filler object
	
	object_event 10,  3, SPRITE_MR_FUJI, ANY_VERSION, STAY, DOWN, 6
	
	object_event 10,  8, SPRITE_JESSIE, YELLOW_VERSION, STAY, DOWN, 4
	object_event 11,  8, SPRITE_JAMES, YELLOW_VERSION, STAY, DOWN, 5
	
	object_event  0,  0, SPRITE_NONE, RED_OR_BLUE, STAY, NONE, 0 ; Filler object
	object_event  0,  0, SPRITE_NONE, RED_OR_BLUE, STAY, NONE, 0 ; Filler object


	def_warps_to POKEMON_TOWER_7F
;show/hide data is attached to jessie and james in such a way that fillers that go unseen are
;required to keep things working in red and blue
