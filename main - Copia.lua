local physics = require('physics')
physics.start()

local tapCount = 0

local background = display.newImageRect("background.png",display.contentWidth,display.contentHeight)
background.x = display.contentCenterX
background.y = display.contentCenterY

local topWall = display.newRect(display.contentCenterX, 1, 0, 1)
physics.addBody( topWall, "static")
topWall.points = 10

local groupShips = display.newGroup()
-- groupShips.x = 0
-- groupShips.y = 50
-- groupShips.width = display.contentWidth*0.6
-- groupShips.height = 10
-- groupShips.anchorX = 0
-- groupShips.anchorY = 0
groupShips.anchorChildren = true
local ships = display.newRect(groupShips, groupShips.x,groupShips.y,display.contentWidth*0.6,10)

-- print('ships.width>>>>>>>>>>>>>',ships.width)
-- print('groupShips.width>>>>>>>>>>>>>',groupShips.width)
-- print('display.contentWidth>>>>>>>>>>>>>',display.contentWidth)





ships.alpha=0
local ships1 = {}
ships1.ship1A = display.newRect(240, groupShips.y, groupShips.width*0.16, 10)
ships1.ship1B = display.newRect(groupShips, (ships1.ship1A.x + ships1.ship1A.width +10 ), groupShips.y+10, groupShips.width*0.16, 10)

print(groupShips.x)
print(groupShips.y)
print(groupShips.width)
print(groupShips.height)
print(groupShips.anchorX)
print(groupShips.anchorY)
print(groupShips.anchorChildren)

-- print('groupShips.width++++++++++++++++',ships1.ship1A.x)

function leftestShip(shipsToCheck)
    local leftestX
    for key,value in pairs(shipsToCheck) do
    -- print('loop')
        if leftestX == nil then
            leftestX = value.x
        elseif value.x<leftestX then
            leftestShip = value.x
        end
    end 
    if leftestX == nil then
            return 0
        else
            return leftestX
    end
end

-- print('leftest>>>>>>>>>>',leftestShip(ships1))



ships1.ship1A:setFillColor( 0, 0, 0 )

function shipToLeft(obj)
-- print('ships.width>>>>>>>>>>>>>',ships.width)
-- print('groupShips.width>>>>>>>>>>>>>',groupShips.width)
-- print('display.contentWidth>>>>>>>>>>>>>',display.contentWidth)
-- -- print('groupShips.x> ', groupShips.x)
-- -- print('groupShips.width> ', groupShips.width)
transition.to( groupShips, { time=1000, x=(0), onComplete=shipToRight})
end

function shipToRight(obj)
-- print('ships.width>>>>>>>>>>>>>',ships.width)
-- print('groupShips.width>>>>>>>>>>>>>',groupShips.width)
-- print('display.contentWidth>>>>>>>>>>>>>',display.contentWidth)
-- -- print('groupShips.x> ', groupShips.x)
-- -- print('groupShips.width> ', groupShips.width)
transition.to( groupShips, { time=1000, x=(display.contentWidth - groupShips.width), onComplete=shipToLeft})
end
-- shipToLeft()

local tapText = display.newText(tapCount, display.contentCenterX, 20, native.systemFont, 40)
tapText:setFillColor( 0, 0, 0 )

local platform = display.newImageRect( "platform.png", 300, 50 )
platform.x = display.contentCenterX
platform.y = display.contentHeight-25
platform.points = 1

local balloon = display.newImageRect( "balloon.png", 112, 112 )
balloon.x = display.contentCenterX
balloon.y = display.contentCenterY
balloon.alpha = 0.8
balloon.points = 25

physics.addBody( platform, "static" )
physics.addBody( balloon, "dynamic", { radius=50, bounce=0.3 } )

local function createBalloonOnTap(event)
    if event.phase == "began" then
        -- print('event.x> ', event.x)
        local balloon = display.newImageRect( "balloon.png", 112, 112 )
        balloon.x = event.x
        balloon.y = event.y
        balloon.alpha = 0.8
        balloon.points = 25
        physics.addBody( balloon, "dynamic", { radius=50, bounce=0.3 } )
        balloon.gravityScale = 0
        balloon:applyLinearImpulse(0, -0.75, balloon.x, balloon.y)
        balloon:addEventListener( "collision", changeDirection )
    end
end

local function pushBalloon(event)
    if event.x >= balloon.x then
    balloon:applyLinearImpulse(0, -0.75, balloon.x, balloon.y)
    
    -- tapCount=tapCount+1
    -- tapText.text=tapCount
    end
    if event.x < balloon.x then
    balloon:applyLinearImpulse(0, -0.75, balloon.x, balloon.y)
    
    -- tapCount=tapCount+1
    -- tapText.text=tapCount
    end
end

local function inversePushBalloon(event)
    if event.x >= balloon.x then
    balloon:applyLinearImpulse(0, 0.75, balloon.x, balloon.y)
    
    -- tapCount=tapCount+1
    -- tapText.text=tapCount
    end
    if event.x < balloon.x then
    balloon:applyLinearImpulse(0, 0.75, balloon.x, balloon.y)
    
    -- tapCount=tapCount+1
    -- tapText.text=tapCount
    end
end

function changeDirection(event)
    -- print('collision')
    if event.phase == "ended" and (event.other == platform or event.other == topWall) then
        tapCount = tapCount + event.other.points
        tapText.text=tapCount
        -- platform:removeSelf()
        event.target:removeSelf()
    end
end

local function printTouch(event)


     if ( event.phase == "began" ) then
        display.getCurrentStage():setFocus( event.target )
        event.target.isFocus = true
        -- print('began')
        touchJoint = physics.newJoint( "touch", event.target, event.target.x, event.target.y )
    elseif ( event.phase == "moved" ) then

        touchJoint:setTarget(event.x,event.y)
    elseif ( event.phase == "ended" or event.phase == "cancelled") then
        -- print('ended')

        -- for key, value in pairs(display.getCurrentStage()) do
        -- --     print(key, value)
        -- end
        touchJoint:removeSelf()
        return
    end
    return true
    
    
    
end

balloon:addEventListener("collision", changeDirection)
-- balloon:addEventListener( "touch", printTouch )
-- platform:addEventListener( "touch", printTouch )
background:addEventListener("touch", createBalloonOnTap)
