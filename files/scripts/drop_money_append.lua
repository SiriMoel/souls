dofile_once( "data/scripts/game_helpers.lua" )
dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local do_money_drop_old = do_money_drop

function do_money_drop( amount_multiplier, trick_kill )
    local entity = GetUpdatedEntityID()
    local x, y = EntityGetTransform(entity)

    math.randomseed(x, y+GameGetFrameNum())

    if math.random(1, 4) == 2 then
        ReapSoul(entity, 1, false)
    end

    do_money_drop_old( amount_multiplier, trick_kill )
end