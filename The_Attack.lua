--[[
    Benediction Lua Scripts
    Quest 434 - The Attack!
    Developed by Nogar
--]]

local Script = {}



function Script.Lord_Death(Unit)
	Script.LordDead = true
end

function Script.Marzon_Spawn(Unit)
	Unit:CastSpell(Unit, 1784,false)
end

function Script.Marzon_Death(Unit)
	Script.MarzonDead = true
end

function Script.Lord_Spawn(Unit)
	Unit:MoveHome()
	Script.Lord = Unit
	Unit:CreateTimer(4321,1000)
end

function Script.Bot_Spawn(Unit)
	Script.Bot = Unit
	Unit:CreateTimer(4321,1000)
end

function Script.Tyrion_Spawn(Unit)
	Script.Tyrion = Unit
	Script.Phase = nil
	Script.InactiveTimer = nil
end


function Script.Lord_Init(Unit, Attacker)
	Unit:SendScriptTextById(11,3934)
end

function Script.Marzon_Init(Unit, Attacker)
	Unit:SendScriptTextById(11,3936)
end

function Script.Reset()
	if Script.Guard1 and Script.Guard2 then
		Script.Guard1:StopMovement()
		Script.Guard2:StopMovement()
		Script.Guard1:ResetMovement()
		Script.Guard2:ResetMovement()
		Script.Guard1:SetCanEnterCombat(true)
		Script.Guard2:SetCanEnterCombat(true)
		Script.Guard1:Despawn(3000,2000)
		Script.Guard2:Despawn(3000,2000)
	end
	if Script.Guard3 then
		Script.Guard3:SetCanEnterCombat(true)
	end
	if Script.Tyrion then
		Script.Tyrion:MoveHome()
		Script.Tyrion:SetCanEnterCombat(true)
	end
	if Script.Lord then
		Script.Lord:ResetMovement()
		Script.Lord:ClearTemporaryFaction()
	end
	if Script.Bot then
		Script.Bot:SetCanEnterCombat(true)
		Script.Bot:StopMovement()
		Script.Bot:ResetMovement()
		Script.Bot:Despawn(10000,1000)
	end
	Script.LordDead = nil
	Script.MarzonDead = nil
	Script.InactiveTimerL = nil
	Script.InactiveTimer = nil
	Script.Phase = nil
end


function Script.Tyrion_QuestAccept(Unit, QuestId, Player)
	if QuestId == 434 then
		Script.Guard1 = Unit:GetCreatureBySqlId(10305)
		Script.Guard2 = Unit:GetCreatureBySqlId(10304)
		Script.Guard3 = Unit:GetCreatureBySqlId(10309)
		Script.Player = Player -- Player
		Script.QLogE = Player:GetQuestLogEntry(434)
		Unit:SetCanEnterCombat(false)
		if Script.Bot then
			Script.Bot:SetCanEnterCombat(false)
			Script.Bot:ResetTimer(4321,3000)
		end
		Script.InactiveTimer = true
		Script.Phase = 0
		Unit:SetFacing(2.058)
		Unit:CastSpell(Unit,1804,false)
	end
end


