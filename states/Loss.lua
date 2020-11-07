Loss = Class{__includes = Default}

function Loss:update(dt, groundSects)
    if love.keyboard.isDown('return') then
        current = 1
        StateMachine:change('Title')
    end
end

function Loss:render()
    love.graphics.print('- you lose :( -', windowWidth / 2, windowHeight / 2)
    love.graphics.print('- press enter -', windowWidth / 2, (windowHeight / 2) + 100)
end