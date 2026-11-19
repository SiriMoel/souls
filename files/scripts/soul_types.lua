function GetSoulTypes()
    local all_soul_types = {
        "bat",
        "fly",
        "friendly",
        "mage",
        "orcs",
        "slimes",
        "spider",
        "zombie",
        "worm",
        "fungus",
        "ghost",
    }
    if ModIsEnabled("Apotheosis") then
        table.insert(all_soul_types, "mage_corrupted")
        table.insert(all_soul_types, "ghost_whisp")
    end
    table.insert(all_soul_types, "souls_void")
    table.insert(all_soul_types, "boss")
    local shifts = {}
    local player = EntityGetWithTag("player_unit") or {}
    if #player > 0 then
        player = player[1]
        local comps = EntityGetComponentIncludingDisabled(player, "VariableStorageComponent", "souls_shifted") or {}
        if #comps > 0 then
            for i = 1, #comps do
                local comp = comps[i]
                local shifted = ComponentGetValue2(comp, "name")
                local to = ComponentGetValue2(comp, "value_string")
                for ii, soul in ipairs(all_soul_types) do
                    if soul == shifted then
                        all_soul_types[ii] = to
                        shifts[shifted] = to
                        break
                    end
                end
            end
        end
    end
    --[[for i, v in ipairs(shifts) do
        for ii, soul in ipairs(all_soul_types) do
            if soul == v[1] then
                soul_types[ii] = v[2]
            end
        end
    end]]
    local types_check = {}
    local soul_types = {}
    for i, v in ipairs(all_soul_types) do
        if types_check[v] == nil then
            types_check[v] = 1
            table.insert(soul_types, v)
        end
    end
    return soul_types, all_soul_types, shifts
end

soul_types = GetSoulTypes()

souls_genomes = {
    player = "friendly",
    ant = "fly",
    apparition = "souls_void",
    mage_swapper = "mage",
    ghost_fairy = "ghost_whisp",
    helpless = "friendly",
    fire = "mage",
    ice = "mage",
    rat = "friendly",
    flower = "slimes",
    healer = "friendly",
    eel = "worm",
}

soul_names = {
    bat = "$souls_soul_bat",
    fly = "$souls_soul_fly",
    friendly = "$souls_soul_friendly",
    mage = "$souls_soul_mage",
    orcs = "$souls_soul_orcs",
    slimes = "$souls_soul_slimes",
    spider = "$souls_soul_spider",
    zombie = "$souls_soul_zombie",
    worm = "$souls_soul_worm",
    fungus = "$souls_soul_fungus",
    ghost = "$souls_soul_ghost",
    souls_void = "$souls_soul_souls_void",
    boss = "$souls_soul_boss",
    mage_corrupted = "$souls_soul_mage_corrupted",
    ghost_whisp = "$souls_soul_ghost_whisp",
}

soul_sparks = {
    bat = "spark_purple_bright",
    fly = "lava",
    friendly = "souls_soul_particles",
    mage = "magic_liquid_mana_regeneration",
    orcs = "spark_green",
    slimes = "radioactive_liquid",
    spider = "spark_purple",
    zombie = "souls_soul_particles_banshee",
    worm = "souls_soul_particles_worm",
    fungus = "fungi",
    ghost = "plasma_fading",
    souls_void = "souls_soul_particles",
    boss = "souls_living_particles",
    mage_corrupted = "blood",
    ghost_whisp = "fire",
}

soul_colours = {
    bat = {r=1.0, g=0.6, b=1.0},
    fly = {r=1.0, g=0.6, b=0.5},
    friendly = {r=1.0, g=0.8, b=1.0},
    mage = {r=0.75, g=0.75, b=1.0},
    orcs = {r=1.0, g=0.9, b=0.75},
    slimes = {r=0.65, g=1.0, b=0.65},
    spider = {r=0.8, g=0.4, b=0.8},
    zombie = {r=1.0, g=0.9, b=0.75},
    worm = {r=1.0, g=1.0, b=0.4},
    fungus = {r=1.0, g=0.5, b=0.7},
    ghost = {r=0.4, g=0.4, b=1.0},
    souls_void = {r=0.5, g=1.0, b=1.0},
    boss = {r=1.0, g=0.85, b=0.85},
    mage_corrupted = {r=0.6, g=0.05, b=0.05},
    ghost_whisp = {r=0.9, g=0.9, b=0.65},
}