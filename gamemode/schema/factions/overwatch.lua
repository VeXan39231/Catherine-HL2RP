local FACTION = catherine.faction.New( "ow" )
FACTION.name = "Overwatch Transhuman Arm"
FACTION.color = Color( 181, 94, 94 )
FACTION.desc = "Mechanised Infantry units utilized to combat the ongoing insurgency, these units are the elite of the combine's forces."
FACTION.isWhitelist = true
FACTION.models = {
	"models/combine_soldier.mdl"
}

FACTION_OW = catherine.faction.Register( FACTION )