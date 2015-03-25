local FACTION = catherine.faction.New( "cp" )
FACTION.name = "Civil Protection"
FACTION.color = Color( 30, 144, 255 )
FACTION.desc = "These units are the brunt of the combine's forces. These units are well-trained military units but they also take part policing the population."
FACTION.isWhitelist = true
FACTION.models = {
	"models/police.mdl"
}

FACTION_CP = catherine.faction.Register( FACTION )