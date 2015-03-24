AddCSLuaFile( )

SWEP.PrintName = "Stunstick"
SWEP.HoldType = "melee"
SWEP.ViewModelFOV = 47
SWEP.ViewModelFlip = false
SWEP.AnimPrefix	 = "melee"

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

SWEP.UseHands = true
SWEP.LowerAngles = Angle( 15, -10, -20 )

function SWEP:SetupDataTables( )
	self:NetworkVar( "Bool", 0, "Active" )
end

function SWEP:Precache( )
	util.PrecacheSound( "weapons/stunstick/spark1.wav" )
	util.PrecacheSound( "weapons/stunstick/spark2.wav" )
	util.PrecacheSound(" weapons/stunstick/spark3.wav" )
	util.PrecacheSound( "weapons/stunstick/stunstick_swing1.wav" )
	util.PrecacheSound( "weapons/stunstick/stunstick_swing2.wav" )
	util.PrecacheSound( "weapons/stunstick/stunstick_impact1.wav" )	
	util.PrecacheSound( "weapons/stunstick/stunstick_impact2.wav" )
end

function SWEP:Initialize( )
	self:SetWeaponHoldType( self.HoldType )
end

function SWEP:PrimaryAttack( )
	local pl = self.Owner
	
	self:SetNextPrimaryFire( CurTime( ) + self.Primary.Delay )
	
	if ( !pl:GetWeaponRaised( ) ) then return end
	
	pl:SetAnimation( PLAYER_ATTACK1 )
	pl:ViewPunch( Angle( 1, 0, 0.5 ) )
	
	self:EmitSound( "weapons/stunstick/stunstick_swing" .. math.random( 1, 2 ) .. ".wav", 70 )
	self:SendWeaponAnim( ACT_VM_HITCENTER )
	
	local dmg = self:GetActive( ) and 5 or self.Primary.Damage
end