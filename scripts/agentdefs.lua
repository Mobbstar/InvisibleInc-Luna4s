local util = include("modules/util")
local commondefs = include("sim/unitdefs/commondefs")
local simdefs = include("sim/simdefs")

local FEMALE_SOUNDS = {
    bio = "",
    escapeVo = "",
    speech = "SpySociety/Agents/dialogue_player",
    step = simdefs.SOUNDPATH_FOOTSTEP_FEMALE_HARDWOOD_NORMAL,
    stealthStep = simdefs.SOUNDPATH_FOOTSTEP_FEMALE_HARDWOOD_SOFT,
    wallcover = "SpySociety/Movement/foley_trench/wallcover",
    crouchcover = "SpySociety/Movement/foley_trench/crouchcover",
    fall = "SpySociety/Movement/foley_trench/fall",
    land = "SpySociety/Movement/deathfall_agent_hardwood",
    land_frame = 16,
    getup = "SpySociety/Movement/foley_trench/getup",
    grab = "SpySociety/Movement/foley_trench/grab_guard",
    pin = "SpySociety/Movement/foley_trench/pin_guard",
    pinned = "SpySociety/Movement/foley_trench/pinned",
    peek_fwd = "SpySociety/Movement/foley_trench/peek_forward",
    peek_bwd = "SpySociety/Movement/foley_trench/peek_back",
    move = "SpySociety/Movement/foley_trench/move",
    hit = "SpySociety/HitResponse/hitby_ballistic_flesh"
}

return {
    onfile = {
        type = "simunit",
        agentID = "luna4s",
        loadoutName = STRINGS.UI.ON_FILE, -- STRINGS.UI.ON_ARCHIVE
        name = STRINGS.LUNA4S.AGENT.NAME,
        fullname = STRINGS.LUNA4S.AGENT.FULLNAME,
        codename = STRINGS.LUNA4S.AGENT.ALT_1.CODENAME or STRINGS.LUNA4S.AGENT.FULLNAME,
        toolTip = STRINGS.LUNA4S.AGENT.ALT_1.TOOLTIP,
        file = STRINGS.LUNA4S.AGENT.FILE,
        yearsOfService = STRINGS.LUNA4S.AGENT.YEARS_OF_SERVICE,
        age = STRINGS.LUNA4S.AGENT.ALT_1.AGE,
        homeTown = STRINGS.LUNA4S.AGENT.HOMETOWN,
        speech = STRINGS.LUNA4S.AGENT.BANTER,
        blurb = STRINGS.LUNA4S.AGENT.ALT_1.BIO,
        hireText = STRINGS.LUNA4S.AGENT.RESCUED,
        gender = "female",
        sounds = FEMALE_SOUNDS,
        onWorldTooltip = commondefs.onAgentTooltip,
        kanim = "kanim_luna4s",
        profile_anim = "portraits/luna4s_face",
        profile_build = "portraits/luna4s_face",
        profile_icon_36x36 = "gui/profile_icons/luna4s_36.png",
        profile_icon_64x64 = "gui/profile_icons/luna4s_64x64.png",
        splash_image = "gui/agents/luna4s_1024.png",
        team_select_img = {"gui/agents/team_select_1_luna4s.png"},
        traits = util.extend(commondefs.DEFAULT_AGENT_TRAITS) {mp = 8, mpMax = 8},
        skills = util.extend(commondefs.DEFAULT_AGENT_SKILLS) {},
        startingSkills = {},
        abilities = util.tconcat({"sprint", "luna4s_chromakey"}, commondefs.DEFAULT_AGENT_ABILITIES),
        upgrades = {"augment_luna4s_cloak", "item_tazer"},
        children = {},
        logs = {}
    },
}
