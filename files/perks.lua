dofile_once("mods/souls/files/scripts/utils.lua")
local total_perks_picked = 0;
local has_movement_perk = false;

local a = {
}

for i,v in ipairs(a) do
    v.id = "MOLDOS_" .. v.id
    table.insert(perk_list, v)
end