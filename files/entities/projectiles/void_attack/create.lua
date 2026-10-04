local this = GetUpdatedEntityID()
local comp = EntityGetFirstComponentIncludingDisabled(this, "ProjectileComponent")
if comp ~= nil then
    local player = EntityGetWithTag("player_unit")[1]
    local comp_used = EntityGetFirstComponentIncludingDisabled(player, "VariableStorageComponent", "souls_used_total")
    if comp_used ~= nil then
        local amt = ComponentGetValue2(comp_used, "value_int")
        local damage = ComponentGetValue2(comp, "damage")
        damage = damage + amt * 0.01
        ComponentSetValue2(comp, "damage", damage)
    end
    local x, y = EntityGetTransform(this)
    GamePlaySound("data/audio/Desktop/projectiles.bank", "projectiles/enlightened_laser/launch_light", x, y)
end