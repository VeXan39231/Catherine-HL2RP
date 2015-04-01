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

Schema.Name = "HL2RP"
Schema.Author = "L7D"
Schema.Title = "Half - Life 2 Role Play"
Schema.Desc = "It's safe here."
Schema.IntroTitle = "City 18, 2016."
Schema.IntroDesc = "It's safe here."

catherine.util.Include( "sh_config.lua" )
catherine.util.Include( "sh_commands.lua" )
catherine.util.Include( "sv_schema.lua" )
catherine.util.Include( "cl_schema.lua" )

Schema.IsCombineFacton = {
	FACTION_CP,
	FACTION_OW
}

local META = FindMetaTable( "Player" )

function Schema:PlayerIsCombine( pl )
	return table.HasValue( self.IsCombineFacton, pl:Team( ) )
end

function META:PlayerIsCombine( )
	return Schema:PlayerIsCombine( self )
end

// Hint stuff
//catherine.hint.Register( "" )

catherine.chat.RegisterClass( "radio", {
	onChat = function( pl, text )
		chat.AddText( Color( 0, 255, 100 ), pl:Name( ) .. " radio says " .. catherine.chat.PreSet( text ) )
	end,
	global = true,
	canRun = function( pl )
		return pl:Alive( )
	end
} )

catherine.chat.RegisterClass( "dispatch", {
	onChat = function( pl, text )
		chat.AddText( Color( 255, 150, 150 ), "Combine Dispatch - " .. text )
	end,
	global = true,
	canRun = function( pl )
		return pl:Alive( )
	end
} )

catherine.chat.RegisterClass( "request", {
	onChat = function( pl, text )
		chat.AddText( Color( 255, 200, 150 ), pl:Name( ) .. " request says " .. catherine.chat.PreSet( text ) )
	end,
	global = true,
	canRun = function( pl )
		return pl:Alive( )
	end
} )