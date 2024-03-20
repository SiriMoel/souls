dofile_once( "data/scripts/game_helpers.lua" )
dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")

local do_money_drop_old = do_money_drop

biomethings = {
    {
        biome = "$biome_coalmine",
        soul = "zombie",
        wand = "",
    },
    {
        biome = "$biome_coalmine_alt",
        soul = "zombie",
        wand = "",
    },
    {
        biome = "$biome_excavationsite",
        soul = "bat",
        wand = "",
    },
    {
        biome = "$biome_fungicave",
        soul = "fungus",
        wand = "",
    },
    {
        biome = "$biome_snowcave",
        soul = "orcs",
        wand = "",
    },
    {
        biome = "$biome_snowcastle",
        soul = "orcs",
        wand = "",
    },
    {
        biome = "$biome_rainforest",
        soul = "spider",
        wand = "",
    },
    {
        biome = "$biome_rainforest_dark",
        soul = "spider",
        wand = "",
    },
    {
        biome = "$biome_vault",
        soul = "",
        wand = "",
    },
    {
        biome = "$biome_crypt",
        soul = "mage",
        wand = "",
    },
    {
        biome = "$biome_gold",
        soul = "gilded",
        wand = "",
    },
    {
        biome = "$biome_winter",
        soul = "orcs",
        wand = "",
    },
    {
        biome = "$biome_tower",
        soul = "ghost",
        wand = "",
    },
    {
        biome = "$biome_secret_lab",
        soul = "mage",
        wand = "",
    },
    {
        biome = "$biome_vault_frozen",
        soul = "",
        wand = "",
    },
    {
        biome = "$biome_wandcave",
        soul = "mage",
        wand = "",
    },
    {
        biome = "$biome_wizardcave",
        soul = "mage",
        wand = "",
    },
    {
        biome = "$biome_liquidcave",
        soul = "mage",
        wand = "",
    },
    {
        biome = "$biome_winter_caves",
        soul = "ghost",
        wand = "",
    },
    {
        biome = "$biome_fun",
        soul = "fungus",
        wand = "",
    },
}

function do_money_drop( amount_multiplier, trick_kill )

    local entity = GetUpdatedEntityID()
    local herd_id_number = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( entity, "GenomeDataComponent" ) or 0, "herd_id")
    local herd_id = HerdIdToString(herd_id_number)
    local x, y = EntityGetTransform(entity)

    math.randomseed(x, y)

    if table.contains(soul_types, herd_id) then
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
                local whichtype = "friendly"
                for i=1,#biomethings do
                    if biomethings[i].biome == BiomeMapGetName(x, y) then
                        if biomethings[i].soul ~= "" then
                            whichtype = biomethings[i].soul
                        else
                            whichtype = "hiisi"
                        end
                    end
                end
                if ModSettingGet("tales_of_kupoli.say_soul") == true then
                    GamePrint("You have acquired a " .. SoulNameCheck(whichtype) .. " soul!")
                end
                AddSoul(whichtype)
            end

            if EntityHasTag(GetPlayer(), "kupoli_enemies_drop_wands") then
                local wand = "data/entities/items/wand_unshuffle_04.xml"
                for i,biometable in ipairs(biomethings) do
                    if biometable.biome == BiomeMapGetName(x, y) then
                        if biometable.wand ~= "" then
                            wand = biometable.wand
                        end
                    end
                end
                if math.random(1, 30) == 2 then
                    EntityLoad(wand, x, y)
                end
            end
        end
    end

    do_money_drop_old( amount_multiplier, trick_kill )
end