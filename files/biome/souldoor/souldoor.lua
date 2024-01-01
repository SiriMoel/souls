dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
dofile_once("data/scripts/gun/gun_actions.lua")
dofile_once("mods/tales_of_kupoli/files/biome/souldoor/recipes.lua")

local altar = GetUpdatedEntityID()
local x, y = EntityGetTransform(altar)

local radius = 80

SetRandomSeed(x, y+GameGetFrameNum())

local targets = EntityGetInRadiusWithTag(x, y, radius, "card_action")

--local keys = EntityGetInRadiusWithTag(x, y, radius, "kupoli_door_key")

local spell_projectiles = {}
local pool_projectiles = {
    "KUPOLI_SOUL_BLAST",
    "KUPOLI_REAPING_FIELD",
    "KUPOLI_REAPER_BLADE",
    "KUPOLI_SOUL_EXPLOSION",
    "KUPOLI_SOUL_GUARD",
}

local spell_modifiers = {}
local pool_modifiers = {
    "KUPOLI_SOUL_SPEED",
    "KUPOLI_REAPING_SHOT",
    "KUPOLI_SOULS_TO_POWER",
    "KUPOLI_SOUL_IS_MANA",
    "KUPOLI_SOUL_BATTERY",
    "KUPOLI_GILDED_SOULS_TO_GOLD",
}

local string = ""

--[[if #keys > 0 and #keys ~- nil then
    if not GameHasFlagRun("kupoli_opened") then
        GamePrint("The altar is unattended.")
        GameAddFlagRun("kupoli_opened")
    end
end]]--

if #targets > 0 and targets ~= nil then
    for i,v in ipairs(targets) do
        if table.contains(spell_projectiles, v) or table.contains(spell_modifiers, v) then return end
        if not EntityHasTag(EntityGetParent(v), "wand") and EntityGetComponent(EntityGetParent(v), "AbilityComponent") == nil and EntityGetName(EntityGetParent(v)) ~= "inventory_full" then
            if EntityGetFirstComponentIncludingDisabled(v, "ItemActionComponent") ~= nil then
                --string = string .. "," .. ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(v, "ItemActionComponent") or 0, "action_id")
                for i,action in ipairs(actions) do
                    if action.id == ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(v, "ItemActionComponent") or 0, "action_id") then
                        --if table.contains(spell_projectiles, v) or table.contains(spell_modifiers, v) then return end
                        if action.type == ACTION_TYPE_PROJECTILE or action.type == ACTION_TYPE_STATIC_PROJECTILE then
                            table.insert(spell_projectiles, v)
                        elseif action.type == ACTION_TYPE_MODIFIER then
                            table.insert(spell_modifiers, v)
                        end
                    end
                end
            end
        end
    end
    --GamePrint(string)  
end

-- projectiles
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

-- modifiers
if #spell_modifiers >= 1 then
    local light_1 = EntityGetInRadiusWithTag(x, y, 150, "kupoli_exchanger_light_1")[1]
    EntitySetComponentsWithTagEnabled( light_1, "kupoli_exchanger_light_mod", true )
else
    local light_1 = EntityGetInRadiusWithTag(x, y, 150, "kupoli_exchanger_light_1")[1]
    EntitySetComponentsWithTagEnabled( light_1, "kupoli_exchanger_light_mod", false )
end

if #spell_modifiers >= 2 then
    local light_2 = EntityGetInRadiusWithTag(x, y, 150, "kupoli_exchanger_light_2")[1]
    EntitySetComponentsWithTagEnabled( light_2, "kupoli_exchanger_light_mod", true )
else
    local light_2 = EntityGetInRadiusWithTag(x, y, 150, "kupoli_exchanger_light_2")[1]
    EntitySetComponentsWithTagEnabled( light_2, "kupoli_exchanger_light_mod", false )
end

if #spell_modifiers >= 3 then
    local light_3 = EntityGetInRadiusWithTag(x, y, 150, "kupoli_exchanger_light_3")[1]
    EntitySetComponentsWithTagEnabled( light_3, "kupoli_exchanger_light_mod", true )
else
    local light_3 = EntityGetInRadiusWithTag(x, y, 150, "kupoli_exchanger_light_3")[1]
    EntitySetComponentsWithTagEnabled( light_3, "kupoli_exchanger_light_mod", false )
end

if #spell_modifiers >= 4 then
    local light_4 = EntityGetInRadiusWithTag(x, y, 150, "kupoli_exchanger_light_4")[1]
    EntitySetComponentsWithTagEnabled( light_4, "kupoli_exchanger_light_mod", true )
else
    local light_4 = EntityGetInRadiusWithTag(x, y, 150, "kupoli_exchanger_light_4")[1]
    EntitySetComponentsWithTagEnabled( light_4, "kupoli_exchanger_light_mod", false )
end

if #spell_modifiers >= 5 then
    for i,v in ipairs(spell_modifiers) do
        EntityKill(v)
    end

    CreateItemActionEntity(pool_modifiers[math.random(1,#pool_modifiers)], x, y)

    spell_modifiers = {}

    local light_1 = EntityGetInRadiusWithTag(x, y, 80, "kupoli_exchanger_light_1")[1]
    EntitySetComponentsWithTagEnabled( light_1, "kupoli_exchanger_light_mod", false )
    local light_2 = EntityGetInRadiusWithTag(x, y, 80, "kupoli_exchanger_light_2")[1]
    EntitySetComponentsWithTagEnabled( light_2, "kupoli_exchanger_light_mod", false )
    local light_3 = EntityGetInRadiusWithTag(x, y, 80, "kupoli_exchanger_light_3")[1]
    EntitySetComponentsWithTagEnabled( light_3, "kupoli_exchanger_light_mod", false )
    local light_4 = EntityGetInRadiusWithTag(x, y, 80, "kupoli_exchanger_light_4")[1]
    EntitySetComponentsWithTagEnabled( light_4, "kupoli_exchanger_light_mod", false )
end