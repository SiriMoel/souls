local this = GetUpdatedEntityID()
local comp_state = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "state")
if comp_state ~= nil then
    local player = EntityGetParent(this)
    local state = ComponentGetValue2(comp_state, "value_int")
    if state == 1 then
        local comp_dmghandler = EntityGetFirstComponent(player, "LuaComponent", "diviner_state_1") or EntityAddComponent2(player, "LuaComponent", {
            _tags="diviner_state_1",
            _enabled=true,
            script_damage_about_to_be_received="mods/souls/files/entities/misc/diviner/1_damagehandler.lua",
        })
    end
    if state == 2 then
        local comp_soulcheck = EntityGetFirstComponent(player, "LuaComponent", "diviner_state_2") or EntityAddComponent2(player, "LuaComponent", {
            _tags="diviner_state_2",
            _enabled=true,
            script_source_file="mods/souls/files/entities/misc/diviner/2_soulcheck.lua",
            execute_every_n_frame=30,
        })
    end
end