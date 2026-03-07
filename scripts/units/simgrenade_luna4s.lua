local util = include("modules/util")
local simunit = include("sim/simunit")
local simdefs = include("sim/simdefs")
local simquery = include("sim/simquery")
local simfactory = include("sim/simfactory")

local _M = {ClassType = "simgrenade_luna4s"}

function _M:throw(throwingUnit, targetCell)
    local sim = self:getSim()
    local player = throwingUnit:getPlayerOwner()
    local x0, y0 = throwingUnit:getLocation()

    assert(player)
    self:setPlayerOwner(player)

    sim:dispatchEvent(simdefs.EV_UNIT_THROWN, {unit = self, x = targetCell.x, y = targetCell.y})

    if x0 ~= targetCell.x or y0 ~= targetCell.y then
        sim:warpUnit(self, targetCell)
    end

    self:getTraits().deployed = true
    self:getTraits().mainframe_item = true
    sim:triggerEvent(simdefs.TRG_UNIT_DEPLOYED, {unit = self})

    sim:processReactions()
end

function _M:toggle(sim)
    if self:getTraits().mainframe_status == "active" then
        self:deactivate(sim)
    else
        self:activate(sim)
    end
end

function _M:activate(sim)
    if self:getTraits().mainframe_status == "active" then
        return
    end

    local player = self:getPlayerOwner()
    if self:getTraits().PWRuse and player:getCpus() < self:getTraits().PWRuse then
        return
    end

    local x, y = self:getLocation()
    local cells = self:getExplodeCells()
    self:getTraits().mainframe_status = "active"
    self:getTraits().luna4s_silenceRadius = 2
    self:getTraits().hasHearing = true
    player:addCPUs(-(self:getTraits().PWRuse or 0), sim, x, y)
    sim:dispatchEvent(simdefs.EV_UNIT_ACTIVATE, {unit = self, cells = cells})
end

function _M:deactivate(sim)
    self:getTraits().mainframe_status = "inactive"
    self:getTraits().luna4s_silenceRadius = nil
    self:getTraits().hasHearing = false
end

function _M:onWarp(sim, oldcell, cell)
    if not oldcell and cell then
        sim:addTrigger(simdefs.TRG_UNIT_WARP, self)
        sim:addTrigger(simdefs.TRG_START_TURN, self)
        sim:addTrigger(simdefs.TRG_UNIT_PICKEDUP, self)
    elseif not cell and oldcell then
        sim:removeTrigger(simdefs.TRG_UNIT_WARP, self)
        sim:removeTrigger(simdefs.TRG_START_TURN, self)
        sim:removeTrigger(simdefs.TRG_UNIT_PICKEDUP, self)
        self:getTraits().mainframe_item = nil
    end
end

function _M:onTrigger(sim, evType, evData)
    if evType == simdefs.TRG_UNIT_PICKEDUP and evData.item == self then
        self:deactivate()
    elseif evType == simdefs.TRG_UNIT_WARP and evData.unit ~= self then
        local selfCell = sim:getCell(self:getLocation())
        if (evData.to_cell == selfCell or evData.from_cell == selfCell) and evData.unit:getTraits().isAgent then
            sim:dispatchEvent(simdefs.EV_UNIT_REFRESH, {unit = self})
        end
    elseif evType == simdefs.TRG_START_TURN then
        local player = sim:getCurrentPlayer()
        if player == self:getPlayerOwner() and self:getTraits().mainframe_status == "active" then
            if player:getCpus() >= (self:getTraits().CPUperTurn or 0) then
                local x, y = self:getLocation()
                player:addCPUs(-(self:getTraits().CPUperTurn or 0), sim, x, y)
            else
                self:deactivate()
            end
        end
    end
end

function _M:getExplodeCells()
    local x0, y0 = self:getLocation()
    local currentCell = self:getSim():getCell(x0, y0)
    local cells = {currentCell}
    if self:getTraits().range then
        local sim = self:getSim()
        cells = simquery.fillCircle(sim, x0, y0, self:getTraits().range, 0)
    end
    return cells
end

local function createUnit(unitData, sim)
    return simunit.createUnit(unitData, sim, _M)
end

simfactory.register(createUnit)

return {
    createUnit = createUnit
}
