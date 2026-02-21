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
}

return tool_templates
