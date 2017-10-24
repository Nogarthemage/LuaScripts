--[[
    Benediction Lua Scripts
    NPC 5702 - Jezelle Pruite
    Developed by Nogar
--]]

local Script = {}

function Script.Adrian_OnSpawn(Unit)
	Script.Adrian = Unit
end

function Script.Winifred_OnSpawn(Unit)
	Script.Winifred = Unit
end

function Script.Jezelle_OnHome(Unit)
	if Script.Phase%3 == 0 then
		Unit:SetFacing(4.1364)
		Unit:CastSpell(Unit, 8677, false)
	end
end

function Script.Jezelle_OnSpawn(Unit)
	Script.Phase = 0
	Unit:CreateTimer(4321,2500)
	Script.CheckTimer = nil
end

function Script.Jezelle_OnDeath(Unit, Killer)
	Script.Phase = 0
	Unit:RemoveTimer(4321)
	Script.CheckTimer = nil
	
end

function Script.Victor_OnSpawn(Unit)
	Script.Victor = Unit
end

function Script.Jezelle_Update(Unit, mapScript, timeDiff)
	if Script.CheckTimer == nil then
		Unit:UpdateTimers(timeDiff)
		if Unit:IsTimerFinished(4321) then
			Script.Phase = Script.Phase + 1
			Script.CheckTimer = false
		end
		return
	end
	if Script.Phase == 1 and not Unit:IsInCombat() then
		Unit:SendScriptTextById(11, 2049)
		Unit:SendEmote(1)
		Unit:ResetTimer(4321, 14000)
		Script.CheckTimer = nil
		return
	end
	if Script.Phase == 2 and not Unit:IsInCombat() then
		Script.Phase = 3
		Unit:SendScriptTextById(11, 2050)
		Unit:CastSpell(Unit, 8677, false)
		return
	end
	if Script.Phase == 4 and not Unit:IsInCombat() then
		Unit:SendScriptTextById(11, 2051)
		if Script.Adrian ~= nil then 
			Script.Adrian:SendEmote(11)
		end
		Unit:SendEmote(1)
		Unit:ResetTimer(4321,17000)
		Script.CheckTimer = nil
		return
	end
	if Script.Phase == 5 and not Unit:IsInCombat() then
		Unit:SendScriptTextById(11, 2052)
		Script.Phase = 6
		if Script.Imp ~= nil then 
			Script.Imp:CastSpell(Script.Imp, 7141, false)
		end
		Unit:CastSpell(Unit, 8677, false)
		return
	end
	if Script.Phase == 7 and not Unit:IsInCombat() then
		if Script.Winifred ~= nil then 
			Script.Winifred:SendEmote(17)
		end
		Unit:SendScriptTextById(11, 2053)
		Unit:SendEmote(1)
		Unit:ResetTimer(4321,17000)
		Script.CheckTimer = nil
		return
	end
	if Script.Phase == 8 and not Unit:IsInCombat() then
		Script.Phase = 9
		Unit:SendScriptTextById(11, 2054)
		if Script.Void ~= nil then 
			Script.Void:CastSpell(Script.Void, 7141, false)
		end
		Unit:CastSpell(Unit, 8677, false)
		return
	end
	if Script.Phase == 10 and not Unit:IsInCombat() then
		Unit:SendScriptTextById(11, 2055)
		Unit:SendEmote(1)
		Unit:ResetTimer(4321,17000)
		Script.CheckTimer = nil
		return
	end
	if Script.Phase == 11 and not Unit:IsInCombat() then
		Script.Phase = 12
		Unit:SendScriptTextById(11, 2056)
		if Script.Succ ~= nil then 
			Script.Succ:CastSpell(Script.Succ, 7141, false)
		end
		Unit:CastSpell(Unit, 8677, false)
		return
	end
	if Script.Phase == 13 and not Unit:IsInCombat() then
		Unit:SendScriptTextById(11, 2057)
		Unit:SendEmote(1)
		Unit:ResetTimer(4321,17000)
		Script.CheckTimer = nil
		return
	end
	if Script.Phase == 14 and not Unit:IsInCombat() then
		Script.Phase = 15
		Unit:SendScriptTextById(11, 2058)
		if Script.Hunter ~= nil then 
			Script.Hunter:CastSpell(Script.Hunter, 7141, false)
		end
		Unit:CastSpell(Unit, 8677, false)
		return
	end
	if Script.Phase == 16 and not Unit:IsInCombat() then
		Unit:SendScriptTextById(11, 2059)
		Unit:SendEmote(1)
		Unit:ResetTimer(4321,17000)
		Script.CheckTimer = nil
		return
	end
	if Script.Phase == 17  and not Unit:IsInCombat() then
		Unit:SendScriptTextById(11, 2060)
		Unit:SendEmote(2)
		if Script.Steed ~= nil then 
			Script.Steed:CastSpell(Script.Steed, 7141, false)
		end
		if Script.Adrian ~= nil then 
			Script.Adrian:SendEmote(21)
		end
		if Script.Winifred ~= nil then 
			Script.Winifred:SendEmote(21)
		end
		if Script.Victor ~= nil then 
			Script.Victor:SendEmote(21)
		end
		Unit:ResetTimer(4321,120000)
		Script.CheckTimer = nil
		return
	end
	if Script.Phase == 18  and not Unit:IsInCombat() then
		Script.Phase = 0
		Script.CheckTimer = nil
	end
