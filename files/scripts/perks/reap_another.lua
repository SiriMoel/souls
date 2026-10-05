dofile_once("data/scripts/lib/utilities.lua")
function on_reap(player, n)
    local x, y = EntityGetTransform(player)
    for i = 1, n do
        shoot_projectile(player, "mods/souls/files/entities/projectiles/perk_reap_another/projectile.xml", x, y - 6, 0, -300)
    end
end
return {on_reap = on_reap}