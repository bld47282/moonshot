Dingo = Class{}

function Dingo:init()
    self.dingo_run_01 = love.graphics.newImage('graphics/dingo/dingo_run_01.png')
    self.dingo_run_02 = love.graphics.newImage('graphics/dingo/dingo_run_02.png')
    self.dingo_run_03 = love.graphics.newImage('graphics/dingo/dingo_run_03.png')
    self.dingo_run_04 = love.graphics.newImage('graphics/dingo/dingo_run_04.png')
    self.dingo_howl_01 = love.graphics.newImage('graphics/dingo/dingo_howl_01.png')
    self.dingo_stand_01 = love.graphics.newImage('graphics/dingo/dingo_stand.png')
    self.dingo_scratch_01 = love.graphics.newImage('graphics/dingo/dingo_scratch_01.png')
    self.dingo_scratch_02 = love.graphics.newImage('graphics/dingo/dingo_scratch_02.png')
    self.dingo_sit_01 = love.graphics.newImage('graphics/dingo/dingo_sit_01.png')
    self.currentImg = self.dingo_run_01
    self.x = 0
    self.y = 500
    self.targetY = 0
    self.targetX = 500
    self.xVelocity = 200
    self.yVelocity = 300
    self.jumpVelocity = -500
    self.currentJumpVelocity = 0
    self.scale = 0.2
    self.size = self.currentImg:getHeight() * self.scale
    self.animateTimer = 0
    self.dingoberry = Dingoberry(self.x + self.size, self.y + self.size + 10)
end

function Dingo:update(dt, water, world)
    -- victory/loss checks
    if self.y >= water.y then
        -- self:loss()
    elseif self.x > 1200 then
        self:victory()
    end

    -- collision checks
    local x, y, cols, len = world:check(self, self.x, self.y + 1)
    local bx, by, bcols, blen = world:check(self.dingoberry, self.dingoberry.x, self.dingoberry.y)
    if (len > 0) and (blen > 0) then
        -- if there's a collision, try to move in x
        self.targetX = self.x + (self.xVelocity * dt)
    end

    -- target y
    self.targetY = self.y + (self.yVelocity * dt)
    
    -- move
    self.x, self.y, cols, len = world:move(self, self.targetX, self.targetY)

    -- animation logic

    self.animateTimer = self.animateTimer + dt

    -- animate standing dingo
    if self.animateTimer > 0.1 then
        if self.x == self.targetX and (blen > 0) then
            self:alternateSprite()
            self.animateTimer = 0
        else
            self:idleAnimation()
        end
    end
 

    self.dingoberry:update(self.x + self.size, self.y + self.size + 10)
    world:update(self.dingoberry, self.dingoberry.x, self.dingoberry.y, 10, 10)
end

function Dingo:render()
    love.graphics.draw(self.currentImg, self.x, self.y, 0, self.scale, self.scale)
    self.dingoberry:render()
end

function Dingo:alternateSprite()
    -- alternate running dingo sprite to animate
    if self.currentImg == self.dingo_run_01 then
        self.currentImg = self.dingo_run_02
        jump8:play()
    elseif self.currentImg == self.dingo_run_02 then
        self.currentImg = self.dingo_run_03
    elseif self.currentImg == self.dingo_run_03 then
        self.currentImg = self.dingo_run_04
        jump9:play()
    else
        self.currentImg = self.dingo_run_01
    end
end

function Dingo:standSprite()
    -- set static standing dingo sprite
    self.currentImg = self.dingo_stand_01
end

function Dingo:victory()
    won = true
    self.currentImg = self.dingo_howl_01
    howl:play()
end

function Dingo:loss()
    lost = true
    self.currentImg = self.dingo_howl_01
    howl:play()
end

function Dingo:idleAnimation()
    if self.animateTimer < 1.85 then
        self.currentImg = self.dingo_sit_01
    elseif self.animateTimer < 2 then
        self.currentImg = self.dingo_scratch_01
    elseif self.animateTimer < 2.15 then
        self.currentImg = self.dingo_scratch_02
    elseif self.animateTimer < 2.3 then
        self.currentImg = self.dingo_scratch_01
    elseif self.animateTimer < 2.45 then
        self.currentImg = self.dingo_scratch_02
    elseif self.animateTimer < 2.6 then
        self.currentImg = self.dingo_scratch_01
    elseif self.animateTimer < 2.75 then
        self.currentImg = self.dingo_scratch_02
    elseif self.animateTimer < 2.9 then
        self.currentImg = self.dingo_scratch_01
    elseif self.animateTimer < 3.05 then
        self.currentImg = self.dingo_sit_01
        self.animateTimer = 0
    end
end