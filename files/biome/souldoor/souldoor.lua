dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("data/scripts/gun/gun_actions.lua")
dofile_once("mods/souls/files/biome/souldoor/recipes.lua")

local altar = GetUpdatedEntityID()
local x, y = EntityGetTransform(altar)

local radius = 120

math.randomseed(x+GameGetFrameNum(), y+tonumber(StatsGetValue("world_seed")))

local targets = EntityGetInRadiusWithTag(x, y, radius, "card_action")

local spell_projectiles = {}
local pool_projectiles = {
    { probability = 1.0, id = "MOLDOS_REAPING_SHOT", },
    { probability = 1.0, id = "MOLDOS_WAND_CONSUMES_X_SOULS", },
    { probability = 0.9, id = "MOLDOS_SOUL_BLAST" },
    { probability = 0.9, id = "MOLDOS_SOUL_SPEED" },
    { probability = 0.8, id = "MOLDOS_SOULS_TO_POWER", },
    { probability = 0.6, id = "MOLDOS_SOUL_STRIKE", },
    { probability = 0.1, id = "MOLDOS_EAT_WAND_FOR_SOULS", },
    { probability = 0.9, id = "MOLDOS_SOUL_ARROW", },
    { probability = 0.6, id = "MOLDOS_SOUL_BALL", },
    { probability = 0.6, id = "MOLDOS_SOUL_METEOR", },
    { probability = 0.1, id = "MOLDOS_SOUL_HEALER", },
    { probability = 0.1, id = "MOLDOS_REAPING_HALO", },
    { probability = 0.1, id = "MOLDOS_WEAKENING_HALO", },
    { probability = 0.7, id = "MOLDOS_SOUL_CLOAK", },
    { probability = 0.7, id = "MOLDOS_SOUL_RAGE", },
    { probability = 1.0, id = "MOLDOS_SOUL_BOLT", },
    { probability = 0.7, id = "MOLDOS_SOULDOS", },
    { probability = 0.7, id = "MOLDOS_RANDOM_REAP", },
    { probability = 0.7, id = "MOLDOS_REAP_TELE", },
    { probability = 0.5, id = "MOLDOS_TOME_SLICE", },
    { probability = 0.5, id = "MOLDOS_TOME_LAUNCHER", },
    { probability = 0.7, id = "MOLDOS_SOUL_BOOST", },
    { probability = 0.6, id = "MOLDOS_SCALING_DAMAGE", },
    { probability = 0.6, id = "MOLDOS_SCALING_SPEED", },
    { probability = 0.1, id = "MOLDOS_SOUL_TINKER", },
    { probability = 0.8, id = "MOLDOS_SOUL_CRIT" },
    { probability = 0.5, id = "MOLDOS_SOUL_FIRE" },
    { probability = 0.5, id = "MOLDOS_REAP_FROM_FIRE" },
    { probability = 0.3, id = "MOLDOS_SOUL_BATTERY" },
}

local string = ""

if #targets > 0 and targets ~= nil then
    for i,v in ipairs(targets) do
        if table.contains(spell_projectiles, v) --[[or table.contains(spell_modifiers, v)]] then return end
        if not EntityHasTag(EntityGetParent(v), "wand") and EntityGetComponent(EntityGetParent(v), "AbilityComponent") == nil and EntityGetName(EntityGetParent(v)) ~= "inventory_full" then
            if EntityGetFirstComponentIncludingDisabled(v, "ItemActionComponent") ~= nil then
                --string = string .. "," .. ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(v, "ItemActionComponent") or 0, "action_id")
                for i,action in ipairs(actions) do
                    if action.id == ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(v, "ItemActionComponent") or 0, "action_id") then
                        --if table.contains(spell_projectiles, v) or table.contains(spell_modifiers, v) then return end
                        table.insert(spell_projectiles, v)
                    end
                end
            end
        end
    end
    --GamePrint(string)  
end

if #spell_projectiles >= 1 then
    local light_1 = EntityGetInRadiusWithTag(x, y, 150, "souls_exchanger_light_1")[1]
    EntitySetComponentsWithTagEnabled( light_1, "souls_exchanger_light_proj", true )
else
    local light_1 = EntityGetInRadiusWithTag(x, y, 150, "souls_exchanger_light_1")[1]
    EntitySetComponentsWithTagEnabled( light_1, "souls_exchanger_light_proj", false )
end

if #spell_projectiles >= 2 then
    local light_2 = EntityGetInRadiusWithTag(x, y, 150, "souls_exchanger_light_2")[1]
    EntitySetComponentsWithTagEnabled( light_2, "souls_exchanger_light_proj", true )
else
    local light_2 = EntityGetInRadiusWithTag(x, y, 150, "souls_exchanger_light_2")[1]
    EntitySetComponentsWithTagEnabled( light_2, "souls_exchanger_light_proj", false )
end

if #spell_projectiles >= 3 then
    local light_3 = EntityGetInRadiusWithTag(x, y, 150, "souls_exchanger_light_3")[1]
    EntitySetComponentsWithTagEnabled( light_3, "souls_exchanger_light_proj", true )
else
    local light_3 = EntityGetInRadiusWithTag(x, y, 150, "souls_exchanger_light_3")[1]
    EntitySetComponentsWithTagEnabled( light_3, "souls_exchanger_light_proj", false )
end

if #spell_projectiles >= 4 then
    local light_4 = EntityGetInRadiusWithTag(x, y, 150, "souls_exchanger_light_4")[1]
    EntitySetComponentsWithTagEnabled( light_4, "souls_exchanger_light_proj", true )
else
    local light_4 = EntityGetInRadiusWithTag(x, y, 150, "souls_exchanger_light_4")[1]
    EntitySetComponentsWithTagEnabled( light_4, "souls_exchanger_light_proj", false )
end

if #spell_projectiles >= 5 then
    for i,v in ipairs(spell_projectiles) do
        EntityKill(v)
    end

    local rnd = random_create(x+GameGetFrameNum(), y+tonumber(StatsGetValue("world_seed")))
    local which = pick_random_from_table_weighted(rnd, pool_projectiles) or { id = "LIGHT_BULLET" }
    CreateItemActionEntity(which.id, x, y)

    spell_projectiles = {}

    local light_1 = EntityGetInRadiusWithTag(x, y, 80, "souls_exchanger_light_1")[1]
    EntitySetComponentsWithTagEnabled( light_1, "souls_exchanger_light_proj", false )
    local light_2 = EntityGetInRadiusWithTag(x, y, 80, "souls_exchanger_light_2")[1]
    EntitySetComponentsWithTagEnabled( light_2, "souls_exchanger_light_proj", false )
    local light_3 = EntityGetInRadiusWithTag(x, y, 80, "souls_exchanger_light_3")[1]
    EntitySetComponentsWithTagEnabled( light_3, "souls_exchanger_light_proj", false )
    local light_4 = EntityGetInRadiusWithTag(x, y, 80, "souls_exchanger_light_4")[1]
    EntitySetComponentsWithTagEnabled( light_4, "souls_exchanger_light_proj", false )
end