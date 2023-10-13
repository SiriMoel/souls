dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
dofile_once("mods/tales_of_kupoli/files/scripts/molebiomes.lua")
dofile_once("mods/tales_of_kupoli/files/scripts/moleslist.lua")

local entity = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity)

local biome_name = ""
local tier = 0
local spawnable_moles = {}

if #EntityGetInRadiusWithTag(x, y, 50, "player_unit") > 0 then -- currently incompatible with modded biomes
    biome_name = (DebugBiomeMapGetFilename(x, y)):match("data/biomes/([a-zA-Z0-9_-])+%.xml")
    for i,v in ipairs(molebiomes) do
        if v.biome == biome_name then
            tier = v.tier
            for i,v in ipairs(moles) do
                if v.tier ~= 0 and v.tier <= tier then
                    if v.spawn_check(x, y, biome_name) then
                        table.insert(spawnable_moles, v)
                    end
                end
                if v.tier == 0 then
                    if v.spawn_check(x, y, biome_name) then
                        table.insert(spawnable_moles, v)
                    end
                end
            end
            if #spawnable_moles <= 0 then return end
            local mole = math.random(1, #spawnable_moles)
            EntityLoad(spawnable_moles[mole].file, x, y)
            spawnable_moles = {}
        end
    end
end