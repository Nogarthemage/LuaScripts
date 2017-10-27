--[[
    Benediction Lua Scripts
    NPC 1683 - Warg Deepwater
    Developed by Nogar
--]]

local Script = {}
Script.Option1 = {343,346,347,348,349}
Script.Option2 = {350,353,356,357,358,359}

function Script.Khara_Spawn(Unit) -- init on spawn
	Script.Phase = 0
	Script.Khara = Unit
	Unit:ResetMovement()
	Unit:SetStandState(0)
	Script.InactiveTimer = true
end

function Script.Warg_Spawn(Unit) -- init on spawn
	math.randomseed(os.time())
	Unit:SetStandState(0)
	Unit:ResetMovement()
	Script.Warg = Unit
	Script.InactiveTimer = true
	Script.Phase = 0
	Unit:CreateTimer(4321, 2500)
end

function Script.Warg_Death(Unit) -- resetting script fully
	Script.Phase = nil
	Unit:RemoveTimer(4321)
	Unit:ResetMovement()
	Unit:SetStandState(0)
	Unit:SetSheathState(0)
	if Script.Khara ~= nil then
		Script.Khara:ResetMovement()
		Script.Khara:MoveHome()
		Script.Khara:SetStandState(0)
	end
	Script.InactiveTimer = false
	Script.ResetChecks()
end

function Script.Khara_Death(Unit) -- resetting script fully
	Script.Phase = nil
	Unit:ResetMovement()
	Unit:SetStandState(0)
	if Script.Warg ~= nil then
		Script.Warg:SetSheathState(0)
		Script.Warg:ResetMovement()
		Script.Warg:MoveHome()
		Script.Warg:SetStandState(0)
	end
	Script.InactiveTimer = false
	Script.ResetChecks()
end

function Script.Warg_LeaveCombat(Unit) -- if they enter combat again after one of them died they will still reset fine like this
	if Script.Phase == nil then
		Unit:MoveHome()
	end
end

function Script.Khara_LeaveCombat(Unit) -- if they enter combat again after one of them died they will still reset fine like this
	if Script.Phase == 0 then
		Unit:MoveHome()
	end
end

function Script.ResetChecks() -- var reset func
	Script.KEnd = nil
	Script.WEnd = nil
	Script.KSitting = nil
	Script.WSitting = nil
end

function Script.Warg_Update(Unit, mapScript, timeDiff)
	if Script.InactiveTimer == true then 					-- timer part
		if not Unit:IsInCombat() then
			Unit:UpdateTimers(timeDiff)
			if Unit:IsTimerFinished(4321) then
				Script.Phase = Script.Phase + 1
				Script.InactiveTimer = nil
			end
		end
	end 													-- timer part end
	if Script.InactiveTimer == nil then
		if Script.Phase == 1  and Script.Khara ~= nil and not Script.Khara:IsDead() then
			Script.Khara:PushWaypointMovement(1006) -- go inside to cook
			Script.Khara:SendScriptTextById(11, 340) -- ask warg for dinner
			Script.InactiveTimer = false
			Script.Phase = 2 
			return
		end
		if Script.Phase == 3 then
			Unit:SendScriptTextById(11, Script.Option1[math.random(5)]) -- dinner was good
			Unit:PushWaypointMovement(1007) -- go outside to fish
			Unit:SetStandState(0) -- stand up
			Script.InactiveTimer = false
			Script.Phase = 4
			return
		end
		if Script.Phase == 5 then
			Unit:SendScriptTextById(11, Script.Option2[math.random(6)]) -- talk about the fishing condition
			Unit:ResetTimer(4321, 20000)
			Script.InactiveTimer = true
			return
		end
		if Script.Phase == 6 then -- end of Warg Script
			Unit:MoveHome() -- go to OG spot
			Unit:SetSheathState(0)	-- unequip fishing pole
			Script.InactiveTimer = false
			Script.WEnd = true	-- mark end of Warg script
			if Script.KEnd == true then -- checking if Khara script has ended to reset
				Unit:ResetTimer(4321, 120000) -- time till next loop
				Script.InactiveTimer = true
				Script.Phase = 0
				Script.ResetChecks()
			end
			return
		end
	end
end

