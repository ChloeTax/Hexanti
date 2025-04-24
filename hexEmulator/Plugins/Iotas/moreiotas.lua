Hexcasting.Iotas["moreiotas:string"] = {
    new = function(self, str)
        data = {
            Type = "moreiotas:string",
            str = str,
        }
        self.__index = self
        return setmetatable(data,self)
    end,
    equals = function(self,other)
        if self.Type ~= other.Type then return false end
        return self.str == other.str
    end,
    copy = function(self)
        return Hexcasting.Iotas["moreiotas:string"]:new(self.str)
    end,
    display = function(self) 
        return table.concat({'"',self.str,'"'})
    end,
    add = function(self,other)
        if self.Type ~= other.Type then error(table.concat({"cannot add ", self.Type, " to ", other.Type})) end
        return Hexcasting.Iotas["moreiotas:string"]:new(self.str .. other.str)
    end,
    serialize = function(self) error("Unimplemented") end,
    deserialize = function(self, data) error("Unimplemented") end,
}