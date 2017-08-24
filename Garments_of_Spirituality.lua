--[[
    Benediction Lua Scripts
    Quest 5648 - Garments of Spirituality
    Developed by Nogar
--]]
ENV = {}
local spells = {["heal"]=2052,["fort"]=1243}
local questID = 5648 -- 5648 for orc and troll, 5650 - undead, 5624 - human, 5625 - dwarf, 5621 - night elf



function PriestQUnit_OnSpawn(Unit)
    Unit:SetHealthPct(30)
end

function PriestQUnit_OnAIUpdate(Unit, mapScript, timeDiff)
    Unit:UpdateTimers(timeDiff)
    if Unit:IsTimerFinished("HPResetTimer") then
        Unit:RemoveTimer("HPResetTimer")
        ENV.hpTimer = nil
		Unit:RemoveAllNonPassiveAuras() 
        Unit:SetHealthPct(30)
		
    end
end



function PriestQUnit_OnSpellTaken(Unit, Attacker, Spell)
	
    if ENV.hpTimer == nil then
        ENV.hpTimer = true
        Unit:CreateTimer("HPResetTimer",10000)
	else Unit:ResetTimer("HPResetTimer",10000)
    end
	if Attacker:IsPlayer() and Attacker:HasQuest(questID) then
		if not Attacker:CanBeFinished(questID) then
			sPlayerGuid = tostring(Attacker:GetGuid())
			if ENV[sPlayerGuid].counter == nil then ENV[sPlayerGuid].counter = 0 end
			ENV[sPlayerGuid] = ENV[sPlayerGuid] ~= nil and ENV[sPlayerGuid] or {}
			ENV[sPlayerGuid].spells_casted = ENV[sPlayerGuid].spells_casted ~= nil and ENV[sPlayerGuid].spells_casted or {}        
			local spellId = Spell:GetSpellId()
			if (spellId == spells.heal) or (spellId == spells.fort) then 
				if ENV[sPlayerGuid].counter == 0 then 
					if ENV[sPlayerGuid].spells_casted[spellId] == nil then
						Unit:SendScriptTextById(11, 7782)
						ENV[sPlayerGuid].counter = 1
					end
					ENV[sPlayerGuid].spells_casted[spellId] = true
				end	
				if ENV[sPlayerGuid].counter == 1 then
					if ENV[sPlayerGuid].spells_casted[spellId] == nil then
						Unit:SendScriptTextById(11, 7784)
					end
					ENV[sPlayerGuid].spells_casted[spellId] = true
				end
			end
			if ENV[sPlayerGuid].spells_casted[spells.heal] ~= nil and ENV[sPlayerGuid].spells_casted[spells.fort] ~= nil then
				local QuestLogEntry = Attacker:GetQuestLogEntry(questID)
				QuestLogEntry:AddKill(0,Unit:GetGuid())
				QuestLogEntry:UpdatePlayerFields()
			end
		end
	end
end


function PriestQ_InitializeQuest(Unit, QuestId, Player)
	sPlayerGuid = tostring(Player:GetGuid())
	ENV[sPlayerGuid] = {}
	ENV[sPlayerGuid].counter = 0
	ENV[sPlayerGuid].spells_casted = {}
	ENV[sPlayerGuid].spells_casted[spells.fort] = nil
	ENV[sPlayerGuid].spells_casted[spells.heal] = nil
end

-- Grunt Kor'ja
RegisterUnitEvent(12430, 1,  "PriestQUnit_OnSpawn")
RegisterUnitEvent(12430, 23, "PriestQUnit_OnAIUpdate")
RegisterUnitEvent(12430, 11, "PriestQUnit_OnSpellTaken")

RegisterUnitEvent(3706, 16, "PriestQ_InitializeQuest")


--	12428 Deathguard Kel
RegisterUnitEvent(12428, 1,  "PriestQUnit_OnSpawn")
RegisterUnitEvent(12428, 23, "PriestQUnit_OnAIUpdate")
RegisterUnitEvent(12428, 16, "PriestQUnit_OnSpellTaken")

-- 	12423 Guard Roberts
RegisterUnitEvent(12423, 1,  "PriestQUnit_OnSpawn")
RegisterUnitEvent(12423, 23, "PriestQUnit_OnAIUpdate")
RegisterUnitEvent(12423, 16, "PriestQUnit_OnSpellTaken")

--	12427 Mountaineer Dolf
RegisterUnitEvent(12427, 1,  "PriestQUnit_OnSpawn")
RegisterUnitEvent(12427, 23, "PriestQUnit_OnAIUpdate")
RegisterUnitEvent(12427, 16, "PriestQUnit_OnSpellTaken")

--	12429 Sentinel Shaya
RegisterUnitEvent(12429, 1,  "PriestQUnit_OnSpawn")
RegisterUnitEvent(12429, 23, "PriestQUnit_OnAIUpdate")
RegisterUnitEvent(12429, 16, "PriestQUnit_OnSpellTaken")











