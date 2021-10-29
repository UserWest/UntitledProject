RespawnOverworldPikachu:
	callfar IsThisPartymonStarterPikachu
	ret nc
	ld a, $3
	ld [wPikachuSpawnState], a
	ret
