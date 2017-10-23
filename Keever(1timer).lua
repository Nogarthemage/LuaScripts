--[[
    Benediction Lua Scripts
    NPC 5734 - Apothecary Keever
    Developed by Nogar
--]]

local Script = {}

function Script.Keever_AIUpdate(Unit, mapScript, timeDiff)
	if not Script.CagedMinion then return end
	Unit:UpdateTimers(timeDiff)
	if Script.Phase == 1  and not Unit:IsInCombat() and Unit:IsTimerFinished(4321) then
		Script.Phase = 2
		Unit:SendScriptTextById(11, 2062)
		Unit:SendEmote(1)
		Unit:ResetTimer(4321,5000)
		return	
	end
	if Script.Phase == 2  and not Unit:IsInCombat() and Unit:IsTimerFinished(4321) then
		Script.Phase = 3
		Unit:SendScriptTextById(13, 2075)
		Unit:SetSheathState(0)
		Unit:ResetTimer(4321,2000)
		return
	end
	if Script.Phase == 3  and not Unit:IsInCombat() and Unit:IsTimerFinished(4321) then
		Script.Phase = 4
		Script.CagedMinion:SwapCreatureEntry(5742, true)
		Unit:ResetTimer(4321,5000)
		return
	end
	if Script.Phase == 4  and not Unit:IsInCombat() and Unit:IsTimerFinished(4321) then
		Script.Phase = 5
		Unit:SendScriptTextById(13, 2064)
		Unit:SetStandState(8)
		Unit:ResetTimer(4321,9000)
		return
	end
	if Script.Phase == 5  and not Unit:IsInCombat() and Unit:IsTimerFinished(4321) then
		Script.Phase = 6
		Unit:SetStandState(0)
		Unit:SetSheathState(1)
		Unit:SendScriptTextById(11, 2063)
		Unit:ResetTimer(4321,5000)
		return
	end
	if Script.Phase == 6  and not Unit:IsInCombat() and Unit:IsTimerFinished(4321) then
		Script.Phase = 7
		Unit:SetStandState(8)
		Unit:SendScriptTextById(13, 2065)
		Unit:ResetTimer(4321,3000)
		return
	end
	if Script.Phase == 7  and not Unit:IsInCombat() and Unit:IsTimerFinished(4321) then
		Script.Phase = 8
		Script.CagedMinion:SwapCreatureEntry(5739, true)
		Unit:ResetTimer(4321,5000)
		return
	end
	if Script.Phase == 8  and not Unit:IsInCombat() and Unit:IsTimerFinished(4321) then
		Script.Phase = 9
		Unit:SendScriptTextById(13, 2066)
		Unit:ResetTimer(4321,11000)
		return
	end
	if Script.Phase == 9  and not Unit:IsInCombat() and Unit:IsTimerFinished(4321) then
		Script.Phase = 10
		Unit:SetStandState(0)
		Unit:SendScriptTextById(11, 2067)
		Unit:ResetTimer(4321,5000)
		return
	end
	if Script.Phase == 10  and not Unit:IsInCombat() and Unit:IsTimerFinished(4321) then
		Script.Phase = 11
		Unit:SendScriptTextById(13, 2068)
		Unit:SetStandState(8)
		Unit:ResetTimer(4321,3000)
		return
	end
	if Script.Phase == 11  and not Unit:IsInCombat() and Unit:IsTimerFinished(4321) then
		Script.Phase = 12
		Script.CagedMinion:SwapCreatureEntry(5741, true)
		Unit:ResetTimer(4321,5000)
		return
	end
	if Script.Phase == 12  and not Unit:IsInCombat() and Unit:IsTimerFinished(4321) then
		Script.Phase = 13
		Unit:SendScriptTextById(13, 2069)
		Unit:ResetTimer(4321,5000)
		return
	end
	if Script.Phase == 13  and not Unit:IsInCombat() and Unit:IsTimerFinished(4321) then
		Script.Phase = 14
		Unit:SetStandState(0)
		Unit:SendScriptTextById(11, 2070)
		Unit:ResetTimer(4321,9000)
		return
	end
	if Script.Phase == 14  and not Unit:IsInCombat() and Unit:IsTimerFinished(4321) then
		Script.Phase = 15
		Unit:SendScriptTextById(13, 2071)
		Unit:SetStandState(8)
		Unit:SetSheathState(0)
		Unit:ResetTimer(4321,3000)
		return
	end
	if Script.Phase == 15  and not Unit:IsInCombat() and Unit:IsTimerFinished(4321) then
		Script.Phase = 16
		Script.CagedMinion:SwapCreatureEntry(5743, true)
		Unit:ResetTimer(4321,2000)
		return
	end
	if Script.Phase == 16  and not Unit:IsInCombat() and Unit:IsTimerFinished(4321) then
		Script.Phase = 17
		Unit:SetStandState(0)
		Unit:SendScriptTextById(11, 2072)
		Unit:ResetTimer(4321,4000)
		return
	end
	if Script.Phase == 17  and not Unit:IsInCombat() and Unit:IsTimerFinished(4321) then
		Script.Phase = 18
		Unit:SendScriptTextById(13, 2073)
		Unit:ResetTimer(4321,3000)
		return
	end
	if Script.Phase == 18  and not Unit:IsInCombat() and Unit:IsTimerFinished(4321) then
		Script.Phase = 19
		Script.CagedMinion:CastSpell(Script.CagedMinion,7670,false)
		Unit:ResetTimer(4321,500)
		return
	end
	if Script.Phase == 19  and not Unit:IsInCombat() and Unit:IsTimerFinished(4321) then
		Script.Phase = 20
		Script.CagedMinion:Suicide()
		Unit:ResetTimer(4321,4000)
		return
	end
	if Script.Phase == 20  and not Unit:IsInCombat() and Unit:IsTimerFinished(4321) then
		Script.Phase = 21
		Script.CagedMinion:Despawn(5000,0)
		Unit:SendScriptTextById(11, 2074)
		Unit:SetSheathState(1)
		Unit:ResetTimer(4321,30000)
		return
	end
	if Script.Phase == 21  and not Unit:IsInCombat() and Unit:IsTimerFinished(4321) then
		Script.Phase = 22
		Script.CagedMinion = nil
		Script.Restart(Unit)
		return
	end
