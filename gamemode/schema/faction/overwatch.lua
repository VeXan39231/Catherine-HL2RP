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

local FACTION = catherine.faction.New( "ow" )
FACTION.name = "^Faction_Name_OW"
FACTION.color = Color( 181, 94, 94 )
FACTION.desc = "^Faction_Desc_OW"
FACTION.isWhitelist = true
FACTION.alwaysRecognized = true
FACTION.models = {
	"models/combine_soldier.mdl"
}

function FACTION:PlayerFirstSpawned( pl )
	catherine.item.Give( pl, "portable_radio" )
	catherine.item.Give( pl, "weapon_pistol" )
	catherine.item.Give( pl, "weapon_ar2" )
	
	for i = 1, 4 do
		catherine.item.Give( pl, "pistol_ammo" )
		catherine.item.Give( pl, "ar2_ammo" )
	end
end

function FACTION:PostSetName( pl )
	return Format( Schema.OWNamePrefix, Schema:GetUniqueCombineUnitCode( ), math.random( 10000, 99999 ) )
end

FACTION_OW = catherine.faction.Register( FACTION )