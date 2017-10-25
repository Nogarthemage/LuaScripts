--[[
    Benediction Lua Scripts
    NPC 5696 - Gerard Abernathy
    Developed by Nogar
--]]

local Script = {}
Script.Option1 = {2000, 2001, 2002, 2003}
Script.Option2 = {2012, 2013, 2014, 2015, 2016, 2017}
Script.Option3 = {2004, 2005, 2006, 2007, 2008, 2009}
Script.Option4 = {2018, 2019, 2020, 2022, 2023, 2024, 2026, 2027}




function Script.Theresa_OnSpawn(Unit)
	Script.Theresa = Unit
	Unit:CreateTimer(321,2500)
	Unit:SetEmoteState(0)
	Script.PhaseT = 0
	Script.StartEventT = nil
	Script.CheckTimerT = nil
end

function Script.Gerard_OnSpawn(Unit)
	Script.Gerard = Unit
	math.randomseed(os.time())
	Unit:CreateTimer(4321,3000)
	Unit:SetEmoteState(0)
	Script.Phase = 0
	Script.PhaseT = 0
	Script.CheckTimer = nil
	Script.StartEventG = nil
end

function Script.Theresa_OnDeath(Unit)
	Script.Gerard:ResetTimer(4321, 3000)
	Unit:ResetMovement()
	Unit:RemoveTimer(321)
	Script.StartEventG = nil
	Script.StartEventT = nil
	Script.CheckTimer = nil
	Script.Phase = 0
	Script.PhaseT = 0
end

function Script.Gerard_OnDeath(Unit, Killer)
	Unit:RemoveTimer(4321)
	Script.StartEventG = false
	Script.StartEventT = nil
end

function Script.Joana_OnSpawn(Unit)
	Script.Joana = Unit
end

function Script.Leona_OnSpawn(Unit)
	Script.Leona = Unit
end

function Script.Father_OnSpawn(Unit)
	Script.Father = Unit
end

function Script.Gerard_Update(Unit, mapScript, timeDiff)
	if Script.StartEventG == false then return end
	if Script.StartEventG == true then
		Unit:ResetTimer(4321, 30000)
		Script.StartEventG = nil
		return 
	end
	if Script.CheckTimer == nil then
		Unit:UpdateTimers(timeDiff)
		if Unit:IsTimerFinished(4321) then
				Script.Phase = Script.Phase + 1
				Script.CheckTimer = false
		end
		return
	end
	if Script.CheckTimer == false then
		if Script.Phase == 1 and Script.Theresa ~= nil and not Script.Theresa:IsDead() and not Unit:IsInCombat() then
			Script.CheckTimer = nil
			Unit:SendScriptTextById(11, 1995)
			Unit:SendEmote(1)
			if Script.Theresa ~= nil then 
				Script.Theresa:SetSheathState(1)
			end
			Unit:ResetTimer(4321, 3000)
			return
		end
		if Script.Phase == 2 and not Unit:IsInCombat() then
			Script.CheckTimer = nil
			if Script.Theresa ~= nil then 
				Script.Theresa:SendEmote(2)
			end
			Unit:ResetTimer(4321, 2000)
			return
		end
		if Script.Phase == 3 and not Unit:IsInCombat() then
			Script.CheckTimer = nil
			Unit:SendScriptTextById(11, Script.Option1[math.random(1, 4)])
			Unit:SendEmote(6)
			if Script.Theresa ~= nil then 
				Script.Theresa:PushWaypointMovement(1001)
			end
			Unit:ResetTimer(4321, 3000)
			return
		end
		if Script.Phase == 4 and not Unit:IsInCombat() then
			Script.CheckTimer = nil
			if Script.Leona ~= nil and not Script.Leona:IsDead() then 
				Script.Leona:SendScriptTextById(11, Script.Option2[math.random(1, 6)])
				Script.Leona:SendEmote(1)
			end
			Unit:ResetTimer(4321, 3000)
			return
		end
		if Script.Phase == 5 and not Unit:IsInCombat() then
			Script.CheckTimer = nil
			Unit:SendEmote(11)
			Unit:ResetTimer(4321, 3000)
			return
		end
		if Script.Phase == 6 and not Unit:IsInCombat() then
			Script.CheckTimer = nil
			Unit:SendScriptTextById(11, Script.Option3[math.random(1, 6)])
			Unit:SendEmote(1)
			if Script.Joana ~= nil and not Script.Joana:IsDead() then 
				Script.Joana:SendEmote(21)
			end
			Unit:ResetTimer(4321, 6000)
			return
		end
		if Script.Phase == 7 and not Unit:IsInCombat() then
			Script.StartEventG = false
			if Script.Joana ~= nil and not Script.Joana:IsDead() then 
				Script.Joana:SendScriptTextById(11, Script.Option4[math.random(1, 8)])
				Script.Joana:SendEmote(1)
			end
		end
	end
end

