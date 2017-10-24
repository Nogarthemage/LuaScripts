--[[
    Benediction Lua Scripts
    Quest 333 - Harlan Needs a Resupply
    Developed by Nogar
--]]

local Script = {}

function Script.Corbett_OnSpawn(Unit)
	Unit:CreateTimer("startwalking",1000)
end

function Corbett_OnDeath(Unit, Killer)
	Script.Active = nil
end

function Script.Rema_OnSpawn(Unit)
	Script.Rema = Unit
end

function Script.Harlan_OnSpawn(Unit)
	Script.Harlan = Unit
end

function Script.Elaine_OnSpawn(Unit)
	Script.Elaine = Unit
end

function Script.Ben_OnSpawn(Unit)
	Script.Ben = Unit
end


function Script.Corbett_Update(Unit, mapScript, timeDiff)
	Unit:UpdateTimers(timeDiff)
	if Unit:IsTimerFinished("startwalking") then
		Unit:RemoveTimer("startwalking")
		Unit:PushWaypointMovement(1002)
	end
end


function Script.Rema_ConcludeQuest(Unit, QuestId, Player)
	if QuestId == 333 and Script.Active == nil then
		Script.Active = true
		Unit:SpawnCreatureAtPosition(1433, -8774.166992,717.649963,99.534027, 4.282)
	end
end

function Script.Corbett_OnReachWaypoint(Unit, WaypointId)
	if WaypointId == 2 then
		if Script.Rema ~= nil then
			Script.Rema:SendScriptTextById(11, math.random(253, 254))
			Script.Rema:SendEmote(1)
		end
		return
	end
	if WaypointId == 3 then
		Unit:SendScriptTextById(11, math.random(255, 256))
		return
	end
	if WaypointId == 7 then
		Unit:SendScriptTextById(11, math.random(257, 258))
		return
	end
	if WaypointId == 16 then
		Unit:SendScriptTextById(11, math.random(259, 260))
		Unit:SendEmote(1)
		return
	end
	if WaypointId == 17 then
		if Script.Harlan ~= nil then
			Script.Harlan:SendScriptTextById(11, math.random(261, 262))
			Script.Harlan:SendEmote(1)
		end
		return
	end
	if WaypointId == 18 then
		Unit:SendScriptTextById(11, math.random(263, 264))
		return
	end
	if WaypointId == 20 then
		Unit:SendScriptTextById(11, 283)
		return
	end
	if WaypointId == 23 then
		Unit:SendScriptTextById(11, math.random(284, 285))
		return
	end
	if WaypointId == 25 then
		if Script.Elaine ~= nil then
			Script.Elaine:SendScriptTextById(11, math.random(286, 287))
			Script.Elaine:SendEmote(1)
		end
		return
	end
	if WaypointId == 26 then
		Unit:SendScriptTextById(11, 295)
		Unit:SendEmote(1)
		return
	end
	if WaypointId == 27 then
		if Script.Ben ~= nil then
			Script.Ben:SendScriptTextById(11, math.random(288, 289))
			Script.Ben:SendEmote(3)
		end
		return
	end
	if WaypointId == 28 then
		Unit:SendScriptTextById(11, math.random(290, 291))
		return
	end
	if WaypointId == 29 then
		Unit:SendScriptTextById(11, math.random(292, 293))
		return
	end
	if WaypointId == 39 then
		Unit:SendScriptTextById(11, 294)
		return
	end
	if WaypointId == 43 then
		Unit:Despawn(1000,0)
		Script.Active = nil
		return
	end
end



RegisterUnitEvent(1428, 17, Script.Rema_ConcludeQuest)
RegisterUnitEvent(1428, 1, Script.Rema_OnSpawn)
RegisterUnitEvent(1427, 1, Script.Harlan_OnSpawn)
RegisterUnitEvent(4981, 1, Script.Ben_OnSpawn)
RegisterUnitEvent(483, 1, Script.Elaine_OnSpawn)
RegisterUnitEvent(1433, 1, Script.Corbett_OnSpawn)
RegisterUnitEvent(1433, 2, Script.Corbett_OnSpawn)
RegisterUnitEvent(1433, 23, Script.Corbett_Update)
RegisterUnitEvent(1433, 14, Script.Corbett_OnReachWaypoint)

