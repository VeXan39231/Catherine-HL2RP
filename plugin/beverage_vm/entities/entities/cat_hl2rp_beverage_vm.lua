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
		self:SetNetVar( "active", true )
		
		local physObject = self.GetPhysicsObject( self )
		
		if ( IsValid( physObject ) ) then
			physObject:EnableMotion( false )
			physObject:Sleep( )
		end
	end
	
	function ENT:Use( pl )
		pl:EmitSound( "buttons/lightswitch2.wav", 60 )
		
		if ( ( self.nextCanUse or 0 ) <= CurTime( ) ) then
			self.nextCanUse = CurTime( ) + 1.5
		else
			return
		end
		
		if ( pl:PlayerIsCombine( ) ) then
			// Open derma menu
		else
			
		end
	end
else

end