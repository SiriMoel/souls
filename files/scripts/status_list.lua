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
		is_harmful=true,
	},
	{
		id="ABSINTHE_BAD",
		ui_name="$status_souls_absinthe_bad",
		ui_description="$statusdesc_souls_absinthe_bad",
		ui_icon="mods/souls/files/status_indicators/absinthe_bad.png",
		effect_entity="mods/souls/files/entities/misc/effect_absinthe/bad.xml",
		is_harmful=true,
	},
	{
		id="ABSINTHE_GOOD",
		ui_name="$status_souls_absinthe_good",
		ui_description="$statusdesc_souls_absinthe_good",
		ui_icon="mods/souls/files/status_indicators/absinthe_good.png",
		effect_entity="mods/souls/files/entities/misc/effect_absinthe/good.xml",
	},
	{
		id="TRIP_SOUL",
		ui_name="$status_souls_trip",
		ui_description="$statusdesc_souls_trip",
		ui_icon="mods/souls/files/status_indicators/trip.png",
		effect_entity="mods/souls/files/entities/misc/effect_trip/effect.xml",
	},
	{
		id="TRIP_CURE",
		ui_name="$status_souls_trip_cure",
		ui_description="$statusdesc_souls_trip_cure",
		ui_icon="mods/souls/files/status_indicators/trip_cure.png",
		effect_entity="mods/souls/files/entities/misc/effect_trip/cure_effect.xml",
	},
}

for i,v in ipairs(to_insert) do
	v.id = "SOULS_" .. v.id
    table.insert(status_effects, v)
end