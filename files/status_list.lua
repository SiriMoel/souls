dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

to_insert = {
	{
		id="KUPOLI_SOULJUICE",
		ui_name="Soulful",
		ui_description="Perhaps you can power something...",
		ui_icon="mods/souls/files/status_icons/souljuice.png",
		effect_entity="mods/souls/files/entities/misc/effect_souljuice.xml",
	},
	{
		id="KUPOLI_TOME_BUFF_1",
		ui_name="$status_berserk",
		ui_description="$statusdesc_berserk",
		ui_icon="data/ui_gfx/status_indicators/berserk.png",
		effect_entity="mods/souls/files/entities/misc/effect_tome_buff_1.xml",
	},
	{
		id="KUPOLI_TOME_BUFF_2",
		ui_name="$status_movement_faster",
		ui_description="$statusdesc_movement_faster",
		ui_icon="data/ui_gfx/status_indicators/movement_faster.png",
		effect_entity="mods/souls/files/entities/misc/effect_tome_buff_2.xml"
	},
	{
		id="KUPOLI_TOME_BUFF_3",
		ui_name="$status_mana_regeneration",
		ui_description="$statusdesc_mana_regeneration",
		ui_icon="data/ui_gfx/status_indicators/mana_regeneration.png",
		effect_entity="mods/souls/files/entities/misc/effect_tome_buff_3.xml"
	},
}

for i,v in ipairs(to_insert) do
    table.insert(status_effects, v)
end