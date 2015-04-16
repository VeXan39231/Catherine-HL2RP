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
Schema.CombineRankClass = {
	Elite = "cp_elite",
	Unit = "cp_unit"
}
Schema.CombineRank = {
	[ "SeC" ] = Schema.CombineRankClass.Elite,
	[ "DvL" ] = Schema.CombineRankClass.Elite,
	[ "EpU" ] = Schema.CombineRankClass.Elite,
	[ "GHOST" ] = Schema.CombineRankClass.Unit,
	[ "OfC" ] = Schema.CombineRankClass.Unit,
	[ "05" ] = Schema.CombineRankClass.Unit,
	[ "04" ] = Schema.CombineRankClass.Unit,
	[ "03" ] = Schema.CombineRankClass.Unit,
	[ "02" ] = Schema.CombineRankClass.Unit,
	[ "01" ] = Schema.CombineRankClass.Unit,
	[ "RCT" ] = Schema.CombineRankClass.Unit
}
/* // Default
Schema.CombineRankModel = {
	[ "SeC" ] = "models/sect_police2.mdl",
	[ "DvL" ] = "models/eliteshockcp.mdl",
	[ "EpU" ] = "models/leet_police2.mdl",
	[ "GHOST" ] = "models/eliteghostcp.mdl",
	[ "OfC" ] = "models/policetrench.mdl",
	[ "05" ] = "models/police.mdl",
	[ "04" ] = "models/police.mdl",
	[ "03" ] = "models/police.mdl",
	[ "02" ] = "models/police.mdl",
	[ "01" ] = "models/police.mdl",
	[ "RCT" ] = "models/police.mdl"
}*/
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
	"__",
	"_____",
	"_"
}

for k, v in pairs( Schema.CombineRankModel ) do
	util.PrecacheModel( v )
	catherine.anim.SetModelAnimation( "metrocop", v )
end

function Schema:GetRankByName( name )
	for k, v in pairs( self.CombineRank ) do
		if ( name:find( k ) ) then
			return k, v
		end
	end
end

function Schema:CanDispatch( name )
	local can = { }
	
	for k, v in pairs( Schema.CombineRank ) do
		if ( v != Schema.CombineRankClass.Elite ) then continue end
		can[ #can + 1 ] = v
	end
	
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
		if ( !v:PlayerIsCombine( ) ) then continue end
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

catherine.chat.RegisterClass( "radio", {
	onChat = function( pl, text, ex )
		local name = pl:Name( )
		
		if ( ex[ 1 ] and LocalPlayer( ) != pl ) then
			name = Schema:CalcBadNameString( )
		end
		
		chat.AddText( Color( 0, 255, 100 ), name .. " radio says " .. catherine.chat.PreSet( text ) )
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