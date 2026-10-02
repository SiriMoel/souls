dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")
dofile_once("mods/souls/files/scripts/tome_upgrades.lua")

local tome = GetUpdatedEntityID()

local x, y = EntityGetTransform(tome)

AddGunAction(tome, "SOULS_TOME_SHOT")

for i,v in ipairs(tome_upgrades) do
    EntityAddComponent2(tome, "VariableStorageComponent", {
        _tags="tome_upgrade_" .. i,
        name="tome_upgrade_" .. i,
        value_int=0
    })
end