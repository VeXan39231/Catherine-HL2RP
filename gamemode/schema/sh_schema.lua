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

Schema.Name = "HL2RP"
Schema.Author = "L7D"
Schema.Title = "^Basic_Schema_Title"
Schema.Desc = "^Basic_Schema_Desc"
Schema.IntroTitle = "^Basic_Schema_IntroTitle"
Schema.IntroDesc = "^Basic_Schema_IntroDesc"

catherine.util.Include( "sh_config.lua" )
catherine.util.Include( "sh_commands.lua" )
catherine.util.Include( "sv_schema.lua" )
catherine.util.Include( "cl_schema.lua" )

Schema.IsCombineFacton = {
	FACTION_CP,
	FACTION_OW
}
Schema.CombineRankClass = {
	Elite = CLASS_CP_ELITE,
	Unit = CLASS_CP_UNIT
}
Schema.CUC = {
	"Alpha",
	"Savage",
	"Reaper",
	"Victor",
	"Sector",
	"Dagger",
	"Razor",
	"Sword",
	"Vamp",
	"Vice",
	"Echo"
}
Schema.CPNamePrefix = "C17-%s-RCT.%s"
Schema.OWNamePrefix = "OW-%s.%s"
local elite, unit = Schema.CombineRankClass.Elite, Schema.CombineRankClass.Unit
Schema.CombineRank = {
	[ "SeC" ] = elite,
	[ "DvL" ] = elite,
	[ "EpU" ] = elite,
	[ "GHOST" ] = unit,
	[ "OfC" ] = unit,
	[ "05" ] = unit,
	[ "04" ] = unit,
	[ "03" ] = unit,
	[ "02" ] = unit,
	[ "01" ] = unit,
	[ "RCT" ] = unit
}
Schema.CombineRankModel = {
	[ "SeC" ] = "models/dpfilms/metropolice/phoenix_police.mdl",
	[ "DvL" ] = "models/dpfilms/metropolice/blacop.mdl",
	[ "EpU" ] = "models/dpfilms/metropolice/elite_police.mdl",
	[ "GHOST" ] = "models/eliteghostcp.mdl",
	[ "OfC" ] = "models/dpfilms/metropolice/policetrench.mdl",
	[ "05" ] = "models/dpfilms/metropolice/hl2concept.mdl",
	[ "04" ] = "models/dpfilms/metropolice/hl2concept.mdl",
	[ "03" ] = "models/dpfilms/metropolice/hl2concept.mdl",
	[ "02" ] = "models/dpfilms/metropolice/hl2concept.mdl",
	[ "01" ] = "models/dpfilms/metropolice/hl2concept.mdl",
	[ "RCT" ] = "models/dpfilms/metropolice/hl2concept.mdl"
}
Schema.BadRadioStrings = {
	"?",
	"%",
	"{",
	"@",
	"*",
	"##",
	"_"
}

for k, v in pairs( Schema.CombineRankModel ) do
	catherine.animation.Register( "metrocop", v )
	util.PrecacheModel( v )
end

function Schema:GetRankByName( name )
	for k, v in pairs( self.CombineRank ) do
		if ( name:find( k ) ) then
			return k, v
		end
	end
end

function Schema:GetUniqueCombineUnitCode( )
	return table.Random( self.CUC ):upper( )
end

function Schema:CanDispatch( name )
	return table.HasValue( {
		"EpU", "SeC", "DvL"
	}, self:GetRankByName( name ) or "ERROR" )
end

function Schema:GetModelByRank( rank )
	return self.CombineRankModel[ rank ] or "models/dpfilms/metropolice/hl2concept.mdl"
end

function Schema:GetCombines( )
	local players = { }
	
	for k, v in pairs( player.GetAllByLoaded( ) ) do
		if ( !v.PlayerIsCombine( v ) ) then continue end
		
		players[ #players + 1 ] = v
	end
	
	return players
end

function Schema:PlayerIsCombine( pl )
	return table.HasValue( self.IsCombineFacton, pl:Team( ) )
end

local META = FindMetaTable( "Player" )

function META:PlayerIsCombine( )
	return Schema:PlayerIsCombine( self )
end

function Schema:CalcBadNameString( )
	local rand = math.random( 5, 15 )
	local text = ""
	
	for i = 1, rand do
		text = text .. table.Random( self.BadRadioStrings )
	end
	
	return text
end

// Hint stuff
//catherine.hint.Register( "" )

catherine.chat.Register( "radio", {
	func = function( pl, text, ex )
		local name = pl:Name( )
		
		if ( ex[ 1 ] and LocalPlayer( ) != pl ) then
			name = Schema:CalcBadNameString( )
		end
		
		chat.AddText( Color( 0, 255, 100 ), LANG( "Chat_Radio", name, catherine.chat.PreSet( text ) ) )
	end,
	isGlobal = true,
	canRun = function( pl )
		return pl:Alive( )
	end,
	canHear = function( pl )
		return pl:Alive( )
	end
} )

catherine.chat.Register( "dispatch", {
	func = function( pl, text )
		chat.AddText( Color( 255, 150, 150 ), LANG( "Chat_Dispatch", text ) )
	end,
	isGlobal = true,
	canRun = function( pl )
		return pl:Alive( )
	end
} )

catherine.chat.Register( "request", {
	func = function( pl, text )
		chat.AddText( Color( 255, 200, 150 ), LANG( "Chat_Request", pl:Name( ), catherine.chat.PreSet( text ) ) )
	end,
	isGlobal = true,
	canRun = function( pl )
		return pl:Alive( )
	end
} )