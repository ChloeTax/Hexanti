
Hexcasting.Actions["hexcasting:get_caster"] = function(self, castEnv) castEnv.stack:push(castEnv.caster:copy()) end
Hexcasting.Actions["hexcasting:entity_pos/eye"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:entity_pos/foot"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:get_entity_look"] = function(self, castEnv)
    dir = castEnv.stack:pop().entity:get_look_dir()
    castEnv.stack:push(Hexcasting.Iotas["hexcasting:vec3"]:new(dir.x,dir.y,dir.z))  
end
Hexcasting.Actions["hexcasting:get_entity_height"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:get_entity_velocity"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:raycast"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:raycast/axis"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:raycast/entity"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:circle/impetus_pos"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:circle/impetus_dir"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:circle/bounds/min"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:circle/bounds/max"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:swap"] = function(self, castEnv)
    local iota1 = castEnv.stack:pop()
    local iota2 = castEnv.stack:pop()

    castEnv.stack:push(iota1)
    castEnv.stack:push(iota2)
end
Hexcasting.Actions["hexcasting:rotate"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:rotate_reverse"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:duplicate"] = function(self, castEnv) castEnv.stack:push(castEnv.stack.list[castEnv.stack:length()]:copy()) end
Hexcasting.Actions["hexcasting:over"] = function(self, castEnv)
    if castEnv.stack:length() > 1 then
        castEnv.stack:push(castEnv.stack.list[castEnv.stack:length()-1]:copy())
    else
        error("Prospector's Gambit: Expected at least 2 iotas on the stack",-1)
    end
end
Hexcasting.Actions["hexcasting:tuck"] = function(self, castEnv)
    if castEnv.stack:length() > 1 then
        local iota = castEnv.stack.list[castEnv.stack:length()]:copy()
        table.insert(castEnv.stack.list,castEnv.stack:length()-1,iota)
    else
        error("Undertaker's Gambit: Expected at least 2 iotas on the stack",-1)
    end
end
Hexcasting.Actions["hexcasting:2dup"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:stack_len"] = function(self, castEnv) castEnv.stack:push(Hexcasting.Iotas["hexcasting:double"]:new(castEnv.stack:length())) end
Hexcasting.Actions["hexcasting:duplicate_n"] = function(self, castEnv)
    local count = castEnv.stack:pop().number
    local data = castEnv.stack:pop()
    for i=1,count do
        castEnv.stack:push(data)
    end
end
Hexcasting.Actions["hexcasting:fisherman"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:fisherman/copy"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:swizzle"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:add"] = function(self, castEnv)
    local iota1 = castEnv.stack:pop()
    local iota2 = castEnv.stack:pop()
    castEnv.stack:push(iota2:add(iota1))
end
Hexcasting.Actions["hexcasting:sub"] = function(self, castEnv)
    local iota1 = castEnv.stack:pop()
    local iota2 = castEnv.stack:pop()
    castEnv.stack:push(iota2:subtract(iota1))
end
Hexcasting.Actions["hexcasting:mul"] = function(self, castEnv)
    local iota1 = castEnv.stack:pop()
    local iota2 = castEnv.stack:pop()
    castEnv.stack:push(iota2:multiply(iota1))
end
Hexcasting.Actions["hexcasting:div"] = function(self, castEnv)
    local iota1 = castEnv.stack:pop()
    local iota2 = castEnv.stack:pop()
    castEnv.stack:push(iota2:divide(iota1))
end
Hexcasting.Actions["hexcasting:abs"] = function(self, castEnv) castEnv.stack:push(Hexcasting.Iotas["hexcasting:double"]:new(castEnv.stack:pop():length())) end
Hexcasting.Actions["hexcasting:pow"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:floor"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:ceil"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:construct_vec"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:deconstruct_vec"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:coerce_axial"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:and"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:or"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:xor"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:greater"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:less"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:greater_eq"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:less_eq"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:equals"] = function(self, castEnv) castEnv.stack:push(Hexcasting.Iotas["hexcasting:bool"]:new(castEnv.stack:pop():equals(castEnv.stack:pop()))) end
Hexcasting.Actions["hexcasting:not_equals"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:not"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:bool_coerce"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:if"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:random"] = function(self, castEnv) num = math.random() castEnv.stack:push(Hexcasting.Iotas["hexcasting:double"]:new(num)) end
Hexcasting.Actions["hexcasting:sin"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:cos"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:tan"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:arcsin"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:arccos"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:arctan"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:arctan2"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:logarithm"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:modulo"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:unique"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:print"] = function(self, castEnv) core.chat_send_player(castEnv.caster:getName(), castEnv.stack.list[castEnv.stack:length()]:display()) end
Hexcasting.Actions["hexcasting:explode"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:explode/fire"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:add_motion"] = function(self, castEnv)
    vel = castEnv.stack:pop()
    ent = castEnv.stack:pop()
    ent.entity:add_velocity(vel)
end
Hexcasting.Actions["hexcasting:blink"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:break_block"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:place_block"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:colorize"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:cycle_variant"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:create_water"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:destroy_water"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:ignite"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:extinguish"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:conjure_block"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:conjure_light"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:bonemeal"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:recharge"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:erase"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:edify"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:beep"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:craft/cypher"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:craft/trinket"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:craft/artifact"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:craft/battery"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:potion/weakness"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:potion/levitation"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:potion/wither"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:potion/poison"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:potion/slowness"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:potion/regeneration"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:potion/night_vision"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:potion/absorption"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:potion/haste"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:potion/strength"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:flight/range"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:flight/time"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:flight/can_fly"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:sentinel/create"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:sentinel/destroy"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:sentinel/get_pos"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:sentinel/wayfind"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:lightning"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:flight"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:create_lava"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:teleport/great"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:sentinel/create/great"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:dispel_rain"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:summon_rain"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:brainsweep"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:akashic/read"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:akashic/write"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:eval"] = function(self, castEnv) eval(castEnv,castEnv.stack:pop()) end
Hexcasting.Actions["hexcasting:eval/cc"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:halt"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:read"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:read/entity"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:write"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:write/entity"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:readable"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:readable/entity"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:writable"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:writable/entity"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:read/local"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:write/local"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:thanatos"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:const/null"] = function(self, castEnv) castEnv.stack:push(Hexcasting.Iotas["hexcasting:null"]:new()) end
Hexcasting.Actions["hexcasting:const/true"] = function(self, castEnv) castEnv.stack:push(Hexcasting.Iotas["hexcasting:bool"]:new(true)) end
Hexcasting.Actions["hexcasting:const/false"] = function(self, castEnv) castEnv.stack:push(Hexcasting.Iotas["hexcasting:bool"]:new(false)) end
Hexcasting.Actions["hexcasting:const/vec/px"] = function(self, castEnv) castEnv.stack:push(Hexcasting.Iotas["hexcasting:vec3"]:new(1,0,0)) end
Hexcasting.Actions["hexcasting:const/vec/py"] = function(self, castEnv) castEnv.stack:push(Hexcasting.Iotas["hexcasting:vec3"]:new(0,1,0)) end
Hexcasting.Actions["hexcasting:const/vec/pz"] = function(self, castEnv) castEnv.stack:push(Hexcasting.Iotas["hexcasting:vec3"]:new(0,0,1)) end
Hexcasting.Actions["hexcasting:const/vec/nx"] = function(self, castEnv) castEnv.stack:push(Hexcasting.Iotas["hexcasting:vec3"]:new(-1,0,0)) end
Hexcasting.Actions["hexcasting:const/vec/ny"] = function(self, castEnv) castEnv.stack:push(Hexcasting.Iotas["hexcasting:vec3"]:new(0,-1,0)) end
Hexcasting.Actions["hexcasting:const/vec/nz"] = function(self, castEnv) castEnv.stack:push(Hexcasting.Iotas["hexcasting:vec3"]:new(0,0,-1)) end
Hexcasting.Actions["hexcasting:const/vec/0"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:const/double/pi"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:const/double/tau"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:const/double/e"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:get_entity"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:get_entity/animal"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:get_entity/monster"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:get_entity/item"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:get_entity/player"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:get_entity/living"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:zone_entity"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:zone_entity/animal"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:zone_entity/not_animal"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:zone_entity/monster"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:zone_entity/not_monster"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:zone_entity/item"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:zone_entity/not_item"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:zone_entity/player"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:zone_entity/not_player"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:zone_entity/living"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:zone_entity/not_living"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:append"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:unappend"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:index"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:for_each"] = function(self, castEnv)
    local data = castEnv.stack:pop()
    local hex = castEnv.stack:pop()
    local savedStack = castEnv.stack:copy()
    local outputList = Hexcasting.Iotas["hexcasting:list"]:new()
    for _,iota in pairs(data.list) do
        castEnv.stack = savedStack:copy():push(iota)
        eval(castEnv,hex)
        for _,iota2 in pairs(castEnv.stack.list) do
            outputList:append(iota2)
        end
    end
    castEnv.stack = savedStack:copy()
    castEnv.stack:push(outputList)
end
Hexcasting.Actions["hexcasting:singleton"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:empty_list"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:reverse"] = function(self, castEnv) castEnv.stack:push(castEnv.stack:pop():reverse()) end
Hexcasting.Actions["hexcasting:last_n_list"] = function(self, castEnv)
    local count = castEnv.stack:pop().number
    local output = Hexcasting.Iotas["hexcasting:list"]:new()
    for i=1,count do
        output:append(castEnv.stack:pop())
    end
    output:reverse()
    castEnv.stack:push(output)
end
Hexcasting.Actions["hexcasting:splat"] = function(self, castEnv)
    local list = castEnv.stack:pop().list
    for _,iota in pairs(list) do
        castEnv.stack:push(iota)
    end
end 
Hexcasting.Actions["hexcasting:index_of"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:remove_from"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:slice"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:replace"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:construct"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:deconstruct"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:interop/pehkui/get"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:interop/pehkui/set"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:number"] = function(self, castEnv) castEnv.stack:push(Hexcasting.Iotas["hexcasting:double"]:new(self.extraData)) end
Hexcasting.Actions["hexcasting:mask"] = function(self, castEnv)
    j=-1
    for i=#self.extraData, 1, -1 do
        j = j + 1
        if (self.extraData[i] == true) then
            table.remove(castEnv.stack.list,castEnv.stack:length()-j)
            j = j - 1
        end
    end
end
Hexcasting.Actions["hexcasting:escape"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:open_paren"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:close_paren"] = function(self, castEnv) Unimplemented(self) end
Hexcasting.Actions["hexcasting:undo"] = function(self, castEnv) Unimplemented(self) end