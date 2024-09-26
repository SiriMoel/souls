dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local card = GetUpdatedEntityID()
local root = EntityGetRootEntity(card) -- player, right?

local player = GetPlayer()
local wand = HeldItem(player)

local x, y = EntityGetTransform(card)

local targets = EntityGetInRadiusWithTag(x, y, 100,"reap_marked_fx")

for i,target in ipairs(targets) do
    LoadGameEffectEntityTo(target, "data/entities/misc/effect_apply_on_fire.xml")
end