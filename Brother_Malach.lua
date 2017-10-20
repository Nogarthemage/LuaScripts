--[[
    Benediction Lua Scripts
    NPC 5661 - Brother Malach
    Developed by Nogar
--]]

local Script = {}


function Script.Malach_OnRecieveEmote(Unit, Player, EmoteId)
	if Script.Initialize ~= true then
		Script.Lysta = Unit:GetCreatureBySqlId(36347)
		Script.Tyler = Unit:GetCreatureBySqlId(36372)
		Script.Edward = Unit:GetCreatureBySqlId(30489)
		Script.Richard = Unit:GetCreatureBySqlId(30487)
		Script.Robert = Unit:GetCreatureBySqlId(36662)
		Script.Andrew = Unit:GetCreatureBySqlId(39839)
		Script.Riley = Unit:GetCreatureBySqlId(30488)
		Script.Chloe = Unit:GetCreatureBySqlId(36658)
		Script.Maria = Unit:GetCreatureBySqlId(36665)
		Script.Initialize = true
	end
	Script.FemaleAttack = nil
	Script.Maledeath = nil
	Script.Killer = nil
	
	Unit:SendScriptTextById(11, 1978)
	Unit:CreateTimer("Summon1",4000)
	Script.Trigger1 = true
	Script.Summoncounter = 0
end

function Script.Malach_AIUpdate(Unit, mapScript, timeDiff)

	Unit:UpdateTimers(timeDiff)
	if Script.Trigger1 == true and Unit:IsTimerFinished("Summon1") then
		Script.Trigger1 = nil
		Unit:RemoveTimer("Summon1")
		Unit:SendScriptTextById(11, 1977)
		Script.Lysta:CastSpell(Unit, 3361, false)
	end
	
end

function Script.Lysta_OnSpellCast(Unit, Spell, Target)
	if Script.Summoncounter == 0 then
		Script.HumanM1 = Unit:SpawnCreatureAtPosition(5680,1734.625610,379.900665,-62.291000, 3.6)
		Script.HumanF = Unit:SpawnCreatureAtPosition(5681,1735.557861,378.017212,-62.266064, 3.74)
		Script.HumanM2 = Unit:SpawnCreatureAtPosition(5680,1737.061401,376.259460,-62.235027, 4.1)
		Script.Summoncounter = 1
	end
end


function Script.Male_Death(Unit, Killer)
	Script.Maledeath = true
	Script.Killer = Killer
end


function Script.Female_Spawn(Unit)
	Script.HumanM1:CastSpell(Unit, 12980, false)
	Script.HumanF:CastSpell(Unit, 12980, false)
	Script.HumanM2:CastSpell(Unit, 12980, false)
	Script.HumanM1:StartCombat(Script.Tyler) 
	Script.HumanF:SetEmoteState(20)
	--Script.HumanM2:StartCombat(Script.Edward)
end

function Script.FemaleAIUpdate(Unit, mapScript, timeDiff)
	if (not Script.Edward:IsInCombat() or not Script.Tyler:IsInCombat()) and Script.Maledeath == true then
		Script.HumanF:StartCombat(Script.Killer)
	end
end

RegisterUnitEvent(5661, 18,  Script.Malach_OnRecieveEmote)
RegisterUnitEvent(5681, 1,  Script.Female_Spawn)
RegisterUnitEvent(5680, 2,  Script.Male_Death)
RegisterUnitEvent(5680, 23,  Script.FemaleAIUpdate)
RegisterUnitEvent(5661, 23,  Script.Malach_AIUpdate)
RegisterUnitEvent(5679, 8,  Script.Lysta_OnSpellCast)





--[[
1978	33	0	Edward. Tyler. Prepare for your first challenge.
1977	33	0	Lysta, summon in the captives.
summons captives
1980	33	0	Not a challenge at all it seems. Let us see how you handle your second test. Lysta, bring forth the minions of the Lich King.
1981	33	0	Now prove your worth!
summons ghouls
1983	33	0	You show some worth after all. Lysta summon a surprise for our young recruits.
starts summoning
1984	33	0	It is time to face your final challenge young warriors! Prepare for your hardest fight yet.
is summoned
1985	33	0	Well done Edward and Tyler. You are progressing along in your training quite nicely. We shall test your mettle again soon.
--]]