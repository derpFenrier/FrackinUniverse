setName="fu_gladiatorset"

weaponBonus={
	{stat = "powerMultiplier", amount = 0.20}
}

armorBonus={
	{stat = "protoImmunity", amount = 1},
	{stat = "sandstormImmunity", amount = 1},
	{stat = "liquidnitrogenImmunity", amount = 1}
}

require "/stats/effects/fu_armoreffects/setbonuses_common.lua"

function init()
	setSEBonusInit(setName)
	weaponBonusHandle=effect.addStatModifierGroup({})
	checkWeapons()
	armorBonusHandle=effect.addStatModifierGroup(armorBonus)
end

function update(dt)
	if not checkSetWorn(self.setBonusCheck) then
		effect.expire()
	else
		checkWeapons()
	end

end

function 
	checkWeapons()
	local weapons=weaponCheck({"fist"})
	if weapons["either"] then
		effect.setStatModifierGroup(weaponBonusHandle,weaponBonus)
	else
		effect.setStatModifierGroup(weaponBonusHandle,{})
	end
end