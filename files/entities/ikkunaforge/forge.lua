dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
dofile_once("mods/tales_of_kupoli/files/alterants.lua")

local forge = GetUpdatedEntityID()
local x, y = EntityGetTransform(forge)

local targets = EntityGetInRadiusWithTag(x, y, 20, "kupoli_alterant")

local wand = EntityGetInRadiusWithTag(x, y, 15, "wand")[1]

local comp_stored_alterants = EntityGetFirstComponentIncludingDisabled(forge, "VariableStorageComponent", "stored_alterants") or 0
local stored_alterants_string = ComponentGetValue2(comp_stored_alterants, "value_string")
local stored_alterants = {}

for i,v in ipairs(targets) do
    local comp_alterant = EntityGetFirstComponentIncludingDisabled(v, "VariableStorageComponent", "alterant_id") or 0
    local alterant_id = ComponentGetValue2(comp_alterant, "value_string")
    stored_alterants_string = stored_alterants_string .. alterant_id .. ","
    ComponentSetValue2(comp_stored_alterants, "value_string", stored_alterants_string)
    EntityKill(v)
    GamePrint("Alterant stored!")
end

if wand ~= nil then
    for i in string.gmatch(stored_alterants_string, '[^,]+') do
        table.insert(stored_alterants, i)
    end
    if #stored_alterants <= 0 then return end
    for i,v in ipairs(stored_alterants) do
        local alterant = {}
        for ii,vv in ipairs(alterants) do
            if vv.id == v then
                alterant = vv
            end
        end
        EntityAddComponent2(wand, "SpriteComponent", {
            _enabled="1",
            _tags="enabled_in_hand,enabled_in_world",
            offset_x=4,
		    offset_y=4,
		    image_file=alterant.sprite_onwand,
        })
        alterant.func_apply(wand)
    end
    stored_alterants = {}
    stored_alterants_string = ""
    for i,v in ipairs(stored_alterants) do
        stored_alterants_string = stored_alterants_string .. "," .. v
    end
    GamePrint("Alterant applied!")
    ComponentSetValue2(comp_stored_alterants, "value_string", stored_alterants_string)
end