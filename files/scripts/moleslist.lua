dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/molebiomes.lua")

moles = {
    {
        id = "mole",
        file = "mods/souls/files/entities/moles/mole/mole.xml",
        tier = 0,
        spawn_check = function(x, y, biome)
            return true -- no special spawn condition
        end,
    },
}