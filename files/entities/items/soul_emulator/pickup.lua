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
        if not (SoulCount(soul, entity_who_picked) >= amount) then
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
        EntityLoad("mods/souls/files/entities/items/soul_emulator/item.xml", x, y)
        EntityKill(entity_item)
    else
        local to_use = {}
        for i, soul in ipairs(soul_types) do
            local amt = -50
            if soul == "boss" then
                amt = -10
            end
            if soul == "souls_void" then
                amt = -15
            end
            to_use[soul] = amt
        end
        EditSoulCounts(to_use, entity_who_picked)
        
        GameAddFlagRun("souls_soul_emulated")

        EntityLoad("mods/souls/files/entities/items/soul_emulator/pickup_fx.xml", x, y)

        GamePlaySound("data/audio/Desktop/projectiles.bank", "projectiles/enlightened_laser/launch_dark", x, y)
        GamePlaySound("data/audio/Desktop/misc.bank", "misc/chest_dark_open", x, y)
        GamePlaySound("data/audio/Desktop/misc.bank", "misc/beam_from_sky_kick", x, y)

        local diviner = EntityLoad("mods/souls/files/entities/misc/diviner/entity.xml", x, y)
        EntityAddChild(entity_who_picked, diviner)

        GlobalsSetValue("souls_diviner_state", "1")

        EntityLoad("mods/souls/files/entities/items/soul_tablet/item.xml", x, y - 6)

        SoulsPrintImportant("SOUL EMULATED!", "Something irreversible has occured.")

        EntityKill(entity_item)
    end
end