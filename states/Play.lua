Play = Class{__includes = Default}

pull = true
won = false
lost = false

function Play:init()
    self.world = bump.newWorld(50)

    self.dingo = Dingo()
    self.world:add(self.dingo, self.dingo.x, self.dingo.y, self.dingo.currentImg:getWidth() * self.dingo.scale, self.dingo.currentImg:getHeight() * self.dingo.scale)

    self.moon = Moon()
    self.groundSects = {}
    self.water = Water(620)
    self.platform = Platform(800, 450)
    self.world:add(self.platform, self.platform.x, self.platform.y, self.platform.platformImg:getWidth() * self.platform.scale, self.platform.platformImg:getHeight() * self.platform.scale)

    for x=0,23 do
        self.groundSects[x] = GroundSect(1280 - (x * 55.4), 720 - 200)
        self.world:add(self.groundSects[x], self.groundSects[x].x, self.groundSects[x].y, self.groundSects[x].groundImg:getWidth() * self.groundSects[x].scale, self.groundSects[x].groundImg:getHeight() * self.groundSects[x].scale)
    end
end

function Play:update(dt)
    -- victory/loss checking
    if won and not howl:isPlaying() then
        StateMachine:change('Title')
    elseif lost and not howl:isPlaying() then
        StateMachine:change('Loss')
    end

    if not paused then
        if not won and not lost then
            self.moon:update(dt)
            self.water:update(dt)
            self.platform:update(dt)
            for x=0,#self.groundSects do
                self.groundSects[x]:update(dt, self.moon.x)
                self.world:update(self.groundSects[x], self.groundSects[x].x, self.groundSects[x].y, self.groundSects[x].groundImg:getWidth(), self.groundSects[x].groundImg:getHeight())
            end
            self.dingo:update(dt, self. water, self.world)
        end
    end

    -- pause checking
    if spacePressed == false and love.keyboard.isDown("space") then
        if paused then
            music:play()
        else
            music:pause()
        end
        paused = not paused
        spacePressed = true
    elseif not love.keyboard.isDown("space") then
        spacePressed = false
    end

    -- pull/push checking
    if zPressed == false and love.keyboard.isDown("z") then
        pull = not pull
        zPressed = true
    elseif not love.keyboard.isDown("z") then
        zPressed = false
    end
end

function Play:render()
    love.graphics.draw(background, 0, 0, 0, 1, 1)
    self.moon:render()
    for x=0,#self.groundSects do
        self.groundSects[x]:render()
    end
    self.dingo:render()
    self.water:render()
    self.platform:render()
    
    -- if paused
    if paused then
        love.graphics.print('- paused -', windowWidth / 2, windowHeight / 2)
    end
end