local simfactory = include("sim/simfactory")
local simdefs = include("sim/simdefs")
local simquery = include("sim/simquery")

local onTrigger
local onTrigger_new = function(self, sim, evType, evData, ...)
	if evType == simdefs.TRG_SOUND_EMITTED and simquery.luna4s_isUnitSilenced(sim, self, evData.x, evData.y) then
		return
	end
	return onTrigger(self, sim, evType, evData, ...)
end

local createUnit = simfactory.createUnit
function simfactory.createUnit(...)
	local unit = createUnit(...)
	if unit and unit.ClassType == "simsoundbug" then
		if not onTrigger then
			onTrigger = unit.onTrigger
		end
		unit.onTrigger = onTrigger_new
	end
	return unit
end
