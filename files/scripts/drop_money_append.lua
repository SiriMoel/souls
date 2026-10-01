dofile_once("mods/souls/files/scripts/souls.lua")

local death_old = death

function death(...)
    local this = GetUpdatedEntityID()
    local x, y = EntityGetTransform(this)
    SetRandomSeed(x, y + this)
    if Random(1, 4) == 1 then
        local player = EntityGetWithTag("player_unit")[1]
        local canreap = true
        for i,v in ipairs(GameGetAllInventoryItems(player) or {}) do
            if EntityHasTag(v, "souls_deny_reap") then
                canreap = false
                break
            end
        end
        if canreap then
            local souls = {}
            local soul_type = GetEntitySoulType(this)
            souls[soul_type] = 1
            if GlobalsGetValue("souls.collect_soul_from_entity", "true") == "true" then
                for soul, amt in pairs(souls) do
                    for i = 1, amt do
                        local entity_soul = EntityLoad("mods/souls/files/entities/souls/_soul.xml", x, y)
                        local comp_sprite = EntityGetFirstComponentIncludingDisabled(entity_soul, "SpriteComponent")
                        local comp_soul = EntityGetFirstComponentIncludingDisabled(entity_soul, "VariableStorageComponent", "soul")
                        if comp_sprite ~= nil then
                            ComponentSetValue2(comp_sprite, "image_file", "mods/souls/files/entities/souls/sprites/soul_" .. soul .. ".xml")
                            EntityRefreshSprite(entity_soul, comp_sprite)
                        end
                        if comp_soul ~= nil then
                            ComponentSetValue2(comp_soul, "value_string", soul)
                        end
                    end
                end
            else
                if GlobalsGetValue("souls.say_soul", "true") == "true" then
                    local str = "You have acquired "
                    local first = true
                    for soul, amt in pairs(souls) do
                        if first then
                            str = str .. amt .. " " .. GameTextGetTranslatedOrNot(soul_names[soul]) .. " souls"
                            first = false
                        else
                            str = str .. ", " .. amt .. " " .. GameTextGetTranslatedOrNot(soul_names[soul]) .. " souls"
                        end
                    end
                    str = str .. "!"
                    GamePrint(str)
                end 
                EditSoulCounts(souls, player)
            end
        end
    end
    death_old(...)
end