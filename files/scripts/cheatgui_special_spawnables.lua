local souls_to_add = {
    {
        path = "mods/souls/files/entities/items/phylactery/item.xml",
        name = "Inactive Phylactery",
        xml = "item.xml",
    },
}

for i,v in ipairs(souls_to_add) do
    table.insert(special_spawnables, v)
end