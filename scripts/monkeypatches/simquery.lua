local simquery = include("sim/simquery")
local mathutil = include("modules/mathutil")

local canHear = simquery.canHear
simquery.canHear = function(unit, ...)
    local result = {canHear(unit, ...)}
    if result[1] and unit and simquery.luna4s_isUnitSilenced(unit:getSim(), unit) then
        return false
    end
    return unpack(result)
end

simquery.luna4s_isUnitSilenced = function(sim, hearingUnit, x1, y1)
    assert(hearingUnit)
    local x0, y0 = hearingUnit:getLocation()

    for i, silencerUnit in pairs(sim:getAllUnits()) do
        if silencerUnit and silencerUnit:getTraits().luna4s_silenceRadius then
            local silenceRadius = silencerUnit:getTraits().luna4s_silenceRadius
            local x2, y2 = silencerUnit:getLocation()
            if x2 and y2 then
                if mathutil.dist2d(x0, y0, x2, y2) <= silenceRadius then
                    return true
                end
                if x1 and y1 and mathutil.dist2d(x1, y1, x2, y2) <= silenceRadius then
                    return true
                end
            end
        end
    end

    return false
end


simquery.luna4s_isTileSilenced = function(sim, x0, y0)

    for i, silencerUnit in pairs(sim:getAllUnits()) do
        if silencerUnit and silencerUnit:getTraits().luna4s_silenceRadius then
            local silenceRadius = silencerUnit:getTraits().luna4s_silenceRadius
            local x2, y2 = silencerUnit:getLocation()
            if x2 and y2 then
                if mathutil.dist2d(x0, y0, x2, y2) <= silenceRadius then
                    return true
                end
            end
        end
    end

    return false
end
