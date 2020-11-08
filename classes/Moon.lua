Moon = Class{}

function Moon:init()
    self.moonImg = love.graphics.newImage('graphics/moon/moon_01_01.png')
    self.x = 1000
    self.y = 100
    self.size = 500
    self.scale = 0.25
    self.speed = 200
    self.rotation = 0
end

function Moon:update(dt)
    -- update moon position based on keys pressed & moon location
    if love.keyboard.isDown("left") then
        self.x = self.x - (self.speed * dt)
        self.rotation = self.rotation - (1 * dt)
        if self.x < 0 + (self.size / 2 * self.scale) then
            self.x = 0 + (self.size / 2 * self.scale)
        end
    end

    if love.keyboard.isDown("right") then
        self.x = self.x + (self.speed * dt)
        self.rotation = self.rotation + (1 * dt)
        if self.x > 1280 - (self.size / 2 * self.scale) then
            self.x = 1280 - (self.size / 2 * self.scale)
        end
    end
end

function Moon:render()
    love.graphics.draw(self.moonImg, self.x, self.y, self.rotation, self.scale, self.scale, self.size / 2, self.size / 2)
end

function Moon:getX()
    return self.x
end