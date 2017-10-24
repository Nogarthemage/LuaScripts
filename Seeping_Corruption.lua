--[[
    Benediction Lua Scripts
    Quest 3569 - Seeping Corruption
    Developed by Nogar
--]]

local Script = {}

function Script.Thersa_OnDeath(Unit, Killer)
	ScriptPhase = 0
	Unit:RemoveTimer(4321)
	Script.UpdateCheck = nil
end

function Script.Thersa_OnConcludeQuest(Unit, QuestId, Player)
	Script.MadScientist = Unit:GetCreatureBySqlId(30498)
	Unit:CreateTimer(4321,3000)
	Unit:CastSpell(Unit,6355,false)
	Script.UpdateCheck = true
	ScriptPhase = 1
	Unit:SetNpcFlags(0)
end

function Script.Thersa_AIUpdate(Unit, mapScript, timeDiff)
	if Script.UpdateCheck == true then
		Unit:UpdateTimers(timeDiff)
		if ScriptPhase == 1 and Unit:IsTimerFinished(4321) then
			Unit:SendScriptTextById(11, 4533)
			ScriptPhase = 2
			Unit:ResetTimer(4321,3000)
			return
		end
		if ScriptPhase == 2 and Unit:IsTimerFinished(4321) then
			Unit:Suicide()
			if Script.MadScientist ~= nil then
				Script.MadScientist:SendEmote(11)
			end
			ScriptPhase = 3
			Unit:ResetTimer(4321,2000)
			return
		end
		if ScriptPhase == 3 and Unit:IsTimerFinished(4321) then
			Unit:RemoveTimer(4321)
			Script.UpdateCheck = nil
			Unit:Despawn(10000,5000)
			Unit:SetNpcFlags(2)
		end
	end
end

RegisterUnitEvent(8393, 2,  Script.Thersa_OnSpawn)
RegisterUnitEvent(8393, 17,  Script.Thersa_OnConcludeQuest)
RegisterUnitEvent(8393, 23,  Script.Thersa_AIUpdate)