function Script.Theresa_Update(Unit, mapScript, timeDiff)
	if Script.StartEventT == nil then return end
	if Script.CheckTimerT == nil then
		Unit:UpdateTimers(timeDiff)
		if Unit:IsTimerFinished(321) then
			Script.PhaseT = Script.PhaseT + 1
			Script.CheckTimerT = false
		end
		return
	end
	if Script.CheckTimerT == false then
		if Script.PhaseT == 2 and not Unit:IsInCombat() then
			Script.CheckTimerT = nil
			if Script.Father ~= nil and not Script.Father:IsDead() then 
				Script.Father:SendScriptTextById(11, 2028)
				Script.Father:SendEmote(22)
			end
			Unit:ResetTimer(321,7000)
			return
		end
		if Script.PhaseT == 3 and not Unit:IsInCombat() then
			Script.CheckTimerT = nil
			Unit:SendScriptTextById(11, 1998)
			Unit:SetStandState(0)
			Unit:SetSheathState(1)
			return
		end
		if Script.PhaseT == 5 and not Unit:IsInCombat() then
			Script.CheckTimerT = nil
			if Script.Gerard ~= nil then 
				Script.Gerard:SetFacing(0.0086)
				Script.Gerard:SendScriptTextById(11, 2011)
				Script.Gerard:SetEmoteState(1)
			end
			Unit:ResetTimer(321, 3000)
			return
		end
		if Script.PhaseT == 6 and not Unit:IsInCombat() then
			if Script.Gerard ~= nil then 
				Script.Gerard:SetFacing(4.93928)
				Script.Gerard:SetEmoteState(0)
			end
		end
	end
end

function Script.Theresa_OnReachWaypoint(Unit, WaypointId)
	if WaypointId == 9 then
		Script.PhaseT = 1
		Script.CheckTimerT = nil
		Script.StartEventT = true
		Unit:SendScriptTextById(11, 1997)
		Unit:SetStandState(8)
		Unit:SetSheathState(0)
		Unit:ResetTimer(321, 2500)
		return
	end
	if WaypointId == 18 then
		Script.CheckTimerT = nil
		Unit:SendScriptTextById(11, 1997)
		Unit:SetStandState(8)
		Unit:ResetTimer(321, 3000)
		Unit:SetSheathState(0)
		Script.PhaseT = 4
		return
	end
	if WaypointId == 19 then
		Script.CheckTimerT = nil
		Script.CheckTimer = nil
		Script.Phase = 0
		Script.PhaseT = 0
		Script.StartEventT = nil
		Script.StartEventG = true
		Unit:ResetMovement()
		Unit:SetStandState(0)
		return
	end
end



RegisterUnitEvent(5696, 23, Script.Gerard_Update)
RegisterUnitEvent(5697, 23, Script.Theresa_Update)
RegisterUnitEvent(5696, 1, Script.Gerard_OnSpawn)
RegisterUnitEvent(5696, 2, Script.Gerard_OnDeath)
RegisterUnitEvent(5697, 1, Script.Theresa_OnSpawn)
RegisterUnitEvent(5697, 2, Script.Theresa_OnDeath)
RegisterUnitEvent(5698, 1, Script.Joana_OnSpawn)
RegisterUnitEvent(5699, 1, Script.Leona_OnSpawn)
RegisterUnitEvent(4607, 1, Script.Father_OnSpawn)
RegisterUnitEvent(5697, 14, Script.Theresa_OnReachWaypoint)

--[[
2000	33	0	How do you like my pet?
2001	33	0	Isn't she just the most amazing little creation?
2002	33	0	Didn't I tell you my new domination techniques would work?
2003	33	0	As good as I told you it would be, yes?

update kt_world.creature_spawns set unitbytes2 = 0 where entry = 5697;
update kt_world.creature_proto set npcflags = 0 where entry = 5698;

update kt_world.creature_spawns set position_x = 1653.441284, position_y = 366.347260, position_z = -60.764091 where entry = 5696;
update kt_world.creature_spawns set position_x = 1652.983887, position_y = 364.271118, position_z = -60.758743 where entry = 5698;
update kt_world.creature_spawns set position_x = 1655.038208, position_y = 364.645996, position_z = -60.758228 where entry = 5699;
update kt_world.creature_spawns set position_x = 1655.199951, position_y = 366.372986, position_z = -60.763599 where entry = 5697;

delete from kt_world.waypoint_script where scriptentry = 1001;
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1001,1,0,0,1660.280396,355.924194,-60.745964,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1001,2,0,0,1698.821899,334.263275,-60.484234,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1001,3,0,0,1706.450562,324.470398,-55.392429,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1001,4,0,0,1735.277222,346.547729,-55.393372,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1001,5,0,0,1744.877930,334.313873,-60.484341,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1001,6,0,0,1759.400146,335.274139,-62.225376,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1001,7,0,0,1781.387451,348.344269,-62.361496,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1001,8,0,0,1794.843994,371.296814,-60.158974,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1001,9,0,13000,1784.913086,400.275604,-57.213470,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1001,10,0,0,1794.843994,371.296814,-60.158974,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1001,11,0,0,1781.387451,348.344269,-62.361496,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1001,12,0,0,1759.400146,335.274139,-62.225376,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1001,13,0,0,1744.877930,334.313873,-60.484341,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1001,14,0,0,1735.277222,346.547729,-55.393372,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1001,15,0,0,1706.450562,324.470398,-55.392429,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1001,16,0,0,1698.821899,334.263275,-60.484234,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1001,17,0,0,1660.280396,355.924194,-60.745964,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1001,18,0,7000,1655.199951,366.372986,-60.763599,3.3666,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1001,19,0,4000,1655.199951,366.372986,-60.763599,4.27606,0,'');




--]]