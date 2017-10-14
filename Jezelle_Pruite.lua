--[[
    Benediction Lua Scripts
    NPC 5702 - Jezelle Pruite
    Developed by Nogar
--]]

local Script = {}

function Script.Jezelle_Update(Unit, mapScript, timeDiff)
	if Script.StartEvent == nil then
		if Script.Adrian ~= nil or Script.Winifred ~= nil or Script.Victor ~= nil then
			Script.Adrian = Unit:GetCreatureBySqlId(36649)
			Script.Winifred = Unit:GetCreatureBySqlId(36305)
			Script.Victor = Unit:GetCreatureBySqlId(36644)
			Script.Initialize = true
		end
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
		Script.Imp = Unit:SpawnCreatureAtPosition(7,1793.282104,128.850159,-63.843094, 3.6)
		Script.SpellCounter = Script.SpellCounter + 1
	elseif Script.SpellCounter == 1 then
		Script.Void = Unit:SpawnCreatureAtPosition(8,1793.282104,128.850159,-63.843094, 3.6)
		Script.SpellCounter = Script.SpellCounter + 1
	elseif Script.SpellCounter == 2 then
		Script.Succ = Unit:SpawnCreatureAtPosition(9,1793.282104,128.850159,-63.843094, 3.6)
		Script.Adrian:SendEmote(4)
		Script.Victor:SendEmote(24)
		Script.SpellCounter = Script.SpellCounter + 1
	elseif Script.SpellCounter == 3 then
		Script.Hunter = Unit:SpawnCreatureAtPosition(10,1793.282104,128.850159,-63.843094, 3.6)
		Script.SpellCounter = Script.SpellCounter + 1
	elseif Script.SpellCounter == 4 then
		Script.Steed = Unit:SpawnCreatureAtPosition(11,1793.282104,128.850159,-63.843094, 3.6)
		Script.Winifred:SendEmote(5)
		Script.SpellCounter = Script.SpellCounter + 1
	end
end

--RegisterUnitEvent(5702, 1, Script.Jezelle_Spawn)
RegisterUnitEvent(5702, 23, Script.Jezelle_Update)
RegisterUnitEvent(5702, 8, Script.Jezelle_OnSpellCast)

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

Replace into kt_world.creature_proto values(11,40,40,35,3116,3116,0,0,1,0,2000,0,4,9,10,0,0,100,2200,1,2,0,0,0,360000,15,15,0,0,0,0,0,0,0,0,0,0,0,128,3,0,1);
Replace into kt_world.creature_proto values(7,4,4,35,166,166,85,85,0.6,0,2000,0,3,6,8,3,0,100,2000,8,11,0,0,0,360000,20,20,0,0,0,0,0,0,0,0,0,0,0,128,3,0,1);
Replace into kt_world.creature_proto values(8,10,10,35,548,548,300,300,0.9,0,2000,0,8,15,19,0,0,100,2000,23,31,0,0,0,360000,20,20,0,0,0,0,0,0,0,0,0,0,0,128,1,0,1);
Replace into kt_world.creature_proto values(10,30,30,35,2666,2666,1630,1666,0.85,0,2000,0,58,94,127,0,0,100,2000,74,102,0,0,0,360000,3327,3327,0,0,0,0,0,0,0,0,0,0,0,128,1,0,1);
Replace into kt_world.creature_proto values(9,20,20,35,1456,1456,436,436,1,0,2000,0,13,24,31,0,0,100,2000,31,43,0,0,0,360000,712,712,0,0,0,0,0,0,0,0,0,0,0,128,1,0,1);

Replace into kt_world.creature_names values(11,'Felsteed','',0,3,0,0,0,2346,0,0,0,0,0,4044);
Replace into kt_world.creature_names values(7,'Imp','',0,3,23,0,0,4449,0,0,0,0,0,4044);
Replace into kt_world.creature_names values(8,'Voidwalker','',0,3,16,0,0,1132,0,0,0,0,0,4044);
Replace into kt_world.creature_names values(10,'Felhunter','',0,3,15,0,0,850,0,0,0,0,0,4044);
Replace into kt_world.creature_names values(9,'Succubus','',0,3,17,0,0,4162,0,0,0,0,0,4044);

--]]