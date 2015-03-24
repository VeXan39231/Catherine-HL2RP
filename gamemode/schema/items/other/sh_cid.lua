Item.name = "CID Card"
Item.desc = "The citizen id card."
Item.cost = 10
Item.model = "models/gibs/metal_gib4.mdl"
Item.weight = 0.1
Item.category = "Wallet"
Item.itemData = {
	cid = "",
	name = ""
}

if ( CLIENT ) then
	function Item:GetDesc( pl, itemTable, itemData, isInv )
		return "#" .. ( itemData.cid or "00000" ) .. ", " .. itemData.name or "Citizen"
	end
end