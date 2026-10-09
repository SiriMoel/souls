local this = GetUpdatedEntityID()
local state = tonumber(GlobalsGetValue("souls_diviner_state", "0"))
local state_upto = tonumber(GlobalsGetValue("souls_diviner_state_upto", "0"))
local player = EntityGetParent(this)
if state == 1 and state_upto == 0 then
    GlobalsSetValue("souls_diviner_state_upto", "1")
    local comp_dmghandler = EntityGetFirstComponent(player, "LuaComponent", "diviner_state_1") or EntityAddComponent2(player, "LuaComponent", {
        _tags="diviner_state_1",
        _enabled=true,
        script_damage_about_to_be_received="mods/souls/files/entities/misc/diviner/1_damagehandler.lua",
    })
end
if state == 2 and state_upto == 1 then
    local comp_dmghandler = EntityGetFirstComponentIncludingDisabled(player, "LuaComponent", "diviner_state_1")
    if comp_dmghandler ~= nil then
        EntityRemoveComponent(player, comp_dmghandler)
    end
    GlobalsSetValue("souls_diviner_state_upto", "2")
    local comp_soulcheck = EntityGetFirstComponent(player, "LuaComponent", "diviner_state_2") or EntityAddComponent2(player, "LuaComponent", {
        _tags="diviner_state_2",
        _enabled=true,
        script_source_file="mods/souls/files/entities/misc/diviner/2_soulcheck.lua",
        execute_every_n_frame=30,
    })
end
if state == 3 and state_upto == 2 then
    GlobalsSetValue("souls_diviner_state_upto", "3")
    local comp_soulcheck = EntityGetFirstComponentIncludingDisabled(player, "LuaComponent", "diviner_state_2")
    if comp_soulcheck ~= nil then
        EntityRemoveComponent(player, comp_soulcheck)
    end
end