--[[
    Benediction Lua Scripts
    NPC 1683 - Warg Deepwater
    Developed by Nogar
--]]

local Script = {}

function Script.Tognus_Spawn(Unit)
	Script.Tognus = Unit
end

function Script.Belm_Spawn(Unit)
	Script.Belm = Unit
end

function Script.Kogan_Death(Unit)
	Unit:RemoveTimer(4321, 1000)
	Unit:ResetMovement()
	Unit:SetEmoteState(0)
end

function Script.Kogan_Spawn(Unit)
	Unit:CreateTimer(4321, 1000)
	Script.InactiveTimer = true 
end

function Script.Kogan_ReachWaypoint(Unit, WaypointId)
	if WaypointId == 1 then
		Unit:SetEmoteState(0)
		Unit:SendScriptTextById(11, 114)
		Unit:SendEmote(1)
		return
	end
	if WaypointId == 2 then
		if Script.Tognus then
			Script.Tognus:SendScriptTextById(11,115)
			Script.Tognus:SendEmote(274)
		end
		return
	end
	if WaypointId == 14 then
		if Script.Belm ~= nil then
			Script.Belm:FaceTarget(Unit)
		end
		Unit:SendScriptTextById(11, 117) 
		Unit:SendEmote(5)
		return
	end
	if WaypointId == 15 then 
		if Script.Belm ~= nil then
			Script.Belm:SendEmote(25)
			Script.Belm:SendScriptTextById(11,120)
		end
		Unit:SendEmote(7)
		return
	end	
	if WaypointId == 16 then 
		Unit:SendEmote(273)
		Unit:SendScriptTextById(11,118)
		return
	end	
	if WaypointId == 17 then 
		if Script.Belm ~= nil then
			Script.Belm:SendEmote(5)
			Script.Belm:SendScriptTextById(11,121)
		end
		return
	end	
	if WaypointId == 18 then 
		if Script.Belm ~= nil then
			Script.Belm:MoveHome()
		end
		return
	end	
	if WaypointId == 30 then
		Unit:SendEmote(14)
		Unit:SendScriptTextById(11,122)
		Unit:ResetTimer(4321,360000)
		return
	end	
	if WaypointId == 31 then
		Unit:ResetMovement()
		if Script.Tognus ~= nil then
			Script.Tognus:SendEmote(11)
			Script.Tognus:SendScriptTextById(11,123)
		end
		Unit:SetEmoteState(233)
		Script.InactiveTimer = true 
		return
	end	
end
 
function Script.Kogan_Update(Unit, mapScript, timeDiff)
	if Script.InactiveTimer == true then 
		if not Unit:IsInCombat() then
			Unit:UpdateTimers(timeDiff)
			if Unit:IsTimerFinished(4321) then    
				Script.InactiveTimer = nil        
				Unit:PushWaypointMovement(1014)       
			end                                   
		end
	end 
end



RegisterUnitEvent(1241, 1, Script.Tognus_Spawn)
RegisterUnitEvent(1247, 1, Script.Belm_Spawn)
RegisterUnitEvent(1245, 1, Script.Kogan_Spawn)
RegisterUnitEvent(1245, 2, Script.Kogan_Death)
RegisterUnitEvent(1245, 14, Script.Kogan_ReachWaypoint)
RegisterUnitEvent(1245, 23, Script.Kogan_Update)



--[[
114	6	0	'Bout time fer me to make mah rounds.
115	6	0	Ah I am too busy for a drink now lad.
117	6	0	Ach! Toss me a cold frosty, Belm!
118	6	0	Bagh! Back to work for me! Thank you kindly Belm.
120	6	0	Aye there you go lad, your favorite brew.
121	6	0	Aye, tell your friend there Tongus if he dont take care of his tab here, i'll be making an appearance with old Steelhead!
122	6	0	Belm says pay your bill or he'll break your face.
123	6	0	Hoha! I'd welcome the challenge from old weakbelly!
124	6	0	I'll take whatever ya got cookin'! And throw in a bottle to wash it down!


delete from kt_world.waypoint_script where scriptentry = 1014;
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1014,1,0,4000,-5576.370117,-429.770996,397.325989,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1014,2,0,3000,-5576.370117,-429.770996,397.325989,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1014,3,0,0,-5571.324219,-430.878296,397.326080,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1014,4,0,0,-5569.505859,-436.173004,397.659698,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1014,5,0,0,-5570.840332,-441.239563,399.725464,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1014,6,0,0,-5574.336914,-444.906158,401.492706,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1014,7,0,0,-5579.487305,-447.019379,401.492706,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1014,8,0,0,-5579.162109,-461.122620,402.603790,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1014,9,0,0,-5575.840820,-481.061523,397.492676,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1014,10,0,0,-5600.228516,-484.218994,397.025208,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1014,11,0,0,-5600.380859,-510.993683,401.381744,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1014,12,0,0,-5582.270508,-510.367523,404.373962,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1014,13,0,0,-5582.563477,-524.145691,400.762665,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1014,14,0,0,-5592.786621,-528.872375,399.652069,0,0,''); -- 117
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1014,15,0,5000,-5598.112305,-530.083435,399.652069,0,0,''); -- 120
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1014,16,0,3500,-5598.112305,-530.083435,399.652069,0,0,''); -- 118
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1014,17,0,5000,-5598.112305,-530.083435,399.652069,0,0,''); -- 121
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1014,18,0,0,-5592.786621,-528.872375,399.652069,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1014,19,0,0,-5582.563477,-524.145691,400.762665,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1014,20,0,0,-5582.270508,-510.367523,404.373962,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1014,21,0,0,-5600.380859,-510.993683,401.381744,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1014,22,0,0,-5600.228516,-484.218994,397.025208,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1014,23,0,0,-5575.840820,-481.061523,397.492676,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1014,24,0,0,-5579.162109,-461.122620,402.603790,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1014,25,0,0,-5579.487305,-447.019379,401.492706,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1014,26,0,0,-5574.336914,-444.906158,401.492706,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1014,27,0,0,-5570.840332,-441.239563,399.725464,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1014,28,0,0,-5569.505859,-436.173004,397.659698,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1014,29,0,0,-5571.324219,-430.878296,397.326080,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1014,30,0,3500,-5576.370117,-429.770996,397.325989,0,0,''); -- 122
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1014,31,0,2000,-5576.370117,-429.770996,397.325989,2.914,0,''); -- 123
--]]

