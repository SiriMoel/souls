if GlobalsGetValue("souls.enable_hauntings", "true") == "true" then
    local this = GetUpdatedEntityID()
    local x, y = EntityGetTransform(this)
    if y > 2000 then
        EntityLoad("mods/souls/files/entities/misc/haunting/entity.xml", x, y - 25)
    end
end