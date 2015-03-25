local ITEM = catherine.item.New( "cid" )
ITEM.name = "CID Card"
ITEM.desc = "The citizen id card."
ITEM.cost = 10
ITEM.model = "models/gibs/metal_gib4.mdl"
ITEM.weight = 0.1
ITEM.category = "Wallet"
ITEM.itemData = {
	cid = "",
	name = ""
}

if ( CLIENT ) then
	function ITEM:GetDesc( pl, itemTable, itemData, isInv )
		if ( !IsInv ) then return end
		return "#" .. ( itemData.cid or "00000" ) .. ", " .. itemData.name or "Citizen"
	end
end

catherine.item.Register( ITEM )