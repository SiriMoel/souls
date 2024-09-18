dofile_once("mods/souls/files/scripts/utils.lua")
local total_perks_picked = 0;
local has_movement_perk = false;

local a = {
    {
		id = "ANIMA_CONDUIT",
		ui_name = "$perk_name_moldos_anima_conduit",
		ui_description = "$perk_desc_moldos_anima_conduit",
		ui_icon = "mods/souls/files/perk_icons/anima_conduit.png",
		perk_icon = "mods/souls/files/perk_icons/anima_conduit_inworld.png",
		stackable = STACKABLE_NO,
		func = function (entity_perk_item, entity_who_picked, item_name)
			EntityAddTag(entity_who_picked, "souls_anima_conduit")
		end,
		func_remove = function(entity_who_picked)
			EntityRemoveTag(entity_who_picked, "souls_anima_conduit")
		end
	},
}

for i,v in ipairs(a) do
    v.id = "MOLDOS_" .. v.id
    table.insert(perk_list, v)
end