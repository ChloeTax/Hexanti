f_registry = io.open("hexEmulator/registry.json","r")
registry = json.decode(f_registry:read("*a"))
f_registry.close()

local patternTable = {}

for _,pattern in pairs(registry.patterns) do
    patternTable[pattern.name] = Hexcasting.Iotas["hexcasting:pattern"]:new(pattern.name, pattern.id, pattern.direction, pattern.signature)
end

poptable = { --replace with the actual thing later
    ["-"]      = Hexcasting.Iotas["hexcasting:pattern"]:new("Bookkeeper's Gambit", "hexcasting:mask", "EAST",       "",         {false}),
    ["v"]      = Hexcasting.Iotas["hexcasting:pattern"]:new("Bookkeeper's Gambit", "hexcasting:mask", "SOUTH_EAST", "a",        {true}),
    ["--"]     = Hexcasting.Iotas["hexcasting:pattern"]:new("Bookkeeper's Gambit", "hexcasting:mask", "EAST"      , "w",        {false,false}),
    ["v-"]     = Hexcasting.Iotas["hexcasting:pattern"]:new("Bookkeeper's Gambit", "hexcasting:mask", "SOUTH_EAST", "ae",       {true,false}),
    ["vv"]     = Hexcasting.Iotas["hexcasting:pattern"]:new("Bookkeeper's Gambit", "hexcasting:mask", "SOUTH_EAST", "ada",      {true,true}),
    ["v--"]    = Hexcasting.Iotas["hexcasting:pattern"]:new("Bookkeeper's Gambit", "hexcasting:mask", "SOUTH_EAST", "aew",      {true,false,false}),
    ["v-v"]    = Hexcasting.Iotas["hexcasting:pattern"]:new("Bookkeeper's Gambit", "hexcasting:mask", "SOUTH_EAST", "aeea",     {true,false,true}),
    ["vv-"]    = Hexcasting.Iotas["hexcasting:pattern"]:new("Bookkeeper's Gambit", "hexcasting:mask", "SOUTH_EAST", "adae",     {true,true,false}),
    ["vvv"]    = Hexcasting.Iotas["hexcasting:pattern"]:new("Bookkeeper's Gambit", "hexcasting:mask", "SOUTH_EAST", "adada",    {true,true,true}),
    ["vvv-"]   = Hexcasting.Iotas["hexcasting:pattern"]:new("Bookkeeper's Gambit", "hexcasting:mask", "SOUTH_EAST", "adadae",   {true,true,true,false}),
    ["vvvv-"]  = Hexcasting.Iotas["hexcasting:pattern"]:new("Bookkeeper's Gambit", "hexcasting:mask", "SOUTH_EAST", "adadadae", {true,true,true,true,false}),
    ["vvvv"]   = Hexcasting.Iotas["hexcasting:pattern"]:new("Bookkeeper's Gambit", "hexcasting:mask", "SOUTH_EAST", "adadada",  {true,true,true,true}),
    ["-vvv--"] = Hexcasting.Iotas["hexcasting:pattern"]:new("Bookkeeper's Gambit", "hexcasting:mask", "EAST",       "eadadaew", {false,true,true,true,false,false}),
    ["v-v-v"]  = Hexcasting.Iotas["hexcasting:pattern"]:new("Bookkeeper's Gambit", "hexcasting:mask", "SOUTH_EAST", "aeeaeea",  {true,false,true,false,true}),
  }

function startsWith(inputstr, check)
    return string.sub(inputstr,1,#check) == check
end

function startsWithout(inputstr, check)
    return string.sub(inputstr,#check+1,-1)
end

function stringSplit(pString, pPattern)
    local Table = {}
    local fpat = "(.-)" .. pPattern
    local last_end = 1
    local s, e, cap = pString:find(fpat, 1)
    while s do
       if s ~= 1 or cap ~= "" then
      table.insert(Table,cap)
       end
       last_end = e+1
       s, e, cap = pString:find(fpat, last_end)
    end
    if last_end <= #pString then
       cap = pString:sub(last_end)
       table.insert(Table, cap)
    end
    return Table
  end

function gen_num(num)
    num = math.floor(num)
    pattern = ""
    if num < 0 then
        base = "dedd"
    else
        base = "aqaa"
    end
    num = math.abs(num)
    while num > 0 do
        if num%2 == 0 then
            num = num/2
            pattern = pattern .. "a"
        else
            num = num-1
            pattern = pattern .. "w"
        end
    end
    pattern = string.reverse(pattern)
    return(base .. pattern)
end
  

function specialHandler(line)
    if line == "{" then return Hexcasting.Iotas["hexcasting:pattern"]:new("Introspection", "hexcasting:open_paren", "WEST", "qqq") end
    if line == "}" then return Hexcasting.Iotas["hexcasting:pattern"]:new("Retrospection", "hexcasting:close_paren", "EAST", "eee") end
    if startsWith(line,"Bookkeeper's Gambit: ") then return poptable[startsWithout(line, "Bookkeeper's Gambit: ")] end
    if startsWith(line,"String: ") then return Hexcasting.Iotas["moreiotas:string"]:new(startsWithout(line, "String: ")) end
    if startsWith(line,"Numerical Reflection: ") then
      number = tonumber(stringSplit(line, "Numerical Reflection: ")[1])
      if number == math.floor(number) then
        p = gen_num(number)
      else
        p = "aqaa"
      end
        return Hexcasting.Iotas["hexcasting:pattern"]:new("Numerical Reflection", "hexcasting:number", "SOUTH_EAST",p, number)
    --   else
    --     return unpack({{startDir="WEST", angles="qqq"}, number, {startDir="EAST", angles="eee"}, {startDir="NORTH_WEST", angles="qwaeawq"}})
    --   end
    end
  end
  

Hexcasting.Patterns = {
    processHexpattern = function(name)
        pattern = patternTable[name]
        if pattern then return pattern end
        pattern = specialHandler(name)
        if pattern then return pattern end
        return
        -- error('Unknown pattern: ' ..name.. '"' )
    end
}
