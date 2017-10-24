--[[
    Benediction Lua Scripts
    NPC 1476 - Hargin Mundar
    Developed by Nogar
--]]

local Script = {}

function Script.Hargin_Spawn(Unit)
	Unit:CreateTimer(4321, 2000)
	Script.InatciveTimer = nil
end


function Script.Hargin_Death(Unit)
	Unit:RemoveTimer(4321)
	Script.InatciveTimer = true
end

function Script.Hargin_Update(Unit, mapScript, timeDiff)
	if Script.InatciveTimer == nil then
		Unit:UpdateTimers(timeDiff) 
		if Unit:IsTimerFinished(4321) then
			Script.InatciveTimer = false
		end
		return
	end
	if Script.InatciveTimer == false then
		if Script.Statement == nil and not Unit:IsInCombat() then
			Unit:SendScriptTextById(11, 318)
			Unit:ResetTimer(4321, 10000)
			Unit:SendEmote(92)
			Script.InatciveTimer = nil
			Script.Statement = 1
			return
		end
		if Script.Statement == 1 and not Unit:IsInCombat() then
			Unit:SendScriptTextById(11, 319)
			Unit:ResetTimer(4321, 10000)
			Unit:SendEmote(92)
			Script.InatciveTimer = nil
			Script.Statement = 2
			return
		end
		if Script.Statement == 2 and not Unit:IsInCombat() then
			Unit:SendScriptTextById(11, 320)
			Unit:ResetTimer(4321, 10000)
			Unit:SendEmote(92)
			Script.InatciveTimer = nil
			Script.Statement = 3
			return
		end
		if Script.Statement == 3 and not Unit:IsInCombat() then
			Unit:SendScriptTextById(11, 321)
			Unit:ResetTimer(4321, 10000)
			Unit:SendEmote(92)
			Script.InatciveTimer = nil
			Script.Statement = nil
			return
		end
	end
end

RegisterUnitEvent(1476, 23, Script.Hargin_Update)
RegisterUnitEvent(1476, 1, Script.Hargin_Spawn)
RegisterUnitEvent(1476, 2, Script.Hargin_Death)