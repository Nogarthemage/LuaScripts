--[[
    Benediction Lua Scripts
    Quest 5648 - Garments of Spirituality
    Developed by Nogar
--]]

ENV = {}

-- LUA_EVENT_ON_INITIALIZE_QUEST(16)
function Calvin_OnInitializeQuest(Unit, QuestId, Player)
	if ENV.ReturnTimer == nil then -- timer to reset the npc for other or current players to initiate the quest
		ENV.ReturnTimer = true
		Unit:CreateTimer("CombatResetTimer",60000)
	end
	ENV.playerUnit = Player
	Unit:SetTemporaryFaction(7) -- Make the npc hostile
	Unit:SetNpcFlags(0) -- remove gossip capabilities
	Unit:StartCombat(Player) -- attack the player who initiated the quest

	
	
end

function Calvin_HealthPerc(Unit, hpPerc)
	if not (ENV.playerUnit) then return end
	local Perc = 15 -- HP on wich he will turn normal again
	if Unit:GetHealthPct() <= Perc then
	Unit:RemoveAllNegativeAuras() -- remove DoTs and other debuffs to prevent abuse
	Unit:RemoveAllNonPassiveAuras() -- safety precautions
	Unit:ClearTemporaryFaction() -- turn him back into friendly
	Unit:SetHealthPct(100) -- heal him to 100% HP
	Unit:SetNpcFlags(2) -- Add gossip capabilites again
	ENV.ReturnTimer = nil
	Unit:RemoveTimer("CombatResetTimer") 
	local QuestLogEntry = ENV.playerUnit:GetQuestLogEntry(590) 
	QuestLogEntry:AddKill(0,Unit:GetGuid()) -- completing the quest for the player
	QuestLogEntry:UpdatePlayerFields()
	
		
	end
end

function Calvin_AIUpdate(Unit, mapScript, timeDiff)
	Unit:UpdateTimers(timeDiff)
	if Unit:IsTimerFinished("CombatResetTimer") then 
        Unit:RemoveTimer("CombatResetTimer")
		Unit:ClearTemporaryFaction() -- turn him back into friendly
		Unit:RemoveAllNegativeAuras()    -- remove DoTs and other debuffs to prevent abuse
		Unit:RemoveAllNonPassiveAuras()  -- safety precautions
		Unit:SetHealthPct(100)  -- heal him to 100% HP
		Unit:SetNpcFlags(2)     -- Add gossip capabilites again
		ENV.ReturnTimer = nil
	end
end



RegisterUnitEvent(6784, 16,  "Calvin_OnInitializeQuest")
RegisterUnitEvent(6784, 5,  "Calvin_HealthPerc")
RegisterUnitEvent(6784, 23,  "Calvin_AIUpdate")



-- update kt_world.creature_spawns set unitflags = 256 where entry = 7980;
-- update kt_world.creature_proto set JadeFlags = 2 where entry = 6784;
-- update kt_world.creature_spawns set orientation = 1.22 where entry = 6784;
-- update kt_world.quests set previousquestID = 8 where questid in (590);












