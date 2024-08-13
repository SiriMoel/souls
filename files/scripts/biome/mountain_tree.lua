dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

RegisterSpawnFunction( 0xff2cbaa0, "spawn_tome" )
RegisterSpawnFunction( 0xff259e88, "spawn_tome_upgrader" )
RegisterSpawnFunction( 0xff449e88, "spawn_phylactery" )

function spawn_tome(x, y)
    EntityLoad("mods/souls/files/entities/items/tome/weapon.xml", x, y)
end

function spawn_tome_upgrader(x, y)
    CreateItemActionEntity("MOLDOS_UPGRADE_TOME", x, y)
end

function spawn_phylactery(x, y)
    EntityLoad("mods/souls/files/entities/items/phylactery/item.xml", x, y)
end