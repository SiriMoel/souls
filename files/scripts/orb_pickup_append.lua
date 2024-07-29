dofile("data/scripts/game_helpers.lua")
dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/sunbook_pages.lua")

local item_pickup_old = item_pickup

function item_pickup(entity_item, entity_who_picked, item_name)
    local comp_b = EntityGetFirstComponentIncludingDisabled(GetPlayer(), "VariableStorageComponent", "brilliance_stored") or 0
    local comp_bmax = EntityGetFirstComponentIncludingDisabled(GetPlayer(), "VariableStorageComponent", "brilliance_max") or 0
    local b = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(GetPlayer(),"VariableStorageComponent", "brilliance_stored") or 0, "value_int")
    local bmax =  ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(GetPlayer(), "VariableStorageComponent", "brilliance_max") or 0, "value_int")

    GiveBrilliance(comp_b, comp_bmax, 25)

    local orb_comp = EntityGetFirstComponent(entity_item, "OrbComponent") or 0
    local orb_id = ComponentGetValue2(orb_comp, "orb_id") or 0
    --GamePrint(orb_id)

    item_pickup_old(entity_item, entity_who_picked, item_name)

    --AddRosetta(orb_id)

    print("Attempting to add Rosetta...")

    GameAddFlagRun("rosetta" .. orb_id)

    --[[for i,v in ipairs(sunbookpages) do
        if v.name == "rosetta" .. orb_id then
            v.unlocked = true
            table.insert(unlocked_sbp, v)
            print("Rosetta added!")
        end
    end]]--

    --[[local moldos = "moldos "
    for i,v in ipairs(sunbookpages) do
        if v.unlocked == true then
            moldos = moldos .. " " .. v.name
        end
    end
    GamePrint(moldos)]]--
end