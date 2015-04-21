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

local PLUGIN = PLUGIN
local PANEL = { }

function PANEL:Init( )
	catherine.vgui.root = self

	self.ent = nil
	self.entCheck = CurTime( ) + 1
	self.closeing = false
	self.player = LocalPlayer( )
	self.inv = nil
	self.cash = nil
	self.w, self.h = ScrW( ) * 0.6, ScrH( ) * 0.8

	self:SetSize( self.w, self.h )
	self:Center( )
	self:SetTitle( "" )
	self:MakePopup( )
	self:ShowCloseButton( false )

	self.close = vgui.Create( "catherine.vgui.button", self )
	self.close:SetPos( self.w - 30, 0 )
	self.close:SetSize( 30, 25 )
	self.close:SetStr( "X" )
	self.close:SetStrFont( "catherine_normal30" )
	self.close:SetStrColor( Color( 255, 150, 150, 255 ) )
	self.close:SetGradientColor( Color( 255, 150, 150, 255 ) )
	self.close.Click = function( )
		if ( self.closeing ) then return end
		self:Close( )
		netstream.Start( "catherine_hl2rp.plugin.root.RootClose" )
	end
end

function PANEL:Paint( w, h )
	catherine.theme.Draw( CAT_THEME_MENU_BACKGROUND, w, h )
	
	if ( !IsValid( self.ent ) ) then return end
	local name = self.ent:Name( )
	
	if ( name ) then
		draw.SimpleText( name, "catherine_normal25", 10, 0, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_RIGHT )
	end
end

function PANEL:InitializeRoot( ent, inv, cash )
	self.ent = ent
	self.inv = inv
	self.cash = cash
end

function PANEL:Think( )
	if ( self.entCheck <= CurTime( ) ) then
		if ( !IsValid( self.ent ) and !self.closeing ) then
			self:Close( )
			return
		end
		self.entCheck = CurTime( ) + 0.01
	end
end

function PANEL:Close( )
	self.closeing = true
	self:Remove( )
	self = nil
end

vgui.Register( "catherine.vgui.root", PANEL, "DFrame" )