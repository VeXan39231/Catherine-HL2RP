--[[
< CATHERINE > - A free role-playing framework for Garry's Mod.
Develop by L7D.

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

local ITEM = catherine.item.New( "portable_radio" )
ITEM.name = "Portable Radio"
ITEM.desc = "Communication to other humans."
ITEM.cost = 300
ITEM.model = "models/items/battery.mdl"
ITEM.weight = 1
ITEM.category = "Communication"
ITEM.itemData = {
	freq = "xxx.x",
	toggle = false
}
ITEM.func = { }
ITEM.func.setfreq = {
	text = "Set Frequency",
	canShowIsMenu = true,
	func = function( pl, itemTable )
		local itemData = pl:GetInvItemDatas( itemTable.uniqueID )
		catherine.util.UniqueStringReceiver( pl, "PortableRadio_UniqueSetFreq", "Set Radio Frequency", "What are you setting for radio?", itemData.freq or "xxx.x", function( _, val )
			if ( val:find( "^%d%d%d%.%d$" ) ) then
				local one, two, three = val:match( "(%d)%d(%d)%.(%d)" )
				one = tonumber( one ) two = tonumber( two ) three = tonumber( three )
				if ( one == 1 and two > 0 and two <= 9 and three > 0 and three <= 9 ) then
					pl:SetInvItemData( itemTable.uniqueID, "freq", val )
					catherine.util.Notify( pl, "You set portable radio freq to " .. val .. "." )
				else
					catherine.util.Notify( pl, "Radio freq is must be 101.1 ~ 199.9!" )
				end
			else
				catherine.util.Notify( pl, "Radio freq is must be XXX.X!" )
			end
		end )
	end
}
ITEM.func.toggle = {
	text = "Toggle",
	icon = "icon16/accept.png",
	canShowIsMenu = true,
	func = function( pl, itemTable )
		local itemData = pl:GetInvItemDatas( itemTable.uniqueID )
		pl:SetInvItemData( itemTable.uniqueID, "toggle", !itemData.toggle )
	end
}

if ( CLIENT ) then
	function ITEM:DrawInformation( pl, itemTable, w, h, itemData )
		if ( itemData.toggle ) then
			surface.SetDrawColor( 255, 255, 255, 255 )
			surface.SetMaterial( Material( "icon16/accept.png" ) )
			surface.DrawTexturedRect( 5, 5, 16, 16 )
		end
	end
	
	function ITEM:GetDesc( pl, itemTable, itemData, isInv )
		return isInv and "Frequency : " .. ( itemData.freq and itemData.freq == "" and "xxx.x" or itemData.freq ) .. "\nPower : " .. ( itemData.toggle == true and "On" or "Off" )
	end
end

catherine.item.Register( ITEM )