Dingoberry = Class{}

function Dingoberry:init(x, y)
    self.x = x
    self.y = y
end

function Dingoberry:update(x, y)
    self.x = x
    self.y = y
end

function Dingoberry:render()
    love.graphics.rectangle('fill', self.x, self.y, 10, 10)
end