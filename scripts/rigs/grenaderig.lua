local unitrig = include("gameplay/unitrig")
local simdefs = include("sim/simdefs")
local rig_util = include("gameplay/rig_util")

local _M = class(unitrig.rig)

function _M:init(boardRig, unit)
	self:_base().init(self, boardRig, unit)
end

function _M:refresh()
	unitrig.rig.refresh(self)

	if self:getUnit():getTraits().deployed then
		self:setCurrentAnim("crybaby_idle")
	else
		self:setCurrentAnim("idle")
	end
end

function _M:onSimEvent(ev, eventType, eventData)
	unitrig.rig.onSimEvent(self, ev, eventType, eventData)

	local unit = self:getUnit()
	if eventType == simdefs.EV_UNIT_THROWN then
		self:setCurrentAnim("thrown")

		if self._HUDlocated then
			self._HUDlocated:setVisible(false)
		end

		local x1, y1 = self._boardRig:cellToWorld(eventData.x, eventData.y)
		rig_util.throwToLocation(self, x1, y1)
		if unit:getSounds().bounce then
			self:playSound(unit:getSounds().bounce)
		end

		self:waitForAnim("crybaby_deploy")
	elseif eventType == simdefs.EV_UNIT_ACTIVATE then
		self:refresh()
		if unit:getSounds().activate then
			local x0, y0 = unit:getLocation()
			MOAIFmodDesigner.playSound(unit:getSounds().activate, nil, nil, {x0, y0, 0}, nil)
		end
		self._boardRig:hiliteCells(eventData.cells, {247 / 255, 247 / 255, 142 / 255, 0.3}, 60)
	end
end

return {
	rig = _M
}
