function Schema:PlayerCanSpray( pl )
	return pl:HasItem( "spray_can" )
end

function Schema:SayRadio( pl, text )
	local chanels = { }
	local playerfreq = pl:GetInvItemData( "portable_radio", "freq" )
	
	for k, v in pairs( player.GetAllByLoaded( ) ) do
		local freq = v:GetInvItemData( "portable_radio", "freq" )
		if ( v:HasItem( "portable_radio" ) and v:GetInvItemData( "portable_radio", "toggle" ) and freq != "" ) then
			chanels[ freq ] = chanels[ freq ] or { }
			chanels[ freq ][ #chanels[ freq ] + 1 ] = v
		end
	end

	catherine.chat.RunByClass( pl, "radio", text, chanels[ playerfreq ] )
end

function Schema:SayDispatch( pl, text )
	catherine.chat.RunByClass( pl, "dispatch", text )
end

function Schema:ChatAdjust( adjustInfo )
	if ( adjustInfo.class == "ic" or adjustInfo.class == "radio" or adjustInfo.class == "yell" or adjustInfo.class == "whisper" ) then
		local tab = { sounds = { }, text = "" }
		local ex = string.Explode( ", ", adjustInfo.text )
		local vol = true

		if ( adjustInfo.class == "ic" ) then
			vol = 80
		elseif ( adjustInfo.class == "yell" ) then
			vol = 100
		elseif ( adjustInfo.class == "whisper" ) then
			vol = 30
		end

		for k, v in pairs( Schema.voice.normalVoice ) do
			for k1, v1 in pairs( ex ) do
				if ( v1:lower( ) == v.command:lower( ) ) then
					tab.sounds[ #tab.sounds + 1 ] = { dir = v.sound, len = SoundDuration( v.sound ), vol = vol }
					
					if ( k1 == 1 ) then
						adjustInfo.text = v.output
					else
						adjustInfo.text = adjustInfo.text .. ", " .. v.output
					end
				end
			end
		end

		adjustInfo.voice = tab.sounds
		return adjustInfo
	elseif ( adjustInfo.class == "dispatch" ) then
		local tab = { sounds = { }, text = "" }
		for k, v in pairs( Schema.voice.dispatchVoice ) do
			if ( v.command:lower( ) == adjustInfo.text:lower( ) ) then
				tab.sounds[ #tab.sounds + 1 ] = { dir = v.sound, len = SoundDuration( v.sound ), vol = true }
				adjustInfo.text = v.output
			end
		end
		
		adjustInfo.voice = tab.sounds
		return adjustInfo
	end
end

function Schema:ChatSended( adjustInfo )
	if ( adjustInfo and adjustInfo.voice ) then
		local pl = adjustInfo.player
		local len = 0
		for k, v in pairs( adjustInfo.voice ) do
			len = len + ( k == 1 and 0 or v.len + 0.3 )
			timer.Create( "catherine_hl2rp.timer.ChatPosted_" .. pl:SteamID( ) .. "_" .. k, len, 1, function( )
				if ( type( v.vol ) == "boolean" and v.vol == true ) then
					catherine.util.PlaySound( nil, v.dir )
				else
					pl:EmitSound( v.dir, v.vol )
				end
			end )
		end
	end
end