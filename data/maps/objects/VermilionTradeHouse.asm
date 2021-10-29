VermilionTradeHouse_Object:
	db $a ; border block

	def_warp_events
	warp_event  2,  7, LAST_MAP, 8
	warp_event  3,  7, LAST_MAP, 8

	def_bg_events

	def_object_events
	object_event  3,  5, SPRITE_GENTLEMAN, YELLOW_VERSION, STAY, UP, 1 ; person
	object_event  3,  5, SPRITE_LITTLE_GIRL, RED_OR_BLUE, STAY, UP, 1 ; person

	def_warps_to VERMILION_TRADE_HOUSE
