dofile_once("data/scripts/lib/utilities.lua")

function flipbool(boolean) -- the real function flipbool()
    return not boolean
end

---@param bool boolean
---this is the greatest function of all time, it flips a boolean. true -> false and false -> true.
function flipboolean(bool) -- honestly quite incredible.
    if string.sub(tostring(bool), 1, 1) == "t" then
        bool = false
        return bool
    elseif string.sub(tostring(bool), 1, 1) == "f" then
        bool = true
        return bool
    end
end

function GetPlayer()
    local player = EntityGetWithTag("player_unit")[1]
    return player
end

PLAYER = GetPlayer() -- this seems bugged, just use GetPlayer()

function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
        return true
    end
end
    return false
end

function SetFileContent(toset, content)
    ModTextFileSetContent(toset, ModTextFileGetContent("mods/moles_n_more/files/set/" .. content))
end

function IsInRadiusOf(xa, ya, xb, yb, radius) -- i dont think this works, isnt needed anyway.
    if xa - xb < radius and ya - yb < radius then
        return true
    end
    return false
end

function GetAmountOfMaterialInInventory(entity_id, material_name) -- stolen from https://github.com/Priskip/purgatory
    --[[
    Description: Returns the amount of material in the material inventory component of the specified entity
    Usage:
    count = GetAmountOfMaterialInInventory(entity_id, material_name)
    Input Types:
    entity_id = [num] id of the entity that has the material inventory component that you wish to add material to
    material_name = [string] material id string of the material you wish to add. See function CellFactory_GetName( material_id:int ) in "lua_api_documentation.txt" for more info
        
    Return Types:
    amount = [num]
    ]]
    local amount = 0
    local mat_inv_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "MaterialInventoryComponent") or 0
    local count_per_material_type = ComponentGetValue2(mat_inv_comp, "count_per_material_type")

    for i,v in ipairs(count_per_material_type) do
        if v ~= 0 then
            if CellFactory_GetName(i - 1) == material_name then
                amount = v
            end
        end
    end

    return amount
end

function TransferBrilliance(from_comp, to_comp, to_comp_max, amount)
    local from_comp_amount = ComponentGetValue2(from_comp_amount, "value_int")
    local to_comp_amount = ComponentGetValue2(to_comp_amount, "value_int")
    local to_max = ComponentGetValue2(to_comp_max, "value_int")

    to_comp_amount = to_comp_amount + amount
    from_comp_amount = from_comp_amount - amount
    if to_comp_amount > to_comp_max then
        to_comp_amount = to_max
        --EntityInflictDamage(GetPlayer(), 10, "DAMAGE_PHYSICS_BODY_DAMAGED", "THE UNMATCHED POWER OF THE SUN", "DISINTERGRATED", 0, 0)
    end
    ComponentSetValue2(to_comp, "value_int", to_comp_amount)
    ComponentSetValue2(from_comp, "value_int", from_comp_amount)
end