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
	[ "Root_Notify_CantRoot" ] = "You can't root this player!"
} )

catherine.language.Merge( "korean", {
	[ "Root_Notify_AlreadyDoing" ] = "이미 당신은 루팅을 하고 있습니다!",
	[ "Root_Notify_CantRoot" ] = "이 사람을 루팅할 수 없습니다!"
} )

catherine.command.Register( {
	command = "charroot",
	runFunc = function( pl, args )
		if ( pl.GetNetVar( pl, "rooting" ) ) then
			catherine.util.NotifyLang( pl, "Root_Notify_AlreadyDoing" )
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
			catherine.util.NotifyLang( pl, "Entity_Notify_NotPlayer" )
		end
	end
} )

if ( CLIENT ) then
	netstream.Hook( "catherine_hl2rp.plugin.root.Work", function( data )
		local pl = catherine.util.FindPlayerByStuff( "SteamID", data[ 1 ] )
		local inventory = data[ 2 ]
		local cash = data[ 3 ]
		if ( !IsValid( pl ) ) then return end
		
		if ( IsValid( catherine.vgui.root ) ) then
			catherine.vgui.root:Remove( )
			catherine.vgui.root = nil
		end
		
		catherine.vgui.root = vgui.Create( "catherine.vgui.root" )
		catherine.vgui.root:InitializeRoot( pl, inventory, cash )
	end )
end