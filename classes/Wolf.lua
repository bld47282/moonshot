Wolf = Class{}

function Wolf:init()
    self.wolf_run_01 = love.graphics.newImage('graphics/wolf_run_01.png')
    self.wolf_run_02 = love.graphics.newImage('graphics/wolf_run_02.png')
    self.wolf_stand_01 = love.graphics.newImage('graphics/wolf_stand_01.png')
    self.currentImg = self.wolf_run_01
    self.x = 0
    self.y = 0
    self.speed = 200
    self.size = 600
    self.scale = 0.2
    self.animateTimer = 0
end

function Wolf:update(dt, groundSects)
    -- collision checks
    collision = false
    currentFloor = 0
    operatingSect = 0

    for x=#groundSects,0,-1 do
        if ((groundSects[x].x < self.x + 36) and (groundSects[x].x + 36 > self.x)) then
            if (self.y + (self.size / 2 * self.scale) > groundSects[x].y) then
                collision = true
                operatingSect = x
                currentFloor = groundSects[x].y
            end
        end
    end

    -- animate running wolf

    self.animateTimer = self.animateTimer + dt
    if self.animateTimer > 0.25 then
        self:alternateSprite()
        self.animateTimer = 0
    end

    -- operate based on collision data

    if collision == false then
        -- if no collision, fall
        self.y = self.y + (250 * dt)
    else
        -- check if self and floor are a certain distance from each other, and update y if they are
        if math.abs(self.y - (currentFloor - (self.size / 2 * self.scale))) > 5 then
            self.y = math.min(self.y, currentFloor - (self.size / 2 * self.scale))
        end

        -- point operatingSect to next GroundSect and move if possible
        -- expr and expr or expr functions as ternary operator as expr ? expr : expr in C
        operatingSect = (operatingSect > 0) and (operatingSect - 1) or (#groundSects)
        if (groundSects[operatingSect].y > self.y) and (groundSects[operatingSect].y < self.y + (self.size * self.scale)) then
            self.x = self.x + (self.speed * dt)
        else
            -- animate static wolf
            self:standSprite()
            self.animateTimer = 0
        end
    end
end

function Wolf:render()
    love.graphics.draw(self.currentImg, self.x - (self.size / 2 * self.scale), self.y - (self.size / 2 * self.scale), 0, self.scale, self.scale)
end

function Wolf:alternateSprite()
    -- alternate running wolf sprite to animate
    if self.currentImg == self.wolf_run_01 then
        self.currentImg = self.wolf_run_02
        jump8:play()
    else
        self.currentImg = self.wolf_run_01
        jump9:play()
    end
end

function Wolf:standSprite()
    -- set static standing wolf sprite
    self.currentImg = self.wolf_stand_01
end