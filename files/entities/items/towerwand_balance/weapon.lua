---@diagnostic disable: param-type-mismatch
dofile("data/scripts/lib/utilities.lua")
dofile("data/scripts/gun/procedural/gun_action_utils.lua")

function get_random_from( target )
	local rnd = Random(1, #target)
	
	return tostring(target[rnd])
end

function get_multiple_random_from( target, amount_ )
	local amount = amount_ or 1
	
	local result = {}
	
	for i=1,amount do
		local rnd = Random(1, #target)
		
		table.insert(result, tostring(target[rnd]))
	end
	
	return result
end

function get_random_between_range( target )
	local minval = target[1]
	local maxval = target[2]
	
	return Random(minval, maxval)
end

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
SetRandomSeed( x, y + GameGetFrameNum() )

local ability_comp = EntityGetFirstComponent( entity_id, "AbilityComponent" )

local gun = { }
gun.name = {"Souls wand"}
gun.deck_capacity = 20
gun.actions_per_round = 1
gun.reload_time = {10,20}
gun.shuffle_deck_when_empty = 0
gun.fire_rate_wait = {10,20}
gun.spread_degrees = -1
gun.speed_multiplier = 1.1
gun.mana_charge_speed = {500,950}
gun.mana_max = {900,1100}
gun.actions_mod = {"MANA_REDUCE", "DAMAGE", "BLOOD_MAGIC"}
gun.actions_proj = {"LIGHT_BULLET","BULLET","BUCKSHOT"}

local mana_max = get_random_between_range( gun.mana_max )
local deck_capacity = gun.deck_capacity

gun.reload_time = get_random_between_range( gun.reload_time )
gun.fire_rate_wait = gun.reload_time

gun.mana_max = get_random_between_range(gun.mana_max)
gun.mana_charge_speed = gun.mana_max

ComponentSetValue( ability_comp, "ui_name", get_random_from( gun.name ) )

ComponentObjectSetValue( ability_comp, "gun_config", "reload_time", gun.reload_time )
ComponentObjectSetValue( ability_comp, "gunaction_config", "fire_rate_wait", gun.fire_rate_wait )
ComponentSetValue( ability_comp, "mana_charge_speed", gun.mana_charge_speed )

ComponentObjectSetValue( ability_comp, "gun_config", "actions_per_round", gun.actions_per_round )
ComponentObjectSetValue( ability_comp, "gun_config", "deck_capacity", deck_capacity )
ComponentObjectSetValue( ability_comp, "gun_config", "shuffle_deck_when_empty", gun.shuffle_deck_when_empty )
ComponentObjectSetValue( ability_comp, "gunaction_config", "spread_degrees", gun.spread_degrees )
ComponentObjectSetValue( ability_comp, "gunaction_config", "speed_multiplier", gun.speed_multiplier )

ComponentSetValue( ability_comp, "mana_max", gun.mana_max )
ComponentSetValue( ability_comp, "mana", gun.mana_max )

local action_count = 1
local gun_action_mod = get_random_from( gun.actions_mod )
local gun_action_proj = get_random_from( gun.actions_proj )

for i=1,action_count do
	AddGunAction( entity_id, gun_action_mod )
end

for i=1,action_count do
	AddGunAction( entity_id, gun_action_proj )
end

local item_comp = EntityGetFirstComponent( entity_id, "ItemComponent" )
ComponentSetValue2( item_comp, "item_name", "Wand of Balance" )
ComponentSetValue2( item_comp, "always_use_item_name_in_ui", true )