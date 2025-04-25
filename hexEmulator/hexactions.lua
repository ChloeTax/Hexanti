function Unimplemented(self)
    error(table.concat({self.Name, " (",self.ID, ") Unimplemented"}),-1)
end

for _,file in pairs(core.get_dir_list(core.get_modpath("hexanti") .. "/hexEmulator/Plugins/Actions")) do
    dofile(core.get_modpath("hexanti") .. "/hexEmulator/Plugins/Actions/" .. file)
end

function eval(castEnv,iota)
    local introDepth = 0
    local introIotas = Hexcasting.Iotas["hexcasting:list"]:new()
    if iota.Type == "hexcasting:list" then
        for _,subiota in pairs(iota.list) do
            if subiota.Type == "hexcasting:pattern" then
                if subiota.ID == "hexcasting:open_paren" then
                    if introDepth > 0 then introIotas:append(subiota) end
                    introDepth = introDepth + 1
                elseif subiota.ID == "hexcasting:close_paren" then
                    introDepth = introDepth - 1
                    if introDepth == 0 then
                        castEnv.stack:push(introIotas)
                        introIotas = Hexcasting.Iotas["hexcasting:list"]:new()
                    else
                        introIotas:append(subiota)
                    end
                else
                    if introDepth == 0 then
                        Hexcasting.Actions[subiota.ID](subiota, castEnv)
                    else
                        introIotas:append(subiota)
                    end
                end
            else
                if introDepth > 0 then
                    introIotas:append(subiota)
                else
                    pprint(subiota)
                    error("expected to eval a pattern but evaluated that instead")
                end
            end
        end
    else
        error('executed a bad Type: ' .. iota.Type ..'"')
    end
end