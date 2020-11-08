-- Load libraries

bump = require 'libraries/bump/bump'
Class = require 'libraries/hump/class'

-- Global variables

debug = true
paused = false
spacePressed = false

-- Load classes

require 'classes/GroundSect'
require 'classes/Moon'
require 'classes/Dingo'
require 'classes/Water'
require 'classes/Platform'

-- Load levels

require 'levels/Level01'

-- Load states

require 'state'
require 'states/Default'
require 'states/Play'
require 'states/Title'
require 'states/Loss'

-- Global images

background = love.graphics.newImage("graphics/global/backdrop_01_default_01.png")

-- Global sounds

music = love.audio.newSource("sounds/david_mumford-twinkle_twinkle.mp3", "stream")
jump8 = love.audio.newSource("sounds/Jump8.wav", "static")
jump9 = love.audio.newSource("sounds/Jump9.wav", "static")
howl = love.audio.newSource("sounds/wolf7.mp3", "static")

function love.load()
    windowHeight = 720
    windowWidth = 1280

    music:play()
    
    StateMachine = state {
        ['Title'] = function() return Title() end,
        ['Play'] = function() return Play() end,
        ['Loss'] = function() return Loss() end,
    }
    StateMachine:change('Title')
end

function love.update(dt)
    StateMachine:update(dt)
end

function love.draw(dt)
    StateMachine:render()
end
