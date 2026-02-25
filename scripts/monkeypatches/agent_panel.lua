local agent_panel = include( "hud/agent_panel" )

local refreshAgentInfo = agent_panel.refreshAgentInfo
agent_panel.refreshAgentInfo = function(unit, binder, self, ...)
    local result = {refreshAgentInfo(unit, binder, self, ...)}

    local ability = unit and unit:isValid() and not (unit:isKO() or unit:getTraits().iscorpse) and unit:hasAbility("luna4s_chromakey")
    if ability and ability.selectedColor then
        binder.greenscreen:setVisible(true)
        binder.greenscreen:setColor(ability.selectedColor:unpack())
    else
        binder.greenscreen:setVisible(false)
    end

    return unpack(result)
end

upvalueUtil.findAndReplace(agent_panel.agent_panel.refreshPanel, "refreshAgentInfo", agent_panel.refreshAgentInfo)
