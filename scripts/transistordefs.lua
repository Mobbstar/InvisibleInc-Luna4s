local util = include("modules/util")
local mainframe_common = include("sim/abilities/mainframe_common")
local simdefs = include("sim/simdefs")

return {
    transistordaemonluna4s = util.extend(mainframe_common.createReverseDaemon(STRINGS.LUNA4S.TRANSISTOR)) {
        icon = "gui/icons/daemon_icons/fu_luna4s.png",
        title = STRINGS.LUNA4S.AGENT.NAME,
        noDaemonReversal = true,
        onSpawnAbility = function(self, sim, player)
            sim:dispatchEvent(
                simdefs.EV_SHOW_REVERSE_DAEMON,
                {showMainframe = true, name = self.name, icon = self.icon, txt = self.activedesc, title = self.title}
            )
        end
    },
}
