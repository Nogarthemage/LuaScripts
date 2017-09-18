--[[
    Benediction Lua Scripts
    Quest 5648 - Garments of Spirituality
    Developed by Nogar
--]]

local Script = {}

-- LUA_EVENT_ON_INITIALIZE_QUEST(16)
function Script.Calvin_OnInitializeQuest(Unit, QuestId, Player)
	if QuestId == 590 then
		Script.playerUnit = Player
		Unit:SetTemporaryFaction(7) -- Make the npc hostile
		Unit:SetNpcFlags(0) -- remove gossip capabilities
		Unit:StartCombat(Player) -- attack the player who initiated the quest
	end
end

function Script.Calvin_HealthPerc(Unit, hpPerc)
	if not (Script.playerUnit) then return end
	local Perc = 15 -- HP on wich he will turn normal again
	if Unit:GetHealthPct() <= Perc then
		Unit:RemoveAllNegativeAuras() -- remove DoTs and other debuffs to prevent abuse
		Unit:RemoveAllNonPassiveAuras() -- safety precautions
		Unit:ClearTemporaryFaction() -- turn him back into friendly
		Unit:SetHealthPct(100) -- heal him to 100% HP
		Unit:SetNpcFlags(2) -- Add gossip capabilites again
		local QuestLogEntry = Script.playerUnit:GetQuestLogEntry(590) 
		QuestLogEntry:AddKill(0,Unit:GetGuid()) -- completing the quest for the player
		QuestLogEntry:UpdatePlayerFields()
	end
end

function Script.Calvin_CombatEnd(Unit)
	Unit:ClearTemporaryFaction() -- turn him back into friendly
	Unit:RemoveAllNegativeAuras()    -- remove DoTs and other debuffs to prevent abuse
	Unit:RemoveAllNonPassiveAuras()  -- safety precautions
	Unit:SetHealthPct(100)  -- heal him to 100% HP
	Unit:SetNpcFlags(2)     -- Add gossip capabilites again
	
end



RegisterUnitEvent(6784, 16,  Script.Calvin_OnInitializeQuest)
RegisterUnitEvent(6784, 5,  Script.Calvin_HealthPerc)
RegisterUnitEvent(6784, 4,  Script.Calvin_CombatEnd)



-- update kt_world.creature_spawns set unitflags = 256 where entry = 7980;
-- update kt_world.creature_proto set JadeFlags = 2 where entry = 6784;
-- update kt_world.creature_spawns set orientation = 1.22 where entry = 6784;
-- update kt_world.quests set previousquestID = 8 where questid in (590);












