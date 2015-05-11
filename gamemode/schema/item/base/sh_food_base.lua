--[[
< CATHERINE > - A free role-playing framework for Garry's Mod.
Development and design by L7D.

Catherine is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Catherine.  If not, see <http://www.gnu.org/licenses/>.
]]--

local BASE = catherine.item.New( "FOOD", nil, true )
BASE.name = "Food Base"
BASE.desc = "A Food."
BASE.category = "^Item_Category_Food"
BASE.cost = 0
BASE.weight = 0
BASE.healthAdd = 0
BASE.staminaSet = 0
BASE.eatSound = {
	"npc/barnacle/barnacle_gulp1.wav",
	"npc/barnacle/barnacle_gulp2.wav"
}
BASE.func = { }
BASE.func.eat = {
	text = "^Item_FuncStr01_Food",
	canShowIsWorld = true,
	canShowIsMenu = true,
	func = function( pl, itemTable, ent )
		pl:EmitSound( type( itemTable.eatSound ) == "table" and table.Random( itemTable.eatSound ) or itemTable.eatSound )
		pl:SetHealth( math.Clamp( pl:Health( ) + ( itemTable.healthAdd or 0 ), 0, pl:GetMaxHealth( ) ) )
		
		if ( itemTable.staminaSet != 0 ) then
			catherine.character.SetCharVar( pl, "stamina", itemTable.staminaSet )
		end
		
		if ( type( ent ) == "Entity" ) then
			ent:Remove( )
		else
			catherine.inventory.Work( pl, CAT_INV_ACTION_REMOVE, {
				uniqueID = itemTable.uniqueID
			} )
		end
	end
}

catherine.item.Register( BASE )