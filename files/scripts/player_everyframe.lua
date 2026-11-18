local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)

local targets = EntityGetInRadiusWithTag(x, y, 400, "souls_boss_soul") or {}
local effect_amount = tonumber(GlobalsGetValue("souls.soul_boss_shader_effect_amount", "0"))
if #targets > 0 then
    effect_amount = math.min(effect_amount + 1, 300)
    GlobalsSetValue("souls.soul_boss_shader_effect_amount", tostring(effect_amount))
    GameSetPostFxParameter("souls_boss_soul_effect_amount", math.min(1, effect_amount / 300), 1, 0, 0)
elseif effect_amount > 0 then
    effect_amount = math.max(effect_amount - 1, 0)
    GlobalsSetValue("souls.soul_boss_shader_effect_amount", tostring(effect_amount))
    GameSetPostFxParameter("souls_boss_soul_effect_amount", math.min(1, effect_amount / 300), 1, 0, 0)
end

local trip_effects = EntityGetAllChildren(this, "souls_effect_trip") or {}
local trip_amt = tonumber(GlobalsGetValue("souls.trip_amt", "0"))
if #trip_effects > 0 then
    trip_amt = math.min(trip_amt + 1, 180)
    GlobalsSetValue("souls.trip_amt", tostring(trip_amt))
    GameSetPostFxParameter("souls_trip", math.min(1, trip_amt / 180), 1, 0, 0)
elseif trip_amt > 0 then
    trip_amt = math.max(trip_amt - 1, 0)
    GlobalsSetValue("souls.trip_amt", tostring(trip_amt))
    GameSetPostFxParameter("souls_trip", math.min(1, trip_amt / 180), 1, 0, 0)
end

local souls_key = tonumber(GlobalsGetValue("souls.souls_wand_key", "25"))
if InputIsKeyDown(souls_key) then
    local comp_inv = EntityGetFirstComponent(this, "Inventory2Component")
    if comp_inv ~= nil then
        local wand = ComponentGetValue2(comp_inv, "mActiveItem")
        if not EntityHasTag(wand, "wand") then return end
        local comp = EntityGetFirstComponentIncludingDisabled(wand, "VariableStorageComponent", "souls_wand_soul_type")
        comp = comp or EntityAddComponent2(wand, "VariableStorageComponent", {
            _tags="souls_wand_soul_type",
            name="souls_wand_soul_type",
            value_int=0
        })
        local val_comp = ComponentGetValue2(comp, "value_int")
        local comp_controls = EntityGetFirstComponent(this, "ControlsComponent")
        local mouse_x, mouse_y = ComponentGetValue2(comp_controls, "mMousePosition")
        dofile_once("mods/souls/files/scripts/souls.lua")
        local soul_types = GetSoulTypes()
        local soul_counts = SoulCounts(this)
        local count = #soul_types + 1
        local dist = 40
        local selected_soul
        local soul_n
        for i = 1, count do
            local soul = soul_types[i] or "soul"
            local a = (i / count) * 2 * math.pi
            local draw_x = x + math.cos(a) * dist
            local draw_y = y + math.sin(a) * dist
            local path = "mods/souls/files/soul_sprites/"
            if mouse_x >= draw_x - 5 and mouse_x <= draw_x + 5 and mouse_y >= draw_y - 5 and mouse_y <= draw_y + 5 then
                path = path .. soul .. ".png"
                selected_soul = soul
                soul_n = i
            elseif val_comp == i or (val_comp == 0 and soul == "soul") then
                path = path .. soul .. ".png"
            else
                path = path .. "silhouettes/" .. soul .. ".png"
            end
            GameCreateSpriteForXFrames(path, draw_x, draw_y, true, 0, 0, 1, true)
        end
        if selected_soul ~= nil and soul_n ~= val_comp and not (selected_soul == "soul" and val_comp == 0) then
            local soul = (selected_soul == "soul" and "any") or SoulNameCheck(soul_types[soul_n])
            ComponentSetValue2(comp, "value_int", (selected_soul == "soul" and 0) or soul_n)
            GamePrint("This wand will now consume " .. soul .. " souls.")
        end
    end
end