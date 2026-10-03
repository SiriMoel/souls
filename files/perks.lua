local souls_perks = {
    {
		id = "ANIMA_CONDUIT",
		ui_name = "$perk_souls_anima_conduit",
		ui_description = "$perkdesc_souls_anima_conduit",
		ui_icon = "mods/souls/files/perk_icons/anima_conduit.png",
		perk_icon = "mods/souls/files/perk_icons/anima_conduit_inworld.png",
		stackable = STACKABLE_NO,
		func = function(entity_perk_item, entity_who_picked, item_name)
			EntityAddTag(entity_who_picked, "souls_anima_conduit")
		end,
		func_remove = function(entity_who_picked)
			EntityRemoveTag(entity_who_picked, "souls_anima_conduit")
		end
	},
	{
		id = "REAP_BETTER",
		ui_name = "$perk_souls_reap_better",
		ui_description = "$perkdesc_souls_reap_better",
		ui_icon = "mods/souls/files/perk_icons/reap_better.png",
		perk_icon = "mods/souls/files/perk_icons/reap_better_inworld.png",
		stackable = STACKABLE_YES,
		stackable_is_rare = true,
		func = function(entity_perk_item, entity_who_picked, item_name)
			local comp = EntityGetFirstComponentIncludingDisabled(entity_who_picked, "VariableStorageComponent", "souls_reap_better") or EntityAddComponent2(entity_who_picked, "VariableStorageComponent", {
				_tags="souls_reap_better",
				name="souls_reap_better",
				value_int=0,
			})
			local val = ComponentGetValue2(comp, "value_int")
			val = val + 1
			ComponentSetValue2(comp, "value_int", val)
		end,
		func_remove = function(entity_who_picked)
			local comp = EntityGetFirstComponentIncludingDisabled(entity_who_picked, "VariableStorageComponent", "souls_reap_better")
			if comp ~= nil then
				ComponentSetValue2(comp, "value_int", 0)
			end
		end
	},
}

for i,v in ipairs(souls_perks) do
    v.id = "SOULS_" .. v.id
    table.insert(perk_list, v)
end