--[[

update kt_world.creature_proto set Respawntime = 0  where entry = 1433;

delete from kt_world.waypoint_script where scriptentry = 1002;
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,1,0,1500,-8774.166992,717.649963,99.534027,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,2,0,3500,-8774.166992,717.649963,99.534027,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,3,0,2000,-8774.166992,717.649963,99.534027,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,4,0,0,-8765.348633,717.536499,99.533287,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,5,0,0,-8757.732422,725.979675,98.228584,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,6,0,0,-8738.249023,701.472839,98.704781,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,7,0,0,-8774.981445,668.297974,103.092438,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,8,0,0,-8761.289063,647.761353,103.883568,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,9,0,0,-8758.430664,626.883240,101.745399,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,10,0,0,-8765.124023,614.351746,97.923508,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,11,0,0,-8794.308594,589.864563,97.515579,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,12,0,0,-8818.376953,617.877686,94.723000,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,13,0,0,-8800.985352,634.130859,94.229149,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,14,0,0,-8787.992188,635.613403,95.284653,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,15,0,500,-8780.585938,637.434998,97.223595,2.204,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,16,0,4000,-8780.585938,637.434998,97.223595,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,17,0,4500,-8780.585938,637.434998,97.223595,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,18,0,1000,-8780.585938,637.434998,97.223595,3.335,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,19,0,0,-8787.992188,635.613403,95.284653,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,20,0,0,-8801.028320,634.157410,94.228981,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,21,0,0,-8832.188477,620.247314,93.656029,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,22,0,0,-8861.688477,585.501770,93.093880,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,23,0,0,-8853.996094,574.638184,94.685699,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,24,0,2000,-8850.674805,571.038025,94.686035,5.6,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,25,0,4500,-8850.674805,571.038025,94.686035,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,26,0,3500,-8850.674805,571.038025,94.686035,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,27,0,1500,-8850.674805,571.038025,94.686035,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,28,0,0,-8853.996094,574.638184,94.685699,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,29,0,0,-8861.688477,585.501770,93.093880,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,30,0,0,-8841.802734,614.536316,92.795380,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,31,0,0,-8836.770508,623.991821,93.560753,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,32,0,0,-8851.186523,661.770386,97.198425,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,33,0,0,-8824.909180,678.705872,97.520432,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,34,0,0,-8844.450195,721.221619,97.301544,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,35,0,0,-8833.882813,728.921936,97.941406,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,36,0,0,-8814.558594,738.809998,97.856850,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,37,0,0,-8784.439453,744.644470,98.874519,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,38,0,0,-8758.321289,727.699280,98.247040,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,39,0,0,-8765.348633,717.536499,99.533287,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,40,0,0,-8776.881836,714.835938,99.533913,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,41,0,0,-8779.057617,717.272461,99.540504,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,42,0,0,-8769.964844,725.008179,105.91375,0,0,'');
insert into waypoint_script (ScriptEntry, waypointId, movetype, delay, x, y, z, o, actionid, note) VALUES(1002,43,0,0,-8764.142578,721.540466,105.91331,0,0,'');


253	7	0	Corbett, dear.  Harlan needs a load of knitted shirts and pants as soon as we can manage.          
254	7	0	Corbett, you there?  Harlan needs another load of knitted goods.  Can you take it to him?          

255	7	0	My pleasure, sugar drop.  I'll be back soon...
256	7	0	Business must be good down at the bazaar.  I'll get him resupplied right away!

258	7	0	I should have a few extra coins from this sale.  Maybe I'll buy myself some lunch...
257	7	0	Hm...after dropping this off, I think I'll head to that cheese shop for a snack.

259	7	0	Hey, Harlan.  Here's a load of knitted cloth for you.
260	7	0	Oomph!  Here's another load of supplies, Harlan.  It must be selling fast!

261	7	0	Ah, much appreciated, Corbett.  We'll get these on the racks immediately.
262	7	0	Ah yes, and promptly delivered.  As always, it's a pleasure doing business with you, Corbett.

263	7	0	Well, I'm off then.  Take care, Harlan.
264	7	0	Glad to see you're doing so well, Harlan.  And I hope to see you again soon...

283	7	0	Now for that snack...

285	7	0	Hullo, Trias clan!  A ball of your smoked mozzarella, if you please!
284	7	0	Good day, Elling!  Hullo Elaine!  Let me have a wheel of bleu cheese, eh?

286	7	0	Good day, Corbett.  Here's your cheese, fresh made this morning!  And how are things at your shop?
287	7	0	Hi Corbett!  Here, you go!  I trust business is faring well at your clothier shop...?

295	7	0	Yes ma'am, business is brisk!

288	7	0	See you later, Corbett, and tell the missus hello!
289	7	0	Take care, and send our regards to your family.

290	7	0	Thank you kindly!
291	7	0	Thanks for the cheese!

292	7	0	I should get back before Rema starts to worry...
293	7	0	Time to get back to the shop...

294	7	0	I'm back!

--]]
