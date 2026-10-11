dofile_once("mods/souls/files/scripts/souls.lua")

local card = GetUpdatedEntityID()
local root = EntityGetRootEntity(card) -- player, right?

if not EntityHasTag(root, "player_unit") then return end

local wand = EntityGetParent(card)

local comp = EntityGetFirstComponentIncludingDisabled(wand, "VariableStorageComponent", "souls_wand_soul_type")
comp = comp or EntityAddComponent2(wand, "VariableStorageComponent", {
       _tags="souls_wand_soul_type",
    name="souls_wand_soul_type",
    value_int=0
})

local val = ComponentGetValue2(comp, "value_int")

local comp_sprite = EntityGetFirstComponentIncludingDisabled(card, "SpriteComponent", "selected_soul")
if comp_sprite ~= nil then
    if val ~= 0 then
        ComponentSetValue2(comp_sprite, "image_file", "mods/souls/files/entities/souls/sprites/soul_" .. soul_types[val] .. ".xml")
        EntityRefreshSprite(card, comp_sprite)
    else
        ComponentSetValue2(comp_sprite, "image_file", "mods/souls/files/entities/souls/sprites/soul_any.xml")
        EntityRefreshSprite(card, comp_sprite)
    end
end

local comp_controls = EntityGetFirstComponentIncludingDisabled(root, "ControlsComponent")
local comp_cd = EntityGetFirstComponentIncludingDisabled(card, "VariableStorageComponent", "cooldown_frame") or 0
local cooldown_frames = 8
local cooldown_frame = ComponentGetValue2(comp_cd, "value_int")
local frame = GameGetFrameNum()
if ComponentGetValue2(comp_controls, "mButtonDownRightClick") == true and frame >= cooldown_frame then
    if val >= #soul_types then
        val = 0
    else
        val = val + 1
    end
    ComponentSetValue2(comp, "value_int", val)
    ComponentSetValue2(comp_cd, "value_int", frame + cooldown_frames)
    local soul = (val == 0 and "any") or SoulNameCheck(soul_types[val])
    GamePrint("This wand will now consume " .. soul .. " souls.")
end