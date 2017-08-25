--[[
    Benediction Lua Scripts
	NPC - 1564 - BloodSail Warlock
    Developed by Nogar
--]]

function BloodSailWarlock_Spawn(Unit)
	local PetRoll = math.random(1, 2)
	if PetRoll == 1 then
		Unit:CastSpell(Unit, 23502, false)
	else
		Unit:CastSpell(Unit, 23503, false)
	end
end

RegisterUnitEvent(1564, 1,  "BloodSailWarlock_Spawn")