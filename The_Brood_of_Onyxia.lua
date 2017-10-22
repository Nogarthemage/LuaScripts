--[[
    Benediction Lua Scripts
    Quest 1172 - The Brood of Onyxia
    Developed by Nogar
--]]

local Script = {}

function Script.OnyxiaEgg_Init(GO, Player)
	if Player:HasQuest(1172) == true then
		Script.QuestLogEntry = Player:GetQuestLogEntry(1172)
		Script.QuestLogEntry:AddKill(0, 20359)
		Script.QuestLogEntry:UpdatePlayerFields()
	end
	GO:SetState(2)
	GO:Despawn(2000, 150000)
end

RegisterGameObjectEvent(20359, 3, Script.OnyxiaEgg_Init)
