require "/stats/effects/fu_armoreffects/setbonuses_common.lua"
require "/scripts/unifiedGravMod.lua"

weaponBonus={
	{stat = "powerMultiplier", baseMultiplier = 3.4}
}

armorBonus={
		{stat = "protoImmunity", amount = 1.0},
		{stat = "fireStatusImmunity", amount = 1.0},
		{stat = "gasImmunity", amount = 1.0},
		{stat = "iceslipImmunity", amount = 1.0},
		{stat = "pressureProtection", amount = 1},
		{stat = "extremepressureProtection", amount = 1},		
		{stat = "breathProtection", amount = 1},
		{stat = "asteroidImmunity", amount = 1}
}

setName="fu_warphunterset"

function init()
	self.gravityMod = config.getParameter("gravityMod",0.0)
	self.gravityNormalize = config.getParameter("gravityNorm",false)
	self.gravityBaseMod = config.getParameter("gravityBaseMod",0.0)
	--sb.logInfo(sb.printJson({self.gravityMod,self.gravityNormalize,self.gravityBaseMod}))
	unifiedGravMod.init()
	setSEBonusInit("fu_warphunterset")
	effect.setParentDirectives("fade=F1EA9C;0.00?border=0;F1EA9C00;00000000")
	
	setSEBonusInit(setName)
	weaponBonusHandle=effect.addStatModifierGroup({})

	checkWeapons()

	armorBonusHandle=effect.addStatModifierGroup(armorBonus)
end

function update(dt)
	if not checkSetWorn(self.setBonusCheck) then
		effect.expire()
	else
	        unifiedGravMod.update(dt)
		checkWeapons()
	end
end

function checkWeapons()
	local weapons=weaponCheck({"mininglaser"})
	if weapons["either"] then
		effect.setStatModifierGroup(weaponBonusHandle,weaponBonus)
	else
		effect.setStatModifierGroup(weaponBonusHandle,{})
	end
end