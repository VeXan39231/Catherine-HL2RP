--[[
< CATHERINE > - A free role-playing framework for Garry's Mod.
Develop by L7D.

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

local ITEM = catherine.item.New( "weapon_pistol", "WEAPON" )
ITEM.name = "9mm Pistol"
ITEM.desc = "A standard 9MM Pistol"
ITEM.cost = 300
ITEM.model = "models/weapons/w_Pistol.mdl"
ITEM.weight = 1.3
ITEM.weaponClass = "weapon_pistol"

catherine.item.Register( ITEM )