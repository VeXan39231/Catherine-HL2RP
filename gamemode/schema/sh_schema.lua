Schema.Name = "HL2RP"
Schema.Author = "L7D"
Schema.FolderName = "cat_hl2rp"
Schema.Title = "Half - Life 2 Role Play"
Schema.Desc = "It's safe here."
Schema.IntroTitle = "City 18, 2016."
Schema.IntroDesc = "It's safe here."

Schema.isCombine = {
	FACTION_MPF,
	FACTION_OTA
}

catherine.util.Include( "sh_config.lua" )
catherine.util.Include( "sh_commands.lua" )
catherine.util.Include( "sv_schema.lua" )
catherine.util.Include( "cl_schema.lua" )

local META = FindMetaTable( "Player" )

function Schema:PlayerIsCombine( pl )
	return table.HasValue( Schema.isCombine, pl:Team( ) )
end

function META:PlayerIsCombine( )
	return Schema:PlayerIsCombine( self )
end












catherine.chat.RegisterClass( "radio", {
	onChat = function( pl, text )
		chat.AddText( Color( 0, 255, 100 ), pl:Name( ) .. " radio says " .. text )
	end,
	global = true,
	canRun = function( pl )
		return pl:Alive( )
	end,
	command = "radio"
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
