local simplayer = include("sim/simplayer")
local simquery = include("sim/simquery")

local trackFootstep = simplayer.trackFootstep
simplayer.trackFootstep = function(self, sim, unit, cellx, celly, ...)
    if simquery.luna4s_isLocationSilenced(sim, cellx, celly) then
        return false
    end
    return trackFootstep(self, sim, unit, cellx, celly, ...)
end
