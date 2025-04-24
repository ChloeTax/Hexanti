
for _,file in pairs(core.get_dir_list("hexEmulator/Plugins/Iotas")) do
    print("hexEmulator/Plugins/Iotas/" .. file)
    dofile("hexEmulator/Plugins/Iotas/" .. file)
end


iotaRequirements = {
    "new",
    "copy",
    "display",
    "equals",
    "serialize",
    "deserialize"
}

for name,iota in pairs(Hexcasting.Iotas) do
    for _,requirment in pairs(iotaRequirements) do
        if not iota[requirment] then
            error(table.concat({name,' does not have a "', requirment, '" function.'}))
        end
    end
end