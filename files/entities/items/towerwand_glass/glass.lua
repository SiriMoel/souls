dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local wand = GetUpdatedEntityID()
local x, y= EntityGetTransform(wand)
local comp_ability = EntityGetFirstComponentIncludingDisabled(wand, "AbilityComponent") or 0
local mana = ComponentGetValue2(comp_ability, "mana")

SetRandomSeed(x, y+GameGetFrameNum())

if mana <= 50 then
    GamePrint("The wand shattered!")

    local children = EntityGetAllChildren(wand) or {}
    for i,v in ipairs(children) do
        if EntityHasTag(v, "card_action") then
            local comp_itemaction = EntityGetFirstComponentIncludingDisabled(v, "ItemActionComponent") or 0
            local action_id = ComponentGetValue(comp_itemaction, "action_id") or ""

            CreateItemActionEntity( action_id, x + math.random(-30,30), y + math.random(0,15))
        end
    end

    EntityKill(wand)
    EntityLoad("data/entities/projectiles/deck/explosion_giga.xml", x, y)
end