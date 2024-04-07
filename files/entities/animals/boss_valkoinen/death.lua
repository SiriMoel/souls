dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity = GetUpdatedEntityID()
	local x, y = EntityGetTransform(entity)

    -- unsure of a reward

	local spells1 = { "REAPING_SHOT", "REAPING_FIELD", "SOULS_TO_POWER", "REAPING_HALO", "HIISI_SHOTGUN", "HIISI_SNIPER", "HIISI_PISTOL", "SOUL_BLAST", "SOUL_SPEED", "REAPER_BLADE", "ROCKET_ROLL", "SOUL_EXPLOSION", "HIISI_GLUE_SHOT", "HIISI_POISON_SHOT", "SNIPER_BEAM", "WORM_ENHANCER", "SUMMON_RAINWORM", "RANDOM_HOMING", "LIGHT_BULLET_TIER_2", "WATER_ESSENCE_PROJ", "BLOOD_TO_STEAM", "SPELLERIOPHAGE", "SOUL_IS_MANA", "REAP_MANY", "GILDED_SOULS_TO_GOLD", "SOUL_BATTERY", "SOUL_GUARD", "SUMMON_SUN", "TRIGGER_RETURN", "RANDOM_REAP", "ALL_REAP_GILDED", "ALL_REAP_MAGE", "ALL_REAP_FLY", "ALL_REAP_SPIDER", "SOULDOS", "SOUL_BALL", "EAT_WAND_FOR_SOULS", "SOUL_NECROMANCY", "SOUL_MINIONS_TO_HEALING", "SOUL_MINIONS_TO_NUKES", "ALL_WORMS", "GREY_HOLE", "CRYSTALLISE_SOULS", "BACKWARDS_PLASMA", "HEALING_ARROW", "SOUL_DASH", "SOUL_RECHARGE" }

	local spells = { "REAPING_FIELD", "REAPING_HALO", "SOULS_TO_POWER", "SOUL_DASH", "REAP_MANY", "SOUL_BALL" }

	for i,v in ipairs(spells) do
		CreateItemActionEntity( "KUPOLI_" .. v, x, y )
	end

	EntityLoad("mods/tales_of_kupoli/files/entities/misc/lootorb/lootorb.xml", x - 16, y )
	EntityLoad("mods/tales_of_kupoli/files/entities/misc/lootorb/lootorb.xml", x + 16, y )
	EntityLoad("mods/tales_of_kupoli/files/entities/misc/lootorb/lootorb.xml", x, y + 8 )

	EntityLoad("mods/tales_of_kupoli/files/entities/items/moldos_special/weapon.xml", x, y-16)

	GameAddFlagRun("ikkuna_valkoinen")
	GamePrint("Trace found!")
end