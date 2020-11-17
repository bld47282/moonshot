Platform = Class{}

function Platform:init(x, y, scale)
    self.platformImg = love.graphics.newImage('graphics/level01/platform.png')
    self.x = x
    self.y = y
    self.scale = scale
end

function Platform:update(dt)
end

function Platform:render()
    love.graphics.draw(self.platformImg, self.x, self.y, 0, self.scale, self.scale)
end