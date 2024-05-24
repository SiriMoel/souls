dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

local entity = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity)

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )

end

EntityLoad("data/entities/animals/rat.xml", x+1, y)
EntityLoad("data/entities/animals/rat.xml", x-1, y)
EntityLoad("data/entities/animals/rat.xml", x+2, y)
EntityLoad("data/entities/animals/rat.xml", x-2, y)