--[[
    Benediction Lua Scripts
    Quest 927 - The Moss-twined Heart
    Developed by Nogar
--]]

ENV = {}

function Denalan_OnConcludeQuest(Unit, QuestId, Player)
	if QuestId == 927 then
		Unit:SetNpcFlags(0) -- removing gossip temporarely to avoid overlap of other players starting other scripts
		Unit:SendScriptTextById(13, 1126) -- emote 
		Unit:CastSpell(Unit, 1804, false) -- dummy spell to "inspect" the heart
		if ENV.EmoteTimer == nil then -- creating timer for the second emote /say
			ENV.EmoteTimer = true
			Unit:CreateTimer("Emote",4000)
		end
	end
end

function Denalan_AIUpdate(Unit, mapScript, timeDiff)
	Unit:UpdateTimers(timeDiff)
	if Unit:IsTimerFinished("Emote") then
		Unit:RemoveTimer("Emote")
		ENV.EmoteTimer = nil
		Unit:SendScriptTextById(11, 1127) -- emote
		Unit:EnterEvadeMode() -- interrupting the mentioned dummy spell
		Unit:SetNpcFlags(2) -- re-activating gossip
	end
end

RegisterUnitEvent(2080, 17,  "Denalan_OnConcludeQuest")
RegisterUnitEvent(2080, 23,  "Denalan_AIUpdate")


