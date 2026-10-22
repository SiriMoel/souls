dofile_once("mods/souls/files/scripts/souls.lua")
local this = GetUpdatedEntityID(this)
local x, y = EntityGetTransform(this)
local targets = EntityGetInRadiusWithTag(x, y, 2, "player_unit") or {}
if #targets > 0 then
    if SpellUseSouls(targets[1], 1) then
        ConvertMaterialOnAreaInstantly(x-4, y-4, 8, 8, CellFactory_GetType("souls_soulless_blood"), CellFactory_GetType("souls_soul_blood_1"), false, false)
        EntityLoad("mods/souls/files/entities/misc/soul_blood_fx.xml", x, y)
    end
end
EntityKill(this)