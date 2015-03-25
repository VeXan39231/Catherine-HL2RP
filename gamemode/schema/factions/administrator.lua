local FACTION = catherine.faction.New( "administrator" )
FACTION.name = "Administrator"
FACTION.color = Color( 237, 179, 97 )
FACTION.desc = "A city administrator."
FACTION.isWhitelist = true
FACTION.alwaysRecognized = true
FACTION.models = {
	"models/breen.mdl"
}

function FACTION:PlayerFirstSpawned( pl )
	catherine.item.Give( pl, "portable_radio" )
end

FACTION_ADMIN = catherine.faction.Register( FACTION )