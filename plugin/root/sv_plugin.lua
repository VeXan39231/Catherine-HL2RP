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

function PLUGIN:RootPlayer( pl, target )
	if ( !catherine.player.IsTied( target ) ) then
		catherine.util.NotifyLang( pl, "Root_Notify_CantRoot" )
		return
	end
	
	pl:SetNetVar( "rooting", true )
	
	netstream.Start( pl, "catherine_hl2rp.plugin.root.Work", {
		target:SteamID( ),
		catherine.inventory.Get( target ),
		catherine.cash.Get( target )
	} )
end

netstream.Hook( "catherine_hl2rp.plugin.root.RootClose", function( pl )
	pl:SetNetVar( "rooting", false )
end )