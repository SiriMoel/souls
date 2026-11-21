dofile_once("mods/souls/files/scripts/souls.lua")

function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
	local this = GetUpdatedEntityID()

    local crystals = {
        ["$animal_boss_alchemist"] = "mods/souls/files/entities/items/soulcrystals/alchemist.xml",
        ["$animal_boss_limbs"] = "mods/souls/files/entities/items/soulcrystals/limbs.xml",
        ["$animal_boss_pit"] = "mods/souls/files/entities/items/soulcrystals/pit.xml",
        ["$animal_boss_dragon"] = "mods/souls/files/entities/items/soulcrystals/dragon.xml",
        ["$animal_boss_wizard"] = "mods/souls/files/entities/items/soulcrystals/wizard.xml",
        ["$animal_fish_giga"] = "mods/souls/files/entities/items/soulcrystals/fish.xml",
        ["$animal_islandspirit"] = "mods/souls/files/entities/items/soulcrystals/deer.xml",
        ["$animal_boss_ghost"] = "mods/souls/files/entities/items/soulcrystals/ghost.xml",
        ["$animal_boss_meat"] = "mods/souls/files/entities/items/soulcrystals/meat.xml",
        ["$animal_maggot_tiny"] = "mods/souls/files/entities/items/soulcrystals/tiny.xml",

        ["$enemy_apotheosis_boss_fire_lukki"] = "mods/souls/files/entities/items/soulcrystals/apotheosis/hot_spider.xml",
        ["$enemy_apotheosis_boss_musical_ghost"] = "mods/souls/files/entities/items/soulcrystals/apotheosis/austria.xml",
        ["$enemy_apotheosis_boss_toxic_worm"] = "mods/souls/files/entities/items/soulcrystals/apotheosis/toxic_worm.xml",
    }
    local name = EntityGetName(this)
    if crystals[name] ~= nil then
        local x, y = EntityGetTransform(this)
        local crystal = EntityLoad(crystals[name], x, y - 2)
        local comp_revived_count = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "revived_count")
        if comp_revived_count ~= nil then
            local amt = ComponentGetValue(comp_revived_count, "value_int")
            amt = amt + 1
            local comp_mat_suck = EntityGetFirstComponentIncludingDisabled(crystal, "MaterialSuckerComponent")
            if comp_mat_suck ~= nil then
                local required = ComponentGetValue2(comp_mat_suck, "barrel_size")
                ComponentSetValue2(comp_mat_suck, "barrel_size", required + 50 * amt)     
            end
            local comp_crystal_revived = EntityGetFirstComponentIncludingDisabled(crystal, "VariableStorageComponent", "revived_count")
            if comp_crystal_revived ~= nil then
                ComponentSetValue2(comp_crystal_revived, "value_int", amt)
            end
        end
    end

    local comps = EntityGetComponent(this, "LuaComponent") or {}
    if #comps > 0 then
        for _, comp in ipairs(comps) do
            local script_death = ComponentGetValue2(comp, "script_death") or ""
            if script_death == "data/scripts/items/drop_money.lua" then
                return
            end
        end
    end
    SoulsDeath(this, entity_thats_responsible)
end