dofile_once("mods/souls/files/scripts/utils.lua")

function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
    local entity = GetUpdatedEntityID()
    local herd_id_number = ComponentGetValue2( EntityGetFirstComponent( entity, "GenomeDataComponent" ) or 0, "herd_id")
    local herd_id = HerdIdToString(herd_id_number)
    local x, y = EntityGetTransform(entity)

    local rainworms_killed = tonumber(GlobalsGetValue("kupoli_rainworms_killed", "0"))

    local rainworms_remaining = 9 - rainworms_killed

    if rainworms_remaining == 9 then
        GamePrintImportant("9 - Sapphire", "8 remain...")
        GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/orb_distant_monster/create", pos_x, pos_y )
        GameScreenshake( 10 )
    elseif rainworms_remaining == 8 then
        GamePrintImportant("8 - Topaz", "7 remain...")
        GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/orb_distant_monster/create", pos_x, pos_y )
        GameScreenshake( 20 )
    elseif rainworms_remaining == 7 then
        GamePrintImportant("7 - Emerald", "6 remain...")
        GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/orb_distant_monster/create", pos_x, pos_y )
        GameScreenshake( 30 )
    elseif rainworms_remaining == 6 then
        GamePrintImportant("6 - Diamond", "5 remain...")
        GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/orb_distant_monster/create", pos_x, pos_y )
        GameScreenshake( 40 )
    elseif rainworms_remaining == 5 then
        GamePrintImportant("5 - Ruby", "4 remain...")
        GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/orb_distant_monster/create", pos_x, pos_y )
        GameScreenshake( 50 )
    elseif rainworms_remaining == 4 then
        GamePrintImportant("4 - Tuoli", "3 remain...")
        GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/orb_distant_monster/create", pos_x, pos_y )
        GameScreenshake( 60 )
    elseif rainworms_remaining == 3 then
        GamePrintImportant("3 - Valkoinen", "2 remain...")
        GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/orb_distant_monster/create", pos_x, pos_y )
        GameScreenshake( 70 )
    elseif rainworms_remaining == 2 then
        GamePrintImportant("2 - Hadal Kupoli", "1 remains...")
        GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/orb_distant_monster/create", pos_x, pos_y )
        GameScreenshake( 80 )
    elseif rainworms_remaining == 1 then
        GamePrintImportant("1 - Voluspa", "It is done.")
        CreateItemActionEntity("KUPOLI_SUMMON_RAINWORM", x, y)
        GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/orb_distant_monster/create", pos_x, pos_y )
        GameScreenshake( 100 )
    elseif rainworms_remaining <= 0 then

    else

    end

    rainworms_killed = rainworms_killed + 1
    GlobalsSetValue("kupoli_rainworms_killed", tostring(rainworms_killed))
end