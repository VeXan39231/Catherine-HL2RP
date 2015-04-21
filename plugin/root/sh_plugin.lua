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
PLUGIN.name = "Root"
PLUGIN.author = "L7D"
PLUGIN.desc = "Good stuff."

catherine.util.Include( "sv_plugin.lua" )

catherine.language.Merge( "english", {
	[ "Root_Notify_AlreadyDoing" ] = "You are already rooting another player!",
} )

catherine.command.Register( {
	command = "charroot",
	runFunc = function( pl, args )
		if ( pl:GetNetVar( "rooting" ) ) then
			catherine.util.NotifyLang( "Root_Notify_AlreadyDoing" )
			return
		end
		
		local data = { }
		data.start = pl:GetShootPos( )
		data.endpos = data.start + pl:GetAimVector( ) * 96
		data.filter = pl
		local ent = util.TraceLine( data ).Entity
	
		if ( IsValid( ent ) and ent:IsPlayer( ) ) then
			PLUGIN:RootPlayer( pl, ent )
		else
			catherine.util.NotifyLang( "Entity_Notify_NotPlayer" )
		end
	end
} )

if ( CLIENT ) then
	netstream.Hook( "catherine_hl2rp.plugin.root.Work", function( data )
		local pl = catherine.util.FindPlayerByStuff( "SteamID", data[ 1 ] )
		local inventory = data[ 2 ]
		local cash = data[ 3 ]
	end )
end