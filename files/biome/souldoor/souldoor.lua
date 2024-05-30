dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
dofile_once("data/scripts/gun/gun_actions.lua")
dofile_once("mods/tales_of_kupoli/files/biome/souldoor/recipes.lua")

local altar = GetUpdatedEntityID()
local x, y = EntityGetTransform(altar)

local radius = 120

math.randomseed(x+GameGetFrameNum(), y+tonumber(StatsGetValue("world_seed")))

local targets = EntityGetInRadiusWithTag(x, y, radius, "card_action")

local spell_projectiles = {}
local pool_projectiles = {
    "KUPOLI_SOUL_BLAST",
    "KUPOLI_SOUL_SPEED",
    "KUPOLI_REAPING_FIELD",
    "KUPOLI_REAPING_SHOT",
    "KUPOLI_REAPER_BLADE",
    "KUPOLI_SOULS_TO_POWER",
    "KUPOLI_SOUL_EXPLOSION",
    "KUPOLI_SOUL_IS_MANA",
    "KUPOLI_SOUL_GUARD",
    "KUPOLI_RANDOM_REAP",
    "KUPOLI_SOUL_BATTERY",
    "KUPOLI_GILDED_SOULS_TO_GOLD",
    "KUPOLI_EAT_WAND_FOR_SOULS",
    "KUPOLI_SOUL_NECROMANCY",
    "KUPOLI_SOUL_MINIONS_TO_HEALING",
    "KUPOLI_SOUL_MINIONS_TO_NUKES",
    "KUPOLI_CRYSTALLISE_SOULS",
    "KUPOLI_SOUL_DASH",
    "KUPOLI_SOUL_HEALER",
    "KUPOLI_SOUL_BALL",
    "KUPOLI_SOUL_METEOR",
    "KUPOLI_SOUL_ARROW",
    "KUPOLI_SOUL_STRIKE"
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
    local light_1 = EntityGetInRadiusWithTag(x, y, 150, "kupoli_exchanger_light_1")[1]
    EntitySetComponentsWithTagEnabled( light_1, "kupoli_exchanger_light_proj", true )
else
    local light_1 = EntityGetInRadiusWithTag(x, y, 150, "kupoli_exchanger_light_1")[1]
    EntitySetComponentsWithTagEnabled( light_1, "kupoli_exchanger_light_proj", false )
end

if #spell_projectiles >= 2 then
    local light_2 = EntityGetInRadiusWithTag(x, y, 150, "kupoli_exchanger_light_2")[1]
    EntitySetComponentsWithTagEnabled( light_2, "kupoli_exchanger_light_proj", true )
else
    local light_2 = EntityGetInRadiusWithTag(x, y, 150, "kupoli_exchanger_light_2")[1]
    EntitySetComponentsWithTagEnabled( light_2, "kupoli_exchanger_light_proj", false )
end

if #spell_projectiles >= 3 then
    local light_3 = EntityGetInRadiusWithTag(x, y, 150, "kupoli_exchanger_light_3")[1]
    EntitySetComponentsWithTagEnabled( light_3, "kupoli_exchanger_light_proj", true )
else
    local light_3 = EntityGetInRadiusWithTag(x, y, 150, "kupoli_exchanger_light_3")[1]
    EntitySetComponentsWithTagEnabled( light_3, "kupoli_exchanger_light_proj", false )
end

if #spell_projectiles >= 4 then
    local light_4 = EntityGetInRadiusWithTag(x, y, 150, "kupoli_exchanger_light_4")[1]
    EntitySetComponentsWithTagEnabled( light_4, "kupoli_exchanger_light_proj", true )
else
    local light_4 = EntityGetInRadiusWithTag(x, y, 150, "kupoli_exchanger_light_4")[1]
    EntitySetComponentsWithTagEnabled( light_4, "kupoli_exchanger_light_proj", false )
end

if #spell_projectiles >= 5 then
    for i,v in ipairs(spell_projectiles) do
        EntityKill(v)
    end

    CreateItemActionEntity(pool_projectiles[math.random(1,#pool_projectiles)], x, y)

    spell_projectiles = {}

    local light_1 = EntityGetInRadiusWithTag(x, y, 80, "kupoli_exchanger_light_1")[1]
    EntitySetComponentsWithTagEnabled( light_1, "kupoli_exchanger_light_proj", false )
    local light_2 = EntityGetInRadiusWithTag(x, y, 80, "kupoli_exchanger_light_2")[1]
    EntitySetComponentsWithTagEnabled( light_2, "kupoli_exchanger_light_proj", false )
    local light_3 = EntityGetInRadiusWithTag(x, y, 80, "kupoli_exchanger_light_3")[1]
    EntitySetComponentsWithTagEnabled( light_3, "kupoli_exchanger_light_proj", false )
    local light_4 = EntityGetInRadiusWithTag(x, y, 80, "kupoli_exchanger_light_4")[1]
    EntitySetComponentsWithTagEnabled( light_4, "kupoli_exchanger_light_proj", false )
end