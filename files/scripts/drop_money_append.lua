dofile_once( "data/scripts/game_helpers.lua" )
dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local do_money_drop_old = do_money_drop

function do_money_drop( amount_multiplier, trick_kill )

    local entity = GetUpdatedEntityID()
    local herd_id_number = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( entity, "GenomeDataComponent" ) or 0, "herd_id")
    local herd_id = HerdIdToString(herd_id_number)
    local x, y = EntityGetTransform(entity)

    if table.contains(soul_types, herd_id) then
        SetRandomSeed(x, y+GameGetFrameNum())

        --[[if math.random(1,15) == 10 then
            herd_id = "gilded"
        end]]--
    
        if math.random(1, 5) == 2 then
            if ModSettingGet("tales_of_kupoli.say_soul") == true then
                GamePrint("You have acquired a " .. herd_id .. " soul!")
            end
        
            AddSoul(herd_id)
        end
    end

    GamePrint("a")

    do_money_drop_old( amount_multiplier, trick_kill )
end