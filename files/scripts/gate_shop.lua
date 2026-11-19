dofile_once("mods/souls/files/scripts/souls.lua")

gate_shop_items = {
    {
        id = "wand_t4",
        name = "Wand",
        price = {
            {"soul", 10}, -- any, or specific types can be specified
            {{"bat", "worm", "ghost"}, 5}, -- 3 of a random one of these types
        },
        chance = function()
            return 5.0
        end,
        spawn = function(x, y)
            local item = EntityLoad("data/entities/items/wand_unshuffle_04.xml", x, y)
            return item
        end,
    },
    {
        id = "sentinel_spell",
        name = "Summon Soul Sentinel",
        price = {
            {"soul", 20},
            {{"souls_void", "ghost", "worm"}, 5},
            {"souls_void", 5},
        },
        chance = function()
            return 1.0
        end,
        spawn = function(x, y)
            local item = CreateItemActionEntity("SOULS_SENTINEL", x, y)
            return item
        end,
    },
}

function GateShop(shop)
    local shop_items = EntityGetAllChildren(shop, "souls_gate_shop_item") or {}
    if #shop_items > 0 then
        for i, v in ipairs(shop_items) do
            EntityKill(v)
        end
    end
    local price_comps = EntityGetComponentIncludingDisabled(shop, "VariableStorageComponent", "shop_price") or {}
    if #price_comps > 0 then
        for _, comp in ipairs(price_comps) do
            EntityRemoveComponent(shop, comp)
        end
    end
    local x, y = EntityGetTransform(shop)
    local frame = GameGetFrameNum()
    SetRandomSeed(x + frame, y)
    local chance_total = 0.0
    local possible_rewards = {}
    for i, v in ipairs(gate_shop_items) do
        local chance = v.chance()
        if chance > 0 then
            v.chance_min = chance_total
            v.chance_max = chance_total + chance
            chance_total = v.chance_max
            table.insert(possible_rewards, v)
        end
    end
    local num = Random(0, math.floor(chance_total)) + 0.1 * Random(0, (chance_total - math.floor(chance_total)) * 10)
    local item
    for i, v in ipairs(possible_rewards) do
        if num >= v.chance_min and num < v.chance_max then
            item = v
            break
        end
    end
    if item ~= nil then
        local soul_types, all_soul_types, shifts = GetSoulTypes()
        for _, v in ipairs(item.price) do
            local soul = v[1]
            if type(v[1]) == "table" then
                soul = v[1][Random(1, #v[1])]
            end
            soul = shifts[soul] or soul
            local price = v[2]
            if type(v[2]) == "table" then
                price = Random(v[2][1], v[2][2])
            end
            EntityAddComponent2(shop, "VariableStorageComponent", {
                _tags = "shop_price",
                name = soul,
                value_int = price
            })
        end
        local item_entity = item.spawn(x, y)
        EntityAddTag(item_entity, "souls_gate_shop_item")
        local comp_item = EntityGetFirstComponentIncludingDisabled(item_entity, "ItemComponent")
        if comp_item ~= nil then
            ComponentSetValue2(comp_item, "is_pickable", false)
        end
        EntityAddChild(shop, item_entity)
    end
end