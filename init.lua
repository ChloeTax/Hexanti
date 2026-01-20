print("This file will be run at load time!")

platform = dofile(core.get_modpath("hexanti") .. "/platform.lua")

Hexcasting = platform.require("hexEmulator/Hexcasting")

local hexpatternParser = platform.require("jankyHexpatternParser")


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


function trinket(itemstack, user)

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
        local hex = hexpatternParser(itemstack:get_meta():get_string("hex"))
        local caster = Hexcasting.Iotas.hexcasting.entity:new(user)

        hex = Hexcasting.buildCast(hex, caster)

        local status, error = pcall(hex.eval, hex)
        if not status then
            core.chat_send_player(user:get_player_name(), tostring(error))
        end
    end
end

core.register_craftitem("hexanti:trinket", {
    description = "Trinket",
    inventory_image = "hexanti_trinket.png",
    stack_max = 1,
    on_place = trinket,
    on_secondary_use = trinket,
})

core.register_craft({
	output = "hexanti:trinket 1",
	recipe = {
		{"",                    "mcl_core:iron_ingot", ""},
		{"mcl_core:iron_ingot", "mcl_amethyst:amethyst_shard", "mcl_core:iron_ingot"},
		{"",                    "mcl_core:iron_ingot", ""},
	}
})
