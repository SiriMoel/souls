dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

function item_pickup(entity_item, entity_who_picked, item_name)
    local x, y = EntityGetTransform(entity_item)
    local goahead = true
    for i,type in ipairs(soul_types) do
        local amount = 50
        if type == "boss" then
            amount = 10
        end
        if not (GetSoulsCount(type) >= amount) then
            goahead = false
            GamePrint("You do not have enough " .. SoulNameCheck(type) .. " souls for this.")
        end
    end
    if goahead then
        for i,type in ipairs(soul_types) do
            local amount = 50
            if type == "boss" then
                amount = 10
            end
            for ii=1,amount do
                RemoveSoul(type)
            end
        end
        EntityKill(entity_item)
        GameAddFlagRun("souls_soul_emulated")
        GlobalsSetValue("souls.soul_emulator_state", "1")
        EntityLoad("data/entities/particles/image_emitters/perk_effect.xml", x, y)
        EntityLoad("mods/souls/files/entities/items/soul_tablet/item.xml", x, y - 6)
        GamePrintImportant("Soul emulated!", "Something irreversible has occured.", "mods/souls/files/souls_decoration.png")
    else
        EntityKill(entity_item)
        EntityLoad("mods/souls/files/entities/items/soul_emulator/item.xml", x, y)
    end

end