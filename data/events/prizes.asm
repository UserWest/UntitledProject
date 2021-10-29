PrizeDifferentMenuPtrs:
	dw PrizeMenuMon1Entries, PrizeMenuMon1Cost
	dw PrizeMenuMon2Entries, PrizeMenuMon2Cost
	dw PrizeMenuTMsEntries,  PrizeMenuTMsCost

PrizeMenuMon1Entries:
	db ABRA
	db VULPIX
	db WIGGLYTUFF
	db "@"

PrizeMenuMon1Cost:
	bcd2 230
	bcd2 1000
	bcd2 2680
	db "@"

PrizeMenuMon2Entries:
	db SCYTHER
	db PINSIR
	db PORYGON
	db "@"

PrizeMenuMon2Cost:
	bcd2 6500
	bcd2 6500
	bcd2 9999
	db "@"

PrizeMenuTMsEntries:
	db TM_DRAGON_RAGE
	db TM_HYPER_BEAM
	db TM_SUBSTITUTE
	db "@"

PrizeMenuTMsCost:
	bcd2 3300
	bcd2 5500
	bcd2 7700
	db "@"

RedPrizeDifferentMenuPtrs:
	dw RedPrizeMenuMon1Entries, RedPrizeMenuMon1Cost
	dw RedPrizeMenuMon2Entries, RedPrizeMenuMon2Cost
	dw PrizeMenuTMsEntries,  PrizeMenuTMsCost

RedPrizeMenuMon1Entries:
	db ABRA
	db CLEFAIRY
	db NIDORINA
	db "@"

RedPrizeMenuMon1Cost:
	bcd2 180
	bcd2 500
	bcd2 1200
	db "@"

RedPrizeMenuMon2Entries:
	db DRATINI
	db SCYTHER
	db PORYGON
	db "@"

RedPrizeMenuMon2Cost:
	bcd2 2800
	bcd2 5500
	bcd2 9999
	db "@"
	
BluePrizeDifferentMenuPtrs:
	dw BluePrizeMenuMon1Entries, BluePrizeMenuMon1Cost
	dw BluePrizeMenuMon2Entries, BluePrizeMenuMon2Cost
	dw PrizeMenuTMsEntries,  PrizeMenuTMsCost

BluePrizeMenuMon1Entries:
	db ABRA
	db CLEFAIRY
	db NIDORINO
	db "@"

BluePrizeMenuMon1Cost:
	bcd2 120
	bcd2 750
	bcd2 1200
	db "@"

BluePrizeMenuMon2Entries:
	db PINSIR
	db DRATINI
	db PORYGON
	db "@"

BluePrizeMenuMon2Cost:
	bcd2 2500
	bcd2 4600
	bcd2 6500
	db "@"