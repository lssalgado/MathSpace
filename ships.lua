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

        difficulty = 4

        targetValue = 0

        system.activate('multitouch')

        local points = 36
        local actualOperation = 'plus'

        local background = display.newImageRect("background.png",display.contentWidth,display.contentHeight)
        self.view:insert(background)
        background.x = display.contentCenterX
        background.y = display.contentCenterY

        local invisibleFireButton = display.newRect(display.contentCenterX, display.contentCenterY-45, display.contentWidth, display.contentHeight-100)
        self.view:insert(invisibleFireButton)
        invisibleFireButton.alpha = 0
        invisibleFireButton.isHitTestable = true
        invisibleFireButton.name = 'fireButton'

        local invisibleFireButton2 = display.newRect(display.contentCenterX+120, display.contentHeight-49, display.contentWidth, 90)
        self.view:insert(invisibleFireButton2)
        invisibleFireButton2.alpha = 0
        invisibleFireButton2.isHitTestable = true
        invisibleFireButton2.name = 'fireButton'

        local directionalArrow = display.newImageRect("arrows1.png", 100, 50)
        directionalArrow.x = 50
        directionalArrow.y = 250
        self.view:insert(directionalArrow)
        -- directionalArrow:setFillColor(1,1,1)

        -- local invisibleLeftButton = display.newRect(display.contentCenterX*0.5, display.contentHeight -50, display.contentWidth *0.5, 100)
        -- self.view:insert(invisibleLeftButton)
        -- invisibleLeftButton.alpha = 0
        -- invisibleLeftButton.isHitTestable = true
        -- invisibleLeftButton.name = 'leftButton'
        -- invisibleLeftButton:setFillColor(1,0,0)

        -- local invisibleRightButton = display.newRect(display.contentCenterX*0.5 + display.contentCenterX, display.contentHeight -50, display.contentWidth *0.5, 100)
        -- self.view:insert(invisibleRightButton)
        -- invisibleRightButton.alpha = 0
        -- invisibleRightButton.isHitTestable = true
        -- invisibleRightButton.name = 'rightButton'

        local leftLimit = display.newRect(0, display.contentHeight-25, 1, 100)
        self.view:insert(leftLimit)
        physics.addBody(leftLimit, 'static', {bounce = 0})

        local rightLimit = display.newRect(display.contentWidth, display.contentHeight-25, 1, 100)
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

        local invisibleMenuButton = display.newImageRect("Settings-Button-2400px.png", 50, 50)
        invisibleMenuButton.y = 55
        invisibleMenuButton.x = display.contentWidth - 30
        self.view:insert(invisibleMenuButton)
        -- invisibleMenuButton:setFillColor(0,0,1)

        -- local pointsDisplay = display.newText({
        --     text = points,
        --     x = display.contentCenterX,
        --     y = 50,
        --     -- width = 128,
        --     font = native.systemFont,
        --     fontSize = 48,
        --     align = "right"})
        -- self.view:insert(pointsDisplay)

        -- local playerShip = display.newPolygon(display.contentWidth * 0.5, display.contentHeight -55, {-10,0, 10,0, 0,-30})
        local playerShip = display.newImageRect("ship2.png", 17, 30)
        self.view:insert(playerShip)
        playerShip.y = display.contentHeight -55
        playerShip.x = display.contentCenterX
        -- playerShip:setFillColor(0,0,0)
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

        function defineEquation(difficulty)

            
            if(difficulty == 1) then
                number1 = math.random( 1,10)
                number2 = math.random( 1,10)
                operation = math.random(1,2)
            elseif(difficulty == 2) then
                number1 = math.random( 1,10)
                number2 = math.random( 1,100 )
                operation = math.random(1,2)
            elseif(difficulty == 3) then
                number1 = math.random( 1,100 )
                number2 = math.random( 1,100 )
                operation = math.random(1,2)
            elseif(difficulty == 4) then
                number1 = math.random( 1,10)
                number2 = math.random( 1,100 )
                operation = math.random(1,3)
            end

            if(operation==1) then
                equationString = number1 .. " + " .. number2
                equationResult = number1 + number2

                return {equationString, equationResult}
            elseif(operation==2) then
                equationString = number1 .. " - " .. number2
                equationResult = number1 - number2

                return {equationString, equationResult}
            elseif(operation==3) then
                equationString = number1 .. " * " .. number2
                equationResult = number1 * number2

                return {equationString, equationResult}
            end
        end

        function startShipsTest(lines)
            k = 1
            for i=1, lines do
                for j=1, lines do
                    print(j+i)
                    -- local shipToInsert = display.newRect(groupShips.x + 35*j, 30*i, 25, 25)
                    shipEquation = defineEquation(difficulty)
                    print("shipeq = "..table.concat( shipEquation, ", " ))
                    local shipToInsert = display.newImageRect("enemyShip.png", 25, 25)

                    shipToInsert.text = shipEquation[2]
                    shipToInsert.x = groupShips.x + 55*j
                    shipToInsert.y = ((30*i)+55)
                    shipToInsert.width = 45
                    shipToInsert.height = 30
                    shipToInsert.font = native.systemFont
                    shipToInsert.fontSize = 12
                    shipToInsert.align = "center"

                    shipToInsert.visibleText = display.newText({
                        text = shipEquation[2],
                        x = shipToInsert.x,
                        y = shipToInsert.y+30,
                        width = 45,
                        height = 30,
                        font = native.systemFont,
                        fontSize = 12,
                        align = "center"})
                    shipToInsert.visibleText:setFillColor(0.16, 0.16,0.16)
                    self.view:insert(shipToInsert.visibleText)
                    -- local shipToInsert = display.newText({
                    --     text = shipEquation[2],
                    --     x = groupShips.x + 35*j,
                    --     y = ((30*i)+25),
                    --     width = 25,
                    --     height = 25,
                    --     font = native.systemFont,
                    --     fontSize = 12,
                    --     align = "center"})
                    -- shipToInsert:setFillColor(0.16, 0.16,0.16)
                    if i == lines then
                        shipToInsert.last = true

                    else
                        shipToInsert.last = false
                        shipToInsert.visibleText.isVisible = false
                    end
                    shipToInsert.position = k
                    shipToInsert.points = shipEquation[2]
                    shipToInsert.equationToShow = shipEquation[1]
                    table.insert(ship,shipToInsert)
                    k = k + 1
                    self.view:insert(shipToInsert)
                end
            end
        end

        startShipsTest(4)

        function createOperation()

            local pointsDisplay = display.newText({
                text = points,
                x = display.contentCenterX,
                y = 50,
                -- width = 128,
                font = native.systemFont,
                fontSize = 48,
                align = "right"})
            self.view:insert(pointsDisplay)

        end

        for k,v in pairs(ship) do
            print(k, v)
            v.name = 'ship'
            self.view:insert(v)
            physics.addBody( v, "dynamic", {isSensor = true})
            if (v.visibleText) then
              physics.addBody( v.visibleText, "dynamic", {isSensor = true})
              v.visibleText.gravityScale = 0
            end
            v.gravityScale = 0
        end

        function toLeft()
            -- transition.to( groupShips, { time=4000, x=(0), onComplete=toRight})
            for k,v in pairs(ship) do
                v:applyLinearImpulse(0.005, 0, ship[1].x, ship[1].y)
                if (v.visibleText) then
                  v.visibleText:applyLinearImpulse(0.005, 0, v.visibleText.x, v.visibleText.y)
                end

            end
        end

        rightest = display.contentWidth-ship[shipsNumber].x-ship[shipsNumber].width
        linearVelocity = 0.005
        verticalVelocity = difficulty/100000
        function toRight()

            -- transition.to( groupShips, { time=4000, x=rightest, onComplete=toLeft})
            for k,v in pairs(ship) do
                v:applyLinearImpulse(linearVelocity, 0, v.x, v.y)
                if (v.visibleText) then
                  v.visibleText:applyLinearImpulse(linearVelocity, 0, v.visibleText.x, v.visibleText.y)
                end
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
                            v:applyLinearImpulse(linearVelocity,verticalVelocity, v.x, v.y)
                            if (v.visibleText) then
                              v.visibleText:setLinearVelocity(0, 0)
                              v.visibleText:applyLinearImpulse(linearVelocity,verticalVelocity, v.visibleText.x, v.visibleText.y)
                            end
                        end
                    end
                elseif event.target.name == 'right' and linearVelocity == 0.005 then
                    linearVelocity = linearVelocity*-1
                    for k,v in pairs(ship) do
                        -- print('direita')
                        if v.isBodyActive then
                            v:setLinearVelocity(0, 0)
                            v:applyLinearImpulse(linearVelocity, verticalVelocity, v.x, v.y)
                            if (v.visibleText) then
                              v.visibleText:setLinearVelocity(0, 0)
                              v.visibleText:applyLinearImpulse(linearVelocity,verticalVelocity, v.visibleText.x, v.visibleText.y)
                            end
                        end
                    end
                end
            end
        end

        toRight()

        function setAndDrawTarget(operationToUse, firstNumber, secondNumber)
            if operationToUse == 1 then
                target = firstNumber + secondNumber
                actualOperation = '+'
                return firstNumber .. ' + ' .. secondNumber
            elseif operationToUse == 2 then
                target = firstNumber - secondNumber
                actualOperation = '-'
                return firstNumber .. ' - ' .. secondNumber
            elseif operationToUse == 3 then
                target = firstNumber * secondNumber
                actualOperation = '*'
                return firstNumber .. ' * ' .. secondNumber

            end


            return ''
        end

        function newOperation()
            possibleNumbers = {}
            arraySize = 0
            for k,v in pairs(ship) do
                if v.last == true then
                    table.insert( possibleNumbers,{v.equationToShow, v.text} )
                    arraySize = arraySize + 1
                end
            end
            -- local operationToUse = math.random( 1,3 )

            math.randomseed( os.time() )
            local firstNumber = math.random( 1, arraySize)
            -- local secondNumber = math.random( 1, arraySize)
            -- if secondNumber == firstNumber then
            --     while secondNumber == firstNumber do
            --         secondNumber = math.random( 1, arraySize)
            --     end
            -- end
            -- -- print(table.concat( possibleNumbers, ", " ))
            -- -- print('first'..firstNumber)
            -- -- print('second'..secondNumber)
            -- print(arraySize)
            -- -- operationText = possibleNumbers[firstNumber] .. operationToUse .. possibleNumbers[secondNumber]
            -- operationText = setAndDrawTarget(operationToUse, possibleNumbers[firstNumber], possibleNumbers[secondNumber])
            targetValue = possibleNumbers[firstNumber][2]
            pointsDisplay = display.newText({
                text = possibleNumbers[firstNumber][1],
                x = display.contentCenterX,
                y = 50,
                -- width = 128,
                font = native.systemFont,
                fontSize = 48,
                align = "right"})
            self.view:insert(pointsDisplay)


        end
        newOperation()
        function operation(shipHit)
            if shipHit.last == true then
                shipHit.last = false
                shipHit.visibleText:removeSelf()
                if ship[shipHit.position - 4] then
                    -- print(ship[shipHit.position - 6].last)
                    ship[shipHit.position - 4].last = true
                    ship[shipHit.position - 4].visibleText.isVisible = true
                    pointsDisplay:removeSelf()
                    newOperation()
                end
            end
            -- if actualOperation == 'mult' then

            -- elseif actualOperation == 'plus' then
            --     points = points - shipPoints
            --     if points < 0 then
            --         -- pointsDisplay:setFillColor(1,0,0)
            --         -- physics.stop()
            --     else
            --         -- pointsDisplay.text = points
            --     end

            -- elseif actualOperation == 'min' then
            -- end
        end

        function adjustDifficulty(value)
            if (value == 1) then
                if (difficulty < 4) then
                    difficulty = difficulty + 1
                end
            elseif (value == 0) then
                if (difficulty > 0) then
                    difficulty = difficulty - 1
                end
            end
        end

        function shipHit(event)
            if(event.phase == 'began' and event.other.name=='ship') then
                if event.other.last == true then
                    print('collision')
                    if(event.other.text == targetValue) then
                        directionalArrow:setFillColor(0,1,0)
                        print(event.other.text .. " CERTOU " .. targetValue)
                        adjustDifficulty(1)
                    else
                        directionalArrow:setFillColor(1,0,0)
                        print(event.other.text   .. " EROU " .. targetValue)
                        adjustDifficulty(0)
                    end
                    operation(event.other)
                    event.other:removeSelf()
                    event.other = nil
                end
                event.target:removeSelf()
                event.target = nil
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
                  print(event.y)
                  projectile = display.newRect(playerShip.x, display.contentHeight-65, 5,5)
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

                if event.x > event.target.x and (playerShip.direction ~= 'right' or playerShip:getLinearVelocity() == 0) then
                    print('right')
                    playerShip.direction = 'right'
                    playerShip:setLinearVelocity(0,0)
                    playerShip:applyLinearImpulse(0.02, 0, playerShip.x, playerShip.y)
                elseif event.x < event.target.x and (playerShip.direction ~= 'left' or playerShip:getLinearVelocity() == 0) then
                    print('left')
                    playerShip.direction = 'left'
                    playerShip:setLinearVelocity(0,0)
                    playerShip:applyLinearImpulse(-0.02, 0, playerShip.x, playerShip.y)
                end
            elseif event.phase == 'moved' then
                if event.x > event.target.x and (playerShip.direction ~= 'right' or playerShip:getLinearVelocity() == 0) then
                    print('right')
                    playerShip.direction = 'right'
                    playerShip:setLinearVelocity(0,0)
                    playerShip:applyLinearImpulse(0.02, 0, playerShip.x, playerShip.y)
                elseif event.x < event.target.x and (playerShip.direction ~= 'left' or playerShip:getLinearVelocity() == 0) then
                    print('left')
                    playerShip.direction = 'left'
                    playerShip:setLinearVelocity(0,0)
                    playerShip:applyLinearImpulse(-0.02, 0, playerShip.x, playerShip.y)
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

        function moveWithArrow( event )

        end

        invisibleFireButton:addEventListener("touch", createProjectile)
        invisibleFireButton2:addEventListener("touch", createProjectile)
        leftWall:addEventListener("collision", invertLinearVelocity)
        rightWall:addEventListener("collision", invertLinearVelocity)
        -- invisibleLeftButton:addEventListener("touch", movePlayerShip)
        -- invisibleRightButton:addEventListener("touch", movePlayerShip)
        -- invisibleLeftButton:addEventListener("touch", moveDirectional)
        -- invisibleRightButton:addEventListener("touch", moveDirectional)
        invisibleMenuButton:addEventListener("touch", returnToMenu)
        directionalArrow:addEventListener("touch", moveDirectional)

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
