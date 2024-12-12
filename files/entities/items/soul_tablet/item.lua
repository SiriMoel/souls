dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local this = GetUpdatedEntityID()

local state = GlobalsGetValue("souls.soul_emulator_state", "1")

local comp = EntityGetFirstComponentIncludingDisabled(this, "ItemComponent") or 0

ComponentSetValue2(comp, "ui_description", "$itemdesc_moldos_soul_tablet_" .. state)