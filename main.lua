-- Global variables

debug = true
paused = false
spacePressed = false

-- Load classes

Class = require 'class'
require 'classes/GroundSect'
require 'classes/Moon'
require 'classes/Wolf'

-- Load states

require 'state'
require 'states/Default'
require 'states/Play'
require 'states/Title'

-- Global images

background = love.graphics.newImage("graphics/backdrop_01_default_01.png")

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
    }
    StateMachine:change('Title')
end

function love.update(dt, groundSects)
    StateMachine:update(dt)
end

function love.draw(dt)
    StateMachine:render()
end
