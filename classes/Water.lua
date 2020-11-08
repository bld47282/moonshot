Water = Class{}

function Water:init(y)
    self.y = y
    self.x = 0
    self.minX = self.x - 20
    self.maxX = self.x + 20
    self.width = 1280
    self.height = 720
    self.rising = true
    self.speed = 50
end

function Water:update(dt)
    if self.rising == true and self.x < self.maxX then
        self.x = self.x + (self.speed * dt)
    elseif self.rising == true and self.x >= self.maxX then
        self.rising = false
    elseif self.rising == false and self.x > self.minX then
        self.x = self.x - (self.speed * dt)
    elseif self.rising == false and self.x <= self.minX then
        self.rising = true
    end
end

function Water:render()
    love.graphics.draw(water, self.x, self.y, 0, 0.5, 0.5)

end