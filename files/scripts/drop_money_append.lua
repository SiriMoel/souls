dofile_once("mods/souls/files/scripts/souls.lua")

local death_old = death

function death(damage_type_bit_field, damage_message, entity_thats_responsible, ...)
    local this = GetUpdatedEntityID()
    SoulsDeath(this, entity_thats_responsible)
    death_old(damage_type_bit_field, damage_message, entity_thats_responsible, ...)
end