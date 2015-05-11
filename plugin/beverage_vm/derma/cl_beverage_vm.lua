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
	catherine.vgui.beverage_vm = self

	self.player = LocalPlayer( )
	self.w, self.h = ScrW( ) * 0.6, ScrH( ) * 0.8

	self:SetSize( self.w, self.h )
	self:Center( )
	self:SetTitle( "" )
	self:MakePopup( )
	self:ShowCloseButton( false )
	
	self.Lists = vgui.Create( "DPanelList", self )
	self.Lists:SetPos( 10, 70 )
	self.Lists:SetSize( self.w - 20, self.h - 80 )
	self.Lists:SetSpacing( 5 )
	self.Lists:EnableHorizontal( false )
	self.Lists:EnableVerticalScrollbar( true )	
	self.Lists.Paint = function( pnl, w, h )
		catherine.theme.Draw( CAT_THEME_PNLLIST, w, h )
		
		if ( !PLUGIN:IsActive( self.ent ) ) then
			draw.SimpleText( ":)", "catherine_normal30", w / 2, h / 2 - 30, Color( 50, 50, 50, 255 ), 1, 1 )
			draw.SimpleText( LANG( "BVM_UI_OfflineNotifyStr" ), "catherine_normal20", w / 2, h / 2, Color( 50, 50, 50, 255 ), 1, 1 )
		end
	end

	self.changeStatus = vgui.Create( "catherine.vgui.button", self )
	self.changeStatus:SetPos( self.w - 40, 35 )
	self.changeStatus:SetSize( 30, 30 )
	self.changeStatus:SetStrColor( Color( 50, 50, 50, 0 ) )
	self.changeStatus:SetGradientColor( Color( 50, 50, 50, 0 ) )
	self.changeStatus.Click = function( )
		if ( !IsValid( self.ent ) or !self.player:PlayerIsCombine( ) ) then return end
		
		netstream.Start( "catherine_hl2rp.plugin.beverage_vm.VMWork", {
			self.ent,
			CAT_HL2RP_BEVERAGE_VM_ACTION_CHANGE_STATUS
		} )
	end
	self.changeStatus.PaintBackground = function( pnl, w, h )
		local col = Color( 255, 255, 150, 255 )
		
		if ( PLUGIN:IsActive( self.ent ) ) then
			col = Color( 150, 255, 150, 255 )
		else
			col = Color( 255, 150, 150, 255 )
		end
		
		draw.RoundedBox( 0, 0, 0, w, h, col )
	end

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
	end
end

