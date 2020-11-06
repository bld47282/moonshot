Play = Class{__includes = Default}

function Play:init()
    self.wolf = Wolf()
    self.moon = Moon()
    self.groundSects = {}
    self.water = Water(620)

    for x=0,23 do
        self.groundSects[x] = GroundSect(1280 - (x * 55.4), 720 - 200)
    end
end

function Play:update(dt)
    if not paused then
        self.moon:update(dt)
        self.water:update(dt)
        for x=0,#self.groundSects do
            self.groundSects[x]:update(dt, self.moon.x)
        end
        self.wolf:update(dt, self.groundSects)
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
end

function Play:render()
    love.graphics.draw(background, 0, 0, 0, 1, 1)
    self.moon:render()
    for x=0,#self.groundSects do
        self.groundSects[x]:render()
    end
    self.wolf:render()
    self.water:render()
    
    -- if paused
    if paused then
        love.graphics.print('- paused -', windowWidth / 2, windowHeight / 2)
    end
end