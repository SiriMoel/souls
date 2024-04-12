dofile_once("mods/tales_of_kupoli/files/scripts/utils.lua")
dofile_once("mods/tales_of_kupoli/files/scripts/souls.lua")

to_insert = {
    {
		id="KUPOLI_TOME_BUFF",
		ui_name="$status_kupoli_tome",
		ui_description="$statusdesc_kupoli_tome",
		ui_icon="data/ui_gfx/status_indicators/wet.png",
		protects_from_fire=true,
		effect_entity="mods/tales_of_kupoli/files/entities/misc/tome_buff.xml",
	},
}

for i,v in ipairs(to_insert) do
    table.insert(status_effects, v)
end