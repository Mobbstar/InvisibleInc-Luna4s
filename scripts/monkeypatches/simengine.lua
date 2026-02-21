local simengine = include("sim/engine")
local moveUnit = simengine.moveUnit
simengine.moveUnit = function(self, unit, ...)
    local ability = unit:ownsAbility("luna4s_cloak")
    local isActive = ability and ability.userUnit:hasTrait("luna4s_active")

    local result = {moveUnit(self, unit, ...)}

    if isActive and ability.userUnit and ability.userUnit:isValid() and ability.itemUnit and ability.itemUnit:isValid() then
        if ability.userUnit:getTraits().cloakDistance then
            ability.itemUnit:getTraits().ammo = math.max(0.5, math.floor(ability.userUnit:getTraits().cloakDistance * 2) / 2) -- round diagonal steps to 1.5
            ability:refreshCloakDuration(ability.userUnit:getTraits().cloakDistance)
        else
            ability.itemUnit:getTraits().ammo = 0
        end
    end

    return unpack(result)
end
