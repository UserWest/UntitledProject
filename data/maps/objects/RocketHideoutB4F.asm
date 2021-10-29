RocketHideoutB4F_Object:
	db $2e ; border block

	def_warp_events
	warp_event 19, 10, ROCKET_HIDEOUT_B3F, 2
	warp_event 24, 15, ROCKET_HIDEOUT_ELEVATOR, 1
	warp_event 25, 15, ROCKET_HIDEOUT_ELEVATOR, 2

	def_bg_events

	def_object_events
	object_event 25,  3, SPRITE_GIOVANNI, ANY_VERSION, STAY, DOWN, 1, OPP_GIOVANNI, 1
	object_event 25, 10, SPRITE_JAMES, YELLOW_VERSION, STAY, DOWN, 13
	object_event 44, 26, SPRITE_POKE_BALL, RED_OR_BLUE, STAY, NONE, 1 ; Filler object
	object_event 24, 10, SPRITE_JESSIE, YELLOW_VERSION, STAY, DOWN, 13
	object_event 44, 26, SPRITE_POKE_BALL, RED_OR_BLUE, STAY, NONE, 1 ; Filler object
	object_event 11,  2, SPRITE_ROCKET, ANY_VERSION, STAY, DOWN, 4, OPP_ROCKET, 18
	object_event 10, 12, SPRITE_POKE_BALL, ANY_VERSION, STAY, NONE, 5, HP_UP
	object_event  9,  4, SPRITE_POKE_BALL, ANY_VERSION, STAY, NONE, 6, TM_RAZOR_WIND
	object_event 12, 20, SPRITE_POKE_BALL, ANY_VERSION, STAY, NONE, 7, IRON
	object_event 25,  2, SPRITE_POKE_BALL, ANY_VERSION, STAY, NONE, 8, SILPH_SCOPE
	object_event 10,  2, SPRITE_POKE_BALL, ANY_VERSION, STAY, NONE, 9, LIFT_KEY
	object_event 23, 12, SPRITE_ROCKET, RED_OR_BLUE, STAY, DOWN, 2, OPP_ROCKET, 16
	object_event 26, 12, SPRITE_ROCKET, RED_OR_BLUE, STAY, DOWN, 3, OPP_ROCKET, 17

	def_warps_to ROCKET_HIDEOUT_B4F
;show/hide data is attached to jessie and james in such a way that fillers that go unseen are
;required to keep things working in red and blue
