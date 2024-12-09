dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

to_insert = {
    {
		id="MOLDOS_SOULJUICE",
		ui_name="$status_moldos_souljuice",
		ui_description="statusdesc_moldos_souljuice",
		ui_icon="mods/souls/files/status_indicators/souljuice.png",
		effect_entity="mods/souls/files/entities/misc/effect_souljuice/effect.xml",
	},
	{
		id="MOLDOS_SOUL_DRAIN",
		ui_name="$status_moldos_soul_drain",
		ui_description="statusdesc_moldos_soul_drain",
		ui_icon="mods/souls/files/status_indicators/soul_drain.png",
		effect_entity="mods/souls/files/entities/misc/effect_soul_drain/effect.xml",
	},
}

for i,v in ipairs(to_insert) do
    table.insert(status_effects, v)
end