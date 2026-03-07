local simengine = include("sim/engine")
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


local simquery = include("sim/simquery")
local emitSound = simengine.emitSound
simengine.emitSound = function(self, sound, x0, y0, unit, altVisTiles)
    if unit and unit:getSim() then
		if simquery.luna4s_isUnitSilenced(unit:getSim(),unit) then
			return
		end
    end
	emitSound(self, sound, x0, y0, unit, altVisTiles)
end
