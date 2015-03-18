catherine.command.Register( {
	command = "radio",
	syntax = "[Text]",
	runFunc = function( pl, args )
		if ( args[ 1 ] ) then
			if ( pl:HasItem( "portable_radio" ) ) then
				if ( pl:GetInvItemData( "portable_radio", "toggle" ) ) then
					if ( pl:GetInvItemData( "portable_radio", "freq" ) != "" ) then
						Schema:SayRadio( pl, table.concat( args, " " ) )
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
	command = "dispatch",
	syntax = "[Text]",
	runFunc = function( pl, args )
		if ( args[ 1 ] ) then
			Schema:SayDispatch( pl, args[ 1 ] )
		else
			catherine.util.Notify( pl, "Please input message!" )
		end
	end
} )