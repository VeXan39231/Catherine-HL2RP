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

	self.entCheck = CurTime( ) + 1
	self.player = LocalPlayer( )
	self.w, self.h = ScrW( ) * 0.8, ScrH( ) * 0.8

	self:SetSize( self.w, self.h )
	self:Center( )
	self:SetTitle( "" )
	self:MakePopup( )
	self:ShowCloseButton( false )
	
	self.targetInv = vgui.Create( "DPanelList", self )
	self.targetInv:SetPos( 10, 55 )
	self.targetInv:SetSize( self.w / 2, self.h - 65 )
	self.targetInv:SetSpacing( 5 )
	self.targetInv:EnableHorizontal( false )
	self.targetInv:EnableVerticalScrollbar( true )	
	self.targetInv.Paint = function( pnl, w, h )
		catherine.theme.Draw( CAT_THEME_PNLLIST, w, h )
	end
	
	self.playerInv = vgui.Create( "DPanelList", self )
	self.playerInv:SetPos( self.w / 2 + 20, 55 )
	self.playerInv:SetSize( self.w / 2 - 30, self.h - 65 )
	self.playerInv:SetSpacing( 5 )
	self.playerInv:EnableHorizontal( false )
	self.playerInv:EnableVerticalScrollbar( true )	
	self.playerInv.Paint = function( pnl, w, h )
		catherine.theme.Draw( CAT_THEME_PNLLIST, w, h )
	end

	self.close = vgui.Create( "catherine.vgui.button", self )
	self.close:SetPos( self.w - 30, 0 )
	self.close:SetSize( 30, 25 )
	self.close:SetStr( "X" )
	self.close:SetStrFont( "catherine_normal30" )
	self.close:SetStrColor( Color( 255, 150, 150, 255 ) )
	self.close:SetGradientColor( Color( 255, 150, 150, 255 ) )
	self.close.Click = function( )
		if ( self.closing ) then return end
		
		self:Close( )
	end
end

