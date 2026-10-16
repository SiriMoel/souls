dofile_once("mods/souls/files/scripts/souls.lua")

function damage_about_to_be_received(damage, x, y, entity_thats_responsible, critical_hit_chance)
    local player = GetUpdatedEntityID()
    local held_item = HeldItem(player)
    local inv_items = GameGetAllInventoryItems(player) or {}
    if #inv_items > 0 then
        for _, item in ipairs(inv_items) do
            local comps = EntityGetComponentIncludingDisabled(item, "LuaComponent", "souls_player_damage") or {}
            if #comps > 0 then
                for i = 1, #comps do
                    local comp = comps[i]
                    local script = ComponentGetValue2(comp, "script_source_file")
                    local is_held = false
                    if item == held_item then
                        is_held = true
                    end
                    damage, critical_hit_chance = dofile_once(script).player_damage(item, player, damage, critical_hit_chance, is_held)
                end
            elseif EntityHasTag(item, "souls_phylactery") then -- backwards compatible! or whatever this is called
                local comp_p = EntityGetFirstComponentIncludingDisabled(item, "VariableStorageComponent", "phylactery")
                if comp_p ~= nil then
                    local p = ComponentGetValue2(comp_p, "value_int")
                    if p > 0 then
                        ComponentSetValue2(comp_p, "value_int", p - 1)
                        local x, y = EntityGetTransform(player)
                        GamePlaySound("data/audio/Desktop/projectiles.bank", "projectiles/enlightened_laser/launch_dark", x, y) -- placeholder probably
                        damage, critical_hit_chance = 0, 0
                    end
                end
            end
        end
    end
    return damage, critical_hit_chance
end