dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")

local card = GetUpdatedEntityID()
local root = EntityGetRootEntity(card) -- player, right?

local tome = EntityGetWithTag("kupoli_tome")[1]
local comp_cc = EntityGetFirstComponentIncludingDisabled(tome, "VariableStorageComponent", "current_charge") or 0
local cc = ComponentGetValue(comp_cc, "value_int")

local whichsprite = 0

whichsprite = cc * 20

local comp_sprite = EntityGetFirstComponentIncludingDisabled(card, "SpriteComponent") or 0
ComponentSetValue2(comp_sprite, "image_file", "mod/tales_of_kupoli/files/spell_icons/tome_charge/" .. tostring(whichsprite) .. ".png")