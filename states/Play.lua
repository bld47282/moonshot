Play = Class{__includes = Default}

current = 1
begunLevel = false

function Play:init()
    pull = true
    won = false
    lost = false
    nextLevel = false
    begunLevel = false
    countdownStart = 3
    currentLevel = Level01(current)
end

function Play:update(dt)
    if begunLevel == true then
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
    elseif begunLevel == false and countdownStart < 0 then
        begunLevel = love.keyboard.isDown('return')
    else
        countdownStart = countdownStart - dt
    end
end

function Play:render()
    if begunLevel == true then
        currentLevel:render()
        love.graphics.setColor(0,0,0)
        love.graphics.print(string.format("Time: %.2f", time), 10, 35)
        love.graphics.setColor(1,1,1)
        
        -- if paused
        if paused then
            love.graphics.setColor(0,0,0)
            love.graphics.print('- paused -', windowWidth / 2, windowHeight / 2)
            love.graphics.setColor(1,1,1)
        end
    else
        love.graphics.setColor(1,1,1)
        love.graphics.print(string.format("Next level: %d", current), windowWidth / 2, windowHeight / 2)
        if countdownStart > 0 then
            love.graphics.print(string.format("Start in: %d", countdownStart + 1), (windowWidth / 2), (windowHeight / 2) - 50)
        else
            love.graphics.print("Press enter", (windowWidth / 2), (windowHeight / 2) - 50)
        end
        love.graphics.setColor(0,0,0)
    end
end