Hexcasting = {
    Iotas = {},
    Actions = {},
    Patterns = {}
}
dofile(core.get_modpath("hexanti") .. "/hexEmulator/json.lua")
dofile(core.get_modpath("hexanti") .. "/hexEmulator/hexiotas.lua")
dofile(core.get_modpath("hexanti") .. "/hexEmulator/hexpatterns.lua")
dofile(core.get_modpath("hexanti") .. "/hexEmulator/hexactions.lua")

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

function Hexcasting.castHex(strhex, caster)

    local castEnv = {
        caster = Hexcasting.Iotas["hexcasting:entity"]:new(caster),
        world = Hexcasting.Iotas["internal:world"]:new(),
        stack = Hexcasting.Iotas["internal:stack"]:new(),
        ravenmind = Hexcasting.Iotas["hexcasting:null"]:new(),
        introIotas = Hexcasting.Iotas["hexcasting:list"]:new(),
        introDepth = 0,
        considering = false,
    }

    hex = Hexcasting.Iotas["hexcasting:list"]:new()


    for line in strhex:gmatch('[^\n]+') do
        line = string.gsub(line, '^%s*(.-)%s*$', '%1')
        if #line > 0 then
            if string.sub(line, 1, 2) ~= "//" then
                line = stringSplit(line,"//")[1]
            end
            hex:append(Hexcasting.Patterns.processHexpattern(line))
        end
    end

    castEnv.stack:push(hex)

    Hexcasting.Actions["hexcasting:eval"](self, castEnv)

    dbg.pp(castEnv.stack)
end