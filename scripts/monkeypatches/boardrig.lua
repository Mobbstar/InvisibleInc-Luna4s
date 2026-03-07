local boardrig = include("gameplay/boardrig")
local simquery = include("sim/simquery")

local canPlayerHear = boardrig.canPlayerHear
boardrig.canPlayerHear = function(self, x, y, range, ...)
    local result = {canPlayerHear(self, x, y, range, ...)}
    if result[1] and simquery.luna4s_isLocationSilenced(self:getSim(), x, y) then
        return false
    end
    return unpack(result)
end
