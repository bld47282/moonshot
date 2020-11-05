Title = Class{__includes = Default}

function Title:update(dt, groundSects)
    if love.keyboard.isDown('return') then
        StateMachine:change('Play')
    end
end

function Title:render()
    love.graphics.print('Moonshot', windowWidth / 2, windowHeight / 2)
    love.graphics.print('Press Enter', windowWidth / 2, (windowHeight / 2) + 100)
end