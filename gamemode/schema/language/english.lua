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

catherine.language.Merge( "english", {
	// Basic
	[ "Basic_Schema_Title" ] = "Half - Life 2 Role Play",
	[ "Basic_Schema_Desc" ] = "This place is safe.",
	[ "Basic_Schema_IntroTitle" ] = "City 18, 2016",
	[ "Basic_Schema_IntroDesc" ] = "This place is safe.",
	[ "Basic_Schema_Author" ] = "Development and design by %s.",
	
	// Cash
	[ "Cash_UI_HasStr" ] = "You have a %s " .. catherine.configs.cashName ..".",
	[ "Cash_Notify_HasNot" ] = "You don't have a enough " .. catherine.configs.cashName .. "!",
	
	// Faction Name
	[ "Faction_Name_Citizen" ] = "Citizen",
	[ "Faction_Name_Administrator" ] = "Administrator",
	[ "Faction_Name_OW" ] = "Overwatch Transhuman Arm",
	[ "Faction_Name_CP" ] = "Civil Protection",
	
	// Faction Description
	[ "Faction_Desc_Citizen" ] = "He wears a dirty shirt.",
	[ "Faction_Desc_Administrator" ] = "A city administrator.",
	[ "Faction_Desc_OW" ] = "Mechanised Infantry units utilized to combat the ongoing insurgency, these units are the elite of the combine's forces.",
	[ "Faction_Desc_CP" ] = "These units are the brunt of the combine's forces. These units are well-trained military units but they also take part policing the population.",

	// Item
	[ "Item_Desc_Wallet" ] = catherine.configs.cashName .. " in a small stack.",
	[ "Item_FuncStr01_Wallet" ] = "Take " .. catherine.configs.cashName,
	[ "Item_FuncStr02_Wallet" ] = "Drop " .. catherine.configs.cashName,
	
	[ "Item_Name_LargeBag" ] = "Large bag",
	[ "Item_Desc_LargeBag" ] = "This item adds more inventory space!",
	
	[ "Item_Name_SmallBag" ] = "Small bag",
	[ "Item_Desc_SmallBag" ] = "This item adds more inventory space!",
	
	[ "Item_Name_CID" ] = "Citizen ID Card",
	[ "Item_Desc_CID" ] = "The Citizen ID Card.",
	
	[ "Item_Name_PR" ] = "Portable Radio",
	[ "Item_Desc_PR" ] = "Communication to other humans.",
	[ "Item_FuncStr01_PR" ] = "Set Frequency",
	[ "Item_FuncStr02_PR" ] = "Toggle",
	[ "Item_DataStr01_PR" ] = "Frequency",
	[ "Item_DataStr02_PR" ] = "Power",
	[ "Item_DataStr02_On_PR" ] = "On",
	[ "Item_DataStr02_Off_PR" ] = "Off",
	
	[ "Item_RadioFreqQ_PR" ] = "Would you like to setting frequency for radio?",
	[ "Item_Notify_FreqSet_PR" ] = "You are set portable radio frequency to %s.",
	[ "Item_Notify_Error01_PR" ] = "Radio frequency is must be 101.1 ~ 199.9!",
	[ "Item_Notify_Error02_PR" ] = "Radio frequency is must be XXX.X!",
	
	[ "Item_Name_RD" ] = "Request Device",
	[ "Item_Desc_RD" ] = "If you have this, your can request it to combine.",

	[ "Item_Name_SC" ] = "Spray Can",
	[ "Item_Desc_SC" ] = "If you have this, your can spray it to wall.",
	
	[ "Item_Name_BW" ] = "Breen Water",
	[ "Item_Desc_BW" ] = "Shake and eat!",
	
	[ "Item_Name_9MM" ] = ".9mm Pistol",
	[ "Item_Desc_9MM" ] = "A standard .9mm Pistol.",
	
	[ "Item_Name_AR2" ] = "AR2",
	[ "Item_Desc_AR2" ] = "The corp combine.",
	
	[ "Item_Name_SMG" ] = "SMG",
	[ "Item_Desc_SMG" ] = "The simple sub machine gun.",
	
	[ "Item_Name_357" ] = ".357 Magnum",
	[ "Item_Desc_357" ] = "A shiny pistol with 6 chambers that appear to rotate.",
	
	[ "Item_Name_CB" ] = "Crossbow",
	[ "Item_Desc_CB" ] = "A massive crossbow that seems to have the ability to heat up metal bars.",
	
	[ "Item_Name_Buckshot" ] = "Shotgun",
	[ "Item_Desc_Buckshot" ] = "A metallic shotgun that has some sort of combine materials added onto the gun near the trigger.",
	
	[ "Item_Name_RPG" ] = "Rocket Lancher",
	[ "Item_Desc_RPG" ] = "A large black tube containing a lot of firepower.",
	
	[ "Item_Name_CrowB" ] = "Crowbar",
	[ "Item_Desc_CrowB" ] = "A rusted tool that looks like it has seen better days.",
	
	[ "Item_Name_SS" ] = "Stunstick",
	[ "Item_Desc_SS" ] = "An electrified baton powered by a mysterious combine battery.",
	
	[ "Item_Name_ZT" ] = "Zip Tie",
	[ "Item_Desc_ZT" ] = "Tie to player.",
	[ "Item_FuncStr01_ZT" ] = "Tie",

	[ "Item_Category_Communication" ] = "Communication",
	[ "Item_Category_Food" ] = "Food",
	[ "Item_FuncStr01_Food" ] = "Eat",
	
	[ "Item_Name_PistolAmmo" ] = ".9mm Pistol Rounds",
	[ "Item_Desc_PistolAmmo" ] = "A greenish catridge with the 9mm label on the side.",
	
	[ "Item_Name_AR2Ammo" ] = "Pulse Energy Cartridge",
	[ "Item_Desc_AR2Ammo" ] = "A curved piece of metal with glowing blue pieces.",
	
	[ "Item_Name_SMGAmmo" ] = "SMG Round",
	[ "Item_Desc_SMGAmmo" ] = "A light teal box with some inscriptions on the side.",
	
	[ "Item_Name_SMG_G_Ammo" ] = "SMG Grenade",
	[ "Item_Desc_SMG_G_Ammo" ] = "A greenish grenade shaped like a bullet.",
	
	[ "Item_Name_Buckshot_Ammo" ] = "Buckshot Shells",
	[ "Item_Desc_Buckshot_Ammo" ] = "A red box with the Salvotech logo on it.",
	
	[ "Item_Name_Crossbow_Ammo" ] = "Crossbow Bolts",
	[ "Item_Desc_Crossbow_Ammo" ] = "An orange colored conductive metal bolt.",
	
	[ "Item_Name_RPGAmmo" ] = "RPG Rocket",
	[ "Item_Desc_RPGAmmo" ] = "A rocket with a grey tip and orange body.",
	
	[ "Item_Name_357Ammo" ] = ".357 Magnum Rounds",
	[ "Item_Desc_357Ammo" ] = "An orange and black container with Magnum on the side.",
	
	[ "Item_Name_CBAmmo" ] = "Energy Orb Cell",
	[ "Item_Desc_CBAmmo" ] = "A small cylindrical piece of material with an orange glow.",
	
	// Radio
	[ "Item_Name_SR" ] = "Static Radio",
	[ "Item_Desc_SR" ] = "Communication to other humans.",
	[ "Item_NoFreq" ] = "No frequency has been set.",
	[ "Item_Freq" ] = "Frequency set to %s.",
	[ "Item_FuncStr01_SR" ] = "Set Frequency",
	[ "Item_FuncStr02_SR" ] = "Toggle",
	[ "Item_RadioFreqQ_SR" ] = "Would you like to setting frequency for radio?",
	[ "Item_Notify_FreqSet_SR" ] = "You are set portable radio frequency to %s.",
	[ "Item_Notify_Error01_SR" ] = "Radio frequency is must be 101.1 ~ 199.9!",
	[ "Item_Notify_Error02_SR" ] = "Radio frequency is must be XXX.X!",
	
	// Chat
	[ "Chat_Dispatch" ] = "Combine Dispatch - %s",
	[ "Chat_Radio" ] = "%s radio says %s",
	[ "Chat_Request" ] = "%s reqeust says %s",
	
	// Combine Overlay
	[ "CombineOverlay_Str01" ] = "Waiting for biosignal ...",
	[ "CombineOverlay_Str02" ] = "Initializing Heads-up-display ...",
	[ "CombineOverlay_Str03" ] = "Ascertaining low-wave radio frequency ...",
	[ "CombineOverlay_Str04" ] = "Finding seeders ...",
	[ "CombineOverlay_Str05" ] = "Finding peers ...",
	[ "CombineOverlay_Str06" ] = "Regaining CAT-equalization ...",
	[ "CombineOverlay_Str07" ] = "Receiving network messages ...",
	[ "CombineOverlay_Str08" ] = "Registering Citadel messages ...",
	[ "CombineOverlay_Str09" ] = "Idle state ...",
	
	[ "CombineOverlay_Request" ] = "%s's request - %s",
	[ "CombineOverlay_HealthFullRecovered" ] = "Vital signs recovered ...",
	[ "CombineOverlay_TakeDmg_Local" ] = "WARNING ! Physical bodily trauma detected ...",
	[ "CombineOverlay_TakeDmg_NoLocal" ] = "WARNING ! Unit '%s' has damaged by unknown problems ...",
	[ "CombineOverlay_HealthRecovering" ] = "Vital signs recovering [%s%] ...",
	[ "CombineOverlay_LocalPlayerDeath_CP" ] = "ERROR ! Shut Down - ...",
	[ "CombineOverlay_LocalPlayerDeath_OW" ] = "Critical Error - ...",
	[ "CombineOverlay_PlayerDeath_CP" ] = "WARNING ! Unit '%s' vital signs absent, alerting dispatch ...",
	[ "CombineOverlay_PlayerDeath_OW" ] = "WARNING ! Overwatch Unit '%s' vital signs absent, alerting dispatch ...",
	[ "CombineOverlay_Online" ] = "Online ...",
	[ "CombineOverlay_RFCitizens" ] = "Refreshing citizen lists ...",
	
	// Attribute
	[ "Jump_Title" ] = "Jump",
	[ "Jump_Desc" ] = "",
} )