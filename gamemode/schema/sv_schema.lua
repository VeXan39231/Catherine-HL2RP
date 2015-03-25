function Schema:PlayerCanSpray( pl )
	return pl:HasItem( "spray_can" )
end

function Schema:SayRadio( pl, text )
	local chanels, playerFreq = { }, pl:GetInvItemData( "portable_radio", "freq", nil )
	if ( !playerFreq ) then return end
	
	for k, v in pairs( player.GetAllByLoaded( ) ) do
		if ( !v:HasItem( "portable_radio" ) ) then continue end
		local targetitemData = v:GetInvItemDatas( "portable_radio" )
		if ( targetitemData.toggle and targetitemData.freq and ( targetitemData.freq != "xxx.x" and targetitemData.freq != "" ) ) then
			chanels[ targetitemData.freq ] = chanels[ targetitemData.freq ] or { }
			chanels[ targetitemData.freq ][ #chanels[ targetitemData.freq ] + 1 ] = v
		end
	end

	catherine.chat.RunByClass( pl, "radio", text, chanels[ playerFreq ] )
end

function Schema:SayDispatch( pl, text )
	catherine.chat.RunByClass( pl, "dispatch", text )
end

function Schema:ChatAdjust( adjustInfo )
	local pl = adjustInfo.player
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
			if ( !table.HasValue( v.faction, pl:Team( ) ) ) then continue end
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
		local tab, text = { sounds = { }, text = "" }, adjustInfo.text:lower( )
		
		for k, v in pairs( Schema.voice.dispatchVoice ) do
			if ( v.command:lower( ) == text ) then
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

function Schema:PlayerUseDoor( pl, ent )
	if ( pl:PlayerIsCombine( ) and !ent:HasSpawnFlags( 256 ) and !ent:HasSpawnFlags( 1024 ) ) then
		ent:Fire( "open", "", 0 )
	end
end

function Schema:PlayerFootstep( pl, pos, foot, soundName, vol )
	if ( !pl:IsRunning( ) ) then return true end
	local team = pl:Team( )
	if ( team == FACTION_MPF ) then
		pl:EmitSound( "npc/metropolice/gear" .. math.random( 1, 6 ) .. ".wav", 70 )
		return true
	elseif ( team == FACTION_OTA ) then
		pl:EmitSound( "npc/combine_soldier/gear" .. math.random( 1, 6 ) .. ".wav", 70 )
		return true
	end
end

function Schema:InventoryInitialize( pl )
	local team = pl:Team( )
	if ( team == FACTION_CITIZEN ) then
		// need suitcase
		local randomNum = math.random( 10000, 99999 )
		catherine.item.Give( pl, "cid" )
		pl:SetInvItemDatas( "cid", {
			cid = randomNum,
			name = pl:Name( )
		} )
		pl:SetCharacterVar( "cid", randomNum )
	elseif ( team == FACTION_MPF or team == FACTION_OTA or team == FACTION_ADMIN ) then
		catherine.item.Give( pl, "portable_radio" )
		if ( team == FACTION_MPF ) then
			catherine.item.Give( pl, "weapon_pistol" )
			catherine.item.Give( pl, "weapon_stunstick" )
		elseif ( team == FACTION_OTA ) then
			catherine.item.Give( pl, "weapon_ar2" )
		end
	end
end

function Schema:GetPlayerPainSound( pl )
	local team = pl:Team( )
	if ( team == FACTION_MPF ) then
		return "npc/metropolice/pain" .. math.random( 1, 3 ) .. ".wav"
	elseif ( team == FACTION_OTA ) then
		return "npc/combine_soldier/pain" .. math.random( 1, 3 ) .. ".wav"
	end
end

function Schema:PlayerDeathSound( pl )
	local team = pl:Team( )
	if ( team == FACTION_MPF ) then
		pl:EmitSound( "npc/metropolice/die" .. math.random( 1, 4 ) .. ".wav" )
		return true
	elseif ( team == FACTION_OTA ) then
		pl:EmitSound( "npc/combine_soldier/die" .. math.random( 1, 3 ) .. ".wav" )
		return true
	end
end