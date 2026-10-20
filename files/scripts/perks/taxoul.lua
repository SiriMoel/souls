function on_reap(player, n)
    local comp = EntityGetFirstComponentIncludingDisabled(player, "WalletComponent")
    if comp ~= nil then
        local money = ComponentGetValue2(comp, "money")
        money = money + 3 * n
        ComponentSetValue2(comp, "money", money)
    end
end
return {on_reap = on_reap}