local FACTION = catherine.faction.New( "cp" )
FACTION.name = "Civil Protection"
FACTION.color = Color( 30, 144, 255 )
FACTION.desc = "These units are the brunt of the combine's forces. These units are well-trained military units but they also take part policing the population."
FACTION.isWhitelist = true
FACTION.alwaysRecognized = true
FACTION.models = {
	"models/police.mdl"
}

function FACTION:PlayerFirstSpawned( pl )
	catherine.item.Give( pl, "portable_radio" )
	catherine.item.Give( pl, "weapon_pistol" )
	catherine.item.Give( pl, "weapon_stunstick" )
end

FACTION_CP = catherine.faction.Register( FACTION )