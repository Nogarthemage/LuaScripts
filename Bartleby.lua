--[[
    Benediction Lua Scripts
    Quest 1640 - Beat Bartleby
    Developed by Nogar
--]]


local Script = {}

function Script.Reset(Unit) 
	Unit:ClearTemporaryFaction()
	if Script.Bar then
		for id, npcs in ipairs(Script.Bar) do 
			npcs:SetCanEnterCombat(true)
		end
	end
	Unit:SetNpcFlags(2)
	Unit:RemoveTimer(4321,40000)
end

function Script.Bartleby_HealthPerc(Unit, hpPerc)
	if hpPerc < 10 then
		Script.Reset(Unit)
		if Script.QLogE then
			Script.QLogE:SendUpdateScriptComplete()
		end
	end
end

function Script.Bartleby_QuestAccept(Unit, QuestId, Player)
	Unit:SetNpcFlags(0)
	Script.Bar = {
	Unit:GetCreatureBySqlId(54513),
	Unit:GetCreatureBySqlId(54514),
	Unit:GetCreatureBySqlId(54515),
	Unit:GetCreatureBySqlId(54516),
	Unit:GetCreatureBySqlId(54517),
	Unit:GetCreatureBySqlId(54527),
	Unit:GetCreatureBySqlId(54529),
	Unit:GetCreatureBySqlId(54530)}
	for id, npcs in ipairs(Script.Bar) do 
		npcs:SetCanEnterCombat(false)
	end
	Script.Player = Player
	Script.QLogE = Player:GetQuestLogEntry(1640)
	Unit:FaceTarget(Player)
	Unit:CreateTimer(21,500)
	Unit:CreateTimer(321,3000)
	Unit:CreateTimer(4321,40000)
	Script.InactiveTimer = true
end

function Script.Bartleby_Update(Unit, mapScript, timeDiff)
	if Script.InactiveTimer == true then
		Unit:UpdateTimers(timeDiff)
		if Unit:IsTimerFinished(21) then
			Unit:SendEmote(92)
			Unit:RemoveTimer(21)
		end
		if Unit:IsTimerFinished(321) then
			Unit:RemoveTimer(321)
			Unit:SetTemporaryFaction(14)
			Unit:StartCombat(Script.Player)
		end
		if Unit:IsTimerFinished(4321) then
			--if Script.QLogE then
				--Script.QLogE:SendQuestFailed()
			--end
			Script.Reset(Unit)
			Script.InactiveTimer = nil
		end
	end 
end


RegisterUnitEvent(6090, 5, Script.Bartleby_HealthPerc)
RegisterUnitEvent(6090, 16, Script.Bartleby_QuestAccept)
RegisterUnitEvent(6090, 23, Script.Bartleby_Update)


--[[

update Creature_proto set jadeflags = 2, attacktime = 1.300 where entry = 6090;
update Creature_Spawns set UnitBytes2 = 4097 where entry = 6090;
update kt_world.quests set  jadefireflags = 512, SpecialFlags = 2 where  questid = 1640;

delete from waypoint where creatureGuid = 54512;
insert into waypoint (creatureGuid, waypointId, movetype, delay, x, y, z, o, actionid) VALUES(54512,1,0,0,-8612.533203,391.680145,102.953667,0,0);
insert into waypoint (creatureGuid, waypointId, movetype, delay, x, y, z, o, actionid) VALUES(54512,2,0,500,-8613.366211,392.928497,103.415718,3.81,0);
insert into waypoint (creatureGuid, waypointId, movetype, delay, x, y, z, o, actionid) VALUES(54512,3,0,30000,-8613.366211,392.928497,103.415718,3.81,1014);
insert into waypoint (creatureGuid, waypointId, movetype, delay, x, y, z, o, actionid) VALUES(54512,4,0,0,-8613.366211,392.928497,103.415718,0,1016);
insert into waypoint (creatureGuid, waypointId, movetype, delay, x, y, z, o, actionid) VALUES(54512,5,0,1500,-8610.216797,384.926208,102.925552,5.39,0);
insert into waypoint (creatureGuid, waypointId, movetype, delay, x, y, z, o, actionid) VALUES(54512,6,0,30000,-8610.216797,384.926208,102.925552,0,1015);
insert into waypoint (creatureGuid, waypointId, movetype, delay, x, y, z, o, actionid) VALUES(54512,7,0,0,-8614.659180,386.953430,102.925552,0,0);
insert into waypoint (creatureGuid, waypointId, movetype, delay, x, y, z, o, actionid) VALUES(54512,8,0,500,-8617.145508,389.777863,103.417091,0.672,0);
insert into waypoint (creatureGuid, waypointId, movetype, delay, x, y, z, o, actionid) VALUES(54512,9,0,30000,-8617.145508,389.777863,103.417091,0.672,1014);
insert into waypoint (creatureGuid, waypointId, movetype, delay, x, y, z, o, actionid) VALUES(54512,10,0,0,-8617.145508,389.777863,103.417091,0,1016);
insert into waypoint (creatureGuid, waypointId, movetype, delay, x, y, z, o, actionid) VALUES(54512,11,0,0,-8614.659180,386.953430,102.925552,0,0);
insert into waypoint (creatureGuid, waypointId, movetype, delay, x, y, z, o, actionid) VALUES(54512,12,0,30000,-8604.556641,389.633575,102.924469,5.39,0);
replace into kt_script.event_trigger_data set triggerid = 1014, eventtype = 27, EventIData1 = 1, note = 'State - Sit';
replace into kt_script.event_trigger_data set triggerid = 1016, eventtype = 27, EventIData1 = 0, note = 'State - Reset';
replace into kt_script.event_trigger_data set triggerid = 1015, eventtype = 6, EventIData1 = 5, note = 'Emote - Exclaim (yell)';
--]]