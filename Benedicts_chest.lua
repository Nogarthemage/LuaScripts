--[[
    Benediction Lua Scripts
    Developed by Nogar (and Roadblock)

    Object 3239: BenedictChest
--]]

ENV = {}

function BenedictChest_OnEnter(Object, Player)
    
	if ENV.Spawn == nil then
		ENV.Player = Player
		ENV.Spawn = Player:SpawnCreatureAtPosition(3129, -230.676, -5132.86, 45.7122, 0.0)
		ENV.SpawnGuid = tostring(ENV.Spawn)
		ENV.Spawn:SendScriptTextById(11, 20)
		
		if ENV.PathTimer == nil then
			ENV.PathTimer = true
			ENV.Spawn:CreateTimer("StartPath",1000)
		end
		
		if ENV.DespawnTimer == nil then
			ENV.DespawnTimer = true
			ENV.Spawn:CreateTimer("DespawnTimer",60000)
		end
	end
end

function BenedictChest_OnAIUpdate(Unit, mapScript, timeDiff)
	local UnitGuid = tostring(Unit)	
	if UnitGuid == ENV.SpawnGuid then
		Unit:UpdateTimers(timeDiff)
		if Unit:IsTimerFinished("StartPath") then
			Unit:RemoveTimer("StartPath")
			ENV.PathTimer = nil
			Unit:PushWaypointMovement(17)
			Unit:SendScriptTextById(12, 21)
			if ENV.CombatTimer == nil then
				ENV.CombatTimer = true
				Unit:CreateTimer("Combat",3200)
			end
		end
		if Unit:IsTimerFinished("Combat") then
			Unit:RemoveTimer("Combat")
			ENV.CombatTimer = nil
			Unit:StartCombat(ENV.Player)
		end
		if Unit:IsTimerFinished("DespawnTimer") then
			Unit:RemoveTimer("DespawnTimer")
			ENV.CombatTimer = nil
			Unit:Despawn(0,0)
			ENV.Spawn = nil
		end
	end
end

function BenedictChest_CombatEnd(Unit)
	local UnitGuid = tostring(Unit)	
	if UnitGuid == ENV.SpawnGuid then
		Unit:ResetMovement()
		Unit:MoveToLocation(-224.438, -5097.87, 49.3254, 4.1, true, true, false, false)
	end
end

function BenedictChest_OnDamageTaken(Unit, Attacker, Amount)
	local UnitGuid = tostring(Unit)	
	if UnitGuid == ENV.SpawnGuid then
		Unit:ResetTimer("DespawnTimer",50000)
	end
end






RegisterGameObjectEvent(3239, 3, "BenedictChest_OnEnter")
RegisterUnitEvent(3129, 23, "BenedictChest_OnAIUpdate")
RegisterUnitEvent(3129, 9, "BenedictChest_OnDamageTaken")
RegisterUnitEvent(3129, 4, "BenedictChest_CombatEnd")

--[[
replace into kt_world.waypoint_script values(50370,17,1,1,0,-220.886, -5132.61, 49.2697, 0,0,'');
replace into kt_world.waypoint_script values(50371,17,2,1,0,-220.665, -5127.37, 49.2697, 0,0,'');
replace into kt_world.waypoint_script values(50372,17,3,1,0,-225.229, -5122.64, 49.2697, 0,0,'');
replace into kt_world.waypoint_script values(50373,17,4,1,0,-225.295, -5112.58, 49.3254, 0,0,'');
--]]
