MtMoonB2F_Object:
	db $3 ; border block

	def_warp_events
	warp_event 25,  9, MT_MOON_B1F, 2
	warp_event 21, 17, MT_MOON_B1F, 5
	warp_event 15, 27, MT_MOON_B1F, 6
	warp_event  5,  7, MT_MOON_B1F, 7

	def_bg_events

	def_object_events
	object_event 12,  8, SPRITE_SUPER_NERD, ANY_VERSION, STAY, RIGHT, 1, OPP_SUPER_NERD, 2
	object_event  9,  3, SPRITE_JESSIE, YELLOW_VERSION, STAY, LEFT, 2
	object_event  0,  0, SPRITE_NONE, RED_OR_BLUE, STAY, NONE, 0 ; Filler object
	object_event 15, 22, SPRITE_ROCKET, ANY_VERSION, STAY, DOWN, 3, OPP_ROCKET, 2
	object_event 29, 11, SPRITE_ROCKET, ANY_VERSION, STAY, UP, 4, OPP_ROCKET, 3
	object_event 29, 17, SPRITE_ROCKET, YELLOW_VERSION, STAY, LEFT, 5, OPP_ROCKET, 1
	object_event 29, 17, SPRITE_ROCKET, RED_OR_BLUE, STAY, LEFT, 5, OPP_ROCKET, 4
	object_event  0,  0, SPRITE_NONE, YELLOW_VERSION, STAY, NONE, 0 ; Filler object
	object_event 11, 16, SPRITE_ROCKET, RED_OR_BLUE, STAY, DOWN, 6, OPP_ROCKET, 1
	object_event  9,  4, SPRITE_JAMES, YELLOW_VERSION, STAY, LEFT, 2
	object_event  0,  0, SPRITE_NONE, RED_OR_BLUE, STAY, NONE, 0 ; Filler object
	object_event 12,  6, SPRITE_FOSSIL, ANY_VERSION, STAY, NONE, 7 ; person
	object_event 13,  6, SPRITE_FOSSIL, ANY_VERSION, STAY, NONE, 8 ; person
	object_event 25, 21, SPRITE_POKE_BALL, ANY_VERSION, STAY, NONE, 9, HP_UP
	object_event 29,  5, SPRITE_POKE_BALL, ANY_VERSION, STAY, NONE, 10, TM_MEGA_PUNCH
	

	def_warps_to MT_MOON_B2F
;show/hide data is attached to jessie and james in such a way that fillers that go unseen are
;required to keep things working in red and blue
