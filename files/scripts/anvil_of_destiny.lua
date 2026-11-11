dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")

append_effect("souls_soul_blood_1", function(wand)
    local souls_spells = {"SOULS_REAPING_SHOT", "SOULS_RANDOM_REAP", "SOULS_SOULDOS", "SOULS_REAP_FROM_FIRE", "SOULS_NECRONOMICAL_REAP"}
    AddGunActionPermanent(wand.entity_id, souls_spells[Random(1, #souls_spells)])
end)