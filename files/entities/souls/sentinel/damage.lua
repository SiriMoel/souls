function damage_about_to_be_received(damage, x, y, entity_thats_responsible, critical_hit_chance)
    local this = GetUpdatedEntityID()
    if damage > 0 then
        local comp_frame = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "damaged_frame")
        local frame = ComponentGetValue2(comp_frame, "value_int")
        local frame_now = GameGetFrameNum()
        if frame_now >= frame then
            ComponentSetValue2(comp_frame, "value_int", frame_now + 20)
            local comp_soul = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "soul")
            local soul = ComponentGetValue2(comp_soul, "value_float")
            soul = soul - 1
            if soul <= 0 then
                EntityKill(this)
            end
            ComponentSetValue2(comp_soul, "value_float", soul)
        end
    end
    return 0, critical_hit_chance
end