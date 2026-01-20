patternTable = {}

for anglesig,pattern in pairs(Hexcasting.Actions) do
    patternTable[pattern.name] = anglesig
end

local function stringSplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

poptable = {
  ["-"] = Hexcasting.Iotas.hexcasting.pattern:new("EAST",""),
  ["v"] = Hexcasting.Iotas.hexcasting.pattern:new("SOUTH_EAST","a"),
  ["--"] = Hexcasting.Iotas.hexcasting.pattern:new("EAST","w"),
  ["v-"] = Hexcasting.Iotas.hexcasting.pattern:new("SOUTH_EAST","ae"),
  ["vv"] = Hexcasting.Iotas.hexcasting.pattern:new("SOUTH_EAST","ada"),
  ["v--"] = Hexcasting.Iotas.hexcasting.pattern:new("SOUTH_EAST","aew"),
  ["v-v"] = Hexcasting.Iotas.hexcasting.pattern:new("SOUTH_EAST","aeea"),
  ["vv-"] = Hexcasting.Iotas.hexcasting.pattern:new("SOUTH_EAST","adae"),
  ["vvv"] = Hexcasting.Iotas.hexcasting.pattern:new("SOUTH_EAST","adada"),
  ["vvv-"] = Hexcasting.Iotas.hexcasting.pattern:new("SOUTH_EAST","adadae"),
  ["vvvv-"] = Hexcasting.Iotas.hexcasting.pattern:new("SOUTH_EAST","adadadae"),
  ["vvvv"] = Hexcasting.Iotas.hexcasting.pattern:new("SOUTH_EAST","adadada"),
  ["-vvv--"] = Hexcasting.Iotas.hexcasting.pattern:new("EAST","eadadaew"),
  ["v-v-v"] = Hexcasting.Iotas.hexcasting.pattern:new("SOUTH_EAST","aeeaeea")
}

local function startsWith(inputstr, check)
    return string.sub(inputstr,1,#check) == check
end

local function startsWithout(inputstr, check)
    return string.sub(inputstr,#check+1,-1)
end

local function gen_num(num)
    local num = math.floor(num)
    local pattern = ""
    local base
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

local function specialHandler(line)
    if line == "{" then return Hexcasting.Iotas.hexcasting.pattern:new("WEST", "qqq") end
    if line == "}" then return Hexcasting.Iotas.hexcasting.pattern:new("EAST", "eee") end
    if startsWith(line,"Bookkeeper's Gambit: ") then return poptable[startsWithout(line, "Bookkeeper's Gambit: ")] end
    if startsWith(line,"String: ") then return Hexcasting.Iotas.moreiotas.string:new(startsWithout(line, "String: "):sub(2, -2)) end
    if startsWith(line,"Numerical Reflection: ") then
      local number = tonumber(stringSplit(line, "Numerical Reflection: ")[1])
      local pattern
      if number == math.floor(number) then
        pattern = gen_num(number)
      else
        pattern = gen_num(math.floor(number * 1024)) .. "dddddddddd"
      end
        return Hexcasting.Iotas.hexcasting.pattern:new("SOUTH_EAST",pattern)
    --   else
    --     return unpack({{startDir="WEST", angles="qqq"}, number, {startDir="EAST", angles="eee"}, {startDir="NORTH_WEST", angles="qwaeawq"}})
    --   end
    end
  end

local function getPattern(name)
    local pattern = patternTable[name]
    if pattern then return Hexcasting.Iotas.hexcasting.pattern:new("EAST", pattern) end
    pattern = specialHandler(name)
    if pattern then return pattern end
    return
end


return function(strhex)
    -- local file = io.open(path, "r")
    -- local strhex = file:read("*all")
    -- file:close()
    local hex = Hexcasting.Iotas.hexcasting.list:new()
    for line in strhex:gmatch('[^\n]+') do
        local line = string.gsub(line, '^%s*(.-)%s*$', '%1')
        if #line > 0 then
            if string.sub(line, 1, 2) ~= "//" then
                line = 
                stringSplit(line,"//")[1]
            end
            hex:append(getPattern(line))
        end
    end
    return hex
end



-- local hex = Hexcasting.Iotas.hexcasting.list:new()
-- for _,line in pairs(
-- for _,line in pairs(hexUtils.stringSplit(strhex,"\n")) do
--     print(patternNames[line])
--     hex:append(Hexcasting.Iotas.hexcasting.pattern:new("EAST", patternNames[line]))
-- end    
