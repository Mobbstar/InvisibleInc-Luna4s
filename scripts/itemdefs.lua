local util = include("modules/util")
local commondefs = include("sim/unitdefs/commondefs")
-- local simdefs = include( "sim/simdefs" )

local function upgradeParamsAmmo(self, unit)
    return {traits = {ammo = unit:getTraits().ammo}}
end

local tool_templates = {
    augment_luna4s_cloak = util.extend(commondefs.augment_template) {
        name = STRINGS.LUNA4S.ITEMS.AUG_CLOAK,
        desc = STRINGS.LUNA4S.ITEMS.AUG_CLOAK_TIP,
        flavor = STRINGS.LUNA4S.ITEMS.AUG_CLOAK_FLAVOR,
        traits = {installed = true, cloakInVision = true, ammo = 4, maxAmmo = 8, addAbilities = "luna4s_cloak"},
        createUpgradeParams = upgradeParamsAmmo,
        profile_icon = "gui/icons/item_icons/items_icon_small/icon-item_invisicloak_small.png",
        profile_icon_100 = "gui/icons/item_icons/icon-item_invisi_cloak.png",
    },
    item_luna4s_silencegrenade = util.extend(commondefs.item_template) {
        type = "simgrenade_luna4s",
        name = STRINGS.LUNA4S.ITEMS.SILENCE_GRENADE,
        desc = STRINGS.LUNA4S.ITEMS.SILENCE_GRENADE_TIP,
        flavor = STRINGS.LUNA4S.ITEMS.SILENCE_GRENADE_FLAVOR,
        profile_icon = "gui/icons/item_icons/items_icon_small/icon-crybaby_small.png",
        profile_icon_100 = "gui/icons/item_icons/crybaby.png",
        kanim = "kanim_stickycam",
        rig = "grenaderig_luna4s",
        uses_mainframe = {
            toggle = {
                name = STRINGS.LUNA4S.ABILITIES.SILENCE_GRENADE_TOGGLE,
                tooltip = STRINGS.LUNA4S.ABILITIES.SILENCE_GRENADE_TOGGLE_TIP,
                fn = "toggle",
                canToggle = function(unit)
                    if unit:getTraits().mainframe_status ~= "active" and unit:getTraits().PWRuse and unit:getSim():getPC():getCpus() < unit:getTraits().PWRuse then
                        return false, STRINGS.UI.REASON.NOT_ENOUGH_PWR
                    end
                    return true
                end
            }
        },
        abilities = {"carryable", "throw"},
        sounds = {activate = "SpySociety/Grenades/stickycam_deploy", bounce = "SpySociety/Grenades/bounce"},
        traits = {
            PWRuse = 1,
            CPUperTurn = 1,
            range = 2,
            targeting_ignoreLOS = true,
            agent_filter = true
        },
        value = 400,
        -- floorWeight = 2,
        -- ITEM_LIST = true,
        locator = true
    }
}

return tool_templates
