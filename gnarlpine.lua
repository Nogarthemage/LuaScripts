GNARL = {}

function Gnarlpine_Death(Unit, Attacker)
	GNARL.GUnit = tostring(Unit) -- saving the dying unit for the buffed unit to recognise (comment = *A)
	local PlayerIdentifier = GNARL.GUnit -- dying unit is used as objectID to identify the player that has to be attacked (comment *B)
	GNARL.Player = {}
	GNARL.Player[PlayerIdentifier] = Attacker -- saving the Player that has to be Attacked in this variable of the object we made in comment *B
	Unit:CastSpell(Unit,5628,false)	-- Cast the buff around him for other Units
	
end



function Gnarlpine_OnSpellTaken(Unit, Attacker, Spell)
	if tostring(Attacker) == GNARL.GUnit then -- comment A*, a spell comes in and if it originates from the dying unit, trigger the attackplayer command
		local PlayerIdentifier = tostring(Attacker) -- find the player in Memory by putting the correct value in the PlayerIdentifier
		Unit:StartCombat(GNARL.Player[PlayerIdentifier]) -- attack the player
		GNARL.GUnit = nil -- nil it again so this function doesnt go into a loop from any spell the mob recieves
	end
	
end

RegisterUnitEvent(2006, 2,  "Gnarlpine_Death")
RegisterUnitEvent(2007, 2,  "Gnarlpine_Death")
RegisterUnitEvent(2008, 2,  "Gnarlpine_Death")
-- RegisterUnitEvent(2009, 2,  "Gnarlpine_Death") shamans didnt have it research showed
-- RegisterUnitEvent(2010, 2,  "Gnarlpine_Death") defenders neither
RegisterUnitEvent(2011, 2,  "Gnarlpine_Death")
RegisterUnitEvent(2012, 2,  "Gnarlpine_Death")
RegisterUnitEvent(2013, 2,  "Gnarlpine_Death")
RegisterUnitEvent(2014, 2,  "Gnarlpine_Death")
RegisterUnitEvent(2152, 2,  "Gnarlpine_Death")
RegisterUnitEvent(7235, 2,  "Gnarlpine_Death")
RegisterUnitEvent(11690,2,  "Gnarlpine_Death")
RegisterUnitEvent(2006, 11,  "Gnarlpine_OnSpellTaken")
RegisterUnitEvent(2007, 11,  "Gnarlpine_OnSpellTaken")
RegisterUnitEvent(2008, 11,  "Gnarlpine_OnSpellTaken")
RegisterUnitEvent(2009, 11,  "Gnarlpine_OnSpellTaken")
RegisterUnitEvent(2010, 11,  "Gnarlpine_OnSpellTaken")
RegisterUnitEvent(2011, 11,  "Gnarlpine_OnSpellTaken")
RegisterUnitEvent(2012, 11,  "Gnarlpine_OnSpellTaken")
RegisterUnitEvent(2013, 11,  "Gnarlpine_OnSpellTaken")
RegisterUnitEvent(2014, 11,  "Gnarlpine_OnSpellTaken")
RegisterUnitEvent(2039, 11,  "Gnarlpine_OnSpellTaken")
RegisterUnitEvent(2152, 11,  "Gnarlpine_OnSpellTaken")
RegisterUnitEvent(7235, 11,  "Gnarlpine_OnSpellTaken")
RegisterUnitEvent(11690,11,  "Gnarlpine_OnSpellTaken")

-- update kt_spell.spellcorrections set ImplicitTargetA0 = 30, ImplicitTargetA1 = 30, ImplicitTargetA2 = 30, ImplicitTargetB0 = 0, ImplicitTargetB1 = 0, ImplicitTargetB2 = 0 where spellid = 5628;