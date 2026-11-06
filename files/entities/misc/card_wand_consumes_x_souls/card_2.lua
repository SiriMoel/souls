dofile_once("mods/souls/files/scripts/souls.lua")

local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)
local x, y = EntityGetTransform(root)
local comp_controls = EntityGetFirstComponent(root, "ControlsComponent")
if comp_controls == nil then return end

local wand = EntityGetParent(this)
local comp = EntityGetFirstComponentIncludingDisabled(wand, "VariableStorageComponent", "souls_wand_soul_type")
comp = comp or EntityAddComponent2(wand, "VariableStorageComponent", {
    _tags="souls_wand_soul_type",
    name="souls_wand_soul_type",
    value_int=0
})
local val_comp = ComponentGetValue2(comp, "value_int")

local comp_button_was_down = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "button_was_down")
local button_was_down = ComponentGetValue2(comp_button_was_down, "value_int")

local button_down = ComponentGetValue2(comp_controls, "mButtonDownThrow")
local mouse_x, mouse_y = ComponentGetValue2(comp_controls, "mMousePosition")

local frame_now = GameGetFrameNum()

local selected_soul
local soul_n

local soul_counts = SoulCounts(root)
local count = #soul_types + 1
local dist = 40

--[[local comp_sprite = EntityGetFirstComponentIncludingDisabled(this, "SpriteParticleEmitterComponent", "selected_soul")
if comp_sprite ~= nil then
    if val_comp ~= 0 then
        ComponentSetValue2(comp_sprite, "sprite_file", "mods/souls/files/soul_sprites/" .. soul_types[val_comp] .. ".png")
        --EntityRefreshSprite(card, comp_sprite)
    else
        ComponentSetValue2(comp_sprite, "sprite_file", "mods/souls/files/soul_sprites/soul.png")
        --EntityRefreshSprite(card, comp_sprite)
    end
end]]

for i = 1, count do
    local soul = soul_types[i] or "soul"
    local a = (i / count) * 2 * math.pi
    local draw_x = x + math.cos(a) * dist
    local draw_y = y + math.sin(a) * dist
    local path = "mods/souls/files/soul_sprites/"
    if mouse_x > draw_x - 5 and mouse_x < draw_x + 5 and mouse_y > draw_y - 5 and mouse_y < draw_y + 5 then
        path = path .. soul .. ".png"
        selected_soul = soul
        soul_n = i
    elseif val_comp == i or (val_comp == 0 and soul == "soul") then
        path = path .. soul .. ".png"
    else
        path = path .. "silhouettes/" .. soul .. ".png"
    end
    if button_down then
        GameCreateSpriteForXFrames(path, draw_x, draw_y, true, 0, 0, 1, true)
    end
end

if button_down then
    button_was_down = 0
end

if button_was_down == 1 and selected_soul ~= nil then
    local comp_frame = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "frame")
    local frame = ComponentGetValue2(comp_frame, "value_int")
    if frame_now > frame + 18 then
        ComponentSetValue2(comp_frame, "value_int", frame_now)
        local soul = (selected_soul == "soul" and "any") or SoulNameCheck(soul_types[soul_n])
        ComponentSetValue2(comp, "value_int", (selected_soul == "soul" and 0) or soul_n)
        GamePrint("This wand will now consume " .. soul .. " souls.")
    end
end

if button_down then
    ComponentSetValue2(comp_button_was_down, "value_int", 1)
else
    ComponentSetValue2(comp_button_was_down, "value_int", 0)
end