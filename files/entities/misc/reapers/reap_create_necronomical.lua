dofile_once("mods/souls/files/scripts/souls.lua")
local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)
if root == this then return end
local reapers = EntityGetAllChildren(root, "souls_reaper") or {}
if #reapers < 2 then
    EntityKill(this)
end
local fx = EntityGetAllChildren(root, "souls_reap_fx_necronomical") or {}
if #fx == 0 then
    local fx_e = EntityLoad("mods/souls/files/entities/misc/reapers/fx_necronomical.xml", x, y)
    EntityAddChild(root, fx_e)
end
local soul_type = GetEntitySoulType(root)
if soul_type == "souls_void" then
    local comp = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "souls_reaper")
    ComponentSetValue2(comp, "name", "souls_void")
end