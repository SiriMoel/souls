dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

to_insert = {
    {
		id="MOLDOS_SOULJUICE",
		ui_name="Soulful",
		ui_description="Perhaps you can power something...",
		ui_icon="mods/souls/files/status_icons/souljuice.png",
		effect_entity="mods/souls/files/entities/misc/effect_souljuice/effect.xml",
	},
}

for i,v in ipairs(to_insert) do
    table.insert(status_effects, v)
end