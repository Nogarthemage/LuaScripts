--[[
    Benediction Lua Scripts
    NPC 5696 - Gerard Abernathy
    Developed by Nogar
--]]

local Script = {}
Script.Option1 = {[1] = 2000, [2] = 2001, [3] = 2002, [4] = 2003}
Script.Option2 = {[1] = 2012, [2] = 2013, [3] = 2014, [4] = 2015, [5] = 2016, [6] = 2017}
Script.Option3 = {[1] = 2004, [2] = 2005, [3] = 2006, [4] = 2007, [5] = 2008, [6] = 2009}
Script.Option4 = {[1] = 2018, [2] = 2019, [3] = 2020, [4] = 2022, [5] = 2023, [6] = 2024, [7] = 2026, [8] = 2027}


function Script.Theresa_OnSpawn(Unit)
	Script.Theresa = Unit
end

function Script.Gerard_OnSpawn(Unit)
	Script.Gerard = Unit
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
		Unit:UpdateTimers(timeDiff)
		if Unit:IsTimerFinished("Option1") then
			Unit:RemoveTimer("Option1")
			local Rand = math.random(1, 4)
			local RandO = Script.Option1[Rand]
			Unit:SendScriptTextById(11, RandO)
			Unit:SendEmote(6)
			Unit:CreateTimer("Option2",10000)
		elseif Unit:IsTimerFinished("Option2") then
			Unit:RemoveTimer("Option2")
			local Rand = math.random(1, 6)
			local RandO = Script.Option2[Rand]
			Script.Leona:SendScriptTextById(11, RandO)
			Script.Leona:SendEmote(1)
			Unit:CreateTimer("Option3",10000)
		elseif Unit:IsTimerFinished("Option3") then
			Unit:RemoveTimer("Option3")
			local Rand = math.random(1, 6)
			local RandO = Script.Option3[Rand]
			Unit:SendScriptTextById(11, RandO)
			Unit:SendEmote(1)
			Unit:CreateTimer("Option4",10000)
		elseif Unit:IsTimerFinished("Option4") then
			Unit:RemoveTimer("Option4")
			local Rand = math.random(1, 8)
			local RandO = Script.Option4[Rand]
			Script.Joana:SendScriptTextById(11, RandO)
			Script.Joana:SendEmote(1)
		end
	elseif Script.StartEventG == nil and Script.Theresa ~= nil then
		Unit:SendScriptTextById(11, 1995)
		Unit:SendEmote(1)
		Script.Theresa:SetSheathState(1)
		Script.Theresa:PushWaypointMovement(1001)
		Unit:CreateTimer("Option1", 5000)
		Script.StartEventG = true
	end
end

function Script.Theresa_Update(Unit, mapScript, timeDiff)
	if Script.StartEventT == nil then 
		if Script.StartEventG == false then
			Unit:UpdateTimers(timeDiff)
			if Unit:IsTimerFinished("EndAndStart") then
				Unit:RemoveTimer("EndAndStart")
				Script.StartEventG = nil
			end
		else return end
	end
	if Script.StartEventT == true then
		if Script.StartWaypoint9 == true then
			Unit:UpdateTimers(timeDiff)
			if Unit:IsTimerFinished("Ugh") then
				Unit:RemoveTimer("Ugh")
				Script.Father:SendScriptTextById(11, 2028)
				Script.Father:SendEmote(22)
				Unit:CreateTimer("Yes",10000)
			elseif Unit:IsTimerFinished("Yes") then
				Unit:RemoveTimer("Yes")
				Unit:SendScriptTextById(11, 1998)
				Unit:SendEmote(1)
				Unit:SetSheathState(1)
				Script.StartEventT = nil
				Script.StartWaypoint9 = nil
			end
		elseif Script.StartWaypoint18 == true then
			Unit:UpdateTimers(timeDiff)
			if Unit:IsTimerFinished("FromFather") then
				Unit:RemoveTimer("FromFather")
				Script.Gerard:SendScriptTextById(11, 2011)
				Script.Gerard:SendEmote(1)
				Unit:CreateTimer("EndAndStart",120000)
				Script.StartWaypoint18 = nil
				Script.StartEventT = nil
				Script.StartEventG = false
			end
		end
	end
end

function Script.Theresa_OnReachWaypoint(Unit, WaypointId)
	if WaypointId == 9 then
		Unit:SendScriptTextById(11, 1997)
		Unit:SendEmote(25)
		Unit:SetSheathState(0)
		Unit:CreateTimer("Ugh", 4000)
		Script.StartWaypoint9 = true
		Script.StartEventT = true
	end
	if WaypointId == 18 then
		Unit:ResetMovement()
		Unit:SendScriptTextById(11, 1997)
		Unit:CreateTimer("FromFather", 4000)
		Unit:SetSheathState(0)
		Script.StartWaypoint18 = true
		Script.StartEventT = true
	end
end



RegisterUnitEvent(5696, 23, Script.Gerard_Update)
RegisterUnitEvent(5697, 23, Script.Theresa_Update)
RegisterUnitEvent(5696, 1, Script.Gerard_OnSpawn)
RegisterUnitEvent(5697, 1, Script.Theresa_OnSpawn)
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

update kt_world.creature_spawns set position_x = 1653.441284, position_y = 366.347260, position_z = -60.764091 where entry = 5696;
update kt_world.creature_spawns set position_x = 1652.983887, position_y = 364.271118, position_z = -60.758743 where entry = 5698;
update kt_world.creature_spawns set position_x = 1655.038208, position_y = 364.645996, position_z = -60.758228 where entry = 5699;
update kt_world.creature_spawns set position_x = 1655.199951, position_y = 366.372986, position_z = -60.763599 where entry = 5697;

delete from kt_world.waypoint_script where scriptentry = 1001;

insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1001,1,0,0,1660.280396,355.924194,-60.745964,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1001,2,0,0,1698.821899,334.263275,-60.484234,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1001,3,0,0,1706.450562,324.470398,-55.392429,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1001,4,1,0,1735.277222,346.547729,-55.393372,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1001,5,1,0,1744.877930,334.313873,-60.484341,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1001,6,1,0,1759.400146,335.274139,-62.225376,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1001,7,1,0,1781.387451,348.344269,-62.361496,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1001,8,1,0,1794.843994,371.296814,-60.158974,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1001,9,1,5000,1784.913086,400.275604,-57.213470,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1001,10,1,0,1794.843994,371.296814,-60.158974,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1001,11,1,0,1781.387451,348.344269,-62.361496,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1001,12,1,0,1759.400146,335.274139,-62.225376,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1001,13,1,0,1744.877930,334.313873,-60.484341,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1001,14,1,0,1735.277222,346.547729,-55.393372,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1001,15,1,0,1706.450562,324.470398,-55.392429,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1001,16,1,0,1698.821899,334.263275,-60.484234,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1001,17,1,0,1660.280396,355.924194,-60.745964,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1001,18,1,5000,1655.199951,366.372986,-60.763599,4.27606,0,'');
--]]