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

AddCSLuaFile( )

DEFINE_BASECLASS( "base_gmodentity" )

ENT.Type = "anim"
ENT.PrintName = "Catherine HL2RP Beverage Vending Machine"
ENT.Author = "L7D"
ENT.Spawnable = false
ENT.AdminSpawnable = false

if ( SERVER ) then
	function ENT:Initialize( )
		self:SetModel( "models/props_interiors/vendingmachinesoda01a.mdl" )
		self:SetSolid( SOLID_VPHYSICS )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetUseType( SIMPLE_USE )

		local physObject = self.GetPhysicsObject( self )
		
		if ( IsValid( physObject ) ) then
			physObject:EnableMotion( false )
			physObject:Sleep( )
		end
	end
	
	function ENT:Use( pl )
		if ( ( self.nextCanUse or 0 ) <= CurTime( ) ) then
			self.nextCanUse = CurTime( ) + 1.5
		else
			return
		end
		
		netstream.Start( pl, "catherine_hl2rp.plugin.beverage_vm.MachineUse", self:EntIndex( ) )
	end
	
	function ENT:SpawnBeverage( pl, uniqueID )
		local itemPos = self:GetPos( ) + self:GetForward( ) * 19 + self:GetRight( ) * 4 + self:GetUp( ) * -35
		local ent = catherine.item.Spawn( uniqueID, itemPos )

		self:EmitSound( "buttons/button4.wav", 100 )
		self:EmitSound( "buttons/lightswitch2.wav", 100 )
	end
	
	function ENT:DoOnline( )
		self:EmitSound( "ambient/machines/thumper_startup1.wav", 60 )
	end
	
	function ENT:DoOffline( )
		self:EmitSound( "ambient/machines/thumper_shutdown1.wav", 60 )
	end
else
	local glowMat = Material( "sprites/glow04_noz" )

	function ENT:Draw( )
		self:DrawModel( )

		render.SetMaterial( glowMat )
		render.DrawSprite( self:GetPos( ) + self:GetForward( ) * 18 + self:GetRight( ) * -22.4 + self:GetUp( ) * 9.3, 10, 10, PLUGIN:IsActive( self ) and Color( 150, 255, 150 ) or Color( 255, 0, 0 ) )
	end
end