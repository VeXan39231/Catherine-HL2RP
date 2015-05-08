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
PLUGIN.name = "^BVM_Plugin_Name"
PLUGIN.author = "L7D"
PLUGIN.desc = "^BVM_Plugin_Desc"

catherine.util.Include( "sv_plugin.lua" )

catherine.language.Merge( "english", {
	[ "BVM_Plugin_Name" ] = "Beverage Vending Machine",
	[ "BVM_Plugin_Desc" ] = "Good stuff."
} )

catherine.language.Merge( "korean", {
	[ "BVM_Plugin_Name" ] = "음료 자동 판매기",
	[ "BVM_Plugin_Desc" ] = "음료를 판매합니다."
} )