dofile_once("mods/souls/files/scripts/souls.lua")
local player = GetUpdatedEntityID()
if SoulCount("total_boss", player) == 0 then
    local comp = EntityGetFirstComponent(player, "DamageModelComponent")
    local max_hp = ComponentGetValue2(comp, "max_hp")
    local x, y = EntityGetTransform(player)
    EntityInflictDamage(player, max_hp * 0.25, "DAMAGE_CURSE", "You are a soulless being.", "DISINTEGRATED", 0, 0, player, x, y, 0)
    GamePrint("You are a soulless being.")
end