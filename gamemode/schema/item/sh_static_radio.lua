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

local ITEM = catherine.item.New( "static_radio" )
ITEM.name = "^Item_Name_SR"
ITEM.desc = "^Item_Desc_SR"
ITEM.cost = 500
ITEM.model = "models/props_lab/citizenradio.mdl"
ITEM.weight = 2
ITEM.category = "^Item_Category_Communication"
ITEM.func = { }
ITEM.func.take = {
	text = "^Item_FuncStr01_Basic",
	icon = "icon16/basket_put.png",
	func = function( pl, itemTable, ent )
		// ^-^;
	end
	canLook = function( pl, itemTable )
		return false
	end
}
ITEM.func.drop = {
	text = "^Item_FuncStr02_Basic",
	icon = "icon16/basket_remove.png",
	canShowIsMenu = true,
	func = function( pl, itemTable )
		local ent = ents.Create( "cat_hl2rp_static_radio" )
		ent:SetPos( catherine.util.GetItemDropPos( pl ) )
		ent:SetAngles( Angle( ) )
		ent:Spawn( )
		ent:PhysicsInit( SOLID_VPHYSICS )
		
		catherine.entity.RegisterUseMenu( ent, {
			{
				uniqueID = "ID_Toggle",
				text = "Toggle",
				func = function( pl, ent )
					ent:SetNetVar( "active", !ent:GetNetVar( "active" ) )
				end
			},
			{
				uniqueID = "ID_SetFreq",
				text = "Set Freq",
				func = function( pl, ent )
					
				end
			}
		} )
		
		catherine.inventory.Work( pl, CAT_INV_ACTION_REMOVE, {
			uniqueID = itemTable.uniqueID
		} )
	end,
	canLook = function( pl, itemTable )
		return catherine.inventory.HasItem( itemTable.uniqueID )
	end
}

catherine.item.Register( ITEM )