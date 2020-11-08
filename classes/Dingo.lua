Dingo = Class{}

function Dingo:init()
    self.dingo_run_01 = love.graphics.newImage('graphics/dingo/dingo_run_01.png')
    self.dingo_run_02 = love.graphics.newImage('graphics/dingo/dingo_run_02.png')
    self.dingo_run_03 = love.graphics.newImage('graphics/dingo/dingo_run_03.png')
    self.dingo_run_04 = love.graphics.newImage('graphics/dingo/dingo_run_04.png')
    self.dingo_howl_01 = love.graphics.newImage('graphics/dingo/dingo_stand.png')
    self.dingo_stand_01 = love.graphics.newImage('graphics/dingo/dingo_stand.png')
    self.currentImg = self.dingo_run_01
    self.x = 0
    self.y = 500
    self.targetY = 0
    self.targetX = 500
    self.xVelocity = 200
    self.yVelocity = 250
    self.scale = 0.2
    self.size = self.currentImg:getHeight() * self.scale
    self.animateTimer = 0
end

function Dingo:update(dt, water, world)
    if self.y >= water.y then
        self:loss()
    elseif self.x > 1200 then
        self:victory()
    end

    local x, y, cols, len = world:check(self, self.x, self.y + 1)
    if len > 0 then
        self.targetX = self.x + (self.xVelocity * dt)
    end

    self.targetY = self.y + (self.yVelocity * dt)
    self.x, self.y, cols, len = world:move(self, self.targetX, self.targetY)

    -- animate standing dingo

    if self.x ~= self.targetX then
        self:standSprite()
        self.animateTimer = 0
    end

    -- animate running dingo

    self.animateTimer = self.animateTimer + dt
    if self.animateTimer > 0.1 then
        self:alternateSprite()
        self.animateTimer = 0
    end
end

function Dingo:render()
    love.graphics.draw(self.currentImg, self.x, self.y, 0, self.scale, self.scale)
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