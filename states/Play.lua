Play = Class{__includes = Default}

pull = true
won = false
lost = false

function Play:init()
    self.wolf = Wolf()
    self.moon = Moon()
    self.groundSects = {}

    for x=0,23 do
        self.groundSects[x] = GroundSect(1280 - (x * 55.4), 720 - 50)
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
        self.moon:update(dt)
        for x=0,#self.groundSects do
            self.groundSects[x]:update(dt, self.moon.x)
        end
        if not won and not lost then
            self.wolf:update(dt, self.groundSects)
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
    self.wolf:render()
    
    -- if paused
    if paused then
        love.graphics.print('- paused -', windowWidth / 2, windowHeight / 2)
    end
end