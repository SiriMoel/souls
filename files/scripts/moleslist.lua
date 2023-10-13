dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
dofile_once("mods/tales_of_kupoli/files/scripts/molebiomes.lua")

moles = {
    {
        id = "mole",
        file = "mods/tales_of_kupoli/files/entities/moles/mole/mole.xml",
        tier = 0,
        spawn_check = function(x, y, biome)
            return true -- no special spawn condition
        end,
    },
}