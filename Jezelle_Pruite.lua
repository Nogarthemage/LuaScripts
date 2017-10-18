--[[
    Benediction Lua Scripts
    NPC 5702 - Jezelle Pruite
    Developed by Nogar
--]]

local Script = {}

function Script.Adrian_OnSpawn(Unit)
	Script.Adrian = Unit:GetCreatureBySqlId(36649)
end

function Script.Winifred_OnSpawn(Unit)
	Script.Winifred = Unit:GetCreatureBySqlId(36305)
end

function Script.Victor_OnSpawn(Unit)
	Script.Victor = Unit:GetCreatureBySqlId(36644)
end

function Script.Jezelle_Update(Unit, mapScript, timeDiff)
	if Script.StartEvent == nil then
		Script.SpellCounter = 0
		Unit:SendScriptTextById(11, 2049)
		Unit:SendEmote(1)
		Unit:CreateTimer("Lessons", 14000)
		Script.StartEvent = true
	elseif Script.StartEvent == true then
		Unit:UpdateTimers(timeDiff)
		if Unit:IsTimerFinished("Lessons") then
			Unit:RemoveTimer("Lessons")
			Unit:SendScriptTextById(11, 2050)
			Unit:CastSpell(Unit, 8677, false)
			Unit:CreateTimer("SummonImp",7000)
		elseif Unit:IsTimerFinished("SummonImp") then
			Unit:RemoveTimer("SummonImp")
			Unit:SendScriptTextById(11, 2051)
			Script.Adrian:SendEmote(11)
			Unit:SendEmote(1)
			Unit:CreateTimer("ExplainVoid",17000)
		elseif Unit:IsTimerFinished("ExplainVoid") then
			Unit:RemoveTimer("ExplainVoid")
			Unit:SendScriptTextById(11, 2052)
			Script.Imp:CastSpell(Script.Imp, 7141, false)
			Script.Imp:Despawn(1000,0)
			Unit:CastSpell(Unit, 8677, false)
			Unit:CreateTimer("SummonVoid",7000)
		elseif Unit:IsTimerFinished("SummonVoid") then
			Unit:RemoveTimer("SummonVoid")
			Script.Winifred:SendEmote(17)
			Unit:SendScriptTextById(11, 2053)
			Unit:SendEmote(1)
			Unit:CreateTimer("ExplainSucc",17000)
		elseif Unit:IsTimerFinished("ExplainSucc") then
			Unit:RemoveTimer("ExplainSucc")
			Unit:SendScriptTextById(11, 2054)
			Script.Void:CastSpell(Script.Void, 7141, false)
			Script.Void:Despawn(1000,0)
			Unit:CastSpell(Unit, 8677, false)
			Unit:CreateTimer("SummonSucc",7000)
		elseif Unit:IsTimerFinished("SummonSucc") then
			Unit:RemoveTimer("SummonSucc")
			Unit:SendScriptTextById(11, 2055)
			Unit:SendEmote(1)
			Unit:CreateTimer("ExplainHunter",17000)
		elseif Unit:IsTimerFinished("ExplainHunter") then
			Unit:RemoveTimer("ExplainHunter")
			Unit:SendScriptTextById(11, 2056)
			Script.Succ:CastSpell(Script.Succ, 7141, false)
			Script.Succ:Despawn(1000,0)
			Unit:CastSpell(Unit, 8677, false)
			Unit:CreateTimer("SummonHunter",7000)
		elseif Unit:IsTimerFinished("SummonHunter") then
			Unit:RemoveTimer("SummonHunter")
			Unit:SendScriptTextById(11, 2057)
			Unit:SendEmote(1)
			Unit:CreateTimer("ExplainSteed",17000)
		elseif Unit:IsTimerFinished("ExplainSteed") then
			Unit:RemoveTimer("ExplainSteed")
			Unit:SendScriptTextById(11, 2058)
			Script.Hunter:CastSpell(Script.Hunter, 7141, false)
			Script.Hunter:Despawn(1000,0)
			Unit:CastSpell(Unit, 8677, false)
			Unit:CreateTimer("SummonSteed",7000)
		elseif Unit:IsTimerFinished("SummonSteed") then
			Unit:RemoveTimer("SummonSteed")
			Unit:SendScriptTextById(11, 2059)
			Unit:SendEmote(1)
			Unit:CreateTimer("EndingEmote",17000)
		elseif Unit:IsTimerFinished("EndingEmote") then
			Unit:RemoveTimer("EndingEmote")
			Unit:SendScriptTextById(11, 2060)
			Unit:SendEmote(2)
			Script.Steed:CastSpell(Script.Steed, 7141, false)
			Script.Steed:Despawn(1000,0)
			Script.Adrian:SendEmote(21)
			Script.Winifred:SendEmote(21)
			Script.Victor:SendEmote(21)
			Unit:CreateTimer("EndAndStart",120000)
			Script.StartEvent = false
		end
	end
	if Script.StartEvent == false then
		Unit:UpdateTimers(timeDiff)
		if Unit:IsTimerFinished("EndAndStart") then
			Unit:RemoveTimer("EndAndStart")
			Script.StartEvent = nil
		end
	end
end

function Script.Jezelle_OnSpellCast(Unit, Spell, Target)
	if Script.SpellCounter == 0 then
		Script.Imp = Unit:SpawnCreatureAtPosition(5730,1793.282104,128.850159,-63.843094, 3.6)
		Script.SpellCounter = Script.SpellCounter + 1
	elseif Script.SpellCounter == 1 then
		Script.Void = Unit:SpawnCreatureAtPosition(5729,1793.282104,128.850159,-63.843094, 3.6)
		Script.SpellCounter = Script.SpellCounter + 1
	elseif Script.SpellCounter == 2 then
		Script.Succ = Unit:SpawnCreatureAtPosition(5728,1793.282104,128.850159,-63.843094, 3.6)
		Script.Adrian:SendEmote(4)
		Script.Victor:SendEmote(24)
		Script.SpellCounter = Script.SpellCounter + 1
	elseif Script.SpellCounter == 3 then
		Script.Hunter = Unit:SpawnCreatureAtPosition(5726,1793.282104,128.850159,-63.843094, 3.6)
		Script.SpellCounter = Script.SpellCounter + 1
	elseif Script.SpellCounter == 4 then
		Script.Steed = Unit:SpawnCreatureAtPosition(5727,1793.282104,128.850159,-63.843094, 3.6)
		Script.Winifred:SendEmote(5)
		Script.SpellCounter = Script.SpellCounter + 1
	end
end

--RegisterUnitEvent(5702, 1, Script.Jezelle_Spawn)
RegisterUnitEvent(5702, 23, Script.Jezelle_Update)
RegisterUnitEvent(5702, 8, Script.Jezelle_OnSpellCast)
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