end

function Script.Jezelle_OnSpellCast(Unit, Spell, Target)
	if Script.Phase == 3 then
		Script.Imp = Unit:SpawnCreatureAtPosition(5730,1793.282104,128.850159,-63.843094, 3.6)
		if Script.Imp ~= nil then
			Script.Imp:PushRandomMovement(1)
			Script.Imp:Despawn(20500,0)
		end
		Unit:ResetTimer(4321, 2000)
		Script.CheckTimer = nil
		return
	end
	if Script.Phase == 6 then
		Script.Void = Unit:SpawnCreatureAtPosition(5729,1793.282104,128.850159,-63.843094, 3.6)
		if Script.Void ~= nil then
			Script.Void:PushRandomMovement(1)
			Script.Void:Despawn(20500,0)
		end
		Unit:ResetTimer(4321,2000)
		Script.CheckTimer = nil
		return
	end
	if Script.Phase == 9 then
		Script.Succ = Unit:SpawnCreatureAtPosition(5728,1793.282104,128.850159,-63.843094, 3.6)
		if Script.Succ ~= nil then
			Script.Succ:PushRandomMovement(1)
			Script.Succ:Despawn(20500,0)
		end
		if Script.Adrian ~= nil then 
			Script.Adrian:SendEmote(4)
		end
		if Script.Victor ~= nil then 
			Script.Victor:SendEmote(24)
		end
		Unit:ResetTimer(4321,2000)
		Script.CheckTimer = nil
		return
	end
	if Script.Phase == 12 then
		Script.Hunter = Unit:SpawnCreatureAtPosition(5726,1793.282104,128.850159,-63.843094, 3.6)
		if Script.Hunter ~= nil then
			Script.Hunter:PushRandomMovement(1)
			Script.Hunter:Despawn(20500,0)
		end
		Unit:ResetTimer(4321,2000)
		Script.CheckTimer = nil
		return
	end
	if Script.Phase == 15 then
		Script.Steed = Unit:SpawnCreatureAtPosition(5727,1793.282104,128.850159,-63.843094, 3.6)
		if Script.Steed ~= nil then
			Script.Steed:PushRandomMovement(1)
			Script.Steed:Despawn(20500,0)
		end
		if Script.Winifred ~= nil then 
			Script.Winifred:SendEmote(5)
		end
		Unit:ResetTimer(4321,2000)
		Script.CheckTimer = nil
	end
end

--RegisterUnitEvent(5702, 1, Script.Jezelle_Spawn)
RegisterUnitEvent(5702, 23, Script.Jezelle_Update)
RegisterUnitEvent(5702, 8, Script.Jezelle_OnSpellCast)
RegisterUnitEvent(5702, 1, Script.Jezelle_OnSpawn)
RegisterUnitEvent(5702, 2, Script.Jezelle_OnDeath)
RegisterUnitEvent(5702, 15, Script.Jezelle_OnHome)
RegisterUnitEvent(5704, 1, Script.Adrian_OnSpawn)
RegisterUnitEvent(5703, 1, Script.Winifred_OnSpawn)
RegisterUnitEvent(5705, 1, Script.Victor_OnSpawn)

--[[
2049	33	If you're here, then it means you are prepared to begin the study of summoning demonic cohorts to do your bidding. We will start with the lowliest creatures you will be able to call and continue from there. Let us begin.
2050	33	The easiest creature for you to summon is the imp. You should already be able to bring forth this minion but for completeness' sake I will start with him.
2051	33	This foul little beast is the imp. It is small and weak, making it almost useless as a meatshield, and its damage output is mediocre at best. This creature is best used for support of a larger group.
2052	33	Now that you have had a chance to study the imp, let us move on to the next minion you will be able to summon, the voidwalker.
2053	33	This demonic entity is known as the Voidwalker. Its strength and endurance are significant, making it ideal for defense. Send it to attack your enemy, then use it as a shield while you use your spells and abilities to drain away your opponent's life.
2054	33	If you've never seen one, it is a sight to behold. A very impressive creature both on and off the field of battle. Next, let us take a look at what I am sure all you male students have been waiting for. The succubus.
2055	33	All right now. Aside from the obvious distractions a minion like this will provide against your more masculine foes, she is also capable of dealing out impressive amounts of damage. However, her fragile endurance makes her almost useless as a shield.
2056	33	Study hard and you might one day be able to summon one on your own, but for now it's time to move on to the felhunter.
2057	33	What you see before you is a felhunter. This creature's natural talents include spell lock and other abilities which make it unequalled when facing a magically attuned opponent.
2058	33	When facing a spellcaster of any kind, this feral beast will be your best friend. Now, let us take a look at something a bit different. This next creature will aid your travels and make your future journeys much easier. Let's take a look at a felsteed.
2059	33	I doubt you have had much occasion to see such a creature. These demonic equines will make your travels much faster by acting as your mount as long as you control them. However, they are difficult to control, so be sure you are ready before attempting it.
 
2060	33	There you have it. Our lesson on summoning has come to an end. A new class will begin shortly, so if you wish to brush up, feel free to stay around.

SQL ------

update kt_world.creature_proto set scale = 0.9 where entry = 5729;
update kt_world.creature_proto set scale = 0.8 where entry = 5726;
update kt_world.creature_proto set scale = 1.1 where entry = 5728;

--]]