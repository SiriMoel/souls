souls_reapers = {
    soul = function(entity, reapers, comp_name, comp_amt, soul_count, souls)
        soul_count = soul_count + comp_amt
        return soul_count, souls
    end,
    random = function(entity, reapers, comp_name, comp_amt, soul_count, souls)
        for i = 1, comp_amt do
            local r_soul = soul_types[Random(1, #soul_types - 2)]
            souls[r_soul] = (souls[r_soul] or 0) + 1
        end
        return soul_count, souls 
    end,
    necronomical = function(entity, reapers, comp_name, comp_amt, soul_count, souls)
        if #reapers > 1 then
            souls["zombie"] = (souls["zombie"] or 0) + comp_amt
        end
        return soul_count, souls 
    end,
}