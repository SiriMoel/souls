local this = GetUpdatedEntityID()

local x, y = EntityGetTransform(this)

local targets = EntityGetInRadiusWithTag(x, y, 400, "player_unit") or {}
if #targets > 0 then
    local player = targets[1]

    local comp_state = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "state")

    local state = ComponentGetValue2(comp_state, "value_int")

    local comp_frame_state = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "frame_state")

    local frame_state = ComponentGetValue2(comp_frame_state, "value_int")

    local frame_now = GameGetFrameNum()

    local comp_frame_souls = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "frame_souls")
    local frame_souls = ComponentGetValue2(comp_frame_souls, "value_int")

    local comp_frame_attack = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "frame_attack")
    local frame_attack = ComponentGetValue2(comp_frame_attack, "value_int")

    local comp_attacks_done = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "attacks_done")
    local attacks_done = ComponentGetValue2(comp_attacks_done, "value_int")

    local comp_frame_lunge_begin = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "frame_lunge_begin")
    local frame_lunge_begin = ComponentGetValue2(comp_frame_lunge_begin, "value_int")

    local p_x, p_y = EntityGetTransform(player)
    p_y = p_y - 5

    local update_state = false

    local movespeed = 0.45

    -- attacking

    if state == 1 then

        movespeed = 0.4

        if frame_now >= frame_souls then

            -- souls attack

            local minions = EntityGetInRadiusWithTag(x, y, 300, "souls_banshee_minion") or {}
            local minions2 = EntityGetInRadiusWithTag(x, y, 300, "souls_banshee_soul") or {}
            if (#minions + #minions2) <= 4 then
                EntityLoad("mods/souls/files/entities/animals/boss_banshee/minion_spawner.xml", x, y)
            end
            if EntityHasTag(this, "souls_banshee_ring_down") and #minions2 > 0 then
                for i = 1, #minions2 do
                    EntityKill(minions2[i])
                end
            end

            frame_souls = frame_now + 300
            ComponentSetValue2(comp_frame_souls, "value_int", frame_souls)
        else
            update_state = true
            attacks_done = attacks_done - 2
        end

    elseif state == 2 then

        movespeed = 0.52

        if frame_now >= frame_attack then

            -- scream attack
            GamePrint("scream attack")

            ComponentSetValue2(comp_frame_attack, "value_int", frame_now + 90)
            attacks_done = attacks_done + 1
        end

    elseif state == 3 then

        local lunge_duration = 50

        local comp_lunge_x = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "lunge_pos_x")
        local comp_lunge_y = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "lunge_pos_y")
        local lunge_x = ComponentGetValue2(comp_lunge_x, "value_float")
        local lunge_y = ComponentGetValue2(comp_lunge_y, "value_float")

        if frame_now >= frame_attack then

            -- lunge attack

            EntitySetComponentsWithTagEnabled(this, "banshee_lunge", true)

            frame_lunge_begin = frame_now
            ComponentSetValue2(comp_frame_lunge_begin, "value_int", frame_lunge_begin)

            ComponentSetValue2(comp_frame_attack, "value_int", frame_now + 60)
            attacks_done = attacks_done + 1

            lunge_x = p_x
            lunge_y = p_y + 20 * (math.ceil(math.sin(attacks_done)) * 2 - 1)

            ComponentSetValue2(comp_lunge_x, "value_float", lunge_x)
            ComponentSetValue2(comp_lunge_y, "value_float", lunge_y)
        end

        if frame_lunge_begin ~= -1 then

            local lunge = (frame_now - frame_lunge_begin) / lunge_duration

            p_x = lunge_x
            p_y = lunge_y

            movespeed = movespeed + 2.9 * math.sin(math.pi * lunge)

            local dist_to_player = math.sqrt((p_x - x)*(p_x - x) + (p_y - y)*(p_y - y))

            if lunge > 1 or dist_to_player <= 10 then
                ComponentSetValue2(comp_frame_lunge_begin, "value_int", -1)

                if dist_to_player <= 25 then
                    attacks_done = attacks_done + 1
                end

                EntitySetComponentsWithTagEnabled(this, "banshee_lunge", false)
            end

        end

    end

    local dist_x = p_x - x
    local dist_y = p_y - y

    local dist_xy = math.sqrt(dist_x*dist_x + dist_y*dist_y)

    if attacks_done >= 4 then
        update_state = true
    end

    local function update_state(current_state)
        local new_state = nil
        if current_state == 1 then
            if frame_now < frame_souls - 60 then
                if dist_xy > 20 and dist_xy < 120 then
                    new_state = 2
                else
                    new_state = 3
                end
            end
        else
            if frame_now >= frame_souls then
                new_state = 1
            else
                if RaytraceSurfacesAndLiquiform(x, y, p_x, p_y - 2) then
                    new_state = 3
                else
                    if dist_xy > 80 then
                        new_state = 3
                    else
                        if current_state == 2 then
                            new_state = 3
                        else
                            new_state = 2
                        end
                    end
                end
            end
        end
        ComponentSetValue2(comp_state, "value_int", new_state or current_state)
        ComponentSetValue2(comp_frame_state, "value_int", frame_now + 200)
    end

    if frame_now >= frame_state and update_state then

       update_state(state)

        attacks_done = attacks_done - 3

    end

    ComponentSetValue2(comp_attacks_done, "value_int", attacks_done)

    -- movement

    if state ~= 3 then
        if dist_xy < 60 then
            movespeed = movespeed * (1 - dist_xy/60)
        end
    elseif frame_lunge_begin == -1 then
        if dist_xy < 30 then
            movespeed = movespeed * (1 - dist_xy/30)
        end
    end

    local a = math.atan2(dist_y, dist_x)

    local new_x = x + movespeed * math.cos(a)
    local new_y = y + movespeed * math.sin(a)

    --[[if dist_xy >= 10 then
        EntityApplyTransform(this, new_x, new_y)
    end]]
    EntityApplyTransform(this, new_x, new_y)
end