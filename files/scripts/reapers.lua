souls_reapers = {
    soul = function(entity, reapers, comp_name, comp_amt, soul_count, souls)
        soul_count = soul_count + comp_amt
        return soul_count, souls
    end,
    random = function(entity, reapers, comp_name, comp_amt, soul_count, souls)
        dofile_once("mods/souls/files/scripts/souls.lua")
        local soul_types = GetSoulTypes()
        for i = 1, comp_amt do
            local r_soul = soul_types[Random(1, #soul_types - 2)]
            souls[r_soul] = (souls[r_soul] or 0) + 1
        end
        return soul_count, souls 
    end,
    necronomical = function(entity, reapers, comp_name, comp_amt, soul_count, souls)
        if #reapers > 1 then
            souls["zombie"] = (souls["zombie"] or 0) + comp_amt
        end
        return soul_count, souls 
    end,
    echo = function(entity, reapers, comp_name, comp_amt, soul_count, souls)
        dofile_once("mods/souls/files/scripts/souls.lua")
        local player = EntityGetWithTag("player_unit")[1]
        local comp = EntityGetFirstComponentIncludingDisabled(player, "Inventory2Component")
	    if comp ~= nil then
    		local wand = ComponentGetValue2(comp, "mActiveItem")
            local wand_type = WandSoulType(wand)
            local entity_type = GetEntitySoulType(entity)
            if entity_type == wand_type then
                souls["bat"] = (souls["bat"] or 0) + comp_amt
            end
        end
        return soul_count, souls 
    end,
    slimy = function(entity, reapers, comp_name, comp_amt, soul_count, souls)
        dofile_once("mods/souls/files/scripts/souls.lua")
        local entity_type = GetEntitySoulType(entity)
        if (entity_type == "slimes" and soul_count > 0) or (souls["slimes"] ~= nil and souls["slimes"] > 0) then
            local x, y = EntityGetTransform(entity)
            souls["slimes"] = (souls["slimes"] or 0) - 1
            for i = 1, comp_amt do
                --SetRandomSeed(x + entity + i, y)
                local chances = {
                    default = 50,
                    souls_void = 20,
                    boss = 1,
                }
                local chance_total = 0
                local soul_types = GetSoulTypes()
                local soul_chances = {}
                for ii, v in ipairs(soul_types) do
                    local chance = chances[v] or chances.default
                    table.insert(soul_chances, {
                        soul = tostring(v),
                        chance = chance,
                        chance_min = chance_total,
                        chance_max = chance_total + chance
                    })
                    chance_total = chance_total + chance
                end
                local num = Random(1, chance_total)
                local soul
                for _, v in ipairs(soul_chances) do
                    if num >= v.chance_min and num < v.chance_max then
                        soul = v.soul
                        break
                    end
                end
                souls[tostring(soul)] = (souls[tostring(soul)] or 0) + 1
            end
        end
        return soul_count, souls 
    end,
}