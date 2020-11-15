Title = Class{__includes = Default}

function Title:init()
    won = false
    lost = false
end

function Title:update(dt, groundSects)
    if love.keyboard.isDown('return') then
        StateMachine:change('Play')
    end
end

function Title:render()
    love.graphics.setFont(bigFont)
    love.graphics.print('Howl', windowWidth / 2, windowHeight / 2)
    love.graphics.setFont(font)
    love.graphics.print('Press Enter', windowWidth / 2, (windowHeight / 2) + 100)
end