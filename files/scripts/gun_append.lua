dofile_once("mods/souls/files/scripts/souls.lua")

souls_not_enough = false
souls_not_enough_count = 0

local draw_shot_old = draw_shot
function draw_shot(...)
    souls_not_enough = false
    souls_not_enough_count = 0
    draw_shot_old(...)
    if souls_not_enough then
        SoulsPrint("You do not have enough souls for this. (" .. souls_not_enough_count .. ")", "say_not_enough")
        souls_not_enough = false
        souls_not_enough_count = 0
    end
end