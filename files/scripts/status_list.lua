dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

to_insert = {
    {
		id="SOULJUICE",
		ui_name="$status_souls_souljuice",
		ui_description="$statusdesc_souls_souljuice",
		ui_icon="mods/souls/files/status_indicators/souljuice.png",
		effect_entity="mods/souls/files/entities/misc/effect_souljuice/effect.xml",
	},
	{
		id="SOUL_DRAIN",
		ui_name="$status_souls_soul_drain",
		ui_description="$statusdesc_souls_soul_drain",
		ui_icon="mods/souls/files/status_indicators/soul_drain.png",
		effect_entity="mods/souls/files/entities/misc/effect_soul_drain_status/effect.xml",
	},
}

for i,v in ipairs(to_insert) do
	v.id = "SOULS_" .. v.id
    table.insert(status_effects, v)
end