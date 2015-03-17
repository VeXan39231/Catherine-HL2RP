Base.uniqueID = "food_base"
Base.name = "Food!"
Base.desc = "A Food!"
Base.category = "Food"
Base.cost = 0
Base.weight = 0
Base.func = { }
Base.func.eat = {
	text = "Eat",
	canShowIsWorld = true,
	canShowIsMenu = true,
	func = function( pl, itemTable )
		pl:EmitSound( "physics/flesh/flesh_impact_hard" .. math.random( 1, 5 ) .. ".wav" )
		pl:SetHealth( math.Clamp( pl:Health( ) + ( itemTable.healthPlus or 0 ), 0, 100 ) )
		catherine.inventory.Work( pl, CAT_INV_ACTION_REMOVE, itemTable.uniqueID )
	end
}