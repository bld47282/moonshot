Level01 = Class{}

function Level01:init(levelNumber)
    if levelNumber == 2 then
        pull = true
        won = false
        lost = false

        self.world = bump.newWorld(10)

        self.dingo = Dingo()
        print(self.dingo.x)
        print(self.dingo.y)

        self.world:add(self.dingo, self.dingo.x, self.dingo.y, self.dingo.currentImg:getWidth() * self.dingo.scale, self.dingo.currentImg:getHeight() * self.dingo.scale)

        self.moon = Moon()
        
        self.water = Water(620)

        self.platform = Platform(800, 350)
        self.world:add(self.platform, self.platform.x, self.platform.y, self.platform.platformImg:getWidth() * self.platform.scale, self.platform.platformImg:getHeight() * self.platform.scale)

        self.groundSects = {}
        for x=0,23 do
            if x ~= 7 and x ~= 8 then
                self.groundSects[x] = GroundSect(1280 - (x * 55.4), 720 - 200, self:randomGroundImg(), self.randomTopImg())
                self.world:add(self.groundSects[x], self.groundSects[x].x, self.groundSects[x].y, self.groundSects[x].groundImg:getWidth() * self.groundSects[x].scale, self.groundSects[x].groundImg:getHeight() * self.groundSects[x].scale)
            end
        end
    elseif levelNumber == 1 then
        pull = true
        won = false
        lost = false

        self.world = bump.newWorld(10)

        self.dingo = Dingo()
        print(self.dingo.x)
        print(self.dingo.y)
        self.world:add(self.dingo, self.dingo.x, self.dingo.y, self.dingo.currentImg:getWidth() * self.dingo.scale, self.dingo.currentImg:getHeight() * self.dingo.scale)

        self.moon = Moon()
        
        self.water = Water(620)

        self.platform = Platform(8000, 3500)
        self.world:add(self.platform, self.platform.x, self.platform.y, self.platform.platformImg:getWidth() * self.platform.scale, self.platform.platformImg:getHeight() * self.platform.scale)


        self.groundSects = {}
        for x=0,23 do
            self.groundSects[x] = GroundSect(1280 - (x * 55.4), 720 - 200, self:randomGroundImg(), self.randomTopImg())
            self.world:add(self.groundSects[x], self.groundSects[x].x, self.groundSects[x].y, self.groundSects[x].groundImg:getWidth() * self.groundSects[x].scale, self.groundSects[x].groundImg:getHeight() * self.groundSects[x].scale)
        end
    end
end

function Level01:update(dt)
    -- victory/loss checking
    if won and not howl:isPlaying() then
        nextLevel = true
    elseif lost and not howl:isPlaying() then
        StateMachine:change('Loss')
    end

    if not paused then
        if not won and not lost then
            self.moon:update(dt)
            self.water:update(dt)
            self.platform:update(dt)
            for k in pairs(self.groundSects) do
                self.groundSects[k]:update(dt, self.moon.x)
                self.world:update(self.groundSects[k], self.groundSects[k].x, self.groundSects[k].y, self.groundSects[k].groundImg:getWidth() * self.groundSects[k].scale, self.groundSects[k].groundImg:getHeight()* self.groundSects[k].scale)
            end
            self.dingo:update(dt, self. water, self.world)
        end
    end
end

function Level01:render()
    love.graphics.draw(background, 0, 0, 0, 1, 1)
    self.moon:render()
    for k in pairs(self.groundSects) do
        self.groundSects[k]:render()
    end
    self.platform:render()
    self.dingo:render()
    self.water:render()
end

function Level01:randomGroundImg()
    local randomNumber = math.random(0, 9)
    if randomNumber == 0 then 
        return love.graphics.newImage('graphics/level01/pillar_01_01.png')
    elseif randomNumber == 1 then 
        return love.graphics.newImage('graphics/level01/pillar_01_02.png')
    elseif randomNumber == 2 then 
        return love.graphics.newImage('graphics/level01/pillar_01_03.png')
    elseif randomNumber == 3 then 
        return love.graphics.newImage('graphics/level01/pillar_01_04.png')
    elseif randomNumber == 4 then 
        return love.graphics.newImage('graphics/level01/pillar_01_05.png')
    elseif randomNumber == 5 then 
        return love.graphics.newImage('graphics/level01/pillar_01_06.png')
    elseif randomNumber == 6 then 
        return love.graphics.newImage('graphics/level01/pillar_01_07.png')
    elseif randomNumber == 7 then 
        return love.graphics.newImage('graphics/level01/pillar_01_08.png')
    elseif randomNumber == 8 then 
        return love.graphics.newImage('graphics/level01/pillar_01_09.png')
    elseif randomNumber == 9 then 
        return love.graphics.newImage('graphics/level01/pillar_01_10.png')
    end
    return groundImages[math.random(0, 9)]
end

function Level01:randomTopImg()
    local randomNumber = math.random(0, 6)
    if randomNumber == 0 then 
        return love.graphics.newImage('graphics/level01/pillar_top_01_01.png')
    elseif randomNumber == 1 then 
        return love.graphics.newImage('graphics/level01/pillar_top_01_02.png')
    elseif randomNumber == 2 then 
        return love.graphics.newImage('graphics/level01/pillar_top_01_03.png')
    elseif randomNumber == 3 then 
        return love.graphics.newImage('graphics/level01/pillar_top_01_04.png')
    elseif randomNumber == 4 then 
        return love.graphics.newImage('graphics/level01/pillar_top_01_05.png')
    elseif randomNumber == 5 then 
        return love.graphics.newImage('graphics/level01/pillar_top_01_06.png')
    elseif randomNumber == 6 then 
        return love.graphics.newImage('graphics/level01/pillar_top_01_07.png')
    end
end