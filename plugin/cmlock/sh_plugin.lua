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
PLUGIN.name = "^COML_Plugin_Name"
PLUGIN.author = "Chessnut"
PLUGIN.desc = "^COML_Plugin_Desc"

catherine.language.Merge( "english", {
	[ "COML_Plugin_Name" ] = "Combine Lock",
	[ "COML_Plugin_Desc" ] = "Good stuff.",
	[ "Item_Name_ComLock" ] = "Combine Lock",
	[ "Item_Desc_ComLock" ] = "A metallic lock that is placed on doors.",
	[ "Item_FuncStr01_ComLock" ] = "Place"
} )

catherine.language.Merge( "korean", {
	[ "COML_Plugin_Name" ] = "콤바인 락",
	[ "COML_Plugin_Desc" ] = "문을 잠급니다.",
	[ "Item_Name_ComLock" ] = "콤바인 락",
	[ "Item_Desc_ComLock" ] = "문을 잠글때 사용합니다.",
	[ "Item_FuncStr01_ComLock" ] = "부착"
} )

if ( CLIENT ) then return end

function PLUGIN:DataSave( )
	local data = { }

	for k, v in pairs( ents.FindByClass( "cat_hl2rp_comlock" ) ) do
		if ( !IsValid( v.doorParent ) ) then continue end
		local ent = v.doorParent
		
		data[ #data + 1 ] = {
			index = ent:EntIndex( ),
			pos = ent:WorldToLocal( v:GetPos( ) ),
			ang = ent:WorldToLocalAngles( v:GetAngles( ) ),
			status = v:GetLocked( ) == true and true or nil
		}
	end

	catherine.data.Set( "comlock", data )
end

function PLUGIN:DataLoad( )
	for k, v in pairs( ents.GetAll( ) ) do
		for k1, v1 in pairs( catherine.data.Get( "comlock", { } ) ) do
			if ( IsValid( v ) and catherine.entity.IsDoor( v ) and v:EntIndex( ) == v1.index ) then
				local ent = ents.Create( "cat_hl2rp_comlock" )
				ent:SetPos( v:GetPos( ) )
				ent:Spawn( )
				ent:SetDoor( v, v:LocalToWorld( v1.pos ), v:LocalToWorldAngles( v1.ang ) )
				ent:SetLocked( v1.status )

				if ( v1.status ) then
					ent.doorParent:Fire( "Close" )
					ent.doorParent:Fire( "Lock" )
				end
			end
		end
	end
end