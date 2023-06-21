dofile_once("mods/moles_things/files/scripts/utils.lua")
dofile_once("mods/moles_things/files/scripts/molebiomes.lua")

moles = {
    {
        id = "mole",
        file = "mods/moles_things/files/entities/moles/mole/mole.xml",
        tier = 0,
        spawn_check = function(x, y, biome)
            return true -- no special spawn condition
        end,
    },
}