function PANEL:RefreshList( )
	if ( !PLUGIN:IsActive( self.ent ) ) then
		self.Lists:Clear( )
		return
	end
	
	self.Lists:Clear( )
	
	for k, v in pairs( PLUGIN:GetSellingItems( self.ent ) ) do
		local itemTable = catherine.item.FindByID( k )
		if ( !itemTable ) then continue end
		local itemName = catherine.util.StuffLanguage( itemTable.name )
		local itemDesc = catherine.util.StuffLanguage( itemTable.desc )
		local model = itemTable.GetDropModel and itemTable:GetDropModel( ) or itemTable.model
		local percentAni = 0
		
		local panel = vgui.Create( "DPanel" )
		panel:SetSize( self.Lists:GetWide( ), 80 )
		panel.Paint = function( pnl, w, h )
			draw.RoundedBox( 0, 0, h - 1, w, 1, Color( 50, 50, 50, 255 ) )
			
			if ( v <= 0 ) then
				catherine.geometry.SlickBackground( 0, 0, w, h )
				draw.SimpleText( LANG( "BVM_UI_NoStockStr" ), "catherine_normal25", w - 10, 60, Color( 50, 50, 50, 255 ), TEXT_ALIGN_RIGHT, 1 )
			else
				percentAni = Lerp( 0.06, percentAni, v / PLUGIN.maxItemStockCount * 360 )
				
				draw.NoTexture( )
				surface.SetDrawColor( 255, 255, 255, 255 )
				catherine.geometry.DrawCircle( w - 30, 50, 15, 5, 90, 360, 100 )

				draw.NoTexture( )
				surface.SetDrawColor( 60, 60, 60, 255 )
				catherine.geometry.DrawCircle( w - 30, 50, 15, 5, 90, percentAni, 100 )
			end

			draw.SimpleText( itemName, "catherine_normal25", 90, 20, Color( 50, 50, 50, 255 ), TEXT_ALIGN_LEFT, 1 )
			draw.SimpleText( itemDesc, "catherine_normal15", 90, 60, Color( 50, 50, 50, 255 ), TEXT_ALIGN_LEFT, 1 )
			draw.SimpleText( itemTable.cost == 0 and LANG( "Item_Free" ) or catherine.cash.GetName( itemTable.cost ), "catherine_normal20", w - 10, 15, Color( 50, 50, 50, 255 ), TEXT_ALIGN_RIGHT, 1 )
		end

		local spawnIcon = vgui.Create( "SpawnIcon", panel )
		spawnIcon:SetSize( 70, 70 )
		spawnIcon:SetPos( 5, 5 )
		spawnIcon:SetModel( model, itemTable.skin or 0 )
		spawnIcon:SetToolTip( false )
		spawnIcon:SetDisabled( true )
		spawnIcon.PaintOver = function( pnl, w, h )
			draw.RoundedBox( 0, 0, h - 1, w, 1, Color( 50, 50, 50, 150 ) )
		end

		local buyItem = vgui.Create( "catherine.vgui.button", panel )
		buyItem:SetSize( panel:GetWide( ), panel:GetTall( ) )
		buyItem:SetStr( "" )
		buyItem.Click = function( )
			if ( self.player:PlayerIsCombine( ) and v <= 0 ) then
				Derma_Query( LANG( "BVM_Notify_RefillQ", catherine.cash.GetName( ( itemTable.cost * PLUGIN.maxItemStockCount ) / PLUGIN.refillDiscont ) ), "", LANG( "Basic_UI_YES" ), function( )
					netstream.Start( "catherine_hl2rp.plugin.beverage_vm.VMWork", {
						self.ent,
						CAT_HL2RP_BEVERAGE_VM_ACTION_REFILL,
						{
							uniqueID = k,
							count = PLUGIN.maxItemStockCount
						}
					} )
				end, LANG( "Basic_UI_NO" ), function( ) end )
			else
				netstream.Start( "catherine_hl2rp.plugin.beverage_vm.VMWork", {
					self.ent,
					CAT_HL2RP_BEVERAGE_VM_ACTION_MAIN,
					k
				} )
			end
		end
		
		self.Lists:AddItem( panel )
	end
end

function PANEL:Paint( w, h )
	catherine.theme.Draw( CAT_THEME_MENU_BACKGROUND, w, h )
	
	if ( !IsValid( self.ent ) ) then return end
	draw.SimpleText( LANG( "BVM_Name" ), "catherine_normal25", 0, 0, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_RIGHT )

	if ( PLUGIN:IsActive( self.ent ) ) then
		draw.SimpleText( LANG( "BVM_UI_OnlineStr" ), "catherine_normal20", w - 50, 40, Color( 50, 50, 50, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_RIGHT )
	else
		draw.SimpleText( LANG( "BVM_UI_OfflineStr" ), "catherine_normal20", w - 50, 40, Color( 50, 50, 50, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_RIGHT )
	end

	draw.SimpleText( LANG( "Cash_UI_HasStr", catherine.cash.Get( self.player ) ), "catherine_normal20", 10, 35, Color( 50, 50, 50, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_RIGHT )
end

function PANEL:InitializeBeverageVM( ent )
	self.ent = ent
	self:RefreshList( )
end

function PANEL:Think( )
	if ( ( self.entCheck or 0 ) <= CurTime( ) ) then
		if ( !IsValid( self.ent ) and !self.closeing ) then
			self:Close( )
			return
		end
		
		self.entCheck = CurTime( ) + 0.01
	end
end

function PANEL:Close( )
	if ( self.closeing ) then return end
	
	self.closeing = true
	self:AlphaTo( 0, 0.2, 0, function( )
		self:Remove( )
		self = nil
	end )
end

vgui.Register( "catherine.vgui.beverage_vm", PANEL, "DFrame" )