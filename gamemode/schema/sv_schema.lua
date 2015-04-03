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

-- Add the resource pack.
resource.AddWorkshop( "104491619" )
resource.AddWorkshop( "105042805" )

CAT_SCHEMA_COMBINEOVERLAY_LOCAL = 1
CAT_SCHEMA_COMBINEOVERLAY_GLOBAL = 2

Schema.NextRadioSignalCheckTick = Schema.NextRadioSignalCheckTick or CurTime( ) + 2

function Schema:PlayerCanSpray( pl )
	return pl:HasItem( "spray_can" )
end

function Schema:SayRadio( pl, text )
	local listeners = self:GetRadioListeners( pl )

	catherine.chat.RunByClass( pl, "radio", text, listeners )
end

function Schema:SayRequest( pl, text )
	local targets = { }
	
	for k, v in pairs( self:GetCombines( ) ) do
		if ( !v:PlayerIsCombine( ) ) then continue end
		targets[ #targets + 1 ] = v
	end
	for k, v in pairs( player.GetAllByLoaded( ) ) do
		if ( !v:PlayerIsCombine( ) ) then continue end
		self:AddCombineOverlayMessage( v, pl:Name( ) .. "'s request - " .. text, 9, Color( 255, 150, 150 ) )
	end
	
	catherine.chat.RunByClass( pl, "request", text, targets )
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

		for k, v in pairs( Schema.vo.normalVoice ) do
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
		
		for k, v in pairs( Schema.vo.dispatchVoice ) do
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
		return true
	end
end

function Schema:AddCombineOverlayMessage( targetType, pl, message, time, col, textMakeDelay )
	if ( !message ) then return end
	targetType = targetType or CAT_SCHEMA_COMBINEOVERLAY_GLOBAL
	local combines = self:GetCombines( )
	
	if ( targetType == CAT_SCHEMA_COMBINEOVERLAY_LOCAL and IsValid( pl ) ) then
		combines = pl
	elseif ( targetType == CAT_SCHEMA_COMBINEOVERLAY_GLOBAL_NOLOCAL and IsValid( pl ) ) then
		table.RemoveByValue( combines, pl )
	end
	
	netstream.Start( combines, "catherine.Schema.AddCombineOverlayMessage", { message, time or 6, col or Color( 255, 255, 255 ), textMakeDelay or 0.05 } )
end

CAT_SCHEMA_COMBINEOVERLAY_LOCAL = 1
CAT_SCHEMA_COMBINEOVERLAY_GLOBAL = 2
CAT_SCHEMA_COMBINEOVERLAY_GLOBAL_NOLOCAL = 3

function Schema:ClearCombineOverlayMessages( pl )
	if ( !IsValid( pl ) ) then return end
	netstream.Start( pl, "catherine.Schema.ClearCombineOverlayMessages" )
end

function Schema:PlayerFootstep( pl, pos, foot, soundName, vol )
	if ( !pl:IsRunning( ) ) then return true end
	local team = pl:Team( )
	if ( team == FACTION_CP ) then
		pl:EmitSound( "npc/metropolice/gear" .. math.random( 1, 6 ) .. ".wav", 70 )
		return true
	elseif ( team == FACTION_OW ) then
		pl:EmitSound( "npc/combine_soldier/gear" .. math.random( 1, 6 ) .. ".wav", 70 )
		return true
	end
end

function Schema:GetPlayerPainSound( pl )
	local team = pl:Team( )
	if ( team == FACTION_CP ) then
		return "npc/metropolice/pain" .. math.random( 1, 3 ) .. ".wav"
	elseif ( team == FACTION_OW ) then
		return "npc/combine_soldier/pain" .. math.random( 1, 3 ) .. ".wav"
	end
end

function Schema:GetPlayerDeathSound( pl )
	local team = pl:Team( )
	if ( team == FACTION_CP ) then
		return "npc/metropolice/die" .. math.random( 1, 4 ) .. ".wav"
	elseif ( team == FACTION_OW ) then
		return "npc/combine_soldier/die" .. math.random( 1, 3 ) .. ".wav"
	end
end

function Schema:AddCombineOverlayMessage( targetType, pl, message, time, col, textMakeDelay )
	if ( !message ) then return end
	targetType = targetType or CAT_SCHEMA_COMBINEOVERLAY_GLOBAL
	local combines = self:GetCombines( )
	
	if ( targetType == CAT_SCHEMA_COMBINEOVERLAY_LOCAL and IsValid( pl ) ) then
		combines = pl
	elseif ( targetType == CAT_SCHEMA_COMBINEOVERLAY_GLOBAL_NOLOCAL and IsValid( pl ) ) then
		table.RemoveByValue( combines, pl )
	end
	
	netstream.Start( combines, "catherine.Schema.AddCombineOverlayMessage", { message, time or 6, col or Color( 255, 255, 255 ), textMakeDelay or 0.05 } )
end

function Schema:HealthFullRecovered( pl )
	if ( !pl:PlayerIsCombine( ) ) then return end
	self:AddCombineOverlayMessage( CAT_SCHEMA_COMBINEOVERLAY_LOCAL, pl, "Vital signs recovered ...", 4, Color( 150, 255, 150 ) )
end

function Schema:PlayerTakeDamage( pl )
	if ( !pl:PlayerIsCombine( ) ) then return end
	if ( ( pl.CAT_HL2RP_nextHurtDelay or CurTime( ) ) <= CurTime( ) ) then
		local combineNumber = pl:GetCharacterVar( "combineNumber", "ERROR" )
		self:AddCombineOverlayMessage( CAT_SCHEMA_COMBINEOVERLAY_LOCAL, pl, "WARNING ! Physical bodily trauma detected ...", 7, Color( 255, 150, 0 ) )
		self:AddCombineOverlayMessage( CAT_SCHEMA_COMBINEOVERLAY_GLOBAL_NOLOCAL, pl, "WARNING ! Unit #" .. combineNumber .. " has damaged by unknown problems ...", 7, Color( 255, 150, 0 ) )
		pl.CAT_HL2RP_nextHurtDelay = CurTime( ) + 5
	end
end

function Schema:HealthRecovering( pl )
	if ( !pl:PlayerIsCombine( ) ) then return end
	self:AddCombineOverlayMessage( CAT_SCHEMA_COMBINEOVERLAY_LOCAL, pl, "Vital signs recovering [" .. ( pl:Health( ) / pl:GetMaxHealth( ) ) * 100 .. "%] ...", 4, Color( 255, 150, 150 ) )
end

function Schema:PlayerGone( pl )
	if ( !pl:PlayerIsCombine( ) ) then return end
	local combineNumber = pl:GetCharacterVar( "combineNumber", "ERROR" )
	
	local localMessage = "ERROR ! Shut Down - ..."
	local globalMessage = "WARNING ! Unit #" .. combineNumber .. " vital signs absent, alerting dispatch ..."
	if ( pl:Team( ) == FACTION_OW ) then
		localMessage = "Critical Error - ..."
		globalMessage = "WARNING ! Overwatch Unit #" .. combineNumber .. " vital signs absent, alerting dispatch ..."
	end
	
	self:AddCombineOverlayMessage( CAT_SCHEMA_COMBINEOVERLAY_GLOBAL_NOLOCAL, pl, "WARNING ! Vital signs dropping ...", 10, Color( 255, 150, 0 ), 0.04 )
	self:AddCombineOverlayMessage( CAT_SCHEMA_COMBINEOVERLAY_LOCAL, pl, localMessage, 10, Color( 255, 0, 0 ), 0.04 )
	self:AddCombineOverlayMessage( CAT_SCHEMA_COMBINEOVERLAY_GLOBAL_NOLOCAL, pl, globalMessage, 10, Color( 255, 0, 0 ), 0.04 )

	for k, v in pairs( self:GetCombines( ) or { } ) do
		v:EmitSound( "npc/overwatch/radiovoice/on1.wav" )
		v:EmitSound( "npc/overwatch/radiovoice/lostbiosignalforunit.wav" )
		
		timer.Simple( 1.5, function( )
			v:EmitSound( "npc/overwatch/radiovoice/off4.wav" )
		end )
	end
end

function Schema:OnSpawnedInCharacter( pl )
	if ( pl:PlayerIsCombine( ) ) then
		self:AddCombineOverlayMessage( CAT_SCHEMA_COMBINEOVERLAY_LOCAL, pl, "Online ...", 5, Color( 150, 255, 150 ), 0.04 )
		
		local rankID, classID = self:GetRankByName( pl:Name( ) )
		if ( pl:Class( ) != nil and pl:Class() == classID ) then return end
		
		if ( rankID and classID ) then
			catherine.class.Set( pl, classID )
			pl:SetModel( self:GetModelByRank( rankID ) )
		else
			if ( pl:Class( ) == "cp_unit" ) then return end
			catherine.class.Set( pl, "cp_unit" )
		end
		return
	end
	
	self:AddCombineOverlayMessage( CAT_SCHEMA_COMBINEOVERLAY_GLOBAL, nil, "Refreshing citizen lists ...", 7, Color( 150, 255, 150 ) )
end

function Schema:CharacterNameChanged( pl, newName )
	if ( !pl:PlayerIsCombine( ) ) then return end
	local rankID, classID = self:GetRankByName( pl:Name( ) )

	if ( pl:Class( ) != nil and pl:Class() == classID ) then return end
	
	if ( rankID and classID ) then
		catherine.class.Set( pl, classID )
		pl:SetModel( self:GetModelByRank( rankID ) )
	else
		if ( pl:Class( ) == "cp_unit" ) then return end
		catherine.class.Set( pl, "cp_unit" )
	end
end

function Schema:CharacterLoadingStart( pl )
	if ( !pl:PlayerIsCombine( ) ) then return end
	self:ClearCombineOverlayMessages( pl )
end

function Schema:GetRadioListeners( pl )
	local listeners, playerFreq = { }, pl:GetInvItemData( "portable_radio", "freq" )
	if ( !playerFreq ) then return end
	
	for k, v in pairs( player.GetAllByLoaded( ) ) do
		if ( !v:HasItem( "portable_radio" ) ) then continue end
		local targetItemDatas = v:GetInvItemDatas( "portable_radio" )
		
		if ( targetItemDatas.toggle and targetItemDatas.freq and ( targetItemDatas.freq != "xxx.x" and targetItemDatas.freq != "" ) ) then
			listeners[ targetItemDatas.freq ] = listeners[ targetItemDatas.freq ] or { }
			listeners[ targetItemDatas.freq ][ #listeners[ targetItemDatas.freq ] + 1 ] = v
		end
	end
	
	return listeners
end

function Schema:Tick( )
	if ( self.NextRadioSignalCheckTick <= CurTime( ) ) then
		self:RadioTick( )
		self.NextRadioSignalCheckTick = CurTime( ) + 2
	end
end

// 1 - 1000,
// 2 - 300,
// 3 - 100
// 4 - 3000

function Schema:CalcRadio( pl )
	local listeners = self:GetRadioListeners( pl )
	local disradio = {
		[ 800 ] = 5,
		[ 1800 ] = 4,
		[ 3000 ] = 3,
		[ 5000 ] = 2,
		[ 8000 ] = 1,
		[ 10000 ] = 0
	}
	local l = 1000000 // need set max map size.
	
	for k, v in pairs( listeners or { } ) do
		if ( pl == v ) then continue end
		local dis = catherine.util.CalcDistanceByPos( pl, v )
		if ( dis < l ) then
			l = dis
		end
	end

	for k, v in pairs( disradio ) do
		if ( k >= l ) then
			return v
		end
	end
	
	return 0
end

function Schema:RadioTick( )
	for k, v in pairs( player.GetAllByLoaded( ) ) do
		if ( v:PlayerIsCombine( ) ) then continue end
		v:SetNetVar( "radioSignal", self:CalcRadio( v ) )
	end
end