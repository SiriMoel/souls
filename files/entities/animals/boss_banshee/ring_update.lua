local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)

local comp = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "ring_frame_last_added")
if comp == nil then return end

local frame_last = ComponentGetValue2(comp, "value_int")
local frame_now = GameGetFrameNum()

local ring_dist = 46

local targets = EntityGetInRadiusWithTag(x, y, ring_dist, "souls_banshee_soul") or {}

local added_to_ring = false

if #targets > 0 then
    if frame_now >= frame_last + 30 then
        local target = targets[1]
        local t_x, t_y = EntityGetTransform(target)

        local dist_x = t_x - x
        local dist_y = t_y - y

        local dist_xy = math.sqrt(dist_x*dist_x + dist_y*dist_y)

        if dist_xy >= 39 then
            local a = math.atan2(dist_y, dist_x)

            local s_x = x + math.cos(a) * ring_dist
            local s_y = y + math.sin(a) * ring_dist

            local soul = EntityLoad("mods/souls/files/entities/animals/boss_banshee/ring_soul.xml", s_x, s_y)
            EntityAddChild(this, soul)

            local comp_rot = EntityGetFirstComponentIncludingDisabled(soul, "VariableStorageComponent", "rot")
            ComponentSetValue2(comp_rot, "value_float", a)

            added_to_ring = true
        end
    end

    if added_to_ring then
        for i = 1, #targets do
            local target = targets[i]
            EntityKill(target)
        end
    end
end

local ring_souls = EntityGetAllChildren(this, "souls_banshee_ring_soul") or {}

if #ring_souls > 0 then
    for i = 1, #ring_souls do
        local soul = ring_souls[i]
        --local s_x, s_y = EntityGetTransform(soul)

        --local dist_x = s_x - x
        --local dist_y = s_y - y

        --local a = math.atan2(dist_y, dist_x)

        local comp_rot = EntityGetFirstComponentIncludingDisabled(soul, "VariableStorageComponent", "rot")
        local a = ComponentGetValue2(comp_rot, "value_float")

        a = a + 0.03

        ComponentSetValue2(comp_rot, "value_float", a)

        local new_x = x + math.cos(a) * ring_dist
        local new_y = y + math.sin(a) * ring_dist

        EntityApplyTransform(soul, new_x, new_y)
    end
end

if added_to_ring then
    ComponentSetValue2(comp, "value_int", frame_now)

    local ring_count = #ring_souls
    
    local comp_bar_back = EntityGetFirstComponent(this, "SpriteComponent", "health_bar_back")
    if comp_bar_back ~= nil then
        ComponentSetValue2(comp_bar_back, "image_file", "mods/souls/files/entities/animals/boss_banshee/health_slider_back_" .. ring_count .. ".png")
    end
    
    if ring_count >= 8 then
        local comp_bar_front = EntityGetFirstComponent(this, "SpriteComponent", "health_bar")
        if comp_bar_front ~= nil then
            ComponentSetValue2(comp_bar_front, "image_file", "mods/souls/files/entities/animals/boss_banshee/health_slider_front.png")
        end

        EntityAddTag(this, "souls_banshee_ring_down")

        EntitySetComponentsWithTagEnabled(this, "banshee_ring", false)

        local comp_hitbox = EntityGetFirstComponent(this, "HitboxComponent")
        if comp_hitbox ~= nil then
            ComponentSetValue2(comp_hitbox, "damage_multiplier", 1.0)
        end

        for i = 1, #ring_souls do
            local target = ring_souls[i]
            EntityKill(target)
        end
    end
end