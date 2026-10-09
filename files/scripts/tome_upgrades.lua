function CheckIsTomeMaxed(tome)
    local comp = EntityGetFirstComponentIncludingDisabled(tome, "AbilityComponent")
    if comp ~= nil then
        local deck_capacity = ComponentObjectGetValue2(comp, "gun_config", "deck_capacity")
        local mana_max = ComponentGetValue2(comp, "mana_max")
        local mana_charge_speed = ComponentGetValue2(comp, "mana_charge_speed")
        local fire_rate_wait = ComponentObjectGetValue2(comp, "gunaction_config", "fire_rate_wait")
        local reload_time = ComponentObjectGetValue2(comp, "gun_config", "reload_time")
        local checks = {
            {"Capacity", function() return deck_capacity >= 26 end},
            {"Mana max", function() return mana_max >= 5000 end},
            {"Mana charge speed", function() return mana_charge_speed >= 2200 end},
            {"Cast delay", function() return fire_rate_wait <= -18 end},
            {"Recharge time", function() return reload_time <= 0 end},
        }
        local maxed = {}
        for _, v in ipairs(checks) do
            if v[2]() then
                table.insert(maxed, v[1])
            end
        end
        if #maxed == 5 then
            return true
        elseif #maxed > 0 then
            local str = ""
            for i, v in ipairs(maxed) do
                if i == 1 then
                    str = str .. v
                else
                    str = str .. ", " .. v
                end
            end
            GamePrint("Maxed tome stats: " .. str)
        end
    end
    return false
end

tome_upgrades = {
    {
        id = "mana_max",
        sprite = "mods/souls/files/entities/items/tome2/upgrade_mana_max.png",
        func_cost = function(count) 
            return math.min(7 + count * 3, 22)
        end,
        func_apply = function(tome) 
            local comp = EntityGetFirstComponentIncludingDisabled(tome, "AbilityComponent")
            if comp ~= nil then
                local mana_max = ComponentGetValue2(comp, "mana_max")
                local reload_time = ComponentObjectGetValue2(comp, "gun_config", "reload_time")
                mana_max = math.min(mana_max + 150, 5000)
                reload_time = math.min(reload_time + 12, 120)
                ComponentSetValue2(comp, "mana_max", mana_max)
                ComponentObjectSetValue2(comp, "gun_config", "reload_time", reload_time)
            end
        end,
    },
    {
        id = "haste",
        sprite = "mods/souls/files/entities/items/tome2/upgrade_haste.png",
        func_cost = function(count) 
            return math.min(7 + count * 3, 22)
        end,
        func_apply = function(tome) 
            local comp = EntityGetFirstComponentIncludingDisabled(tome, "AbilityComponent")
            if comp ~= nil then
                local mana_charge_speed = ComponentGetValue2(comp, "mana_charge_speed")
                local reload_time = ComponentObjectGetValue2(comp, "gun_config", "reload_time")
                local fire_rate_wait = ComponentObjectGetValue2(comp, "gunaction_config", "fire_rate_wait")
                mana_charge_speed = math.min(mana_charge_speed + 70, 2200)
                reload_time = math.max(reload_time - 18, 0)
                fire_rate_wait = math.max(fire_rate_wait - 24, -18)
                ComponentSetValue2(comp, "mana_charge_speed", mana_charge_speed)
                ComponentObjectSetValue2(comp, "gun_config", "reload_time", reload_time)
                ComponentObjectSetValue2(comp, "gunaction_config", "fire_rate_wait", fire_rate_wait)
            end
        end,
    },
    {
        id = "capacity",
        sprite = "mods/souls/files/entities/items/tome2/upgrade_capacity.png",
        func_cost = function(count) 
            return math.min(7 + count * 3, 22)
        end,
        func_apply = function(tome) 
            local comp = EntityGetFirstComponentIncludingDisabled(tome, "AbilityComponent")
            if comp ~= nil then
                local mana_max = ComponentGetValue2(comp, "mana_max")
                local deck_capacity = ComponentObjectGetValue2(comp, "gun_config", "deck_capacity")
                local fire_rate_wait = ComponentObjectGetValue2(comp, "gunaction_config", "fire_rate_wait")
                mana_max = math.max(mana_max - 100, 150)
                deck_capacity = math.min(deck_capacity + 2, 26)
                fire_rate_wait = math.min(fire_rate_wait + 18, 120)
                ComponentSetValue2(comp, "mana_max", mana_max)
                ComponentObjectSetValue2(comp, "gun_config", "deck_capacity", deck_capacity)
                ComponentObjectSetValue2(comp, "gunaction_config", "fire_rate_wait", fire_rate_wait)
            end
        end,
    },
}