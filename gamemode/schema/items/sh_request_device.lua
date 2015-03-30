local ITEM = catherine.item.New( "request_device" )
ITEM.name = "Request Device"
ITEM.desc = "If you have this, your can request it to combine."
ITEM.cost = 50
ITEM.model = "models/items/battery.mdl"
ITEM.weight = 0.5
ITEM.onBusinessFactions = {
	FACTION_CITIZEN
}

catherine.item.Register( ITEM )