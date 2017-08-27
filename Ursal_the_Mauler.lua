--[[
    Benediction Lua Scripts
	Quest - 486 - Ursal the Mauler
    Developed by Nogar
--]]

ENV = {}

function Ursal_Spawn(Unit)
	ENV.Druid = {}
	ENV.Druid[1] = Unit:SpawnCreatureAtPosition(2852, 9095.219727, 1838.829956, 1327.260010, 1.0645) -- spawn the druids
	ENV.Druid[2] = Unit:SpawnCreatureAtPosition(2852, 9093.740234, 1841.180054, 1327.530029, 0.1396)
	ENV.Druid[3] = Unit:SpawnCreatureAtPosition(2852, 9094.309570, 1844.030029, 1327.550049, 5.4978)
	ENV.Druid[4] = Unit:SpawnCreatureAtPosition(2852, 9095.980469, 1845.660034, 1327.489990, 4.9044)
	


end

function Druid_Spawn(Unit)
	Unit:CastSpell(Unit, 16093, false) -- sleeping ZzzZZZzz's
	Unit:SetStandState(3)  -- making them lie down to sleep
end

function Ursal_Death(Unit, Attacker)
	ENV.Ursal = Unit
	ENV.Druid[1]:RemoveAura(16093) -- removing zZZzzZZz's
	ENV.Druid[2]:RemoveAura(16093)
	ENV.Druid[3]:RemoveAura(16093)
	ENV.Druid[4]:RemoveAura(16093)
	ENV.Druid[1]:SetStandState(0) -- making them stand up
	ENV.Druid[2]:SetStandState(0)
	ENV.Druid[3]:SetStandState(0)
	ENV.Druid[4]:SetStandState(0)
	ENV.Druid[1]:SetDisplay(6300) -- fransform to bird
	ENV.Druid[2]:SetDisplay(6300)
	ENV.Druid[3]:SetDisplay(6300)
	ENV.Druid[4]:SetDisplay(6300)
	ENV.Druid[1]:CastSpell(ENV.Druid[1], 24085, false) -- tansform effect
	ENV.Druid[2]:CastSpell(ENV.Druid[2], 24085, false)
	ENV.Druid[3]:CastSpell(ENV.Druid[3], 24085, false)
	ENV.Druid[4]:CastSpell(ENV.Druid[4], 24085, false)
	ENV.Druid[3]:SendScriptTextById(11, 888) -- thanking the player
	Unit:CreateTimer("FlyOff",3000) -- time till the fly off

end

function Druid_AIUpdate(Unit, mapScript, timeDiff)
	ENV.Ursal:UpdateTimers(timeDiff) -- updating timers
	if ENV.Ursal:IsTimerFinished("FlyOff") then
		ENV.Ursal:RemoveTimer("FlyOff")
		ENV.Druid[4]:PushWaypointMovement(19) -- letting the first fly off
		ENV.DruidC = 4
	end
end


function Druid_OnReachWaypoint(Unit, WaypointId)
	local DruidCheck1 = tostring(ENV.Druid[ENV.DruidC])
	local DruidCheck2 = tostring(Unit)
	if DruidCheck2 == DruidCheck1 and WaypointId == 1 then
		ENV.Druid[ENV.DruidC]:Despawn(7000,0) -- despawn in the air after a while
		ENV.DruidC = ENV.DruidC - 1
		if ENV.DruidC >= 1 then
			ENV.Druid[ENV.DruidC]:PushWaypointMovement(19) -- letting the other 3 fly off
		end
	end
end




RegisterUnitEvent(2039, 1,  "Ursal_Spawn")
RegisterUnitEvent(2039, 2,  "Ursal_Death")
RegisterUnitEvent(2852, 1,  "Druid_Spawn")
RegisterUnitEvent(2852, 23,  "Druid_AIUpdate")
RegisterUnitEvent(2852, 14,  "Druid_OnReachWaypoint")


-- delete from kt_world.creature_spawns where entry = 2852;