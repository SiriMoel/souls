dofile_once("mods/souls/files/scripts/souls.lua")
dofile_once("data/scripts/gun/gun_actions.lua")

GateSouls = {
    USUAL = 1, -- all minus void & boss
    ALL = 2, -- all minus boss
    ALL_BOSS = 3, -- all
}

gate_shop_items = {
    {
        id = "spell_t3",
        name = nil,
        spell = true,
        price = {
            {GateSouls.USUAL, {7, 15}},
            {{"slimes", "orcs", "zombie", "spider"}, {3, 10}},
            {{"bat", "worm", "ghost", "fungus"}, {2, 5}},
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
        spell = true,
        price = {
            {GateSouls.USUAL, {5, 15}},
            {GateSouls.USUAL, {5, 15}},
            {{"bat", "worm", "ghost", "fungus"}, {5, 10}},
            {GateSouls.ALL, {1, 5}},
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
        spell = true,
        price = {
            {GateSouls.USUAL, {15, 40}},
            {GateSouls.USUAL, {10, 30}},
            {{"bat", "worm", "ghost"}, {0, 15}},
            {GateSouls.ALL, {1, 10}},
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
        spell = true,
        price = {
            {GateSouls.USUAL, {15, 35}},
            {GateSouls.USUAL, {10, 40}},
            {GateSouls.USUAL, {5, 25}},
            {{"bat", "slimes", "fungus", "orcs", "ghost", "mage"}, {10, 20}},
            {{"souls_void", "boss", "bat", "worm"}, {0, 4}},
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
        spell = true,
        price = {
            {GateSouls.USUAL, 10},
            {GateSouls.USUAL, 10},
            {GateSouls.USUAL, 10},
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
        id = "tome_spell",
        spell = true,
        price = {
            {GateSouls.USUAL, 20},
            {GateSouls.USUAL, 20},
            {GateSouls.USUAL, 20},
            {GateSouls.ALL, {1, 15}},
            {"boss", 1},
        },
        chance = function()
            return 0.3
        end,
        spawn = function(x, y)
            local opts = {"SOULS_TOME_SLICE", "SOULS_TOME_LAUNCHER", "SOULS_TOME_LASER", "SOULS_TOME_SPELLBOOK_2"}
            local item = CreateItemActionEntity(opts[Random(1, #opts)], x, y)
            return item
        end,
    },
    {
        id = "reaping_spell",
        spell = true,
        price = {
            {GateSouls.USUAL, {1, 10}},
            {GateSouls.USUAL, {1, 10}},
            {GateSouls.USUAL, {1, 10}},
            {GateSouls.USUAL, {1, 10}},
            {GateSouls.ALL, {1, 10}},
        },
        chance = function()
            return 1.0
        end,
        spawn = function(x, y)
            local opts = {"SOULS_REAPING_SHOT", "SOULS_RANDOM_REAP", "SOULS_SOULDOS", "SOULS_REAP_FROM_FIRE", "SOULS_NECRONOMICAL_REAP", "SOULS_ECHOREAP", "SOULS_REAP_SLIMY"}
            local item = CreateItemActionEntity(opts[Random(1, #opts)], x, y)
            return item
        end,
    },
    {
        id = "heart_fullhp",
        price = {
            {"soul", {50, 100}},
            {{"mage", "worm", "bat", "ghost"}, {0, 15}},
            {"boss", 1},
        },
        chance = function()
            return 0.7
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
            {"soul", {35, 70}},
            {"souls_void", {0, 2}}
        },
        chance = function()
            return 0.9
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

        local item_entity = item.spawn(x, y)
        EntityAddTag(item_entity, "souls_gate_shop_item")

        local item_name = item.name or ""
        local comp_item = EntityGetFirstComponentIncludingDisabled(item_entity, "ItemComponent")
        if comp_item ~= nil then
            ComponentSetValue2(comp_item, "is_pickable", false)
            if not item.spell then
                item_name = GameTextGetTranslatedOrNot(ComponentGetValue2(comp_item, "item_name"))
            end
        end
        EntityAddChild(shop, item_entity)

        if item.spell then
            local comp_action = EntityGetFirstComponentIncludingDisabled(item_entity, "ItemActionComponent")
            if comp_action ~= nil then
                local action_id = ComponentGetValue2(comp_action, "action_id")
                for _, action in ipairs(actions) do
                    if action.id == action_id then
                        item_name = GameTextGetTranslatedOrNot(action.name)
                        break
                    end
                end
            end
        end

        local comp_interact = EntityGetFirstComponentIncludingDisabled(shop, "InteractableComponent")
        if comp_interact ~= nil then
            local interact_text = "INTERACT: Purchase " .. item_name
            ComponentSetValue2(comp_interact, "ui_text", interact_text)
        end

        local soul_prices = {}
        for i, v in ipairs(item.price) do
            SetRandomSeed(x + frame + i, y)
            local soul = v[1]
            if type(v[1]) == "table" then soul = v[1][Random(1, #v[1])] -- amazing formatting!!!
            elseif v[1] == GateSouls.USUAL then soul = soul_types[Random(1, #soul_types - 2)]
            elseif v[1] == GateSouls.ALL then soul = soul_types[Random(1, #soul_types - 1)]
            elseif v[1] == GateSouls.ALL_BOSS then soul = soul_types[Random(1, #soul_types)] end
            soul = shifts[soul] or soul
            local price = v[2]
            if type(v[2]) == "table" then
                price = Random(v[2][1], v[2][2])
            end
            if price > 0 then
                soul_prices[tostring(soul)] = (soul_prices[tostring(soul)] or 0) + price
            end
        end
        if soul_prices["soul"] ~= nil then
            EntityAddComponent2(shop, "VariableStorageComponent", {
                _tags = "shop_price",
                name = "soul",
                value_int = soul_prices["soul"]
            })
        end
        for k, v in pairs(soul_prices) do
            if tostring(k) ~= "soul" then
                EntityAddComponent2(shop, "VariableStorageComponent", {
                    _tags = "shop_price",
                    name = tostring(k),
                    value_int = v
                })
            end
        end
    end
end