local composer = require('composer')

-- local testao = {}

-- local teste = function () print("teste") end

-- testao.teste = teste

-- testao.teste()

local options = {params = {  }}

composer.gotoScene('menu')

-- local physics = require('physics')
-- physics.start()

-- system.activate('multitouch')

-- local points = 36
-- local actualOperation = 'plus'

-- local background = display.newImageRect("background.png",display.contentWidth,display.contentHeight)
-- background.x = display.contentCenterX
-- background.y = display.contentCenterY

-- local invisibleFireButton = display.newRect(display.contentCenterX, display.contentCenterY-50, display.contentWidth, display.contentHeight-100)
-- invisibleFireButton.alpha = 0
-- invisibleFireButton.isHitTestable = true
-- invisibleFireButton.name = 'fireButton'

-- local invisibleLeftButton = display.newRect(display.contentCenterX*0.5, display.contentHeight -50, display.contentWidth *0.5, 100)
-- invisibleLeftButton.alpha = 0
-- invisibleLeftButton.isHitTestable = true
-- invisibleLeftButton.name = 'leftButton'
-- -- invisibleLeftButton:setFillColor(1,0,0)

-- local invisibleRightButton = display.newRect(display.contentCenterX*0.5 + display.contentCenterX, display.contentHeight -50, display.contentWidth *0.5, 100)
-- invisibleRightButton.alpha = 0
-- invisibleRightButton.isHitTestable = true
-- invisibleRightButton.name = 'rightButton'

-- local leftLimit = display.newRect(0, display.contentHeight-50, 1, 100)
-- physics.addBody(leftLimit, 'static', {bounce = 0})

-- local rightLimit = display.newRect(display.contentWidth, display.contentHeight-50, 1, 100)
-- physics.addBody(rightLimit, 'static', {bounce = 0})

-- local leftWall = display.newRect(0, display.contentCenterY, 1, display.contentHeight)
-- physics.addBody(leftWall, 'static', {isSensor = true})
-- leftWall.name = 'left'

-- local rightWall = display.newRect(display.contentWidth, display.contentCenterY, 1, display.contentHeight)
-- physics.addBody(rightWall, 'static', {isSensor = true}) 
-- rightWall.name = 'right'

-- local pointsDisplay = display.newText({
--     text = points, 
--     x = display.contentCenterX, 
--     y = 50, 
--     -- width = 128,
--     font = native.systemFont,   
--     fontSize = 48,
--     align = "right"})

-- local playerShip = display.newPolygon(display.contentWidth * 0.5, display.contentHeight -30, {-10,0, 10,0, 0,-30})
-- playerShip:setFillColor(0,0,0)
-- physics.addBody(playerShip, 'dynamic', {bounce = 0  })
-- playerShip.gravityScale = 0
-- playerShip.name = 'player'

-- local groupShips = display.newGroup()
-- groupShips.x = 0
-- groupShips.name = 'group'
-- groupShips.gravityScale = 0

-- local ship = {}
-- local shipsNumber = 6

-- function startShips()
--     ship[1] = display.newRect(groupShips.x + 20*1, 5, 10, 10)
--     ship[2] = display.newRect(groupShips.x + 20*2, 5, 10, 10)
--     ship[3] = display.newRect(groupShips.x + 20*3, 5, 10, 10)
--     ship[4] = display.newRect(groupShips.x + 20*4, 5, 10, 10)
--     ship[5] = display.newRect(groupShips.x + 20*5, 5, 10, 10)
--     ship[6] = display.newRect(groupShips.x + 20*6, 5, 10, 10)
-- end

-- function startShipsTest(lines)
--     for i=1, lines do
--         for j=1, lines do
--             print(j+i)
--             local shipToInsert = display.newRect(groupShips.x + 20*j, 15*i, 10, 10)
--             shipToInsert:setFillColor(0, 0.16*j,0)
--             shipToInsert.points = j*i
--             table.insert(ship,shipToInsert)
--         end
--     end
-- end

-- startShipsTest(6)

-- for k,v in pairs(ship) do
--     print(k, v)
--     v.name = 'ship'
--     groupShips:insert(v)
--     physics.addBody( v, "dynamic", {isSensor = true})
--     v.gravityScale = 0
-- end

-- function toLeft()
--     -- transition.to( groupShips, { time=4000, x=(0), onComplete=toRight})
--     for k,v in pairs(ship) do
--         v:applyLinearImpulse(0.005, 0, ship[1].x, ship[1].y)
--     end
-- end

-- rightest = display.contentWidth-ship[shipsNumber].x-ship[shipsNumber].width
-- linearVelocity = 0.005
-- function toRight()

