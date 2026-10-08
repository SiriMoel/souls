dofile_once("mods/souls/files/scripts/souls.lua")
function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
	local this = GetUpdatedEntityID()
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