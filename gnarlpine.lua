ENV = {}

function Gnarlpine_Death(Unit, Attacker)
	ENV.GUnit = tostring(Unit)
	local PlayerIdentifier = ENV.GUnit
	ENV.Player = {}
	ENV.Player[PlayerIdentifier] = Attacker
	Unit:CastSpell(Unit,5628,false)
	
end



function Gnarlpine_OnSpellTaken(Unit, Attacker, Spell)
	if tostring(Attacker) == ENV.GUnit then 
		local PlayerIdentifier = tostring(Attacker)
		Unit:StartCombat(ENV.Player[PlayerIdentifier])
		ENV.player = {}
		ENV.GUnit = nil
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
---RegisterUnitEvent(2009, 11,  "Gnarlpine_OnSpellTaken")
--RegisterUnitEvent(2010, 11,  "Gnarlpine_OnSpellTaken")
RegisterUnitEvent(2011, 11,  "Gnarlpine_OnSpellTaken")
RegisterUnitEvent(2012, 11,  "Gnarlpine_OnSpellTaken")
RegisterUnitEvent(2013, 11,  "Gnarlpine_OnSpellTaken")
RegisterUnitEvent(2014, 11,  "Gnarlpine_OnSpellTaken")
RegisterUnitEvent(2152, 11,  "Gnarlpine_OnSpellTaken")
RegisterUnitEvent(7235, 11,  "Gnarlpine_OnSpellTaken")
RegisterUnitEvent(11690,11,  "Gnarlpine_OnSpellTaken")