function Script.Warg_OnReachWaypoint(Unit, WaypointId)
	if Script.Phase == 2 then -- going inside
		if WaypointId == 4 then
			Script.WSitting = true
			Unit:SetStandState(1) -- sit down
			Unit:ResetMovement() 
			Unit:SetFacing(1.53) -- face the table
			Unit:SendScriptTextById(11,345) -- say it smells delicious
			if Script.KSitting == true then -- check if khara is sitting down so they can start eating
				Unit:CastSpell(Unit, 433, false) -- eat
				if Script.Khara ~= nil then
					Script.Khara:CastSpell(Unit, 433, false) -- make khara eat
				end
				Unit:ResetTimer(4321,25000)
				Script.InactiveTimer = true
			end
			return
		end
	end
	if Script.Phase == 4 then -- going oustside
		if WaypointId == 5 then
			Unit:SetSheathState(1) -- grab and equip pole
			if Script.Khara ~= nil then
				Script.Khara:PushWaypointMovement(1008) -- Khara goes outside too
				Script.Khara:SetStandState(0) -- make sure she stands up throughout her trip outside
			end
			return
		end
		if WaypointId == 7 then
			Unit:ResetMovement() -- stop by the water
			Unit:SendScriptTextById(13,352) -- look out to the water
			Unit:ResetTimer(4321,12000)
			Script.InactiveTimer = true
		end
	end
end

function Script.Khara_OnReachWaypoint(Unit, WaypointId)
	if Script.Phase == 2 then	-- going inside
		if WaypointId == 3 then
			Unit:SendScriptTextById(13, 341) -- hum a song
			Unit:CastSpell(Unit, 1804, false) -- cook
			return
		end
		if WaypointId == 4 then
			Unit:CastSpell(Unit, 1804, false) -- cook
			return
		end
		if WaypointId == 5 then
			Unit:SendScriptTextById(11, 342) -- call Warg for dinner
			Unit:SendEmote(16) -- kneel to pick up dinner
			return
		end
		if WaypointId == 6 then 
			if Script.Warg ~= nil then
				Script.Warg:PushWaypointMovement(1005) -- Warg going inside 
				Script.Warg:SendScriptTextById(11,344) -- Warg saying hes comming
			end
			return
		end
		if WaypointId == 8 then
			Unit:SetStandState(1) -- sit down
			Unit:ResetMovement() -- stop waypoint movement
			Unit:SetFacing(3.213)	-- face the table
			Script.KSitting = true -- check if Warg is sitting
			if Script.WSitting == true then
				if Script.Warg ~= nil then
					Script.Warg:CastSpell(Unit, 433, false) -- make warg eat
				end
				Unit:CastSpell(Unit, 433, false)  -- eat
				Script.Warg:ResetTimer(4321,25000)
				Script.InactiveTimer = true
				return
			end
		end
	end
	if Script.Phase ~= 2 then -- going outside
		if WaypointId == 5 then
			Unit:ResetMovement()
			Script.KEnd = true -- mark end of Khara script
			if Script.WEnd == true then -- check if Warg ended his script
				Script.Warg:ResetTimer(4321, 120000) -- reset till next loop
				Script.Phase = 0
				Script.InactiveTimer = true
				Script.ResetChecks()
			end
		end
	end
end

RegisterUnitEvent(1683, 1, Script.Warg_Spawn)
RegisterUnitEvent(1683, 2, Script.Warg_Death)
RegisterUnitEvent(1683, 2, Script.Warg_LeaveCombat)
RegisterUnitEvent(1683, 14, Script.Warg_OnReachWaypoint)
RegisterUnitEvent(1683, 23, Script.Warg_Update)
RegisterUnitEvent(1684, 1, Script.Khara_Spawn)
RegisterUnitEvent(1684, 2, Script.Khara_Death)
RegisterUnitEvent(1684, 4, Script.Khara_LeaveCombat)
RegisterUnitEvent(1684, 14, Script.Khara_OnReachWaypoint)
	







