local requireCache = {}

table.unpack = table.unpack or unpack

math.randomseed(os.time())

return {
    platform = "luanti",
    print = function(message, player)
       core.chat_send_player(player:get_player_name(), message) 
    end,
    random = math.random,
    require = function(path, ...)
        path = core.get_modpath("hexanti") .. "/" .. path
        local file = requireCache[path]
        if file then return file end
        
        file =  loadfile(path .. ".lua")
        requireCache[path] = file
        if not file then 
            local file2 = io.open(path.. ".lua", "r")
            if file2 then
                print("broken")
                error(path .. ".lua broken")
                file2:close()
            else
                -- print(path .. ".lua", " not found")
            end
        return nil end
        return file(...)
    end,
    file = {
        read = function(path)
            local file = io.open(path, "r")
            if not file then return nil end
            local content = file:read("*a")
            file:close()
            return content
        end
    },
    readChat = function ()
        local message = io.read("*l")
        if message then
            return message
        else
            return ""
        end
    end,
    entity = {
        get_name = function(entity)
            return entity:get_player_name()
        end,
        add_velocity = function(entity, vector)
            entity.entity:add_velocity(vector)
        end,
        get_pos = function(entity)
            local pos = entity:get_pos()
            return Hexcasting.Iotas.hexcasting.vec3:new(pos.x,pos.y,pos.z)
        end,
        get_velocity = function(entity)
            local pos = entity:get_velocity()
            return Hexcasting.Iotas.hexcasting.vec3:new(pos.x,pos.y,pos.z)
        end,
        eye_height = function(entity)
            return Hexcasting.Iotas.hexcasting.double:new(entity.entity:get_properties().eye_height)
        end,
        get_look_dir = function(entity)
            local pos = entity:get_look_dir()
            return Hexcasting.Iotas.hexcasting.vec3:new(pos.x,pos.y,pos.z)
        end,
        get_entities = function(center, radius, filter)
            local entities = core.get_objects_inside_radius(center, radius.number)
            local outputList = Hexcasting.Iotas.hexcasting.list:new()
            for _,entity in pairs(entities) do
                if filter(entity) then
                    outputList:append(Hexcasting.Iotas.hexcasting.entity:new(entity))
                end
            end
            return outputList
        end
    },
    block = {
        break_block = function(pos, entity)
            core.dig_node(pos,entity)
        end,
        set_block = function(caster, pos, type)
            core.set_node(pos,{name=type})
        end,
        explode = function(caster, pos, power, firey) 
            mcl_explosions.explode(pos, power.number, {drop_chance=1, max_blast_resistance = 1, fire = firey}, caster.entity)
        end
    },
    raycast = function (start_pos, end_pos, type)
        
        local ray = Raycast(start_pos, end_pos, false, false)
        local hit

        local raycast_types = {        
            block = {"under", false},
            block_normal = {"intersection_normal", false},
            entity = {"entity", true}
        }

        for pointed_thing in ray do
            hit = pointed_thing.intersection_normal
            break
        end

        if hit then
            return Hexcasting.Iotas.hexcasting.vec3:new(hit.x,hit.y,hit.z)
        else
            return Hexcasting.Iotas.hexcasting.null:new()
        end
    end,
    filters = {
        entity = {
            any = function() return true end
        }
    },
    blocktypes = {
        water = "mcl_core:water_source",
        conjured_block = "mcl_core:glass",
        conjured_light = "mcl_torches:torch"
    },
    Plugins = {
        "custom",
        "hexcasting",
        "moreiotas",
        "hexal",
        "internal"
    }
}