function PANEL:Paint( w, h )
	catherine.theme.Draw( CAT_THEME_MENU_BACKGROUND, w, h )
	
	if ( !IsValid( self.ent ) ) then return end
	local name = self.ent:Name( )
	
	if ( name ) then
		draw.SimpleText( name, "catherine_normal25", 10, 0, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_RIGHT )
		draw.SimpleText( LANG( "Cash_UI_TargetHasStr", self.cash ), "catherine_normal20", 10, 30, Color( 50, 50, 50, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_RIGHT )
	end
	
	draw.SimpleText( self.player:Name( ), "catherine_normal25", w / 2 + 20, 0, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_RIGHT )
	draw.SimpleText( LANG( "Cash_UI_HasStr", catherine.cash.Get( self.player ) ), "catherine_normal20", w / 2 + 20, 30, Color( 50, 50, 50, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_RIGHT )
end

function PANEL:InitializeRoot( ent, inv )
	self.ent = ent
	self.cash = catherine.cash.Get( ent )
	
	local targetInventory = inv
	local tab = { }
	
	for k, v in pairs( targetInventory ) do
		local itemTable = catherine.item.FindByID( k )
		if ( !itemTable ) then continue end
		local category = itemTable.category
		
		tab[ category ] = tab[ category ] or { }
		tab[ category ][ v.uniqueID ] = v
	end
	
	self.targetInventory = tab

	local playerInventory = catherine.inventory.Get( )
	local tab = { }
	
	for k, v in pairs( playerInventory ) do
		local itemTable = catherine.item.FindByID( k )
		if ( !itemTable ) then continue end
		local category = itemTable.category
		
		tab[ category ] = tab[ category ] or { }
		tab[ category ][ v.uniqueID ] = v
	end
	
	self.playerInventory = tab
	
	self:RebuildRoot( )
end

function PANEL:RebuildRoot( )
	if ( !self.targetInventory or !self.playerInventory ) then return end
	self.targetInv:Clear( )
	self.playerInv:Clear( )
	
	local delta = 0
	
	for k, v in pairs( self.targetInventory ) do
		local form = vgui.Create( "DForm" )
		form:SetSize( self.targetInv:GetWide( ), 54 )
		form:SetName( catherine.util.StuffLanguage( k ) )
		form:SetAlpha( 0 )
		form:AlphaTo( 255, 0.1, delta )
		form.Paint = function( pnl, w, h )
			catherine.theme.Draw( CAT_THEME_FORM, w, h )
		end
		form.Header:SetFont( "catherine_normal15" )
		form.Header:SetTextColor( Color( 90, 90, 90, 255 ) )
		delta = delta + 0.05

		local lists = vgui.Create( "DPanelList", form )
		lists:SetSize( form:GetWide( ), form:GetTall( ) )
		lists:SetSpacing( 3 )
		lists:EnableHorizontal( true )
		lists:EnableVerticalScrollbar( false )	
		
		form:AddItem( lists )

		for k1, v1 in pairs( v ) do
			local w, h = 54, 54
			local itemTable = catherine.item.FindByID( v1.uniqueID )
			if ( !itemTable ) then continue end
			local itemDesc = itemTable.GetDesc and itemTable:GetDesc( self.player, itemTable, self.player:GetInvItemDatas( itemTable.uniqueID ), false ) or nil

			local spawnIcon = vgui.Create( "SpawnIcon" )
			spawnIcon:SetSize( w, h )
			spawnIcon:SetModel( itemTable.model )
			spawnIcon:SetSkin( itemTable.skin or 0 )
			spawnIcon:SetToolTip( catherine.item.GetBasicDesc( itemTable ) .. ( itemDesc and "\n" .. itemDesc or "" ) )
			spawnIcon.DoClick = function( )
				netstream.Start( "catherine_hl2rp.plugin.root.Work", {
					self.ent,
					CAT_ROOT_ACTION_TAKE,
					{
						uniqueID = v1.uniqueID
					}
				} )
			end
			spawnIcon.PaintOver = function( pnl, w, h )
				if ( catherine.inventory.IsEquipped( v1.uniqueID ) ) then
					surface.SetDrawColor( 255, 255, 255, 255 )
					surface.SetMaterial( Material( "icon16/accept.png" ) )
					surface.DrawTexturedRect( 5, 5, 16, 16 )
				end
				
				if ( itemTable.DrawInformation ) then
					itemTable:DrawInformation( self.player, itemTable, w, h, self.player:GetInvItemDatas( itemTable.uniqueID ) )
				end
				
				if ( v1.itemCount > 1 ) then
					draw.SimpleText( v1.itemCount, "catherine_normal20", 5, h - 25, Color( 50, 50, 50, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_RIGHT )
				end
			end
			
			lists:AddItem( spawnIcon )
		end
		
		self.targetInv:AddItem( form )
	end
	
	delta = 0
	
	for k, v in pairs( self.playerInventory ) do
		local form = vgui.Create( "DForm" )
		form:SetSize( self.playerInv:GetWide( ), 54 )
		form:SetName( catherine.util.StuffLanguage( k ) )
		form:SetAlpha( 0 )
		form:AlphaTo( 255, 0.1, delta )
		form.Paint = function( pnl, w, h )
			catherine.theme.Draw( CAT_THEME_FORM, w, h )
		end
		form.Header:SetFont( "catherine_normal15" )
		form.Header:SetTextColor( Color( 90, 90, 90, 255 ) )
		delta = delta + 0.05

		local lists = vgui.Create( "DPanelList", form )
		lists:SetSize( form:GetWide( ), form:GetTall( ) )
		lists:SetSpacing( 3 )
		lists:EnableHorizontal( true )
		lists:EnableVerticalScrollbar( false )	
		
		form:AddItem( lists )

		for k1, v1 in pairs( v ) do
			local w, h = 54, 54
			local itemTable = catherine.item.FindByID( v1.uniqueID )
			if ( !itemTable ) then continue end
			local itemDesc = itemTable.GetDesc and itemTable:GetDesc( self.player, itemTable, self.player:GetInvItemDatas( itemTable.uniqueID ), true ) or nil

			local spawnIcon = vgui.Create( "SpawnIcon" )
			spawnIcon:SetSize( w, h )
			spawnIcon:SetModel( itemTable.model )
			spawnIcon:SetSkin( itemTable.skin or 0 )
			spawnIcon:SetToolTip( catherine.item.GetBasicDesc( itemTable ) .. ( itemDesc and "\n" .. itemDesc or "" ) )
			spawnIcon.DoClick = function( )
				netstream.Start( "catherine_hl2rp.plugin.root.Work", {
					self.ent,
					CAT_ROOT_ACTION_GIVE,
					{
						uniqueID = v1.uniqueID
					}
				} )
			end
			spawnIcon.PaintOver = function( pnl, w, h )
				if ( catherine.inventory.IsEquipped( v1.uniqueID ) ) then
					surface.SetDrawColor( 255, 255, 255, 255 )
					surface.SetMaterial( Material( "icon16/accept.png" ) )
					surface.DrawTexturedRect( 5, 5, 16, 16 )
				end
				
				if ( itemTable.DrawInformation ) then
					itemTable:DrawInformation( self.player, itemTable, w, h, self.player:GetInvItemDatas( itemTable.uniqueID ) )
				end
				
				if ( v1.itemCount > 1 ) then
					draw.SimpleText( v1.itemCount, "catherine_normal20", 5, h - 25, Color( 50, 50, 50, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_RIGHT )
				end
			end
			
			lists:AddItem( spawnIcon )
		end
		
		self.playerInv:AddItem( form )
	end
end

function PANEL:Think( )
	if ( ( self.entCheck or 0 ) <= CurTime( ) ) then
		if ( !IsValid( self.ent ) and !self.closing ) then
			self:Close( )
			
			return
		end
		
		self.entCheck = CurTime( ) + 0.5
	end
end

function PANEL:Close( )
	self.closing = true
	
	self:Remove( )
	self = nil
	
	netstream.Start( "catherine_hl2rp.plugin.root.RootClose" )
end

vgui.Register( "catherine.vgui.root", PANEL, "DFrame" )