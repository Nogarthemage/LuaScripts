--[[
    Benediction Lua Scripts
    Quest 489 - Seek Redemption!
    Developed by Nogar
--]]


function Zenn_OnConcludeQuest(Unit, QuestId, Player)
	if Questid == 489 then
		Unit:SendScriptTextById(11, 886) -- emote
		Unit:ForceCastSpell(Unit, 3329, false, 2028) -- turns himself into a frog
		Unit:SetNpcFlags(0) -- avoid players talking to him since... he's a frog
		Unit:PushRandomMovement(1) -- making from walk around randomly
	end
end

function Zenn_OnRemoveAura(Unit, AuraId)
	Unit:SetNpcFlags(2) -- re-activate gossip
	Unit:MoveToLocation(9920.86,738.112, 1314.33, 4.36, true, true, true, false) -- make him go back to his original position
	Unit:ResetMovement() -- reset the random movement
end

RegisterUnitEvent(2150, 17,  "Zenn_OnConcludeQuest")
RegisterUnitEvent(2150, 21,  "Zenn_OnRemoveAura")


-- update creature_spawns set randomspread = 0, position_x = 9920.86, position_y = 738.112, position_z =  1314.33, orientation = 4.36 where entry = 2150;