function Script.Bot_Update(Unit, mapScript, timeDiff)
	if Script.InactiveTimer == nil then return end
	if Script.InactiveTimer == true then 					-- timer part
		if not Unit:IsInCombat() then
			Unit:UpdateTimers(timeDiff)
			if Unit:IsTimerFinished(4321) then
				Script.Phase = Script.Phase + 1
				Script.InactiveTimer = false
			end
		end
	end
	if Script.InactiveTimer == false then
		if Script.Phase == 1 then
			if Script.Tyrion then
				Script.Tyrion:FaceTarget(Unit)
			end
			Unit:ResetTimer(4321,1500)
			Script.InactiveTimer = true
			return
		end
		if Script.Phase == 2 then
			if Script.Tyrion then
				Script.Tyrion:SendEmote(0)
			end
			Unit:CastSpell(Unit,24085,false)
			Unit:SendScriptTextById(11,4593)
			Unit:ResetTimer(4321,1500)
			Script.InactiveTimer = true
			return
		end
		if Script.Phase == 3 then
			if Script.Player ~= nil and Script.Tyrion ~= nil then
				Script.Tyrion:FaceTarget(Script.Player)
			end
			if Script.Tyrion then
				Script.Tyrion:SendScriptTextById(11,3761)
				Script.Tyrion:SendEmote(1)
			end
			Unit:ResetTimer(4321,1000)
			Script.InactiveTimer = true
			return
		end
		if Script.Phase == 4 then
			Unit:SwapCreatureEntry(7779, false)
			Unit:ResetTimer(4321,2500)
			Script.InactiveTimer = true
			return
		end
		if Script.Phase == 5 then
			if Script.Tyrion then
				Script.Tyrion:MoveHome()
			end
			Unit:ResetTimer(4321,1500)
			Script.InactiveTimer = true
			return
		end
		if Script.Phase == 6 then
			Unit:PushWaypointMovement(1009)
			Script.Phase = 7
			return
		end
		if Script.Phase == 8 then
			Unit:SendScriptTextById(11,3781)
			if Script.Guard1 and Script.Guard2 then
				if not Script.Guard1:IsDead() and not Script.Guard2:IsDead() then
					Script.Guard1:FaceTarget(Unit)
					Script.Guard2:FaceTarget(Unit)
				end
			end
			Unit:ResetTimer(4321,1000)
			Script.InactiveTimer = true
			return
		end
		if Script.Phase == 9 then
			if Script.Guard1 and Script.Guard2 then
				if not Script.Guard1:IsDead() and not Script.Guard2:IsDead() then
					Script.Guard1:SendEmote(16)
					Script.Guard2:SendEmote(16)
				end
			end
			Unit:ResetTimer(4321,2000)
			Script.InactiveTimer = true
			return
		end
		if Script.Phase == 10 then
			if Script.Guard1 and Script.Guard2 then
				if not Script.Guard1:IsDead() and not Script.Guard2:IsDead() then
					Script.Guard1:SendScriptTextById(11,3783)
					Script.Guard1:SetStandState(26)
					Script.Guard2:SetStandState(26)
					Script.Guard1:SendEmote(1)
				end
			end
			Unit:ResetTimer(4321,2500)
			Script.InactiveTimer = true
			return
		end
		if Script.Phase == 11 then
			if Script.Guard1 and Script.Guard2 then
				if not Script.Guard1:IsDead() and not Script.Guard2:IsDead() then
					Script.Guard1:MoveHome()
					Script.Guard2:MoveHome()
				end
			end
			Unit:SendScriptTextById(11,3782)
			Unit:ResetTimer(4321,1500)
			Script.InactiveTimer = true
			return
		end
		if Script.Phase == 12 then
			Unit:PushWaypointMovement(1010)
			Script.Phase = 13
			return
		end
		if Script.Phase == 14 then
			Unit:SendScriptTextById(11,3762)
			Unit:SendEmote(1)
			if Script.Lord then
				Script.Lord:FaceTarget(Unit)
			end
			Unit:ResetTimer(4321,3500)
			Script.InactiveTimer = true
			return
		end
		if Script.Phase == 15 then
			if Script.Lord then
				Script.Lord:SendScriptTextById(11,3784)
				Script.Lord:SendEmote(1)
			end
			Unit:ResetTimer(4321,3000)
			Script.InactiveTimer = true
			return
		end
		if Script.Phase == 16 then
			if Script.Lord then
				Script.Lord:PushWaypointMovement(1011)
			end
			Unit:SendScriptTextById(11,3791)
			Unit:SendEmote(2)
			Script.Phase = 17
			Script.InactiveTimer = nil
			return
		end
	end
end

