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

netstream.Hook( "catherine.Schema.AddCombineOverlayMessage", function( data )
	Schema:AddCombineOverlayMessage( data[ 1 ], data[ 2 ], data[ 3 ], data[ 4 ] )
end )

netstream.Hook( "catherine.Schema.ClearCombineOverlayMessages", function( )
	Schema.playercombineOverlays = { }
end )

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
	local data = { }
	data.colour = 0.6
	return data
end

function Schema:AutomaticCombineOverlayMessage( )
	self.playercombineOverlays[ #self.playercombineOverlays + 1 ] = {
		message = "",
		a = 0,
		y = 20 + ( ( #self.playercombineOverlays + 2 ) * 20 ),
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
	if ( !message or !time ) then return end
	self.playercombineOverlays[ #self.playercombineOverlays + 1 ] = {
		message = "",
		a = 0,
		y = 20 + ( ( #self.playercombineOverlays + 2 ) * 20 ),
		time = CurTime( ) + ( time or 6 ),
		textTime = CurTime( ),
		textMakeDelay = textMakeDelay or 0.05,
		textSubCount = 1,
		gradientW = 0,
		originalMessage = self:PrefixCombineOverlayMessage( ) .. message,
		col = col or Color( 255, 255, 255 )
	}
end

function Schema:HUDDrawBarBottom( x, y )
	if ( !LocalPlayer( ):PlayerIsCombine( ) ) then return end
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
			v.gradientW = v.gradientW + 10
		end
		surface.SetDrawColor( v.col.r, v.col.g, v.col.b, v.a - 100 )
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