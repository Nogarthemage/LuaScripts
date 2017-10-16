--[[
    Benediction Lua Scripts
    Quest 927 - The Moss-twined Heart
    Developed by Nogar
--]]

local Script = {}

function Script.Denalan_OnConcludeQuest(Unit, QuestId, Player)
	if Script.BogPlayer == nil then
		Script.BogPlayer = Player
	end
	if QuestId == 927 then
		Unit:SetNpcFlags(0) -- removing gossip temporarely to avoid overlap of other players starting other scripts
		Unit:SendScriptTextById(13, 1126) -- emote 
		Unit:CastSpell(Unit, 1804, false) -- dummy spell to "inspect" the heart
		if Script.EmoteTimer == nil then -- creating timer for the second emote /say
			Script.EmoteTimer = true
			Unit:CreateTimer("Emote",4000)
		end
		Script.Active = true
	end
	if QuestId == 930 then
		if Script.ResetTimer == nil then
			Script.ResetTimer = true
			Unit:CreateTimer("Reset",10000) -- timer to make the npc responsive again for the next script
			Unit:SetNpcFlags(0) -- removing gossip temporarely to avoid overlap of other players starting other scripts
			Unit:SendScriptTextById(13, 1156) -- emote
			Unit:CastSpell(Unit, 1804, false) -- dummy spell to take the seeds out of the fruit
			Unit:CreateTimer("Move",3500) -- creating timer to move to the planter
			Unit:CreateTimer("Plant",6000) -- timer to kneel and plant the seeds
			Unit:CreateTimer("Home",8000) -- timer to spurt the seeds into mobs and return home
			Script.Active = true
		end
	end
end

function Script.Denalan_AIUpdate(Unit, mapScript, timeDiff)
	if Script.Active == true then
		Unit:UpdateTimers(timeDiff) -- updating timers
		if Unit:IsTimerFinished("Emote") then
			Unit:RemoveTimer("Emote")
			Script.EmoteTimer = nil
			Unit:SendScriptTextById(11, 1127) -- emote
			Unit:EnterEvadeMode() -- interrupting the mentioned dummy spell
			Unit:SetNpcFlags(2) -- re-activating gossip
			Script.active = nil
		end
		if Unit:IsTimerFinished("Move") then
			Unit:RemoveTimer("Move")
			Unit:EnterEvadeMode() -- interrupting the mentioned dummy spell
			Unit:PushWaypointMovement(18) -- moving to the planter
			Unit:SendScriptTextById(11, 1157) -- emote
		end
		if Unit:IsTimerFinished("Plant") then
			Unit:RemoveTimer("Plant")
			Unit:StopMovement() -- stop in front of the planter and not continuemoving between the waypoints
			Unit:SendScriptTextById(13, 1158) -- emote
			Unit:SetEmoteState(16) -- kneel and plant
		end
		if Unit:IsTimerFinished("Home") then
			Unit:RemoveTimer("Home")
			Unit:ResetMovement() -- stop waypoints
			Unit:MoveToLocation(9506.92,713.766,1255.89, 0.279253, false, false, false, false) -- moving back to original spot
			Unit:SetEmoteState(26) -- removing the kneel and go back to standing 
			ScriptBActive = true
			Script.bogling1 = tostring(Unit:SpawnCreatureAtPosition(3569, 9503.47, 720.007, 1255.94, 5.80658)) -- spawning the boglings
			Script.bogling2 = tostring(Unit:SpawnCreatureAtPosition(3569, 9502.51, 718.025, 1255.94, 5.80658))
			Script.bogling3 = tostring(Unit:SpawnCreatureAtPosition(3569, 9504.53, 721.649, 1255.94, 5.80658))
		end
		if Unit:IsTimerFinished("Reset") then 
			Unit:RemoveTimer("Reset")
			Script.ResetTimer = nil
			Unit:SetNpcFlags(2)-- re-activating gossip
			Script.active = nil
		end
	end
end

function Script.Bogling_Spawn(Unit)
	local GuidUnit = tostring(Unit)
	Unit:SetCanEnterCombat(false) -- making them stand still and not enter combat while they grow
	Unit:CastSpell(Unit, 22788, false) -- grow
	-- Unit:CastSpell(Unit, 22788, false) -- grow even more
	if GuidUnit == Script.bogling1 then -- making individual timers for each different bogling
		if Script.AttackTimer1 == nil then 
			Script.AttackTimer1 = true
			Unit:SendScriptTextById(13, 1175)
			Unit:CreateTimer("Attack1",2000) -- timer to start combat wth the player
		end
	end
	if GuidUnit == Script.bogling2 then
		if Script.AttackTimer2 == nil then 
			Script.AttackTimer2 = true
			Unit:CreateTimer("Attack2",2000) -- timer to start combat wth the player
		end
	end
	if GuidUnit == Script.bogling3	then
		if Script.AttackTimer3 == nil then 
			Script.AttackTimer3 = true
			Unit:CreateTimer("Attack3",2000) -- timer to start combat wth the player
		end
	end
end

function Script.Bogling_AIUpdate(Unit, mapScript, timeDiff)
	local GuidUnit = tostring(Unit)
	if ScriptBActive == true then
		Unit:UpdateTimers(timeDiff)
		if GuidUnit == Script.bogling1 then
			if Unit:IsTimerFinished("Attack1") then
				Unit:RemoveTimer("Attack1")
				Script.AttackTimer1 = nil
				Script.bogling1 = nil
				Unit:SetCanEnterCombat(true) -- activating their ability to enter combat and move
				Unit:StartCombat(Script.BogPlayer) -- initiate combat with the correct target
				Script.BogPlayer = nil
				Unit:SendScriptTextById(11, 1176)
				Unit:Despawn(30000, 0) -- making them despawn if the player doesnt kill them and resets them
			end
		end
		if GuidUnit == Script.bogling2 then
			if Unit:IsTimerFinished("Attack2") then
				Unit:RemoveTimer("Attack2")
				Script.AttackTimer2 = nil
				Script.bogling2 = nil
				Unit:SetCanEnterCombat(true)
				Unit:StartCombat(Script.BogPlayer)
				Script.BogPlayer = nil
				Unit:Despawn(30000, 0)
			end
		end
		if GuidUnit == Script.bogling3 then
			if Unit:IsTimerFinished("Attack3") then
				Unit:RemoveTimer("Attack3")
				Script.AttackTimer3 = nil
				Script.bogling3 = nil
				Unit:SetCanEnterCombat(true)
				Unit:StartCombat(Script.BogPlayer)
				Script.BogPlayer = nil
				Unit:Despawn(30000, 0) 
				ScriptBActive = nil
			end
		end
	end
end


RegisterUnitEvent(3569, 1,  Script.Bogling_Spawn)
RegisterUnitEvent(2080, 17,  Script.Denalan_OnConcludeQuest)
RegisterUnitEvent(2080, 23,  Script.Denalan_AIUpdate)
RegisterUnitEvent(3569, 23,  Script.Bogling_AIUpdate)

-- update kt_spell.spellcorrections set attributes = 8388992 where spellid = 22788;
-- update kt_world.creature_proto set respawntime = 0 where entry = 3569;
-- update kt_world.creature_proto set scale = 0.15 where entry = 3569;
-- replace into kt_world.waypoint_script values (158,18,1,0,0,9507.543945,717.882446,1255.885742,0,0,'');
-- replace into kt_world.waypoint_script values (159,18,2,0,0,9505.663086,718.937927,1256.207886,0,0,'');