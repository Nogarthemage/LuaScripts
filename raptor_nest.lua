--[[
    Benediction Lua Scripts
    Quest 905 - The Brood of Onyxia
    Developed by Nogar
--]]

local Script = {}

function Script.RedRaptor_Init(GO, Player)
	if Player ~= nil and Player:HasQuest(905) == true then
		Script.QuestLogEntryRed = Player:GetQuestLogEntry(905)
		Script.QuestLogEntryRed:AddKill(2, 6906)
		Script.QuestLogEntryRed:UpdatePlayerFields()
	end
end

function Script.BlueRaptor_Init(GO, Player)
	if Player ~= nil and Player:HasQuest(905) == true then
		Script.QuestLogEntryBlue = Player:GetQuestLogEntry(905)
		Script.QuestLogEntryBlue:AddKill(0, 6907)
		Script.QuestLogEntryBlue:UpdatePlayerFields()
	end
end

function Script.YellowRaptor_Init(GO, Player)
	if Player ~= nil and Player:HasQuest(905) == true then
		Script.QuestLogEntryYellow = Player:GetQuestLogEntry(905)
		Script.QuestLogEntryYellow:AddKill(1, 6908)
		Script.QuestLogEntryYellow:UpdatePlayerFields()
	end
end

RegisterGameObjectEvent(6906, 3, Script.RedRaptor_Init)
RegisterGameObjectEvent(6907, 3, Script.BlueRaptor_Init) 
RegisterGameObjectEvent(6908, 3, Script.YellowRaptor_Init) 

-- update kt_world.items set spellcharges_1 = -1 where entry = 5165;
-- update kt_world.quests set requiredspellcast1 = 0, requiredspellcast2 = 0, requiredspellcast3 = 0, requiredspellcast4 = 0, ObjectiveTexts4 = '' , RequiredMobsCount1 = 1 where questid = 905;

