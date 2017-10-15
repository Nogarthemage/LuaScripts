--[[
    Benediction Lua Scripts
    Quest 1286 - The Deserters
    Developed by Nogar
--]]

local Script = {}


function Script.Balos_OnDamageTaken(Unit, Attacker, Amount)
	if Script.Init == nil then
		Script.Deserter1 = nil
		Script.Deserter1 = nil
		Script.Deserter1 = nil
		if Unit:GetCreatureBySqlId(30242) ~= nil then
			Script.Deserter1 = Unit:GetCreatureBySqlId(30242)
			Script.Deserter1:StartCombat(Attacker)
		end
		if Unit:GetCreatureBySqlId(30246) ~= nil then
			Script.Deserter2 = Unit:GetCreatureBySqlId(30246)
			Script.Deserter2:StartCombat(Attacker)
		end
		if Unit:GetCreatureBySqlId(30241) ~= nil then
			Script.Deserter3 = Unit:GetCreatureBySqlId(30241)
			Script.Deserter3:StartCombat(Attacker)
		end
		Script.Init = true
	end
	local Perc = 15 -- HP on wich he will turn normal
	if Unit:GetHealthPct() <= Perc then
		Unit:SetUnitFlags(512)
		Unit:EnterEvadeMode()
		Unit:SetCanEnterCombat(false) 
		Unit:RemoveAllNegativeAuras() -- remove DoTs and other debuffs to prevent abuse
		Unit:RemoveAllNonPassiveAuras() -- safety precautions
		Unit:SetTemporaryFaction(1077) -- turn him back into friendly
		Unit:SetHealthPct(100) -- heal him to 100% HP
		Unit:SetNpcFlags(2) -- Add gossip capabilites 
		Unit:SendScriptTextById(11, 1756)
		Unit:SendEmote(1)
		Script.UpdateCheck = true
		Unit:CreateTimer("RevertFac",60000)
	end
end

function Script.Balos_CombatEnd(Unit)
	Script.Init = nil
end

function Script.Balos_AIUpdate(Unit, mapScript, timeDiff)
	if Script.UpdateCheck == true then
		Unit:UpdateTimers(timeDiff)
		if Unit:IsTimerFinished("RevertFac") then
			Unit:RemoveTimer("RevertFac")
			Unit:ClearTemporaryFaction()
			Unit:SetNpcFlags(0)
			Unit:SetUnitFlags(0)
			Unit:SetCanEnterCombat(true)
			Script.UpdateCheck = nil
			Script.Init = nil
		end
	end
end



RegisterUnitEvent(5089, 4,  Script.Balos_CombatEnd)
RegisterUnitEvent(5089, 9,  Script.Balos_OnDamageTaken)
RegisterUnitEvent(5089, 23,  Script.Balos_AIUpdate)

--[[
update kt_world.creature_proto set npcflags = 0 where entry = 5089;
update kt_world.creature_spawns set factionid = 36 where entry in (5057,5089);
update kt_world.creature_proto set JadeFlags = 2 where entry = 5089;
--]]
