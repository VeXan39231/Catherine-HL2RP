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

local ITEM = catherine.item.New( "weapon_ar2", "WEAPON" )
ITEM.name = "AR2"
ITEM.desc = "The corp combine."
ITEM.cost = 950
ITEM.model = "models/weapons/w_IRifle.mdl"
ITEM.weight = 3
ITEM.weaponClass = "weapon_ar2"

catherine.item.Register( ITEM )