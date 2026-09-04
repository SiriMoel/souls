dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")

local tome = GetUpdatedEntityID()

local x, y = EntityGetTransform(tome)

AddGunAction(tome, "MOLDOS_TOME_SHOT")