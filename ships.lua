local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 

local ship = {}
function returnToMenu(event)
    print('return to menu')
    if event.phase == 'began' then
        -- for k,v in pairs(ship) do
        --     v:setLinearVelocity(0,0)
        -- end
        -- composer.removeScene('ships', true)
        -- composer.gotoScene('menu')
        local options = {
            effect = "fade",
            time = 500,
            isModal = true
        }
        composer.gotoScene( "menu", options )
    end
end
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
 
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        local physics = require('physics')
        physics.start()

        composer.removeHidden() 

        system.activate('multitouch')

        local points = 36
        local actualOperation = 'plus'

        local background = display.newImageRect("background.png",display.contentWidth,display.contentHeight)
        self.view:insert(background)
        background.x = display.contentCenterX
        background.y = display.contentCenterY

        local invisibleFireButton = display.newRect(display.contentCenterX, display.contentCenterY-50, display.contentWidth, display.contentHeight-100)
        self.view:insert(invisibleFireButton)
        invisibleFireButton.alpha = 0
        invisibleFireButton.isHitTestable = true
        invisibleFireButton.name = 'fireButton'

        local invisibleLeftButton = display.newRect(display.contentCenterX*0.5, display.contentHeight -50, display.contentWidth *0.5, 100)
        self.view:insert(invisibleLeftButton)
        invisibleLeftButton.alpha = 0
        invisibleLeftButton.isHitTestable = true
        invisibleLeftButton.name = 'leftButton'
        -- invisibleLeftButton:setFillColor(1,0,0)

        local invisibleRightButton = display.newRect(display.contentCenterX*0.5 + display.contentCenterX, display.contentHeight -50, display.contentWidth *0.5, 100)
        self.view:insert(invisibleRightButton)
        invisibleRightButton.alpha = 0
        invisibleRightButton.isHitTestable = true
        invisibleRightButton.name = 'rightButton'

        local leftLimit = display.newRect(0, display.contentHeight-50, 1, 100)
        self.view:insert(leftLimit)
        physics.addBody(leftLimit, 'static', {bounce = 0})

        local rightLimit = display.newRect(display.contentWidth, display.contentHeight-50, 1, 100)
        self.view:insert(rightLimit)
        physics.addBody(rightLimit, 'static', {bounce = 0})

        local leftWall = display.newRect(0, display.contentCenterY, 1, display.contentHeight)
        self.view:insert(leftWall)
        physics.addBody(leftWall, 'static', {isSensor = true})
        leftWall.name = 'left'

        local rightWall = display.newRect(display.contentWidth, display.contentCenterY, 1, display.contentHeight)
        self.view:insert(rightWall)
        physics.addBody(rightWall, 'static', {isSensor = true}) 
        rightWall.name = 'right'

        local invisibleMenuButton = display.newRect(display.contentWidth - 30, 30, 50, 50)
        self.view:insert(invisibleMenuButton)
        invisibleMenuButton:setFillColor(0,0,1)

        local pointsDisplay = display.newText({
            text = points, 
            x = display.contentCenterX, 
            y = 50, 
            -- width = 128,
            font = native.systemFont,   
            fontSize = 48,
            align = "right"})
        self.view:insert(pointsDisplay)

        local playerShip = display.newPolygon(display.contentWidth * 0.5, display.contentHeight -30, {-10,0, 10,0, 0,-30})
        self.view:insert(playerShip)
        playerShip:setFillColor(0,0,0)
        physics.addBody(playerShip, 'dynamic', {bounce = 0  })
        playerShip.gravityScale = 0
        playerShip.name = 'player'

        local groupShips = display.newGroup()
        self.view:insert(groupShips)
        groupShips.x = 0
        groupShips.name = 'group'
        groupShips.gravityScale = 0

        
        local shipsNumber = 6

        function startShips()
            ship[1] = display.newRect(groupShips.x + 20*1, 5, 10, 10)
            self.view:insert(1)
            ship[2] = display.newRect(groupShips.x + 20*2, 5, 10, 10)
            self.view:insert(2)
            ship[3] = display.newRect(groupShips.x + 20*3, 5, 10, 10)
            self.view:insert(3)
            ship[4] = display.newRect(groupShips.x + 20*4, 5, 10, 10)
            self.view:insert(4)
            ship[5] = display.newRect(groupShips.x + 20*5, 5, 10, 10)
            self.view:insert(5)
            ship[6] = display.newRect(groupShips.x + 20*6, 5, 10, 10)
            self.view:insert(6)
        end

        function startShipsTest(lines)
            for i=1, lines do
                for j=1, lines do
                    print(j+i)
                    local shipToInsert = display.newRect(groupShips.x + 20*j, 15*i, 10, 10)
                    shipToInsert:setFillColor(0, 0.16*j,0)
                    shipToInsert.points = j*i
                    table.insert(ship,shipToInsert)
                end
            end
        end

        startShipsTest(6)

        for k,v in pairs(ship) do
            print(k, v)
            v.name = 'ship'
            self.view:insert(v)
            physics.addBody( v, "dynamic", {isSensor = true})
            v.gravityScale = 0
        end

        function toLeft()
            -- transition.to( groupShips, { time=4000, x=(0), onComplete=toRight})
            for k,v in pairs(ship) do
                v:applyLinearImpulse(0.005, 0, ship[1].x, ship[1].y)
            end
        end

        rightest = display.contentWidth-ship[shipsNumber].x-ship[shipsNumber].width
        linearVelocity = 0.005
        function toRight()

            -- transition.to( groupShips, { time=4000, x=rightest, onComplete=toLeft})
            for k,v in pairs(ship) do
                v:applyLinearImpulse(linearVelocity, 0, v.x, v.y)
            end
        end

        function invertLinearVelocity(event)
            if(event.phase=='began') then
                if event.target.name == 'left' and linearVelocity == -0.005 then
                    linearVelocity = linearVelocity*-1
                    for k,v in pairs(ship) do
                        -- print('esquerda')
                        if v.isBodyActive then
                            v:setLinearVelocity(0, 0)
                            v:applyLinearImpulse(linearVelocity, 0.00005, v.x, v.y)
                        end
                    end
                elseif event.target.name == 'right' and linearVelocity == 0.005 then
                    linearVelocity = linearVelocity*-1
                    for k,v in pairs(ship) do
                        -- print('direita')
                        if v.isBodyActive then
                            v:setLinearVelocity(0, 0)
                            v:applyLinearImpulse(linearVelocity, 0.00005, v.x, v.y)
                        end
                    end
                end
            end
        end

        toRight()

        function operation(shipPoints)
            if actualOperation == 'mult' then

            elseif actualOperation == 'plus' then
                points = points - shipPoints
                if points < 0 then
                    pointsDisplay:setFillColor(1,0,0)
                    -- physics.stop()
                else
                    pointsDisplay.text = points
                end

            elseif actualOperation == 'min' then
            end
        end

        function shipHit(event)
            if(event.phase == 'began' and event.other.name=='ship') then
                print('collision')
                operation(event.other.points)
                event.target:removeSelf()
                event.target = nil
                event.other:removeSelf()
                event.other = nil
            end
        end

        function movePlayerShip(event)
            if event.target.name == "rightButton" then
                if event.phase == "began" then
                    playerShip:applyLinearImpulse(0.05, 0, playerShip.x, playerShip.y)
                elseif event.phase == "moved" then
                elseif event.phase == "ended" or event.phase == "cancelled" then
                    playerShip:setLinearVelocity(0,0)
                end
            elseif event.target.name == "leftButton" then
                if event.phase == "began" then
                    playerShip:applyLinearImpulse(-0.05, 0, playerShip.x, playerShip.y)
                elseif event.phase == "moved" then
                elseif event.phase == "ended" or event.phase == "cancelled" then
                    playerShip:setLinearVelocity(0,0)
                end
            end
        end

        function createProjectile(event)
            if event.phase == 'began' then
                projectile = display.newRect(playerShip.x, display.contentHeight-45, 5,5)
                self.view:insert(projectile)
                physics.addBody( projectile, "dynamic")
                projectile.gravityScale = 0
                projectile:applyLinearImpulse(0, -0.005, projectile.x, projectile.y)
                projectile:addEventListener("collision", shipHit)
            end
        end

        -- usar para não ter aceleração contínua
        playerShip.direction = ''

        function moveDirectional( event )
            if event.phase == 'began' then
                if reference ~= nil then
                    reference:removeSelf()
                    reference = nil
                end

                reference = display.newRect(event.xStart, event.yStart, 5, 5)
                self.view:insert(reference)
            elseif event.phase == 'moved' then
                if event.x > event.xStart and (playerShip.direction ~= 'right' or playerShip:getLinearVelocity() == 0) then
                    print('right')
                    playerShip.direction = 'right'
                    playerShip:setLinearVelocity(0,0)
                    playerShip:applyLinearImpulse(0.05, 0, playerShip.x, playerShip.y)
                elseif event.x < event.xStart and (playerShip.direction ~= 'left' or playerShip:getLinearVelocity() == 0) then
                    print('left')
                    playerShip.direction = 'left'
                    playerShip:setLinearVelocity(0,0)
                    playerShip:applyLinearImpulse(-0.05, 0, playerShip.x, playerShip.y)
                end
            elseif event.phase == 'ended' or event.phase == 'cancelled' then
                print('end')
                playerShip:setLinearVelocity(0,0)
                if reference ~= nil then
                    reference:removeSelf()
                    reference = nil
                end
            end
        end

        -- invisibleFireButton:addEventListener("touch", createProjectile)
        leftWall:addEventListener("collision", invertLinearVelocity)
        rightWall:addEventListener("collision", invertLinearVelocity)
        -- invisibleLeftButton:addEventListener("touch", movePlayerShip)
        -- invisibleRightButton:addEventListener("touch", movePlayerShip)
        invisibleLeftButton:addEventListener("touch", moveDirectional)
        invisibleRightButton:addEventListener("touch", moveDirectional)
        invisibleMenuButton:addEventListener("touch", returnToMenu)
  
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene