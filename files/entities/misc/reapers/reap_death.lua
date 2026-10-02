dofile_once("mods/souls/files/scripts/souls.lua")

function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
    local this = GetUpdatedEntityID()
    local comps = EntityGetComponentIncludingDisabled(this, "VariableStorageComponent", "souls_reap") or {}
    local souls = {}
    if #comps > 0 then
        for i,comp in ipairs(comps) do
            local soul = ComponentGetValue2(comp, "name")
            local amt = ComponentGetValue2(comp, "value_int")
            souls[soul] = (souls[soul] or 0) + amt
        end
    end
    DontFearTheReaper(souls, this)
end