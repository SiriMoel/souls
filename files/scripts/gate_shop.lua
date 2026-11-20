dofile_once("mods/souls/files/scripts/souls.lua")

GateSouls = {
    USUAL = 1, -- all minus void & boss
    ALL = 2, -- all minus boss
    ALL_BOSS = 3, -- all
}

gate_shop_items = {
    {
        id = "spell_t3",
        name = "Spell",
        price = {
            {"soul", {5, 10}},
            {{"slimes", "orcs", "zombie", "orcs", "spider"}, {2, 5}},
            {GateSouls.USUAL, {2, 5}},
        },
        chance = function()
            return 6.0
        end,
        spawn = function(x, y)
            local item = CreateItemActionEntity(GetRandomAction(x + GameGetFrameNum(), y, 3), x, y)
            return item
        end,
    },
    {
        id = "spell_t4",
        name = "Spell",
        price = {
            {"soul", {5, 20}},
            {{"bat", "worm", "ghost", "fungi"}, {5, 10}},
            {{"slimes", "orcs", "zombie", "orcs", "spider"}, {2, 10}},
            {GateSouls.USUAL, {1, 5}},
        },
        chance = function()
            return 7.0
        end,
        spawn = function(x, y)
            local item = CreateItemActionEntity(GetRandomAction(x + GameGetFrameNum(), y, 4), x, y)
            return item
        end,
    },
    {
        id = "spell_t5",
        name = "Spell",
        price = {
            {"soul", {10, 30}},
            {{"bat", "worm", "ghost"}, {0, 5}},
            {{"slimes", "orcs", "zombie"}, {2, 10}},
            {GateSouls.USUAL, {2, 10}},
        },
        chance = function()
            return 6.0
        end,
        spawn = function(x, y)
            local item = CreateItemActionEntity(GetRandomAction(x + GameGetFrameNum(), y, 5), x, y)
            return item
        end,
    },
    {
        id = "spell_t6",
        name = "Spell",
        price = {
            {"soul", {15, 30}},
            {{"bat", "worm", "ghost", "mage"}, {5, 15}},
            {{"slimes", "orcs", "zombie"}, {5, 30}},
            {GateSouls.USUAL, {0, 8}},
            {{"souls_void", "boss", "mage", "bat"}, {0, 2}},
        },
        chance = function()
            return 2.0
        end,
        spawn = function(x, y)
            local item = CreateItemActionEntity(GetRandomAction(x + GameGetFrameNum(), y, 6), x, y)
            return item
        end,
    },
    {
        id = "sentinel_spell",
        name = "Summon Soul Sentinel",
        price = {
            {"soul", 20},
            {GateSouls.USUAL, 5},
            {GateSouls.USUAL, 5},
            {"souls_void", 3},
        },
        chance = function()
            return 0.1
        end,
        spawn = function(x, y)
            local item = CreateItemActionEntity("SOULS_SENTINEL", x, y)
            return item
        end,
    },
    {
        id = "heart_fullhp",
        name = "heart_fullhp",
        price = {
            {"soul", {30, 50}},
            {{"souls_void", "worm", "bat"}, {0, 10}},
            {"boss", 1},
        },
        chance = function()
            return 0.3
        end,
        spawn = function(x, y)
            local item = EntityLoad("data/entities/items/pickup/heart_fullhp.xml", x, y)
            return item
        end,
    },
    {
        id = "boss_soul",
        name = "Boss Soul",
        price = {
            {"soul", {10, 30}},
            {{"mage", "worm", "bat"}, {2, 15}},
        },
        chance = function()
            return 0.7
        end,
        spawn = function(x, y)
            local item = EntityLoad("mods/souls/files/entities/souls/boss.xml", x, y)
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
            elseif v[1] == GateSouls.USUAL then  
                soul = soul_types[Random(1, #soul_types - 2)]
            elseif v[1] == GateSouls.ALL then
                soul = soul_types[Random(1, #soul_types - 1)]
            elseif v[1] == GateSouls.ALL_BOSS then
                soul = soul_types[Random(1, #soul_types)]
            end
            soul = shifts[soul] or soul
            local price = v[2]
            if type(v[2]) == "table" then
                price = Random(v[2][1], v[2][2])
            end
            if price > 0 then
                EntityAddComponent2(shop, "VariableStorageComponent", {
                    _tags = "shop_price",
                    name = soul,
                    value_int = price
                })
            end
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