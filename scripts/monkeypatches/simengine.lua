local simengine = include("sim/engine")
local simquery = include("sim/simquery")

local moveUnit = simengine.moveUnit
simengine.moveUnit = function(self, unit, ...)
    local ability = unit:ownsAbility("luna4s_cloak")
    local wasActive = ability and ability.userUnit:hasTrait("luna4s_active")

    local result = {moveUnit(self, unit, ...)}

    if ability then
        ability:onMoveUnit(wasActive)
    end

    return unpack(result)
end

local emitSound = simengine.emitSound
simengine.emitSound = function(self, sound, x0, y0, unit, altVisTiles, ...)
    if unit and simquery.luna4s_isUnitSilenced(self, unit) then
        return
    end
    emitSound(self, sound, x0, y0, unit, altVisTiles, ...)
end

local emitSpeech = simengine.emitSpeech
simengine.emitSpeech = function(self, unit, speechIndex, ...)
    local deafenedUnits = {}
    if unit and simquery.luna4s_isUnitSilenced(self, unit) then
        --hacky way to tell the listeners to not listen to this
        for i, unitListen in ipairs(self:getPC():getUnits()) do
            unitListen:getTraits().luna4s_ignoreNextSound = true
            table.insert(deafenedUnits, unitListen)
        end
    end

    local result = {emitSpeech(self, unit, speechIndex, ...)}

    for i, unitListen in ipairs(deafenedUnits) do
        unitListen:getTraits().luna4s_ignoreNextSound = nil
    end

    return unpack(result)
end
