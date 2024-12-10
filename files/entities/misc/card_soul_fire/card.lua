dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local card = GetUpdatedEntityID()
local root = EntityGetRootEntity(card) -- player, right?

local x, y = EntityGetTransform(root)

local targets = EntityGetInRadiusWithTag(x, y, 200,"reap_marked_fx")

for i,target in ipairs(targets) do
    LoadGameEffectEntityTo(target, "data/entities/misc/effect_apply_on_fire.xml")
end