--     -- transition.to( groupShips, { time=4000, x=rightest, onComplete=toLeft})
--     for k,v in pairs(ship) do
--         v:applyLinearImpulse(linearVelocity, 0, v.x, v.y)
--     end
-- end

-- function invertLinearVelocity(event)
--     if(event.phase=='began') then
--         if event.target.name == 'left' and linearVelocity == -0.005 then
--             linearVelocity = linearVelocity*-1
--             for k,v in pairs(ship) do
--                 -- print('esquerda')
--                 if v.isBodyActive then
--                     v:setLinearVelocity(0, 0)
--                     v:applyLinearImpulse(linearVelocity, 0.00005, v.x, v.y)
--                 end
--             end
--         elseif event.target.name == 'right' and linearVelocity == 0.005 then
--             linearVelocity = linearVelocity*-1
--             for k,v in pairs(ship) do
--                 -- print('direita')
--                 if v.isBodyActive then
--                     v:setLinearVelocity(0, 0)
--                     v:applyLinearImpulse(linearVelocity, 0.00005, v.x, v.y)
--                 end
--             end
--         end
--     end
-- end

-- toRight()

-- function operation(shipPoints)
--     if actualOperation == 'mult' then

--     elseif actualOperation == 'plus' then
--         points = points - shipPoints
--         if points < 0 then
--             pointsDisplay:setFillColor(1,0,0)
--             -- physics.stop()
--         else
--             pointsDisplay.text = points
--         end

--     elseif actualOperation == 'min' then
--     end
-- end

-- function shipHit(event)
--     if(event.phase == 'began' and event.other.name=='ship') then
--         print('collision')
--         operation(event.other.points)
--         event.target:removeSelf()
--         event.target = nil
--         event.other:removeSelf()
--         event.other = nil
--     end
-- end

-- function movePlayerShip(event)
--     if event.target.name == "rightButton" then
--         if event.phase == "began" then
--             playerShip:applyLinearImpulse(0.05, 0, playerShip.x, playerShip.y)
--         elseif event.phase == "moved" then
--         elseif event.phase == "ended" or event.phase == "cancelled" then
--             playerShip:setLinearVelocity(0,0)
--         end
--     elseif event.target.name == "leftButton" then
--         if event.phase == "began" then
--             playerShip:applyLinearImpulse(-0.05, 0, playerShip.x, playerShip.y)
--         elseif event.phase == "moved" then
--         elseif event.phase == "ended" or event.phase == "cancelled" then
--             playerShip:setLinearVelocity(0,0)
--         end
--     end
-- end

-- function createProjectile(event)
--     if event.phase == 'began' then
--         projectile = display.newRect(playerShip.x, display.contentHeight-45, 5,5)
--         physics.addBody( projectile, "dynamic")
--         projectile.gravityScale = 0
--         projectile:applyLinearImpulse(0, -0.005, projectile.x, projectile.y)
--         projectile:addEventListener("collision", shipHit)
--     end
-- end

-- -- usar para não ter aceleração contínua
-- playerShip.direction = ''

-- function moveDirectional( event )
--     if event.phase == 'began' then
--         if reference ~= nil then
--             reference:removeSelf()
--             reference = nil
--         end

--         reference = display.newRect(event.xStart, event.yStart, 5, 5)
--     elseif event.phase == 'moved' then
--         if event.x > event.xStart and (playerShip.direction ~= 'right' or playerShip:getLinearVelocity() == 0) then
--             print('right')
--             playerShip.direction = 'right'
--             playerShip:setLinearVelocity(0,0)
--             playerShip:applyLinearImpulse(0.05, 0, playerShip.x, playerShip.y)
--         elseif event.x < event.xStart and (playerShip.direction ~= 'left' or playerShip:getLinearVelocity() == 0) then
--             print('left')
--             playerShip.direction = 'left'
--             playerShip:setLinearVelocity(0,0)
--             playerShip:applyLinearImpulse(-0.05, 0, playerShip.x, playerShip.y)
--         end
--     elseif event.phase == 'ended' or event.phase == 'cancelled' then
--         print('end')
--         playerShip:setLinearVelocity(0,0)
--         if reference ~= nil then
--             reference:removeSelf()
--             reference = nil
--         end
--     end
-- end

-- invisibleFireButton:addEventListener("touch", createProjectile)
-- leftWall:addEventListener("collision", invertLinearVelocity)
-- rightWall:addEventListener("collision", invertLinearVelocity)
-- -- invisibleLeftButton:addEventListener("touch", movePlayerShip)
-- -- invisibleRightButton:addEventListener("touch", movePlayerShip)
-- invisibleLeftButton:addEventListener("touch", moveDirectional)
-- invisibleRightButton:addEventListener("touch", moveDirectional)


