dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local arrow = GetUpdatedEntityID()

local comp_proj = EntityGetFirstComponentIncludingDisabled(arrow, "ProjectileComponent") or 0

local damage_healing = ComponentObjectGetValue2(comp_proj, "damage_by_type", "healing")

damage_healing = damage_healing * 1.25

ComponentObjectSetValue2(comp_proj, "damage_by_type", "healing", damage_healing)