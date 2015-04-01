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

local ITEM = catherine.item.New( "breenwater", "FOOD" )
ITEM.name = "Breen Water"
ITEM.desc = "Shake and eat!"
ITEM.cost = 20
ITEM.model = "models/props_junk/PopCan01a.mdl"
ITEM.weight = 0.4
ITEM.healthAdd = 10

catherine.item.Register( ITEM )