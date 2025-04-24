Hexcasting.Iotas["internal:stack"] = {
    new = function(self, table)
        if not table then table = {} end
        data = {
            Type = "internal:stack",
            list=table
        }
        self.__index = self
        return setmetatable(data,self)
    end,
    push = function(self, iota)
        table.insert(self.list, iota)
        return self
    end,
    pop = function(self)
        return table.remove(self.list, #self.list)
    end,
    copy = function(self)
        local newIota = Hexcasting.Iotas["internal:stack"]:new()
        for _,iota in pairs(self.list) do
            newIota:push(iota:copy())
        end
        return newIota
    end,
    display = function(self)
        error("The stack should not be possible to display?")
    end,
    equals = function(self)
        return false
    end,
    length = function(self)
        return #self.list
    end,
    serialize = function(self) error("Unimplemented") end,
    deserialize = function(self, data) error("Unimplemented") end,
}

Hexcasting.Iotas["internal:block"] = {
    new = function(self, blockType, blockData)
        data = {
            Type = "internal:block",
            blockType = blockType,
            blockData = blockData,
        }
        self.__index = self
        return setmetatable(data,self)
    end,
    copy = function(self)
        return Hexcasting.Iotas["internal:block"]:new(self.blockType, self.blockData:copy())
    end,
    display = function(self)
        error("The world should not be possible to display?")
    end,
    equals = function(self)
        return false
    end,
    serialize = function(self) error("Unimplemented") end,
    deserialize = function(self, data) error("Unimplemented") end,
}

Hexcasting.Iotas["internal:nbt"] = {
    new = function(self, tags)
        data = {
            Type = "internal:nbt",
            tags = tags,
        }
        self.__index = self
        return setmetatable(data,self)
    end,
    copy = function(self)
        local newData = {}
        for k,v in pairs(self.tags) do
            newData[k] = v:copy()
        end
        return Hexcasting.Iotas["internal:nbt"]:new(newData)
    end,
    display = function(self)
        error("nbt should not be possible to display?")
    end,
    equals = function(self)
        return false
    end,
    serialize = function(self) error("Unimplemented") end,
    deserialize = function(self, data) error("Unimplemented") end,
}


Hexcasting.Iotas["internal:world"] = {
    new = function(self)
        data = {
            Type = "internal:world",
            blocks = {},
            entities = {},
        }
        self.__index = self
        return setmetatable(data,self)
    end,
    copy = function(self)
        error("Unimplemented")
    end,
    display = function(self)
        error("The world should not be possible to display?")
    end,
    equals = function(self)
        return false
    end,
    serialize = function(self) error("Unimplemented") end,
    deserialize = function(self, data) error("Unimplemented") end,
}