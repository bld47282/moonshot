GroundSect = Class{}

hmath = require 'libraries/hmath'

function GroundSect:init(x, y, groundImg, topImg)
    self.groundImg = groundImg
    self.topImg = topImg
    self.defaulty = y + 20
    self.miny = y - 350
    self.x = x
    self.y = y
    self.scale = 0.25
    self.speed = 100
end

function GroundSect:update(dt, moon)
    if (math.abs(self.x - moon) < 100) and pull then
        self.y = hmath.clamp(self.miny + math.abs(self.x - moon), self.y - (self.speed * dt), self.defaulty)
    elseif (math.abs(self.x - moon) < 100) and not pull then
        self.y = hmath.clamp(self.miny + math.abs(self.x - moon), self.y + (self.speed * dt), self.defaulty)
    else
        if self.defaulty > self.y then
            self.y = self.y + ((self.speed / 4) * dt)
        else
            self.y = math.max(self.defaulty, self.y - ((self.speed / 4) * dt))
        end
    end
end

function GroundSect:render()
    
    love.graphics.draw(self.groundImg, self.x, self.y, 0, self.scale, self.scale)
    love.graphics.draw(self.topImg, self.x, self.y + 10 - (self.topImg:getHeight()* self.scale), 0, self.scale, self.scale)
end