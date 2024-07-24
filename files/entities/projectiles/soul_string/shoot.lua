dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")

local host = GetUpdatedEntityID()

local x, y = EntityGetTransform(host)

local comp_segments_left = EntityGetFirstComponentIncludingDisabled(host, "VariableStorageComponent", "segments_left") or 0
local segments_left = ComponentGetValue2(comp_segments_left, "value_int")

if segments_left > 0 and GetSoulsCount("all") > 0 then
    -- unsure if 0, 0 will work, else ill have to use trig
    local entity = shoot_projectile_from_projectile( host, "mods/tales_of_kupoli/files/entities/projectiles/soul_string/proj.xml", x, y, 0, 0)
    segments_left = segments_left - 1
    RemoveSouls(1)
    ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(entity, "VariableStorageComponent", "segments_left") or 0, "value_int", segments_left)
end