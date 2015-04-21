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

catherine.command.Register( {
	command = "radio",
	syntax = "[Text]",
	runFunc = function( pl, args )
		local args = table.concat( args, " " )
		if ( args != "" ) then
			if ( pl:HasItem( "portable_radio" ) ) then
				local itemData = pl:GetInvItemDatas( "portable_radio" )
				
				if ( itemData.toggle ) then
					if ( itemData.freq != "xxx.x" and itemData.freq != "" ) then
						Schema:SayRadio( pl, args )
					else
						catherine.util.Notify( pl, "You have not set the radio freq!" )
					end
				else
					catherine.util.Notify( pl, "Please turn on the radio!" )
				end
			else
				catherine.util.Notify( pl, "You don't have a Portable radio!" )
			end
		else
			catherine.util.Notify( pl, "Please input a message!" )
		end
	end
} )

catherine.command.Register( {
	command = "request",
	syntax = "[Text]",
	runFunc = function( pl, args )
		local args = table.concat( args, " " )
		if ( args != "" ) then
			if ( pl:HasItem( "request_device" ) ) then
				Schema:SayRequest( pl, args )
			else
				catherine.util.Notify( pl, "You don't have a Request device!" )
			end
		else
			catherine.util.Notify( pl, "Please input a message!" )
		end
	end
} )

catherine.command.Register( {
	command = "dispatch",
	syntax = "[Text]",
	runFunc = function( pl, args )
		local args = table.concat( args, " " )
		if ( pl:PlayerIsCombine( ) or pl:Team( ) == FACTION_ADMIN ) then
			if ( Schema:CanDispatch( pl:Name( ) ) ) then
				if ( args != "" ) then
					Schema:SayDispatch( pl, args )
				else
					catherine.util.Notify( pl, "Please input message!" )
				end
			else
				catherine.util.Notify( pl, "You don't have permission using Dispatch!" )
			end
		else
			catherine.util.Notify( pl, "You are not combine!" )
		end
	end
} )