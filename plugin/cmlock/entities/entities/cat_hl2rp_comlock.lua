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
ENT.PrintName = "Catherine HL2RP Combine Lock"
ENT.Author = "Chessnut"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.PhysgunDisable = true

function ENT:SetupDataTables( )
	self:NetworkVar( "Bool", 0, "Locked" )
	self:NetworkVar( "Bool", 1, "Error" )
end

if ( SERVER ) then
	function ENT:Initialize( )
		self:SetModel( "models/props_combine/combine_lock01.mdl" )
		self:SetSolid( SOLID_VPHYSICS )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
		self:SetUseType( SIMPLE_USE )
	end
	
	function ENT:Use( pl )
		if ( self:GetError( ) ) then
			return
		end
		
		if ( ( pl.CAT_HL2RP_nextcomLUse or 0 ) <= CurTime( ) ) then
			pl.CAT_HL2RP_nextcomLUse = CurTime( ) + 1
		else
			return
		end
		
		if ( !pl:PlayerIsCombine( ) and pl:Team( ) != FACTION_ADMIN ) then
			self:DoError( )
			return
		end
		
		self:Toggle( )
	end
	
	function ENT:DoError( )
		self:EmitSound( "buttons/combine_button_locked.wav" )
		self:SetError( true )
		
		timer.Create( "Catherine.HL2RP.timer.ComLock." .. self:EntIndex( ), 1, 2, function( )
			if ( IsValid( self ) ) then
				self:SetError( false )
			end
		end )
	end
	
	function ENT:Toggle( ) // need partner!
		if ( self:GetLocked( ) ) then
			self:EmitSound( "buttons/combine_button7.wav" )
			self.doorParent:Fire( "UnLock" )
			self:SetLocked( false )
		else
			self:EmitSound( "buttons/combine_button2.wav" )
			self.doorParent:Fire( "Close" )
			self.doorParent:Fire( "Lock" )
			self:SetLocked( true )
		end
	end
	
	function ENT:GetPlacePosition( pl, ent )
		local index, index2 = ent:LookupBone( "handle" )
		local eyeTrace = pl:GetEyeTrace( )
		local eyeTraceNormal = eyeTrace.HitNormal:Angle( )
		local eyeTracePos = ( index and index >= 1 ) and ent:GetBonePosition( index ) or eyeTrace.HitPos
		
		eyeTracePos = eyeTracePos + eyeTraceNormal:Forward( ) * 7 + eyeTraceNormal:Up( ) * 10
		
		eyeTraceNormal:RotateAroundAxis( eyeTraceNormal:Up( ), 90 )
		eyeTraceNormal:RotateAroundAxis( eyeTraceNormal:Forward( ), 180 )
		eyeTraceNormal:RotateAroundAxis( eyeTraceNormal:Right( ), 180 )
		
		return eyeTracePos, eyeTraceNormal
	end
	
	function ENT:SetDoor( ent, pos, ang )
		if ( !IsValid( ent ) ) then return end
		
		self.doorParent = ent
		ent.lock = self
		
		self:SetPos( pos )
		self:SetAngles( ang )
		self:SetParent( ent )
	end
	
	function ENT:OnRemove( )
		if ( IsValid( self.doorParent ) ) then
			self.doorParent:Fire( "UnLock" )
		end
	end
else
	local mat = Material( "sprites/glow04_noz" )
	local co = Color( 255, 125, 0 )
	local cg = Color( 0, 255, 0 )
	local cr = Color( 255, 0, 0 )

	function ENT:Draw()
		self:DrawModel( )

		local pos = self:GetPos( ) + self:GetUp( ) * -8.7 + self:GetForward( ) * -3.85 + self:GetRight( ) * -6
		local col = self:GetLocked( ) and co or cg

		if ( self:GetError( ) ) then
			col = cr
		end

		render.SetMaterial( mat )
		render.DrawSprite( pos, 14, 14, col )
	end
end