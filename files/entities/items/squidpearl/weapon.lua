dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")

local weapon = GetUpdatedEntityID()
local x, y = EntityGetTransform(weapon)

local to_add = {}

local pool = {
    "RUBBER_BALL",
    "ROCKET",
    "ROCKET_TIER_2",
    "ROCKET_TIER_3",
    "GRENADE",
    "GRENADE_TIER_2",
    "GRENADE_TIER_3",
}

if ModIsEnabled("copis_things") then
    local copispells = {
        "COPIS_THINGS_VACUUM_CLAW",
    }
    for i,v in ipairs(copispells) do
        table.insert(pool, v)
    end
end

for i=1,5 do
    local target = ""
    while table.contains(to_add, target) == false do
        target = pool[math.random(1, #pool)]
    end
    table.insert(to_add, target)
end

for i,v in ipairs(to_add) do
    AddGunAction(weapon, v)
end