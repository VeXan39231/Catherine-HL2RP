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
local PLUGIN = PLUGIN

local ITEM = catherine.item.New( "flashlight" )
ITEM.name = "^Item_Name_Flashlight"
ITEM.desc = "^Item_Desc_Flashlight"
ITEM.category = "^Item_Category_Other"
ITEM.model = "models/props_combine/combine_lock01.mdl"
ITEM.cost = 300
ITEM.weight = 0.45
ITEM.onBusinessFactions = {
	FACTION_CITIZEN
}

if ( SERVER ) then
	local function func( pl )
		if ( pl:FlashlightIsOn( ) ) then
			pl:Flashlight( false )
		end
	end
	
	hook.Add( "OnItemDrop", "catherine_hl2rp.item.hooks.flashlight.OnItemDrop", function( pl, itemTable )
		func( pl )
	end )
	
	hook.Add( "OnItemStorageMove", "catherine_hl2rp.item.hooks.weapon_base.OnItemStorageMove", function( pl, itemTable )
		func( pl )
	end )
	
	hook.Add( "OnItemVendorSold", "catherine_hl2rp.item.hooks.weapon_base.OnItemVendorSold", function( pl, itemTable )
		func( pl )
	end )
end

catherine.item.Register( ITEM )