local senses = include("sim/btree/senses")
local simquery = include("sim/simquery")

local processSoundTrigger = senses.processSoundTrigger
senses.processSoundTrigger = function(self, sim, evData, ...)
    if simquery.luna4s_isUnitSilenced and simquery.luna4s_isUnitSilenced(sim, self.unit, evData.x, evData.y) then
        return
    end

    return processSoundTrigger(self, sim, evData, ...)
end