function Script.Lord_Update(Unit, mapScript, timeDiff)
	if Script.InactiveTimerL == nil then return end
	if Script.InactiveTimerL == true then 					-- timer part
		if not Unit:IsInCombat() then
			Unit:UpdateTimers(timeDiff)
			if Unit:IsTimerFinished(4321) then
				Script.Phase = Script.Phase + 1
				Script.InactiveTimerL = false
			end
		end
	end
	if Script.InactiveTimerL == false then
		if Script.Phase == 29 then 
			if Script.MarzonDead == true and Script.LordDead == true then
				Unit:ClearTemporaryFaction()
				Unit:Despawn(30000,1000)
				Script.Reset()
			end
			return
		end
		if Script.Phase == 30 then 
			if Script.Marzon then
				Script.Marzon:Despawn(1000,0)
			end
			Unit:ClearTemporaryFaction()
			Script.Reset()
			Unit:Despawn(1000,1000)
			return
		end
		if Script.Phase == 18 then
			if Script.Guard then
				Unit:FaceTarget(Script.Guard1)
			end
			Unit:SendScriptTextById(11,322)
			Unit:SendEmote(1)
			Unit:ResetTimer(4321,2000)
			Script.InactiveTimerL = true
			return
		end
		if Script.Phase == 19 then
			if Script.Guard1 and Script.Guard2 then
				if not Script.Guard1:IsDead() and not Script.Guard2:IsDead() then
					Script.Guard1:SendEmote(66)
					Script.Guard2:SendEmote(66)
					Script.Guard1:SendScriptTextById(11,3690)
					Script.Guard2:SendScriptTextById(11,3690)
					Script.Guard1:SetCanEnterCombat(false)
					Script.Guard2:SetCanEnterCombat(false)
					if Script.Guard3 then
						Script.Guard3:SetCanEnterCombat(false)
					end
				end
			end
			Unit:ResetTimer(4321,2000)
			Script.InactiveTimerL = true
			return
		end
		if Script.Phase == 20 then
			if Script.Guard1 and Script.Guard2 then
				if not Script.Guard1:IsDead() and not Script.Guard2:IsDead() then
					Script.Guard1:PushWaypointMovement(1012)
					Script.Guard2:PushWaypointMovement(1012)
				end
			end
			Script.Marzon = Unit:SpawnCreatureAtPosition(1755, -8405.426758,487.028595,123.760399, 5.03)
			Script.Phase = 21
			return
		end
		if Script.Phase == 22 then
			if Script.Tyrion then
				Script.Tyrion:FaceTarget(Unit)
			end
			Unit:ResetTimer(4321,500)
			Script.InactiveTimerL = true
			return
		end
		if Script.Phase == 23 then
			if Script.Marzon then
				Script.Marzon:PushWaypointMovement(1013)
			end
			Unit:ResetTimer(4321,7000)
			Script.InactiveTimerL = true
			return
		end
		if Script.Phase == 24 then
			if Script.Marzon then
				Unit:FaceTarget(Script.Marzon)
				Script.Marzon:RemoveAura(1784)
			end
			Unit:SendScriptTextById(11,323)
			Unit:SendEmote(1)
			Unit:ResetTimer(4321,3500)
			Script.InactiveTimerL = true
			return
		end
		if Script.Phase == 25 then 
			if Script.Marzon then
				Script.Marzon:SendScriptTextById(11,324)
				Script.Marzon:SendEmote(1)
			end
			Unit:ResetTimer(4321,4500)
			Script.InactiveTimerL = true
			return
		end
		if Script.Phase == 26 then
			Unit:SendScriptTextById(11,326)
			Unit:SendEmote(14)
			Unit:ResetTimer(4321,3500)
			Script.InactiveTimerL = true
			return
		end
		if Script.Phase == 27 then 
			if Script.Marzon then
				Script.Marzon:SendScriptTextById(11,325)
				Script.Marzon:SendEmote(1)
			end
			if Script.QLogE then
				Script.QLogE:AddKill(0,7779)
				Script.QLogE:UpdatePlayerFields()
			end
			Unit:ResetTimer(4321,2000)
			Script.InactiveTimerL = true
			return
		end
		if Script.Phase == 28 then
			if Script.Tyrion then
				Script.Tyrion:SendScriptTextById(12,4613)
				Script.Tyrion:SendEmote(5)
			end
			Unit:SetTemporaryFaction(17)
			if Script.Marzon then
				Script.Marzon:SetTemporaryFaction(17)
			end
			Script.Phase = 29
			Script.Bot:ResetTimer(4321,90000)
			Script.InactiveTimer = true
			return
		end
	end