--[[
warg by the water
340	6	0	Warg, are you about ready to eat? I am gonna get it started.

341	0	0	Khara hums an old dwarven tune while she cooks.

342	6	0	Hon, food is ready. Come wash up and eat.

344	6	0	Ahhh, just in time! My stomach was rumblin' loud.

345	6	0	MMmmMMmmm. Smells delicious Khara.

346	6	0	Burp! Hon, that was really good. Not only do you know how to catch a fish but you sure do know how to cook one.
343	6	0	Mmmm, that was good. However, time to get back to work!
347	6	0	Whew! I think I ate too much. Need to loosen my belt a few notches.
348	6	0	Thanks for the great meal darlin' but I need to get back out front.
349	6	0	Another glorious day of fishin' is ahead of me, Khara. I best get movin'.

352	0	0	Warg looks over the water appraising what his luck might be today.

350	6	0	What a day for fishin'. They are sure to be bitin' today!
353	6	0	Welp the fish ain't bitin' no more so I might as start gutting and cleaning what I did catch today.
356	6	0	Look at all those ripples. Lots of activity in the water so I should catch a mess of fish today.
357	6	0	Hmmmm, only a little bit of activity on the surface but the sun is in the right place. Might turn out to be a fine day.
358	6	0	Not looking too good today. Sun is high and bright early and no activity on the water.
359	6	0	Hmph! What a sorry day for fishin' this is going to be. Ah well, a bad day fishin' is better then a good day workin'.







[SQL]

update kt_world.locale_broadcast_text set EN_FemaleText = EN_MaleText, RU_FemaleText = RU_MaleText, DE_FemaleText = DE_MaleText, FR_FemaleText = FR_MaleText, CN_FemaleText = CN_MaleText where id in (340,342);
delete from kt_world.waypoint_script where scriptentry = 1005;
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1005,1,0,0,-5212.459961,-3111.720703,301.528015,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1005,2,0,0,-5212.459961,-3111.720703,301.528015,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1005,3,0,0,-5212.843750,-3089.551025,300.115204,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1005,4,0,2000,-5208.116211,-3089.455322,300.608093,0,0,'');

delete from kt_world.waypoint_script where scriptentry = 1006;
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1006,1,0,0,-5212.599609,-3103.615723,303.171112,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1006,2,0,0,-5212.904297,-3090.823242,300.115479,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1006,3,0,6000,-5216.783691,-3085.379639,299.781982,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1006,4,0,5500,-5216.783691,-3085.379639,299.781982,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1006,5,0,3500,-5216.783691,-3085.379639,299.781982,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1006,6,0,0,-5216.783691,-3085.379639,299.781982,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1006,7,0,0,-5206.375977,-3085.402588,300.114868,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1006,8,0,2000,-5206.252441,-3087.468262,300.614838,0,0,'');


delete from kt_world.waypoint_script where scriptentry = 1007;
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1007,1,0,0,-5207.950195,-3089.439941,300.114990,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1007,2,0,0,-5212.988770,-3089.803223,300.115417,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1007,3,0,0,-5212.660645,-3103.792480,303.170990,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1007,4,0,3000,-5214.383301,-3104.217285,303.171356,0,1005,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1007,5,0,0,-5214.383301,-3104.217285,303.171356,0,1005,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1007,6,0,0,-5212.499512,-3107.095947,303.171356,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1007,7,0,2000,-5213.938965,-3126.565430,297.786255,4.311,0,'');
	

delete from kt_world.waypoint_script where scriptentry = 1008;
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1008,1,0,0,-5206.486328,-3085.491211,300.115234,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1008,2,0,0,-5210.527832,-3085.683105,300.115234,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1008,3,0,0,-5212.909668,-3090.963867,300.115234,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1008,4,0,0,-5212.564941,-3102.986084,303.171387,0,1005,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1008,5,0,2000,-5210.089844,-3104.739990,303.170990,5.55,0,'');

replace into kt_script.event_trigger_data set triggerid = 1005, eventtype = 6, EventIData1 = 25, note = 'point emote';

replace into kt_script.event_trigger_data set triggerid = 1007, eventtype = 5, EventIData1 = 173, note = 'work state';

update kt_world.creature_spawns set unitBytes2 = 0 where entry = 1683;

update kt_world.creature_proto set EquipItem0 = 6256 where entry = 1683;

[SQL END]

IGNORE THIS
kids playing outside an inn
360	6	0	Berte! Evalyn! It's getting dark. Come inside.

367	6	0	Awww Mom! It's hardly dark yet! Can we play for a bit longer please?

361	6	0	You can play more tomorrow. Now come on inside.

368	6	0	Ok...

362	6	0	Alright, alright. You two can go play just stay in town. No sneaking off to bug Warg and Khara down by the water.



daryl somewhere else in loch modan getting startled
363	6	0	Hah! Daryl, you should have seen the look on your face! You half jumped out of your skin!

365	6	0	They have you good on that one, lad!

366	0	0	Oh, shut up.



?
355	6	0	Best be on my way. Khara will be expecting me soon. See ya tomorrow X.
--]]