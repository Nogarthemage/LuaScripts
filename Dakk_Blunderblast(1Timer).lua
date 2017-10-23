--[[
    Benediction Lua Scripts
    NPC 1777 - Dakk Blunderblast
    Developed by Nogar
--]]

local Script = {}

function Script.Dummy_Spawn(Unit)
	Script.Dummy = Unit
	Unit:CastSpell(Unit,23196,false)
end

function Script.Dakk_Death(Unit)
	Script.Phase = nil
	Unit:RemoveTimer(4321)
	Unit:ResetMovement()
end

function Script.Dakk_Spawn(Unit)
	Script.InactiveTimer = nil
	Script.Path2 = nil
	Script.Phase = nil
	Unit:CreateTimer(4321, 2500)
end

function Script.Dakk_Update(Unit, mapScript, timeDiff)
	if Script.InactiveTimer == true then
		Unit:UpdateTimers(timeDiff)
		if Unit:IsTimerFinished(4321) and not Unit:IsInCombat() then
			Script.InactiveTimer = nil
			Script.Path2 = nil
			Script.Phase = nil
			Unit:ResetMovement()
			Unit:ResetTimer(4321, 2500)
			return
		end
	end
	if Script.InactiveTimer == nil then 
		Unit:UpdateTimers(timeDiff)
		if Script.Phase == nil  and not Unit:IsInCombat() and Unit:IsTimerFinished(4321) then
			Unit:PushWaypointMovement(1003)
			Script.Phase = 1
			return
		end
		if Script.Phase == 2 and not Unit:IsInCombat() and Unit:IsTimerFinished(4321) then
			Script.Phase = 3
			Unit:CastSpell(Script.Dummy,7918,false)
			Unit:ResetTimer(4321, 2500)
			return
		end
		if Script.Phase == 3 and not Unit:IsInCombat() and Unit:IsTimerFinished(4321) then
			Script.Phase = 4
			Unit:SendScriptTextById(11, 330)
			Unit:SendEmote(5)
			Unit:ResetTimer(4321, 3500)
			return
		end
		if Script.Phase == 4 and not Unit:IsInCombat() and Unit:IsTimerFinished(4321) then
			Script.Phase = 5
			Unit:CastSpell(Script.Dummy,7918,false)
			Unit:ResetTimer(4321, 2500)
			return
		end
		if Script.Phase == 5 and not Unit:IsInCombat() and Unit:IsTimerFinished(4321) then
			Script.Phase = 6
			Unit:SendScriptTextById(11, 331)
			Unit:SendEmote(1)
			Unit:ResetTimer(4321, 3500)
			return
		end
		if Script.Phase == 6 and not Unit:IsInCombat() and Unit:IsTimerFinished(4321) then
			Script.Phase = 7
			Unit:CastSpell(Script.Dummy,7918,false)
			Unit:ResetTimer(4321, 2500)
			return
		end
		if Script.Phase == 7 and not Unit:IsInCombat() and Unit:IsTimerFinished(4321) then
			Script.Phase = 8
			Unit:SendScriptTextById(11, 332)
			Unit:SendEmote(6)
			Unit:ResetTimer(4321, 3500)
			return
		end
		if Script.Phase == 8 and not Unit:IsInCombat() and Unit:IsTimerFinished(4321) then
			Script.Phase = 9
			Unit:CastSpell(Script.Dummy,7918,false)
			Unit:ResetTimer(4321, 2500)
			return
		end
		if Script.Phase == 9 and not Unit:IsInCombat() and Unit:IsTimerFinished(4321) then
			Script.Phase = 10
			Unit:SendScriptTextById(11, 333)
			Unit:SendEmote(22)
			Unit:ResetTimer(4321, 3000)
			return
		end
		if Script.Phase == 10 and not Unit:IsInCombat() and Unit:IsTimerFinished(4321) then
			Script.Phase = 11
			Unit:PushWaypointMovement(1004)
			return
		end
	end
end

function Script.Dakk_OnReachWaypoint(Unit, WaypointId)
	if Script.Path2 == nil then 
		if WaypointId == 1 then
			Unit:SendScriptTextById(11, 329)
			Unit:SendEmote(1)
			return
		end
		if WaypointId == 5 then
			Unit:ResetMovement()
			Unit:ResetTimer(4321, 1000)
			Script.Phase = 2
			Script.Path2 = true
		end
	end
	if Script.Path2 == true then 
		if WaypointId == 4 then
			Unit:ResetMovement()
			Script.InactiveTimer = true
			Unit:ResetTimer(4321, 30000)
		end
	end
end


RegisterUnitEvent(1777, 23, Script.Dakk_Update)
RegisterUnitEvent(1777, 1, Script.Dakk_Spawn)
RegisterUnitEvent(1777, 2, Script.Dakk_Death)
RegisterUnitEvent(15996, 1, Script.Dummy_Spawn)
RegisterUnitEvent(1777, 14, Script.Dakk_OnReachWaypoint)
	
--[[
delete from kt_world.waypoint_script where scriptentry = 1003;
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1003,1,0,3000,-5275.259766,-2971.020020,338.737000,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1003,2,0,0,-5277.974609,-2969.365967,338.737274,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1003,3,0,0,-5277.974609,-2969.365967,338.737274,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1003,4,0,0,-5293.418945,-2986.785645,340.631226,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1003,5,0,2000,-5300.376953,-2988.329346,340.631226,1.697,0,'');
delete from kt_world.waypoint_script where scriptentry = 1004;
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1004,4,0,0,-5293.418945,-2986.785645,340.631226,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1004,3,0,0,-5277.974609,-2969.365967,338.737274,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1004,2,0,0,-5277.974609,-2969.365967,338.737274,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1004,1,0,3000,-5275.259766,-2971.020020,338.737000,0,0,'');
update kt_world.creature_proto set AImode = 2, rangedspell = 7918, EquipItem2 = 2552 where entry = 1777; -- 
delete from kt_world.creature_spawns where entry = 15996;
replace into creature_spawns (entry, map, position_x, position_y, position_z, orientation, RandomSpread, factionId, unitBytes2, walkSpeed, runSpeed, EventState, unitflags) VALUES(15996,0,-5301.720703,-2979.369385,340.631592,2.02,0,14,4097,2.5,7.5,1,256);
329	6	0	Vrok said the sights are off on Grumlar's gun. I suppose I should check it.
330	6	0	Hmph! I didn't even hit the blasted target! That thick skulled dwarf was probably using the gun as a mace again.
331	6	0	Hmmmm... That one clipped it's shoulder. Grumlar was right, the sights are slightly off. Easy enough for me to fix though.
332	6	0	Almost perfect shot! It's a bit off but I can see where Grumlar would miss with it. He couldn't hit the broad side of a barn.
333	6	0	Bullseye! That blasted dwarf doesn't know what he is talking about. Only thing wrong with Grumlar's gun is Grumlar's aim.
--]]