dofile_once( "data/scripts/game_helpers.lua" )
dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
dofile_once("mods/tales_of_kupoli/files/scripts/biome_things.lua")
dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")

local do_money_drop_old = do_money_drop

function do_money_drop( amount_multiplier, trick_kill )

    local entity = GetUpdatedEntityID()
    local herd_id_number = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( entity, "GenomeDataComponent" ) or 0, "herd_id")
    local herd_id = HerdIdToString(herd_id_number)
    local x, y = EntityGetTransform(entity)

    if table.contains(soul_types, herd_id) then
        SetRandomSeed(x, y+GameGetFrameNum())
        if #EntityGetInRadiusWithTag(x, y, 300, "player_unit") > 0 then
            if math.random(1,15) == 10 then
                herd_id = "gilded"
            end
    
            if math.random(1, 5) == 2 or EntityHasTag(GetPlayer(), "kupoli_always_drop_souls") then
                if ModSettingGet("tales_of_kupoli.say_soul") == true then
                    GamePrint("You have acquired a " .. SoulNameCheck(herd_id) .. " soul!")
                end
                AddSoul(herd_id)
            end

            if EntityHasTag(GetPlayer(), "kupoli_biome_souls") then
                local whichtype = ""
                for i=1,#biomethings do
                    if biomethings[i].biome == BiomeMapGetName(x, y) then
                        if biomethings[i].soul ~= "" then
                            whichtype = biomethings[i].soul
                            if ModSettingGet("tales_of_kupoli.say_soul") == true then
                                GamePrint("You have acquired a " .. SoulNameCheck(whichtype) .. " soul!")
                            end
                            AddSoul(whichtype)
                        end
                    end
                end
            end
        end
    end

    do_money_drop_old( amount_multiplier, trick_kill )
end