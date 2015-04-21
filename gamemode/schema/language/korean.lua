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

catherine.language.Merge( "korean", {
	// Basic
	[ "Basic_Schema_Title" ] = "하프 - 라이프 2 롤 플레잉",
	[ "Basic_Schema_Desc" ] = "이곳은 안전합니다.",
	[ "Basic_Schema_IntroTitle" ] = "2016 년, 18번 지구",
	[ "Basic_Schema_IntroDesc" ] = "이곳은 안전합니다.",
	[ "Basic_Schema_Author" ] = "%s 에 의해 개발 및 디자인.",
	
	// Cash
	[ "Cash_UI_HasStr" ] = "당신은 %s " .. catherine.configs.cashName .. " 를 가지고 있습니다.",
	[ "Cash_Notify_HasNot" ] = "당신은 충분한 " .. catherine.configs.cashName .. " 가 없습니다!",
	
	// Faction Name
	[ "Faction_Name_Citizen" ] = "시민",
	[ "Faction_Name_Administrator" ] = "관리자",
	[ "Faction_Name_OW" ] = "콤바인 군대",
	[ "Faction_Name_CP" ] = "시민 보호 기동대",
	
	// Faction Description
	[ "Faction_Desc_Citizen" ] = "더러운 옷을 입고 있습니다.",
	[ "Faction_Desc_Administrator" ] = "이 도시의 관리자 입니다.",
	[ "Faction_Desc_OW" ] = "콤바인에 의해 강제로 개조당한 기계 인간 입니다.",
	[ "Faction_Desc_CP" ] = "시민들을 보호합니다.",

	// Item
	[ "Item_Desc_Wallet" ] = catherine.configs.cashName .. " 가 쌓여있습니다.",
	[ "Item_FuncStr01_Wallet" ] = catherine.configs.cashName .. " 가지기",
	[ "Item_FuncStr02_Wallet" ] = catherine.configs.cashName .. " 떨어트리기",
	
	[ "Item_Name_LargeBag" ] = "큰 가방",
	[ "Item_Desc_LargeBag" ] = "당신의 인벤토리의 공간을 많이 늘려줍니다.",
	
	[ "Item_Name_SmallBag" ] = "작은 가방",
	[ "Item_Desc_SmallBag" ] = "당신의 인벤토리의 공간을 조금 늘려줍니다.",
	
	[ "Item_Name_CID" ] = "시민 아이디 카드",
	[ "Item_Desc_CID" ] = "당신의 정보를 보여주고 있습니다.",
	
	[ "Item_Name_PR" ] = "휴대용 라디오",
	[ "Item_Desc_PR" ] = "다른 사람들과 통신을 할 수 있습니다.",
	[ "Item_FuncStr01_PR" ] = "라디오 주파수 설정",
	[ "Item_FuncStr02_PR" ] = "전원 켜기/끄기",
	[ "Item_DataStr01_PR" ] = "주파수",
	[ "Item_DataStr02_PR" ] = "전원",
	[ "Item_DataStr02_On_PR" ] = "켜짐",
	[ "Item_DataStr02_Off_PR" ] = "꺼짐",
	
	[ "Item_RadioFreqQ_PR" ] = "라디오 주파수를 무엇으로 설정하시겠습니까?",
	[ "Item_Notify_FreqSet_PR" ] = "당신은 라디오 주파수를 %s 로 설정하셨습니다.",
	[ "Item_Notify_Error01_PR" ] = "라디오 주파수의 범위는 101.1 ~ 199.9 입니다!",
	[ "Item_Notify_Error02_PR" ] = "라디오 주파수 형식은 XXX.X 가 되어야 합니다!",
	
	[ "Item_Name_RD" ] = "신고 장치",
	[ "Item_Desc_RD" ] = "이것을 사용하면 콤바인에게 신고를 할 수 있습니다.",
	
	[ "Item_Name_SC" ] = "스프래이 캔",
	[ "Item_Desc_SC" ] = "누르면 페인트가 나와서 벽에다 그릴 수 있습니다.",

	[ "Item_Name_BW" ] = "브린 워터",
	[ "Item_Desc_BW" ] = "흔들어서 드세요.",
	
	[ "Item_Name_9MM" ] = "9MM 피스톨",
	[ "Item_Desc_9MM" ] = "기본적인 9MM 피스톨 입니다.",
	
	[ "Item_Name_AR2" ] = "AR2",
	[ "Item_Desc_AR2" ] = "강력한 화력을 자랑합니다.",
	
	[ "Item_Name_SMG" ] = "MP7",
	[ "Item_Desc_SMG" ] = "기본적인 SMG 입니다.",
	
	[ "Item_Name_SS" ] = "전기봉",
	[ "Item_Desc_SS" ] = "사람을 때려서 기절시킬 수 있습니다.",

	[ "Item_Category_Communication" ] = "통신",
	[ "Item_Category_Food" ] = "음식",
	
	[ "Item_FuncStr01_Food" ] = "먹기",
	
	// Radio
	[ "Item_Name_SR" ] = "고정식 라디오",
	[ "Item_Desc_SR" ] = "다른 사람들과 통신을 할 수 있습니다.",
	[ "Item_NoFreq" ] = "아직 주파수가 설정되지 않았습니다.",
	[ "Item_Freq" ] = "주파수 : %s.",
	[ "Item_FuncStr01_SR" ] = "라디오 주파수 설정",
	[ "Item_FuncStr02_SR" ] = "전원 켜기/끄기",
	[ "Item_RadioFreqQ_SR" ] = "라디오 주파수를 무엇으로 설정하시겠습니까?",
	[ "Item_Notify_FreqSet_SR" ] = "당신은 라디오 주파수를 %s 로 설정하셨습니다.",
	[ "Item_Notify_Error01_SR" ] = "라디오 주파수의 범위는 101.1 ~ 199.9 입니다!",
	[ "Item_Notify_Error02_SR" ] = "라디오 주파수 형식은 XXX.X 가 되어야 합니다!"
} )