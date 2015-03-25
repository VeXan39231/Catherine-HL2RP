local BASE = catherine.item.New( "FOOD", nil, true )
BASE.name = "Food Base"
BASE.desc = "A Food."
BASE.category = "Food"
BASE.cost = 0
BASE.weight = 0
BASE.healthAdd = 0
BASE.func = { }
BASE.func.eat = {
	text = "Eat",
	canShowIsWorld = true,
	canShowIsMenu = true,
	func = function( pl, itemTable )
		pl:EmitSound( "physics/flesh/flesh_impact_hard" .. math.random( 1, 5 ) .. ".wav" )
		pl:SetHealth( math.Clamp( pl:Health( ) + ( itemTable.healthAdd or 0 ), 0, 100 ) )
		catherine.inventory.Work( pl, CAT_INV_ACTION_REMOVE, itemTable.uniqueID )
	end
}

catherine.item.Register( BASE )