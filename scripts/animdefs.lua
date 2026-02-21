local commondefs = include("sim/unitdefs/commondefs")
local commonanims = include("common_anims")
local util = include("modules/util")

local AGENT_ANIMS = commondefs.AGENT_ANIMS
local Layer = commondefs.Layer
local BoundType = commondefs.BoundType

-------------------------------------------------------------------
-- Data for anim definitions.

local animdefs = {
}

local agentCommon = {
    animMap = AGENT_ANIMS,
    symbol = "character",
    anim = "idle",
    shouldFlip = true,
    scale = 0.25,
    layer = Layer.Unit,
    boundType = BoundType.Character,
    boundTypeOverrides = {
        {anim = "idle_ko", boundType = BoundType.CharacterFloor},
        {anim = "dead", boundType = BoundType.CharacterFloor}
    },
    peekBranchSet = 1
}

local function compileDefs(skip_wireframes)
    local compiled = util.tdupe(animdefs)

    compiled["kanim_luna4s"] = util.extend(agentCommon) {
        wireframe = {
            -- skip_wireframes and
            "data/anims/characters/agents/agent_male_empty.abld"
            -- or "data/anims/characters/agents/overlay_agent_luna4s.abld"
        },
        build = {
            "data/anims/characters/anims_female/shared_female_hits_01.abld",
            "data/anims/characters/anims_female/shared_female_attacks_a_01.abld",
            "data/anims/characters/agents/agent_luna4s.abld"
        },
        grp_build = {
            "data/anims/characters/agents/grp_agent_luna4s.abld"
        },
        grp_anims = commonanims.female.grp_anims,
        anims = commonanims.female.default_anims_unarmed,
        anims_1h = commonanims.female.default_anims_1h,
        anims_2h = commonanims.female.default_anims_2h
    }

    return compiled
end

return compileDefs