end

function Script.Bot_ReachWaypoint(Unit, WaypointId)
	if Script.Phase == 7 then	
		if WaypointId == 4 then
			Unit:ResetTimer(4321,1000)
			Unit:ResetMovement()
			Script.InactiveTimer = true
			return
		end
	end
	if Script.Phase == 13 then	
		if WaypointId == 5 then
			Unit:ResetTimer(4321,1000)
			Script.InactiveTimer = true
			return
		end
	end
	if WaypointId >= 11 then
		if WaypointId == 12 then
			Unit:CastSpell(Unit,1804,false)
			return
		end
		if WaypointId == 13 then
			Unit:SwapCreatureEntry(8856, false)
			Unit:CastSpell(Unit,24085,false)
			Unit:CastSpell(Unit,1785,false)
			return
		end
		if WaypointId == 16 then
			Unit:ResetMovement()
			Unit:StopMovement()
			Unit:Despawn(5000,1000)
			return
		end
	end
end

function Script.Lord_ReachWaypoint(Unit, WaypointId)
	if WaypointId == 6 then
		Unit:ResetTimer(4321,1000)
		Script.InactiveTimerL = true
		return
	end
	if WaypointId == 7 then
		Unit:StopMovement()
		Unit:ResetMovement()
		Unit:ResetTimer(4321,500)
		Script.InactiveTimerL = true
	end
end

function Script.Marzon_ReachWaypoint(Unit, WaypointId)
	if WaypointId == 3 then
		Unit:ResetMovement()
		Unit:StopMovement()
	end
end


RegisterUnitEvent(1755, 1, Script.Marzon_Spawn)
RegisterUnitEvent(1755, 2, Script.Marzon_Death)
RegisterUnitEvent(1755, 3, Script.Marzon_Init)
RegisterUnitEvent(1755, 14, Script.Marzon_ReachWaypoint)
RegisterUnitEvent(1754, 1, Script.Lord_Spawn)
RegisterUnitEvent(1754, 2, Script.Lord_Death)
RegisterUnitEvent(1754, 3, Script.Lord_Init)
RegisterUnitEvent(1754, 14, Script.Lord_ReachWaypoint)
RegisterUnitEvent(1754, 23, Script.Lord_Update)
RegisterUnitEvent(8856, 1, Script.Bot_Spawn)
RegisterUnitEvent(8856, 14, Script.Bot_ReachWaypoint)
RegisterUnitEvent(8856, 23, Script.Bot_Update)
RegisterUnitEvent(7766, 1, Script.Tyrion_Spawn)
RegisterUnitEvent(7766, 16, Script.Tyrion_QuestAccept)


--[[


update kt_world.creature_Proto set faction = 35 where entry = 1755;
delete from kt_world.creature_spawns where entry in (7779);
update kt_world.creature_proto set RespawnTime = 0 where entry = 1755;

update kt_world.creature_spawns set position_x = -8408.056641,position_y = 450.679932,position_z = 123.760002, orientation = 6.282 where entry = 7766;
update kt_world.creature_spawns set position_x = -8408.855469,position_y = 452.049622,position_z = 123.760002, orientation = 5.632 where entry = 8856;

delete from kt_world.waypoint_script where scriptentry = 1009;
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1009,1,0,0,-8411.648438,460.652252,123.760002,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1009,2,0,0,-8404.439453,465.591278,123.760002,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1009,3,0,0,-8397.789063,459.658844,123.760002,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1009,4,0,2000,-8392.724609,453.216675,123.760002,0,0,'');

delete from kt_world.waypoint_script where scriptentry = 1010;
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1010,1,0,0,-8357.384766,408.798615,122.274498,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1010,2,0,0,-8363.937500,396.753571,122.274498,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1010,3,0,0,-8351.968750,382.661774,122.274498,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1010,4,0,0,-8343.313477,388.867889,122.274498,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1010,5,0,11000,-8336.538086,393.243500,122.274498,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1010,6,0,0,-8343.313477,388.867889,122.274498,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1010,7,0,0,-8351.968750,382.661774,122.274498,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1010,8,0,0,-8363.937500,396.753571,122.274498,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1010,9,0,0,-8358.738281,409.097107,122.274498,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1010,10,0,0,-8384.937500,441.370819,122.274498,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1010,11,0,0,-8409.605469,425.778107,122.274635,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1010,12,0,7000,-8423.702148,443.715790,122.274498,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1010,13,0,2000,-8423.702148,443.715790,122.274498,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1010,14,0,0,-8423.702148,443.715790,122.274498,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1010,15,0,0,-8427.382813,448.360016,122.274498,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1010,16,0,2000,-8433.605469,443.533661,122.274498,0,0,'');

