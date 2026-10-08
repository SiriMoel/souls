dofile_once("data/scripts/lib/utilities.lua")
function on_reap(player, n)
    local x, y = EntityGetTransform(player)
    for i = 1, n do
        local vel_x = (n > 1 and Random(-n * 15, n * 15)) or 0
        shoot_projectile(player, "mods/souls/files/entities/projectiles/perk_reap_another/projectile.xml", x, y - 6, vel_x, -300)
    end
end
return {on_reap = on_reap}