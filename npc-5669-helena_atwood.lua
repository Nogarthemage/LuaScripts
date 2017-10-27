--[[
    Benediction Lua Scripts
    NPC 5669 - Helena Atwood
    Developed by Nogar
--]]

local Script = {}

function Script.Target_Spawn(Unit)
	Script.Target = Unit
end

function Script.Helena_Spawn(Unit)
	Script.Shoot = false
	Script.ShootC = 0
end

function Script.Helena_Death(Unit, Killer)
	Script.Shoot = nil
end

function Script.Helena_Update(Unit, mapScript, timeDiff)
	if Script.Shoot == false then
		Script.ShootC = Script.ShootC + 1
		if Script.ShootC == 14 then
			Script.Shoot = true
			Script.ShootC = 0
		end
	end
	if Script.Shoot == true then
		Unit:CastSpell(Script.Target,7918,false)
		Script.Shoot = false
	end
end



RegisterUnitEvent(5669, 1, Script.Helena_Spawn)
RegisterUnitEvent(5669, 2, Script.Helena_Death)
RegisterUnitEvent(5669, 23, Script.Helena_Update)
RegisterUnitEvent(5674, 1, Script.Target_Spawn)









--[[

update kt_world.creature_spawns set entry = 5669, position_x = 1717.003662, position_y = 289.931335, position_z = -62.189739, orientation= 4.94, unitBytes2 = 4097 where entry = 5669;
delete from kt_world.waypoint where creatureGuid = 39847;

--]]