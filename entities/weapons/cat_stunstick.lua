AddCSLuaFile( )

SWEP.PrintName = "Stunstick"
SWEP.Author = "Chessnut"
SWEP.HoldType = "melee"
SWEP.ViewModelFOV = 47
SWEP.ViewModelFlip = false
SWEP.AnimPrefix	 = "melee"
SWEP.ViewTranslation = 4

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""
SWEP.Primary.Damage = 7.5
SWEP.Primary.Delay = 0.7

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

SWEP.ViewModel = Model( "models/weapons/c_stunstick.mdl" )
SWEP.WorldModel = Model( "models/weapons/w_stunbaton.mdl" )

SWEP.LowerAngles = Angle( 15, -10, -20 )
SWEP.CanFireLowered = true

function SWEP:SetupDataTables( )
	self:NetworkVar( "Bool", 0, "Active" )
end

function SWEP:Precache( )
	util.PrecacheSound( "weapons/stunstick/spark1.wav" )
	util.PrecacheSound( "weapons/stunstick/spark2.wav" )
	util.PrecacheSound( "weapons/stunstick/spark3.wav" )
	util.PrecacheSound( "weapons/stunstick/stunstick_swing1.wav" )
	util.PrecacheSound( "weapons/stunstick/stunstick_swing2.wav" )
	util.PrecacheSound( "weapons/stunstick/stunstick_impact1.wav" )	
	util.PrecacheSound( "weapons/stunstick/stunstick_impact2.wav" )
end

function SWEP:Initialize( )
	self:SetWeaponHoldType( self.HoldType )
end

function SWEP:OnLowered()
	self:SetActive(false)
end

function SWEP:PrimaryAttack( )
	local pl = self.Owner
	
	self:SetNextPrimaryFire( CurTime( ) + self.Primary.Delay )
	
	if ( !pl:GetWeaponRaised( ) ) then return end
	
	if ( pl:KeyDown( IN_WALK ) ) then
		if ( SERVER ) then
			self:SetActive( !self:GetActive( ) )
			
			local seq = "deactivatebaton"
			
			if ( self:GetActive( ) ) then
				pl:EmitSound( "weapons/stunstick/spark3.wav", 100, math.random( 70, 130 ) )
				seq = "activatebaton"
			else
				pl:EmitSound( "weapons/stunstick/spark" .. math.random( 1, 2 ) .. ".wav", 100, math.random( 70, 130 ) )
			end

			if ( catherine.animation.Get( pl:GetModel( ) ) == "metrocop" ) then
				catherine.animation.SetSeqAnimation( pl, seq )
			end
		end
		
		return
	end
	
	local dmg = self.Primary.Damage

	if ( self:GetActive( ) ) then
		dmg = dmg + 15
	end

	self:EmitSound( "weapons/stunstick/stunstick_swing" .. math.random( 1, 2 ) .. ".wav" )
	self:SendWeaponAnim( ACT_VM_HITCENTER )
	pl:SetAnimation( PLAYER_ATTACK1 )
	pl:ViewPunch( Angle( 1, 0, 0.125 ) )
	
	pl:LagCompensation( true )
	
	local data = { }
	data.start = pl:GetShootPos( )
	data.endpos = data.start + pl:GetAimVector( ) * 80
	data.filter = pl
	local tr = util.TraceLine( data )
	
	pl:LagCompensation( false )

	if ( SERVER and tr.Hit ) then
		if ( self:GetActive( ) ) then
			local eff = EffectData( )
			eff:SetStart( tr.HitPos )
			eff:SetOrigin( tr.HitPos )
			eff:SetNormal( tr.HitNormal )
			util.Effect( "StunstickImpact", eff, true, true )
		end

		pl:EmitSound( "weapons/stunstick/stunstick_impact" .. math.random( 1, 2 ) .. ".wav" )

		local ent = tr.Entity

		if ( IsValid( ent ) ) then
			if ( ent:IsPlayer( ) ) then
				if ( self:GetActive( ) ) then
					catherine.util.ScreenColorEffect( ent, Color( 255, 255, 255 ), 0.5, 0.001 )
				else
					catherine.util.ScreenColorEffect( ent, nil, 2, 0.005 )
				end

				ent:ViewPunch( Angle( -20, math.random( -15, 15 ), math.random( -10, 10 ) ) )

				if ( self:GetActive( ) and entity:Health( ) - dmg <= 0 ) then
					catherine.player.RagdollWork( ent, true, 60 )
					ent:SetHealth( 50 )

					return
				end
			elseif ( ent:GetClass( ) == "prop_ragdoll" ) then
				dmg = self:GetActive( ) and 2 or 10
			end

			local dmgInfo = DamageInfo( )
			dmgInfo:SetInflictor( self )
			dmgInfo:SetAttacker( pl )
			dmgInfo:SetDamage( dmg )
			dmgInfo:SetDamageType( DMG_CLUB )
			dmgInfo:SetDamagePosition( tr.HitPos )
			dmgInfo:SetDamageForce( pl:GetAimVector( ) * 100000 )
			
			ent:DispatchTraceAttack( dmgInfo, data.start, data.endpos )
		end
	end
