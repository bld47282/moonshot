Water = Class{}

function Water:init(y)
    self.y = y
    self.minY = y - 20
    self.maxY = y + 20
    self.width = 1280
    self.height = 720
    self.rising = true
end

function Water:update(dt)
    if self.rising == true and self.y < self.maxY then
        self.y = self.y + (100 * dt)
    elseif self.rising == true and self.y >= self.maxY then
        self.rising = false
    elseif self.rising == false and self.y > self.minY then
        self.y = self.y - (100 * dt)
    elseif self.rising == false and self.y <= self.minY then
        self.rising = true
    end
end

function Water:render()
    love.graphics.rectangle('fill', (self.width / 2), self.y, self.width, self.height)
end