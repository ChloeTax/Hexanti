function roundNumberString(number)
    local s = tostring(math.floor(number*100))
    s = string.rep("0", 3 - #s)..s
    local leading = string.sub(s,1,#s-2)
    local trailing = string.sub(s,#s-1)

    if leading == "" then leading = "0" end
    return table.concat({leading,".",trailing})
end

Hexcasting.Iotas["hexcasting:null"] = {
    new = function(self)
        data = {
            Type = "hexcasting:null",
        }
        self.__index = self
        return setmetatable(data,self)
    end,
    equals = function(self,other)
        if self.Type ~= other.Type then return false end
    end,
    copy = function(self)
        return Hexcasting.Iotas["hexcasting:null"]:new()
    end,
    display = function(self) return "Null" end,
    serialize = function(self) error("Unimplemented") end,
    deserialize = function(self, data) error("Unimplemented") end,
}

Hexcasting.Iotas["hexcasting:garbage"] = {
    new = function(self)
        data = {
            Type = "hexcasting:garbage",
        }
        self.__index = self
        return setmetatable(data,self)
    end,
    equals = function(self,other)
        if self.Type ~= other.Type then return false end
    end,
    copy = function(self)
        return Hexcasting.Iotas["hexcasting:garbage"]:new()
    end,
    display = function(self) return "Garbage" end,
    serialize = function(self) error("Unimplemented") end,
    deserialize = function(self, data) error("Unimplemented") end,
}

Hexcasting.Iotas["hexcasting:vec3"] = {
    new = function(self, x, y, z)
        data = {
            Type = "hexcasting:vec3",
            x = x,
            y = y,
            z = z,
        }
        self.__index = self
        return setmetatable(data,self)
    end,
    multiply = function(self, other)
        if other.Type == "hexcasting:double" then
            return Hexcasting.Iotas["hexcasting:vec3"]:new(self.x * other.number, self.y * other.number, self.z * other.number)
        end
    end,
    equals = function(self,other)
        if self.Type ~= other.Type then return false end
        return self.x == other.x and self.y == other.y and self.z == other.z
    end,
    copy = function(self)
        return Hexcasting.Iotas["hexcasting:vec3"]:new(self.x, self.y, self.z)
    end,
    display = function(self)
        return table.concat({"(",roundNumberString(self.x),", ",roundNumberString(self.y),", ",roundNumberString(self.z),")"})
    end,
    serialize = function(self) error("Unimplemented") end,
    deserialize = function(self, data) error("Unimplemented") end,
}

Hexcasting.Iotas["hexcasting:bool"]  = {
    new = function(self, bool)
        data = {
            Type = "hexcasting:bool",
            bool = bool,
        }
        self.__index = self
        return setmetatable(data,self)
    end,
    equals = function(self,other)
        if self.Type ~= other.Type then return false end
        return self.bool == other.bool
    end,
    copy = function(self)
        return Hexcasting.Iotas["hexcasting:bool"]:new(self.bool)
    end,
    display = function(self) if self.bool then return "True" else return "False" end end,
    serialize = function(self) error("Unimplemented") end,
    deserialize = function(self, data) error("Unimplemented") end,
}

Hexcasting.Iotas["hexcasting:double"] = {
    new = function(self, number)
        data = {
            Type = "hexcasting:double",
            number = number,
        }
        self.__index = self
        return setmetatable(data,self)
    end,
    equals = function(self,other)
        if self.Type ~= other.Type then return false end
        return self.number == other.number
    end,
    copy = function(self)
        return Hexcasting.Iotas["hexcasting:double"]:new(self.number)
    end,
    display = function(self) 
        return roundNumberString(self.number)
    end,
    add = function(self,other)
        if self.Type ~= other.Type then error(table.concat({"cannot add ", self.Type, " to ", other.Type})) end
        return Hexcasting.Iotas["hexcasting:double"]:new(self.number + other.number)
    end,
    subtract = function(self,other)
        if self.Type ~= other.Type then error(table.concat({"cannot add ", self.Type, " to ", other.Type})) end
        return Hexcasting.Iotas["hexcasting:double"]:new(self.number - other.number)
    end,
    multiply = function(self,other)
        if self.Type ~= other.Type then error(table.concat({"cannot add ", self.Type, " to ", other.Type})) end
        return Hexcasting.Iotas["hexcasting:double"]:new(self.number * other.number)
    end,
    divide = function(self,other)
        if self.Type ~= other.Type then error(table.concat({"cannot add ", self.Type, " to ", other.Type})) end
        return Hexcasting.Iotas["hexcasting:double"]:new(self.number / other.number)
    end,
    serialize = function(self) error("Unimplemented") end,
    deserialize = function(self, data) error("Unimplemented") end,
}

Hexcasting.Iotas["hexcasting:entity"] = {
    new = function(self, entity)
        data = {
            Type = "hexcasting:entity",
            entity = entity,
        }
        self.__index = self
        return setmetatable(data,self)
    end,
    equals = function(self,other)
        if self.Type ~= other.Type then return false end
        return self.entity == other.entity
    end,
    getName = function(self)
        return self.entity:get_player_name()
    end,
    copy = function(self)
        return Hexcasting.Iotas["hexcasting:entity"]:new(self.entity)
    end,
    display = function(self) 
        return self.entity:get_player_name()
    end,
    -- add = function(self,other)
    --     if self.Type ~= other.Type then error(table.concat({"cannot add ", self.Type, " to ", other.Type})) end
    --     return Hexcasting.Iotas["hexcasting:double"]:new(self.number + other.number)
    -- end,
    -- subtract = function(self,other)
    --     if self.Type ~= other.Type then error(table.concat({"cannot add ", self.Type, " to ", other.Type})) end
    --     return Hexcasting.Iotas["hexcasting:double"]:new(self.number - other.number)
    -- end,
    -- multiply = function(self,other)
    --     if self.Type ~= other.Type then error(table.concat({"cannot add ", self.Type, " to ", other.Type})) end
    --     return Hexcasting.Iotas["hexcasting:double"]:new(self.number * other.number)
    -- end,
    -- divide = function(self,other)
    --     if self.Type ~= other.Type then error(table.concat({"cannot add ", self.Type, " to ", other.Type})) end
    --     return Hexcasting.Iotas["hexcasting:double"]:new(self.number / other.number)
    -- end,
    serialize = function(self) error("Unimplemented") end,
    deserialize = function(self, data) error("Unimplemented") end,
}

Hexcasting.Iotas["hexcasting:pattern"] = {
    new = function(self, name, id, direction, signature, extraData)
        data = {
            Type = "hexcasting:pattern",
            Name=name,
            ID=id,
            Direction=direction,
            Angles=signature,
            extraData = extraData
        }
        self.__index = self
        return setmetatable(data,self)
    end,
    equals = function(self, other)
        error("Unimplemented")
    end,
    copy = function(self)
        return Hexcasting.Iotas["hexcasting:pattern"]:new(self.Name, self.ID, self.Direction, self.Angles, self.extraData)
    end,
    display = function(self)
        if self.ID == "hexcasting:number" then
            return table.concat({self.Name, ": ", self.extraData})
        end
        return self.Name
    end,
    serialize = function(self) error("Unimplemented") end,
    deserialize = function(self, data) error("Unimplemented") end,
}

Hexcasting.Iotas["hexcasting:list"] = {
    new = function(self, table)
        if not table then table = {} end
        data = {
            Type = "hexcasting:list",
            list=table
        }
        self.__index = self
        return setmetatable(data,self)
    end,
    add = function(self, iota)
        table.insert(self.list, iota)
        return self
    end,
    append = function(self, iota)
        table.insert(self.list, iota)
        return self
    end,
    copy = function(self)
        local newIota = Hexcasting.Iotas["hexcasting:list"]:new()
        for _,iota in pairs(self.list) do
            newIota:append(iota:copy())
        end
        return newIota
    end,
    length = function(self)
        return #self.list
    end,
    display = function(self)
        local output = {"["}
        for _,iota in pairs(self.list) do
            table.insert(output,iota:display())
            table.insert(output,", ")
        end
        if #output > 1 then
            table.remove(output)
        end
        table.insert(output,"]")
        return table.concat(output)
    end,
    reverse = function(self)
        rev = {}
        for i=#self.list, 1, -1 do
            rev[#rev+1] = self.list[i]
        end
        self.list = rev
        return self
    end,
    equals = function(self, other)
        error("Unimplemented")
    end,
    serialize = function(self) error("Unimplemented") end,
    deserialize = function(self, data) error("Unimplemented") end,
}