end

function Script.Keever_OnSpellCast(Unit, Spell, Target)
	if Spell:GetSpellId() == 7077 then
		Script.CagedMinion = Unit:SpawnCreatureAtPosition(5736,1400.849976,363.242004,-84.867996, 1.117)
		Unit:ResetTimer(4321,9000)
		Script.Phase = 1
	end
end

function Script.Restart(Unit)
	if not Script.CagedMinion then
		Unit:SendScriptTextById(11, 2061)
		Unit:SetSheathState(1)
		Unit:SendEmote(1)		
		Unit:CastSpell(Unit,7077,false)
		Script.Phase = nil
		return
	end	
	if Script.CagedMinion then
		Script.CagedMinion:Despawn(0,0)
		Unit:SendScriptTextById(11, 2061)
		Unit:SetSheathState(1)
		Unit:SendEmote(1)		
		Unit:CastSpell(Unit,7077,false)
		Script.Phase = nil
	end
end

function Script.Keever_Spawn(Unit)
	Script.Restart(Unit)
	Unit:CreateTimer(4321,1000)
end

function Script.Keever_Death(Unit, Killer)
	Unit:RemoveTimer(4321)
	Script.Phase = nil
end

RegisterUnitEvent(5734, 1, Script.Keever_Spawn)
RegisterUnitEvent(5734, 2, Script.Keever_Death)
RegisterUnitEvent(5734,23, Script.Keever_AIUpdate)
RegisterUnitEvent(5734, 8, Script.Keever_OnSpellCast)
	

--[[
2061	33	0	Hmm, it would seem Keever needs a new subject. If that fool Abernathy keeps taking Keever's subjects, Keever may have to have a word with him.
2062	33	0	Ahh, there we go. Now, Keever must try this vial and see if it works.
2063	33	0	Not what Keever was hoping for. Keever may have added too much earthroot. Let's see if the second serum will do what Keever needs.
2064	0	0	%s pokes the small toad.
2065	0	0	%s feeds the toad some of the strange liquid.
2066	0	0	%s pokes the small fuzzy squirrel with obvious disappointment.
2067	33	0	Well, that is just not right. The creature is far too small. Let us see what Keever's third batch will do.
2068	0	0	%s feeds the squirrel some of the viscous fluid.
2069	0	0	%s pokes the skittish rabbit.
2070	33	0	Keever is unhappy with this. Perhaps if Keever were to try a larger dose, that may fix this dilemma.
2071	0	0	%s grabs the rabbit and pours the fluid down its throat, then sets it back inside the cage.
2072	33	0	What is this? Did Keever ask for a sheep? Keever wanted a weapon of great power and all he got was this sheep. Keever is very disappointed.
2073	0	0	%s pokes the wooly sheep repeatedly.
2074	33	0	Keever is most pleased.

SQL
    
update kt_world.creature_names set name = 'Squirrel' where entry = 5739;
update kt_world.creature_names set name = 'Toad' where entry = 5742;
update kt_world.creature_names set name = 'Skittish Rabbit' where entry = 5741;
update kt_world.creature_names set name = 'Wooly Sheep' where entry = 5743;
Update kt_world.creature_proto set equipitem0 = 2198  where entry = 5734;
update kt_world.creature_spawns set unitbytes1 = 0 where entry = 5734;
delete from kt_world.creature_spawns where id = 42978;
--]]
