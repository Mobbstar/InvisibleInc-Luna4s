-- Include files to be used throughout this file.
-- Don't eager-load sim- or client-heavy things though, those may break translation.
local util = include("modules/util")

-- Private static variables can be used by load/unload to remember what has been done.
local ThisModLoaded = false

local function earlyInit(modApi)
    modApi.requirements = {
        "Contingency Plan",
        "Sim Constructor",
        "Function Library"
    }

    if STRINGS.alpha_voice then -- Talkative Agents
        STRINGS.alpha_voice.AGENT_ONELINERS.luna4s = STRINGS.LUNA4S.BARKS.LUNA4S
        for k,v in pairs(STRINGS.LUNA4S.BARKS.GUARDS.LINES) do
            STRINGS.alpha_voice.GUARDS.LINES[k][2] = util.tconcat(STRINGS.alpha_voice.GUARDS.LINES[k][2], v)
        end
        STRINGS.alpha_voice.GUARDS.BANTERS = util.tconcat(STRINGS.alpha_voice.GUARDS.BANTERS, STRINGS.LUNA4S.BARKS.GUARDS.BANTERS)
        STRINGS.alpha_voice.GUARDS.BANTERS_HUNTING = util.tconcat(STRINGS.alpha_voice.GUARDS.BANTERS_HUNTING, STRINGS.LUNA4S.BARKS.GUARDS.BANTERS_HUNTING)
    end
end

local function init(modApi)
    local dataPath = modApi:getDataPath()
    KLEIResourceMgr.MountPackage(dataPath .. "/gui.kwad", "data")
    KLEIResourceMgr.MountPackage(dataPath .. "/anims.kwad", "data")

    modApi:addGenerationOption("rescue_luna4s", STRINGS.LUNA4S.OPTIONS.ONFILE, STRINGS.LUNA4S.OPTIONS.ONFILE_TIP, {noUpdate = true})
    -- if modApi.addTransistorDef then -- Transistor pt1
    --     modApi:addTransistorDef("luna4s", "transistordaemonluna4s")
    -- end

    local scriptPath = modApi:getScriptPath()
    include(scriptPath .. "/monkeypatches/simunit")
    include(scriptPath .. "/monkeypatches/simengine")
    include(scriptPath .. "/monkeypatches/stealCredits")
end

local function FindModOption(mod_options, modname, optionname)
    if not mod_options then
        return
    end
    for k, mod in pairs(mod_options) do
        if k == modname or mod.name == modname then
            if mod and mod.enabled and mod.options and mod.options[optionname] then
                return mod.options[optionname].value or mod.options[optionname].enabled
            end
            return -- can give up at this point
        end
    end
end

local function generationOptionEnabled(options, name, default)
    if options and options[name] then
        return options[name].enabled
    end
    return default or false
end

local function load(modApi, options, params, mod_options)
    ThisModLoaded = true

    local scriptPath = modApi:getScriptPath()

    -- do
    --     local simdefs = include("sim/simdefs")
    --     for name, simDef in pairs(include(scriptPath .. "/simdefs")) do
    --         simdefs[name] = simDef
    --     end
    -- end

    -- modApi:addTooltipDef( include( scriptPath .. "/tooltipdefs" ) )

    local skip_wireframes = FindModOption(mod_options, "Mods Combo by Shirsh", "noWireframes")
    local mod_animdefs = include(scriptPath .. "/animdefs")(skip_wireframes)
    for name, animDef in pairs(mod_animdefs) do
        modApi:addAnimDef(name, animDef)
    end

    local mod_itemdefs = include(scriptPath .. "/itemdefs")
    for itemid, itemdef in pairs(mod_itemdefs) do
        modApi:addItemDef(itemid, itemdef)
    end

    local mod_agentdefs = include(scriptPath .. "/agentdefs")
    modApi:addAgentDef("luna4s", mod_agentdefs.onfile, {"luna4s"})
    if generationOptionEnabled(options, "luna4s") then
        modApi:addRescueAgent("luna4s", {mod_agentdefs.onfile.upgrades[1]})
    end

    include(scriptPath .. "/banter")( modApi )

    modApi:addAbilityDef("luna4s_cloak", scriptPath .. "/abilities/cloak")

    if modApi.addTransistorDef then -- Transistor pt2
        local transistordefs = include(scriptPath .. "/transistordefs")
        for k,v in pairs(transistordefs) do
            modApi:addDaemonAbility(k,v)
        end
    end
end

local function unload(modApi, options)
    ThisModLoaded = false
end

local function initStrings(modApi)
    local dataPath = modApi:getDataPath()
    local scriptPath = modApi:getScriptPath()
    local strings = include(scriptPath .. "/strings")
    strings.BARKS = include(scriptPath .. "/barks")
    modApi:addStrings(dataPath, "LUNA4S", strings)
end

return {
    init = init,
    earlyInit = earlyInit,
    load = load,
    unload = unload,
    initStrings = initStrings
}
