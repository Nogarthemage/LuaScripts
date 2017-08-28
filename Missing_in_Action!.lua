--[[
    Benediction Lua Scripts
    Quest 219 - Missing in Action!
    Developed by Nogar
--]]

ENV = {}

function Keeshan_OnConcludeQuest(Unit, QuestId, Player)
	--if Questid == 219 then
		Unit:SetNpcFlags(0) -- avoid players talking to him
		Unit:PushWaypointMovement(20)
		ENV.Combat = nil
		ENV.Combat = 0
		Unit:CreateTimer("LoopCombat",2000)
	--end
end

function Keeshan_CombatStart(Unit, Target)
	ENV.Combat = 1
end

function Keeshan_CombatEnd(Unit)
	Unit:CreateTimer("CombatTimer",2000)
end


function Keeshan_AIUpdate(Unit, mapScript, timeDiff)
	Unit:UpdateTimers(timeDiff) -- updating timers
	if Unit:IsTimerFinished("CombatTimer") then
		Unit:RemoveTimer("CombatTimer")
		ENV.Combat = 0
	end
	if ENV.Combat == 0 then
		if Unit:IsTimerFinished("LoopCombat") then
			Unit:ResetTimer("LoopCombat",2000)
			Unit:SendScriptTextById(13, 1156)
			ENV.ClosestC = nil
			ENV.ClosestC = Unit:FindClosestCreature(0)
			local DisctanceC = Unit:GetDistanceFromObject(ENV.ClosestC)
			if DistanceC <= 15 then
				Unit:StartCombat(ENV.ClosestC)
			end
		end
	end
end

RegisterUnitEvent(349, 18,  "Keeshan_OnConcludeQuest")
RegisterUnitEvent(349, 23,  "Keeshan_AIUpdate")
RegisterUnitEvent(349, 3,  "Keeshan_CombatStart")
RegisterUnitEvent(349, 4,  "Keeshan_CombatEnd")
