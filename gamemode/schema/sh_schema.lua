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

local META = FindMetaTable( "Player" )

function Schema:PlayerIsCombine( pl )
	return table.HasValue( {
		FACTION_CP,
		FACTION_OW
	}, pl:Team( ) )
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