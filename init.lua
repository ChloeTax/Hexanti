print("This file will be run at load time!")

dofile("./hexEmulator/hexEmulator.lua")




core.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= "hexanti:hexInput" then
        return
    end

    if fields.hex then
        local newTrinket = player:get_wielded_item()
        newTrinket:get_meta():set_string("hex", fields.hex)
        player:set_wielded_item(newTrinket)
    end
end)


function trinket(itemstack, user, pointed_thing)

    if user:get_player_control().sneak then

        local formspec = {
            "formspec_version[4]",
            "size[24,24]",
            "label[0.375,0.5;", core.formspec_escape("input your hex here"), "]",
            "field[1,1;22,22;hex;;]",
            "button[20,0.25;3,0.8;save;Save]"
        }

        core.show_formspec(user:get_player_name(), "hexanti:hexInput", table.concat(formspec, ""))

    else
        Hexcasting.castHex(itemstack:get_meta():get_string("hex"), user)
    end
end

core.register_craftitem("hexanti:trinket", {
    description = "trinket",
    inventory_image = "hexanti_trinket.png",
    stack_max = 1,
    on_use = trinket,
})
