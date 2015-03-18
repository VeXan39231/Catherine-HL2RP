Schema.Name = "HL2RP"
Schema.Author = "L7D"
Schema.FolderName = "cat_hl2rp"
Schema.Title = "Half - Life 2 Role Play"
Schema.Desc = "This is safe."
Schema.IntroTitle = "2016 year, City 18"
Schema.IntroDesc = "This is safe."

catherine.util.Include( "sh_config.lua" )
catherine.util.Include( "sh_commands.lua" )
catherine.util.Include( "sv_schema.lua" )
catherine.util.Include( "cl_schema.lua" )

catherine.chat.RegisterClass( "radio", {
	onChat = function( pl, text )
		chat.AddText( Color( 0, 255, 100 ), pl:Name( ) .. " radio says " .. text )
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