end

function SWEP:SecondaryAttack( )
	local pl = self.Owner
	
	pl:LagCompensation( true )
	
	local data = { }
	data.start = pl:GetShootPos( )
	data.endpos = data.start + pl:GetAimVector( ) * 72
	data.filter = pl
	data.mins = Vector( -8, -8, -30 )
	data.maxs = Vector( 8, 8, 10 )
	local tr = util.TraceHull( data )
	local ent = tr.Entity
	
	pl:LagCompensation( false )

	if ( SERVER and IsValid( ent ) ) then
		local pushed = false

		if ( catherine.entity.IsDoor( ent ) ) then
			pl:ViewPunch( Angle( -1.3, 1.8, 0 ) )
			pl:EmitSound( "physics/plastic/plastic_box_impact_hard" .. math.random( 1, 4 ) .. ".wav" )	
			pl:SetAnimation( PLAYER_ATTACK1 )

			self:SetNextSecondaryFire( CurTime( ) + 0.4 )
			self:SetNextPrimaryFire( CurTime( ) + 1 )
		elseif ( ent:IsPlayer( ) ) then
			local direct = self.Owner:GetAimVector( ) * 10
			direct.z = 0

			entity:SetVelocity( direct )

			pushed = true
		else
			local physObject = ent:GetPhysicsObject( )

			if ( IsValid( physObject ) ) then
				physObject:SetVelocity( pl:GetAimVector( ) * 180 )
			end

			pushed = true
		end

		if ( pushed ) then
			self:SetNextSecondaryFire( CurTime( ) + 1.5 )
			self:SetNextPrimaryFire( CurTime( ) + 1.5 )
			pl:EmitSound( "weapons/crossbow/hitbod" .. math.random( 1, 2 ) .. ".wav" )

			if ( catherine.animation.Get( pl:GetModel( ) ) == "metrocop") then
				catherine.animation.SetSeqAnimation( pl, "pushplayer", nil, function( )

				end, function( )

				end )
			end
		end
	end
end

local STUNSTICK_GLOW_MATERIAL = Material( "effects/stunstick" )
local STUNSTICK_GLOW_MATERIAL2 = Material( "effects/blueflare1" )
local STUNSTICK_GLOW_MATERIAL_NOZ = Material( "sprites/light_glow02_add_noz" )
local col_glow = Color( 128, 128, 128 )

function SWEP:DrawWorldModel( )
	self:DrawModel( )

	if ( self:GetActive( ) ) then
		local size = math.Rand( 4.0, 6.0 )
		local glow = math.Rand( 0.6, 0.8 ) * 255
		local att = self:GetAttachment( 1 )

		if ( att ) then
			local pos = att.Pos

			render.SetMaterial( STUNSTICK_GLOW_MATERIAL2 )
			render.DrawSprite( pos, size * 2, size * 2, Color( glow, glow, glow ) )

			render.SetMaterial( STUNSTICK_GLOW_MATERIAL )
			render.DrawSprite( pos, size, size + 3, col_glow )
		end
	end
end

function SWEP:ViewModelDrawn( )
	if ( !self:GetActive( ) ) then
		return
	end

	local viewModel = LocalPlayer( ):GetViewModel( )

	if ( !IsValid( viewMdl ) ) then
		return
	end

	cam.Start3D( EyePos( ), EyeAngles( ) )
		local size = math.Rand( 3.0, 4.0 )
		local col = Color( 255, 255, 255, 100 + math.sin( RealTime( ) * 2 ) * 20 )

		STUNSTICK_GLOW_MATERIAL_NOZ:SetFloat( "$alpha", col.a / 255 )

		render.SetMaterial( STUNSTICK_GLOW_MATERIAL_NOZ )

		local att = viewMdl:GetAttachment( viewMdl:LookupAttachment( "sparkrear" ) )

		if ( att ) then
			render.DrawSprite( att.Pos, size * 10, size * 15, col)
		end

		for i = 1, 9 do
			local att = viewMdl:GetAttachment( viewMdl:LookupAttachment( "spark" .. i .. "a" ) )

			size = math.Rand( 2.5, 5.0 )

			if ( att and att.Pos ) then
				render.DrawSprite( att.Pos, size, size, col )
			end

			local att = viewMdl:GetAttachment( viewMdl:LookupAttachment( "spark" .. i .. "b" ) )

			size = math.Rand( 2.5, 5.0 )

			if ( att and att.Pos ) then
				render.DrawSprite( att.Pos, size, size, col )
			end
		end
	cam.End3D( )
end