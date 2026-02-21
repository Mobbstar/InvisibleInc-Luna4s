local SimUnit = include("sim/simunit")
local setInvisible = SimUnit.setInvisible
SimUnit.setInvisible = function(self, ...)
    self:getTraits().luna4s_active = nil
    return setInvisible(self, ...)
end
local countAugments = SimUnit.countAugments
SimUnit.countAugments = function(self, ...)
    if self:hasTrait("luna4s_activating") then
        return 0
    end
    return countAugments(self, ...)
end
