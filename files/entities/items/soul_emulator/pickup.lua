dofile_once("mods/souls/files/scripts/souls.lua")

function item_pickup(entity_item, entity_who_picked, item_name)
    if not EntityHasTag(entity_who_picked, "player_unit") then return end
    local x, y = EntityGetTransform(entity_item)
    local goahead = true
    local no = {}
    for i, soul in ipairs(soul_types) do
        local amount = 50
        if soul == "boss" then
            amount = 10
        end
        if soul == "souls_void" then
            amount = 15
        end
        if not SoulCount(soul, entity_who_picked) >= amount then
            table.insert(no, {SoulNameCheck(soul), amount})
        end
    end
    if #no > 0 then
        goahead = false
    end
    if not goahead then
        local str = "You do not have enough "
        for i, soul in ipairs(no) do
            if i > 1 then
                str = str .. ", "
                if i == #no then
                    str = str .. "and "
                end
            end
            str = str .. soul[1] .. " (" .. soul[2] .. ")"
        end
        str = str .. " souls for this."
        GamePrint(str)
        EntityKill(entity_item)
        EntityLoad("mods/souls/files/entities/items/soul_emulator/item.xml", x, y)
    else
        local to_use = {}
        for i, soul in ipairs(soul_types) do
            local amt = 50
            if soul == "boss" then
                amt = 10
            end
            if soul == "souls_void" then
                amt = 15
            end
            to_use[soul] = amt
        end
        SpellUseSouls(entity_who_picked, to_use)
        
        GameAddFlagRun("souls_soul_emulated")

        --EntityLoad("data/entities/particles/image_emitters/perk_effect.xml", x, y)

        local diviner = EntityLoad("mods/souls/files/entities/misc/diviner/entity.xml", x, y)
        EntityAddChild(entity_who_picked, diviner)

        EntityLoad("mods/souls/files/entities/items/soul_tablet/item.xml", x, y - 6)

        GamePrintImportant("SOUL EMULATED!", "Something irreversible has occured.", "mods/souls/files/souls_decoration.png")

        EntityKill(entity_item)
    end
end