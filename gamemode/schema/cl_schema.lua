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

Schema.combineOverlayMessage = {
	"Waiting for biosignal ...",
	"Initializing Heads-up-display ...",
	"Ascertaining low-wave radio frequency ...",
	"Finding seeders ...",
	"Finding peers ...",
	"Regaining CAT-equalization ...",
	"Receiving network messages ...",
	"Registering Citadel messages ..."
}
Schema.playercombineOverlays = { }
local combineOverlayMaterial

function Schema:GetSchemaInformation( )
	return {
		title = Schema.IntroTitle,
		desc = Schema.IntroDesc,
		author = "Development and design by " .. Schema.Author .. "."
	}
end

function Schema:PrefixCombineOverlayMessage( )
	return "< ::: "
end

function Schema:PostRenderScreenColor( _, data )
	return {
		colour = 0.6
	}
end

function Schema:AutomaticCombineOverlayMessage( )
	local index = #self.playercombineOverlays + 1
	
	self.playercombineOverlays[ index ] = {
		message = "",
		a = 0,
		y = 20 + ( ( index + 1 ) * 20 ),
		time = CurTime( ) + 6,
		textTime = CurTime( ),
		textMakeDelay = 0.03,
		textSubCount = 1,
		gradientW = 0,
		originalMessage = self:PrefixCombineOverlayMessage( ) .. table.Random( self.combineOverlayMessage ),
		col = Color( 255, 255, 255 )
	}
end

function Schema:AddCombineOverlayMessage( message, time, col, textMakeDelay )
	local index = #self.playercombineOverlays + 1
	
	self.playercombineOverlays[ index ] = {
		message = "",
		a = 0,
		y = 20 + ( ( index + 1 ) * 20 ),
		time = CurTime( ) + time,
		textTime = CurTime( ),
		textMakeDelay = textMakeDelay,
		textSubCount = 1,
		gradientW = 0,
		originalMessage = self:PrefixCombineOverlayMessage( ) .. message,
		col = col or Color( 255, 255, 255 )
	}
end

function Schema:HUDDrawBarBottom( x, y )
	if ( !LocalPlayer( ):PlayerIsCombine( ) ) then return end
	
	self:DrawCombineOverlay( x, y )
end

function Schema:DrawCombineOverlay( x, y )
	for k, v in pairs( self.playercombineOverlays ) do
		if ( v.time <= CurTime( ) ) then
			v.a = Lerp( 0.06, v.a, 0 )
			
			if ( math.Round( v.a ) <= 0 ) then
				table.remove( self.playercombineOverlays, k )
			end
		else
			v.a = Lerp( 0.06, v.a, 255 )
		end
		
		v.y = Lerp( 0.06, v.y, ( y ) + ( k * 20 ) )
		
		if ( v.textTime <= CurTime( ) and string.utf8len( v.message ) < string.utf8len( v.originalMessage ) ) then
			local text = string.utf8sub( v.originalMessage, v.textSubCount, v.textSubCount )
			v.message = v.message .. text
			v.textSubCount = v.textSubCount + 1
			v.textTime = CurTime( ) + v.textMakeDelay
			v.gradientW = v.gradientW + 5
		end
		
		surface.SetDrawColor( v.col.r, v.col.g, v.col.b, v.a - 130 )
		surface.SetMaterial( Material( "gui/gradient" ) )
		surface.DrawTexturedRect( 5, v.y + 10, v.gradientW, 1 )

		draw.SimpleText( v.message, "catherine_hl2rp_combineOverlay", 5, v.y, Color( v.col.r, v.col.g, v.col.b, v.a ), TEXT_ALIGN_LEFT, 1 )
	end
end

function Schema:HUDBackgroundDraw( )
	if ( !LocalPlayer( ):PlayerIsCombine( ) ) then return end
	
	if ( !combineOverlayMaterial ) then
		combineOverlayMaterial = Material( "effects/combine_binocoverlay" )
		combineOverlayMaterial:SetFloat( "$alpha", "0.6" )
		combineOverlayMaterial:Recompute( )
	end
	
	surface.SetDrawColor( 255, 255, 255, 50 )
	surface.SetMaterial( combineOverlayMaterial )
	surface.DrawTexturedRect( 0, 0, ScrW( ), ScrH( ) )
end

function Schema:HUDDraw( )
	local pl = LocalPlayer( )
	if ( !pl:Alive( ) or !pl:HasItem( "portable_radio" ) or pl:GetInvItemData( "portable_radio", "toggle", false ) == false ) then return end
	local freq = pl:GetInvItemData( "portable_radio", "freq", "000.0" )
	local x, y = 15, ScrH( ) * 0.4
	local signal = pl:GetNetVar( "radioSignal", 0 )

	if ( !pl.CAT_HL2RP_radioSignalLast ) then
		pl.CAT_HL2RP_radioSignalLast = signal
	end
	
	if ( !pl.CAT_HL2RP_radioSignalTable ) then
		pl.CAT_HL2RP_radioSignalTable = { }
	end
	
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( Material( "CAT_HL2RP/antenna.png", "smooth" ) )
	surface.DrawTexturedRect( x, y, 42, 42 )

	if ( signal == 0 ) then
		draw.SimpleText( "X", "catherine_normal20", x + 50, y + 40, Color( 255, 0, 0, 255 ), TEXT_ALIGN_LEFT, 1 )
	else
		if ( pl.CAT_HL2RP_radioSignalLast != signal ) then
			pl.CAT_HL2RP_radioSignalTable = { }
			
			for i = 1, signal do
				local col = Color( 255, 255, 255, 255 )
				
				if ( signal == 1 ) then
					col = Color( 255, 0, 0, 255 )
				elseif ( signal == 2 ) then
					col = Color( 255, 255, 0, 255 )
				end
		
				pl.CAT_HL2RP_radioSignalTable[ #pl.CAT_HL2RP_radioSignalTable + 1 ] = {
					h = 0,
					targetH = 10 * i,
					col = col
				}
			end
			
			pl.CAT_HL2RP_radioSignalLast = signal
		end

		for k, v in pairs( pl.CAT_HL2RP_radioSignalTable ) do
			v.h = math.Approach( v.h, v.targetH, 0.7 )
			draw.RoundedBox( 0, ( x + 40 ) + 7 * k, ( y + 40 ) - v.h, 5, v.h, v.col )
		end
	end
	
	draw.SimpleText( "Radio Signal", "catherine_normal15", x, y - 20, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, 1 )
	draw.SimpleText( freq, "catherine_normal15", x + 5, y + 55, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, 1 )
end

function Schema:Think( )
	local pl = LocalPlayer( )
	if ( !pl:PlayerIsCombine( ) or !pl:Alive( ) ) then return end
	if ( !pl.CAT_HL2RP_nextCombineOverlay ) then pl.CAT_HL2RP_nextCombineOverlay = CurTime( ) end
	
	if ( pl.CAT_HL2RP_nextCombineOverlay <= CurTime( ) ) then
		self:AutomaticCombineOverlayMessage( )
		pl.CAT_HL2RP_nextCombineOverlay = CurTime( ) + 4
	end
end

catherine.font.Register( "catherine_hl2rp_combineOverlay", "Consolas", 15, 1000 )

netstream.Hook( "catherine.Schema.AddCombineOverlayMessage", function( data )
	Schema:AddCombineOverlayMessage( data[ 1 ], data[ 2 ], data[ 3 ], data[ 4 ] )
end )

netstream.Hook( "catherine.Schema.ClearCombineOverlayMessages", function( )
	Schema.playercombineOverlays = { }
end )