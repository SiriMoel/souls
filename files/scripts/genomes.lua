-- stolen from apotheosis

-- Big thank you to Horscht for this genome adding function :)
function split_string(inputstr, sep)
    sep = sep or "%s"
    local t= {}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
      table.insert(t, str)
    end
    return t
end
  
function add_new_genome(content, genome_name, default_relation_ab, default_relation_ba, self_relation, relations)
    local lines = split_string(content, "\r\n")
    local output = ""
    local genome_order = {}
    local function get_relation(herd, index)
      if type(relations[herd]) == "number" then
        return relations[herd]
      elseif type(relations[herd]) == "table" then
        if type(index) ~= "number" then
          error("Wrong format", 3)
        end
        return relations[herd][index]
      end
    end
    for i, line in ipairs(lines) do
      if i == 1 then
        output = output .. line .. "," .. genome_name .. "\r\n"
      else
        local herd = line:match("([%w_-]+),")
        local relation = get_relation(herd, 2)
        output = output .. line .. ","..(relation or default_relation_ba).."\r\n"
        table.insert(genome_order, herd)
      end
    end
  
    local line = genome_name
    for i, v in ipairs(genome_order) do
      local relation = get_relation(v, 1)
      line = line .. "," .. (relation or default_relation_ab)
    end
  
    return output .. line .. "," .. self_relation
end
  
local content = ModTextFileGetContent("data/genome_relations.csv")

content = add_new_genome(content, "souls_void", 40, 60, 100, {
    player = 0,
    ["-1"] = 0,
    slimes = 100,
    mage = 100,
})

ModTextFileSetContent("data/genome_relations.csv", content)