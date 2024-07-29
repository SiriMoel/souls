dofile_once("mods/souls/files/scripts/utils.lua")

local arrow = GetUpdatedEntityID()

local comp_proj = EntityGetFirstComponentIncludingDisabled(arrow, "ProjectileComponent") or 0

local damage_healing = ComponentObjectGetValue2(comp_proj, "damage_by_type", "healing")

damage_healing = damage_healing * 1.4

--GamePrint(damage_healing)

ComponentObjectSetValue2(comp_proj, "damage_by_type", "healing", damage_healing)