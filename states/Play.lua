Play = Class{__includes = Default}

current = 1

function Play:init()
    pull = true
    won = false
    lost = false
    nextLevel = false
    currentLevel = Level01(current)
end

function Play:update(dt)
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

    if not paused then
        currentLevel:update(dt)
    end

    if nextLevel == true then
        nextLevel = false
        current = current + 1
        self:init(current)
    end
    
end

function Play:render()
    currentLevel:render()
    
    -- if paused
    if paused then
        love.graphics.print('- paused -', windowWidth / 2, windowHeight / 2)
    end
end