GroundSect = Class{}

function GroundSect:init(x, y)
    self.groundImg = love.graphics.newImage('graphics/pillar_01_01.png')
    self.defaultx = x
    self.defaulty = y
    self.miny = y - 350
    self.x = x
    self.y = y
end

function GroundSect:update(dt, moon)
    if (math.abs(self.x - moon) < 200) then
        self.y = clamp(self.miny + math.abs(self.x - moon), self.y - (100 * dt), self.defaulty)
    else
        self.y = clamp(self.miny, self.y + (100 * dt), self.defaulty)
    end
end

function GroundSect:render()
    love.graphics.draw(self.groundImg, self.x, self.y, 0, 0.25, 0.25)
end

function clamp(low, n, high) 
    return math.min(math.max(n, low), high) 
end