dofile_once("mods/souls/files/scripts/utils.lua")

--addGlimmer("Soul Blood", "Gives your projectile a soulful sparkly trail", {"soul_blood_1", "soul_blood_perfect"}, "mods/souls/files/spell_icons/glimmer_soul_blood", 8, "1,2,3,4,5,6", 4.5)

local glimmer_appends = {
    {
        name = "Soul Blood",
        desc = "Gives your projectile a soulful sparkly trail",
        materials = {"soul_blood_1", "soul_blood_perfect"},
        image = "mods/souls/files/spell_icons/glimmer_soul_blood",
        spawn_tiers = "1,2,3,4,5,6",
        sort_after = 4.5,
        mod_prefix = "SOULS",
    },
}

for _,entry in ipairs(glimmer_appends) do
    table.insert(glimmer_data, entry)
end