local souls_to_add = {
    {
        path = "mods/souls/files/entities/items/phylactery/item.xml",
        name = "Inactive Phylactery",
        xml = "item.xml",
    },
    {
        path = "data/entities/animals/souls_boss_soul.xml",
        name = "$animal_souls_boss_soul",
        xml = "souls_boss_soul.xml",
    },
    {
        path = "mods/souls/files/entities/items/soul_of_the_diviner/item.xml",
        name = "Soul of the Diviner",
        xml = "item.xml",
    },
}

for i,v in ipairs(souls_to_add) do
    table.insert(special_spawnables, v)
end