delete from kt_world.waypoint_script where scriptentry = 1011;
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1011,1,0,0,-8334.000000,394.721985,122.274002,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1011,2,0,0,-8337.247070,398.814270,122.275002,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1011,3,0,0,-8336.492188,402.584564,122.275002,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1011,4,0,0,-8346.471680,414.852997,122.275002,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1011,5,0,0,-8358.000000,409.349182,122.275002,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1011,6,0,6500,-8392.730469,453.089966,123.759949,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1011,7,0,2000,-8403.958008,466.479523,123.760490,0,0,'');

delete from kt_world.waypoint_script where scriptentry = 1012;
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1012,1,0,0,-8390.528320,451.669525,123.760284,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1012,2,0,0,-8390.528320,451.669525,123.760284,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1012,3,0,0,-8384.090820,443.891907,122.274712,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1012,4,0,0,-8361.581055,461.521576,122.274712,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1012,5,0,0,-8367.853516,468.977539,122.274887,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1012,6,0,0,-8380.565430,485.500885,122.275177,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1012,7,0,0,-8342.837891,515.558228,122.274612,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1012,8,0,0,-8330.825195,513.905396,122.275108,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1012,9,0,0,-8328.985352,526.225647,122.274696,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1012,10,0,0,-8341.941406,528.008057,122.275581,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1012,11,0,0,-8342.837891,515.558228,122.274612,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1012,12,0,0,-8330.825195,513.905396,122.275108,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1012,13,0,0,-8328.985352,526.225647,122.274696,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1012,14,0,0,-8341.941406,528.008057,122.275581,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1012,15,0,0,-8342.837891,515.558228,122.274612,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1012,16,0,0,-8330.825195,513.905396,122.275108,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1012,17,0,0,-8328.985352,526.225647,122.274696,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1012,18,0,0,-8341.941406,528.008057,122.275581,0,0,'');

delete from kt_world.waypoint_script where scriptentry = 1013;
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1013,1,0,0,-8405.426758,487.028595,123.760399,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1013,2,0,0,-8407.740234,479.508453,123.760399,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1013,3,0,10000,-8404.900391,469.425964,123.759811,0,0,'');


322	7	0	It's time for my meditation, leave me.
323	7	0	There you are. What news from Westfall?
324	7	0	VanCleef sends word that the plans are underway. But he's heard rumors about someone snooping about.
325	7	0	Very well. I will return then.
326	7	0	Hmm, it could be that meddler Shaw. I will see what I can discover. Be off with you. I'll contact you again soon.

3690	0	0	Yes, sir!
3721	0	0	%s waits for the guards to be out of sight.
3761	0	0	Wait here, $n. Spybot will make Lescovar come out as soon as possible. Be ready! Attack only after you've overheard their conversation.
3762	0	0	Milord, your guest has arrived. He awaits your presence.
3781	0	0	Good day to you both. I would speak to Lord Lescovar.
3782	0	0	Thank you. The Light be with you both.
3783	0	0	Of course. He awaits you in the library.
3784	0	0	Ah, thank you kindly. I will leave you to the library while I tend to this small matter.
3785	0	0	Ok, here I go!
3791	0	0	I shall use the time wisely, milord. Thank you.

4613	0	0	That's it! That's what you were waiting for! KILL THEM!
4593	0	0	By your command!

3936	0	0	The Defias shall succeed! No meek adventurer will stop us!
3934	0	0	What?! How dare you!


--]]