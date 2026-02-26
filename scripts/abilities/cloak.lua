local abilityutil = include("sim/abilities/abilityutil")
local abilitydefs = include("sim/abilitydefs")
local simdefs = include("sim/simdefs")
local util = include("modules/util")
local useInvisiCloak = abilitydefs._abilities.useInvisiCloak

local _M = {
    name = STRINGS.ABILITIES.CLOAK,
    profile_icon = "gui/icons/item_icons/items_icon_small/icon-item_invisicloak_small.png",
    alwaysShow = true,
    HUDpriority = 5
}

local function getItemUnit(userUnit) -- assumption: only one per agent
	for _, itemUnit in pairs(userUnit:getChildren()) do
		if itemUnit:getTraits().addAbilities == "luna4s_cloak" then
			return itemUnit
		end
	end
end

function _M:addCharge(sim, delta)
    delta = delta or 1
    self.itemUnit:getTraits().ammo = self.itemUnit:getTraits().ammo + delta
    if self.itemUnit:getTraits().ammo < 0 then
        self.itemUnit:getTraits().ammo = 0
    elseif self.itemUnit:getTraits().ammo > self.itemUnit:getTraits().maxAmmo then
        self.itemUnit:getTraits().ammo = self.itemUnit:getTraits().maxAmmo
    end
	if self.userUnit and delta > 0 then   -- adding an indicator
		local x0,y0 = self.userUnit:getLocation()
		local txt = string.format("+%s Charge", delta)
		local rand = sim:nextRand(1,20)
		if rand == 20 then
			txt = string.format("+%s Shiny", delta)
		elseif rand == 1 then
			txt = string.format("Shiny Get", delta)
		end
		sim:dispatchEvent( simdefs.EV_UNIT_FLOAT_TXT,
			{ txt= txt, x=x0,y=y0 } )
	end
end

function _M:refreshCloakDuration(value)
    value = value or self.itemUnit:getTraits().ammo
    -- log:write("[LUNA] refresh to ".. tostring(value))
    if self.userUnit and self.userUnit:hasTrait("luna4s_active") then
        self.userUnit:getTraits().cloakDistance = value
        self.userUnit:getTraits().invisDuration = math.ceil(value)
    end
end

function _M:getName(sim, abilityOwner, userUnit)
    if self.userUnit and self.userUnit:hasTrait("luna4s_active") then
        return STRINGS.LUNA4S.ABILITIES.UNCLOAK
    end
    if self.itemUnit and self.itemUnit:getTraits().ammo > 0 then
        return string.format(STRINGS.ABILITIES.CLOAK_DURATION, self.itemUnit:getTraits().ammo)
    end
    return STRINGS.ABILITIES.CLOAK_USE
end

function _M:onTooltip(hud, sim, abilityOwner, ...)
    -- tooltip = useInvisiCloak.onTooltip(self, hud, sim, self.itemUnit, self.userUnit, ...)
    -- tooltip._base._headerTxt = string.gsub(tooltip._base._headerTxt, STRINGS.ABILITIES.CLOAK_DESC, STRINGS.LUNA4S.ABILITIES.CLOAK_DESC, 1)
    return abilityutil.hotkey_tooltip(self, sim, abilityOwner, STRINGS.LUNA4S.ABILITIES.CLOAK_DESC)
end

function _M:canUseAbility(sim, abilityOwner, ...)
    if self.itemUnit and (self.itemUnit:getTraits().ammo or 0) <= 0 then
        return false, STRINGS.LUNA4S.REASON.SHINY_CHARGES
    end
    return useInvisiCloak.canUseAbility(self, sim, self.itemUnit, ...)
end

function _M:executeAbility(sim, abilityOwner, ...)
    if self.userUnit:hasTrait("luna4s_active") then
        self.userUnit:getTraits().cloakDistance = nil
        self.userUnit:setInvisible(false)
		sim:processReactions( self.userUnit )  -- uncloaking in guard vision is a bad idea!
        return
    end

    self.userUnit:getTraits().luna4s_activating = true
    local result = {useInvisiCloak.executeAbility(self, sim, self.itemUnit, ...)}
    self:addCharge(sim,1) -- hack against inventory.useItem in base ability
    self.userUnit:getTraits().luna4s_activating = nil
    self.userUnit:getTraits().luna4s_active = true
    self:refreshCloakDuration()

    return unpack(result)
end

function _M:onSpawnAbility(sim, abilityOwner)
    self.itemUnit = getItemUnit(abilityOwner) or abilityOwner
    self.userUnit = abilityOwner
    sim:addTrigger(simdefs.TRG_START_TURN, self)
    sim:addTrigger(simdefs.TRG_ACTION, self)
end

function _M:onDespawnAbility(sim, abilityOwner)
    self.itemUnit = nil
    self.userUnit = nil
    sim:removeTrigger(simdefs.TRG_START_TURN, self)
    sim:removeTrigger(simdefs.TRG_ACTION, self)
end

function _M:onTrigger(sim, evType, evData)
    -- disable when another cloak gets used: monkeypatched in simunit.setInvisible
    -- remove charge on move: monkeypatched in engine.moveUnit
    -- add charge on loot itemless safe: monkeypatched in stealCredits.executeAbility

    if evType == simdefs.TRG_START_TURN and evData == self.userUnit:getPlayerOwner() and self.userUnit:hasTrait("luna4s_active") then
        self:addCharge(sim,-1)
        self:refreshCloakDuration()

    elseif evType == simdefs.TRG_ACTION and evData.ClassType == "lootItem" and not evData.pre and evData[1] == self.userUnit:getID() and evData[2] then
        local targetUnit = sim:getUnit(evData[2])
        if targetUnit and not targetUnit:hasAbility("carryable") then -- looted cash, pwr, or a program, all of which are irreversible and thus unexploitable
            targetUnit:getTraits().luna4s_looted = true
            self:addCharge(sim,1)
            self:refreshCloakDuration()
        end
    end
end

return _M
