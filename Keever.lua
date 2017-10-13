--[[
    Benediction Lua Scripts
    NPC 5734 - Apothecary Keever
    Developed by Nogar
--]]

local Script = {}

function Script.Keever_Update(Unit, mapScript, timeDiff)
	if Script.StartEvent == nil then
		Unit:SendScriptTextById(11, 2061)
		Unit:SetSheathState(1)
		Unit:SendEmote(1)
		Unit:CastSpell(Unit,7077,false)
		Script.StartEvent = true
		Unit:CreateTimer("FirstVialEmote",9000)
	end
	if Script.StartEvent == true then
		Unit:UpdateTimers(timeDiff)
		if Unit:IsTimerFinished("FirstVialEmote") then
			Unit:RemoveTimer("FirstVialEmote")
			Unit:SendScriptTextById(11, 2062)
			Unit:SendEmote(1)
			Unit:CreateTimer("FirstVial",5000)
		elseif Unit:IsTimerFinished("FirstVial") then
			Unit:RemoveTimer("FirstVial")
			Unit:SendScriptTextById(13, 2075)
			Unit:SetSheathState(0)
			Unit:CreateTimer("TurnFrog",2000)
		elseif Unit:IsTimerFinished("TurnFrog") then
			Unit:RemoveTimer("TurnFrog")
			Script.Caged:SwapCreatureEntry(5742, true)
			Unit:CreateTimer("PokeFrog",5000)
		elseif Unit:IsTimerFinished("PokeFrog") then
			Unit:RemoveTimer("PokeFrog")
			Unit:SendScriptTextById(13, 2064)
			Unit:SetStandState(8)
			Unit:CreateTimer("Earthroot",9000)
		elseif Unit:IsTimerFinished("Earthroot") then
			Unit:RemoveTimer("Earthroot")
			Unit:SetStandState(0)
			Unit:SetSheathState(1)
			Unit:SendScriptTextById(11, 2063)
			Unit:CreateTimer("Vial2",5000)
		elseif Unit:IsTimerFinished("Vial2") then
			Unit:RemoveTimer("Vial2")
			Unit:SetStandState(8)
			Unit:SendScriptTextById(13, 2065)
			Unit:CreateTimer("TurnSquirrel",3000)
		elseif Unit:IsTimerFinished("TurnSquirrel") then
			Unit:RemoveTimer("TurnSquirrel")
			Script.Caged:SwapCreatureEntry(5739, true)
			Unit:CreateTimer("PokeSquirrel",5000)
		elseif Unit:IsTimerFinished("PokeSquirrel") then
			Unit:RemoveTimer("PokeSquirrel")
			Unit:SendScriptTextById(13, 2066)
			Unit:CreateTimer("NotRight",11000)
		elseif Unit:IsTimerFinished("NotRight") then
			Unit:RemoveTimer("NotRight")
			Unit:SetStandState(0)
			Unit:SendScriptTextById(11, 2067)
			Unit:CreateTimer("Vial3",5000)
		elseif Unit:IsTimerFinished("Vial3") then
			Unit:RemoveTimer("Vial3")
			Unit:SendScriptTextById(13, 2068)
			Unit:SetStandState(8)
			Unit:CreateTimer("TurnRabbit",3000)
		elseif Unit:IsTimerFinished("TurnRabbit") then
			Unit:RemoveTimer("TurnRabbit")
			Script.Caged:SwapCreatureEntry(5741, true)
			Unit:CreateTimer("PokeRabbit",5000)
		elseif Unit:IsTimerFinished("PokeRabbit") then
			Unit:RemoveTimer("PokeRabbit")
			Unit:SendScriptTextById(13, 2069)
			Unit:CreateTimer("UnhappyRabbit",5000)
		elseif Unit:IsTimerFinished("UnhappyRabbit") then
			Unit:RemoveTimer("UnhappyRabbit")
			Unit:SetStandState(0)
			Unit:SendScriptTextById(11, 2070)
			Unit:CreateTimer("Vial4",9000)
		elseif Unit:IsTimerFinished("Vial4") then
			Unit:RemoveTimer("Vial4")
			Unit:SendScriptTextById(13, 2071)
			Unit:SetStandState(8)
			Unit:SetSheathState(0)
			Unit:CreateTimer("TurnSheep",3000)
		elseif Unit:IsTimerFinished("TurnSheep") then
			Unit:RemoveTimer("TurnSheep")
			Script.Caged:SwapCreatureEntry(5743, true)
			Unit:CreateTimer("AngrySheep",2000)
		elseif Unit:IsTimerFinished("AngrySheep") then
			Unit:RemoveTimer("AngrySheep")
			Unit:SetStandState(0)
			Unit:SendScriptTextById(11, 2072)
			Unit:CreateTimer("PokeSheep",4000)
		elseif Unit:IsTimerFinished("PokeSheep") then
			Unit:RemoveTimer("PokeSheep")
			Unit:SendScriptTextById(13, 2073)
			Unit:CreateTimer("Explode",3000)
		elseif Unit:IsTimerFinished("Explode") then
			Unit:RemoveTimer("Explode")
			Script.Caged:CastSpell(Script.Caged,7670,false)
			Unit:CreateTimer("KillSheep",500)
		elseif Unit:IsTimerFinished("KillSheep") then
			Unit:RemoveTimer("KillSheep")
			Script.Caged:Suicide()
			Unit:CreateTimer("Pleased",4000)
		elseif Unit:IsTimerFinished("Pleased") then
			Unit:RemoveTimer("Pleased")
			Script.Caged:Despawn(5000,0)
			Unit:SendScriptTextById(11, 2074)
			Unit:SetSheathState(1)
			Unit:CreateTimer("EndAndStart",30000)
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

function Script.Keever_OnSpellCast(Unit, Spell, Target)
		Script.Caged = Unit:SpawnCreatureAtPosition(5736,1400.849976,363.242004,-84.867996, 1.117)
end




RegisterUnitEvent(5734, 23, Script.Keever_Update)
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
    
update kt_world.creature_names set name = 'Squirrel' where name like 'caged Squirrel';
update kt_world.creature_names set name = 'Toad' where name like 'caged Toad';
update kt_world.creature_names set name = 'Skittish Rabbit' where name like 'caged Rabbit';
update kt_world.creature_names set name = 'Wooly Sheep' where name like 'caged Sheep';
Update kt_world.creature_proto set equipitem0 = 2198  where entry = 5734;
delete from kt_world.creature_spawns where entry = 5736;
--]]
