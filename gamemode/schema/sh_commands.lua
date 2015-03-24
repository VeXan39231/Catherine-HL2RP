catherine.command.Register( {
	command = "radio",
	syntax = "[Text]",
	runFunc = function( pl, args )
		local args = table.concat( args, " " )
		if ( args != "" ) then
			if ( pl:HasItem( "portable_radio" ) ) then
				local itemData = pl:GetInvItemData("portable_radio")
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
	command = "dispatch",
	syntax = "[Text]",
	runFunc = function( pl, args )
		local args = table.concat( args, " " )
		if ( pl:PlayerIsCombine( ) or pl:Team( ) == FACTION_ADMIN ) then
			if ( args != "" ) then
				Schema:SayDispatch( pl, args )
			else
				catherine.util.Notify( pl, "Please input message!" )
			end
		else
			catherine.util.Notify( pl, "You are not combine!" )
		end
	end
} )