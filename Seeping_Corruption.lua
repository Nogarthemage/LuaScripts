--[[
    Benediction Lua Scripts
    Quest 3569 - Seeping Corruption
    Developed by Nogar
--]]

local Script = {}

function Script.Thersa_OnConcludeQuest(Unit, QuestId, Player)
	Script.MadScientist = Unit:GetCreatureBySqlId(30498)
	Unit:CreateTimer("Emote",3000)
	Unit:CastSpell(Unit,6355,false)
	Script.UpdateCheck = true
	Unit:SetNpcFlags(0)
end

function Script.Thersa_AIUpdate(Unit, mapScript, timeDiff)
	if Script.UpdateCheck == true then
		Unit:UpdateTimers(timeDiff)
		if Unit:IsTimerFinished("Emote") then
			Unit:RemoveTimer("Emote")
			Unit:SendScriptTextById(11, 4533)
			Unit:CreateTimer("Die",2000)
		elseif Unit:IsTimerFinished("Die") then
			Unit:RemoveTimer("Die")
			Unit:Suicide()
			if Script.MadScientist ~= nil then
				Script.MadScientist:SendEmote(11)
			end
			Unit:CreateTimer("Despawn",2000)
		elseif Unit:IsTimerFinished("Despawn") then
			Unit:RemoveTimer("Despawn")
			Script.UpdateCheck = nil
			Unit:Despawn(10000,5000)
			Unit:SetNpcFlags(2)
		end
	end
end

RegisterUnitEvent(8393, 17,  Script.Thersa_OnConcludeQuest)
RegisterUnitEvent(8393, 23,  Script.Thersa_AIUpdate)