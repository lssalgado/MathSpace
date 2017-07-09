local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
rightCounter = 0
function goToShips(event)
        print('hide')
        composer.gotoScene('ships')
        -- composer.gotoScene('goldenMat')
end

function restartLevel()
  rightCounter = rightCounter + 1
  if rightCounter < 3 then
    options = { params={counter = rightCounter} }
    composer.gotoScene('blankScene', options)
  elseif rightCounter >= 3 then
    composer.gotoScene( 'ships' )
  end

end


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

end


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        rightCounter = event.params.counter
        function loadImages()

          local background = display.newImageRect("lab.jpg",display.contentWidth,display.contentHeight)
          self.view:insert(background)
          background.x = display.contentCenterX
          background.y = display.contentCenterY

          ship = display.newImageRect("ship.png", 69, 120)
          self.view:insert(ship)
          ship.x = display.contentCenterX
          ship.y = display.contentCenterY
          physics.addBody( ship, "dynamic")
          ship.gravityScale = 0

          shipFilter1 = display.newImageRect("shipFilter1.png", 69, 40)
          self.view:insert(shipFilter1)
          shipFilter1.x = display.contentCenterX
          shipFilter1.y = display.contentCenterY + 40

          shipFilter2 = display.newImageRect("shipFilter2.png", 69, 40)
          self.view:insert(shipFilter2)
          shipFilter2.x = display.contentCenterX
          shipFilter2.y = display.contentCenterY

          shipFilter3 = display.newImageRect("shipFilter3.png", 69, 40)
          self.view:insert(shipFilter3)
          shipFilter3.x = display.contentCenterX
          shipFilter3.y = display.contentCenterY - 40


          function removePointsAndTarget()
            if pointsDisplayMD then
              pointsDisplayMD:removeSelf()
            end
            if targetDisplay then
              targetDisplay:removeSelf()
            end
          end

          function setPointsAndTarget()
            -- removePointsAndTarget()
            pointsDisplayMD = display.newText({
                text = 0,
                x = display.contentCenterX-45,
                y = 50,
                -- width = 128,
                font = native.systemFont,
                fontSize = 48,
                align = "right"})
            self.view:insert(pointsDisplayMD)


            targetDisplay = display.newText({
                text = "",
                x = display.contentCenterX+45,
                y = 50,
                -- width = 128,
                font = native.systemFont,
                fontSize = 48,
                align = "right"})

            math.randomseed( os.time() )
            targetDisplay.value = math.random(1, 2)
            -- targetDisplay.value = 100
            targetDisplay.text = "/".. targetDisplay.value
            self.view:insert(targetDisplay)
          end

          setPointsAndTarget()

          function updatePointsAndTarget()

          end

          md1 = display.newImageRect("md1.png", 51, 51)
          self.view:insert(md1)
          md1.x = display.contentCenterX - 100
          md1.y = display.contentHeight - 70
          md1.value = 1
          physics.addBody( md1, "dynamic")
          md1.gravityScale = 0
          md1.originalX = display.contentCenterX - 100
          md1.originalY = display.contentHeight - 70

          md10 = display.newImageRect("md10.png", 51, 51)
          self.view:insert(md10)
          md10.x = display.contentCenterX
          md10.y = display.contentHeight - 70
          md10.value = 10
          physics.addBody( md10, "dynamic")
          md10.gravityScale = 0
          md10.originalX = display.contentCenterX
          md10.originalY = display.contentHeight - 70

          md100 = display.newImageRect("md100.png", 51, 51)
          self.view:insert(md100)
          md100.x = display.contentCenterX + 100
          md100.y = display.contentHeight - 70
          md100.value = 100
          physics.addBody( md100, "dynamic")
          md100.gravityScale = 0
          md100.originalX = display.contentCenterX + 100
          md100.originalY = display.contentHeight - 70
        end

        loadImages()

        function checkCounter()
          print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
          for k,v in pairs(event) do
            print (k , v)
          end
          if event.params.counter >= 1 then
            shipFilter1:removeSelf()
          end
          if event.params.counter >= 2 then
            shipFilter2:removeSelf()
          end
          if event.params.counter == 3 then
            shipFilter3:removeSelf()
          end
        end

        checkCounter()

        function dragObject(event)
          if event.phase == "began" then
            originalX = event.target.x
            originalY = event.target.y
          elseif event.phase == "moved" then
             -- then drag our object
            event.target.x = event.x
            event.target.y = event.y

          elseif event.phase == "ended" or event.phase == "cancelled" then

            print(event.x .. " " .. display.contentCenterX)
            print(event.y .. " " .. display.contentCenterY)
            if event.target.value then
              if event.x < display.contentCenterX + 25 and event.x > display.contentCenterX - 25 then
                if event.y < display.contentCenterY + 25 and event.y > display.contentCenterY - 25 then
                  feedShip(event.target.value)
                end
              end
            end

            event.target.x = event.target.originalX
            event.target.y = event.target.originalY
             -- we end the movement by removing the focus from the objec
          end

           -- return true so Corona knows that the touch event was handled properly
           return true
        end

        oldH = ship.height
        oldW = ship.width

        function reduceShip()
          ship.height = oldH
          ship.width = oldW
          shipFilter1.height = 40
          shipFilter1.width = oldW
          shipFilter2.height = 40
          shipFilter2.width = oldW
          shipFilter3.height = 40
          shipFilter3.width = oldW
        end

        function enlargeShip()
          ship.height = oldH*1.033
          ship.width = oldW*1.1
          shipFilter1.height = 40*1.1
          shipFilter1.width = oldW*1.1
          shipFilter2.height = 40*1.1
          shipFilter2.width = oldW*1.1
          shipFilter3.height = 40*1.1
          shipFilter3.width = oldW*1.1
          timer.performWithDelay( 100, reduceShip )
        end

        function feedShip(amount)

            enlargeShip()
            pointsDisplayMD.text = tonumber(pointsDisplayMD.text)+amount
            if tonumber( pointsDisplayMD.text) == tonumber( targetDisplay.value) then
              pointsDisplayMD:setFillColor(0,1,0)
              if event.params.counter == 2 then
                shipFilter3:removeSelf()
              end
              timer.performWithDelay( 1000, removePointsAndTarget )
              timer.performWithDelay( 1000, restartLevel )
            end

            if tonumber( pointsDisplayMD.text) > tonumber( targetDisplay.value) then
              pointsDisplayMD:setFillColor(1,0,0)
              timer.performWithDelay( 500, setPointsAndTarget )
              -- targetDisplay.value = math.math.random(1, 500)
              -- targetDisplay.text = "/" .. targetDisplay.value
            end

        end

        md1:addEventListener("touch", dragObject)
        md10:addEventListener("touch", dragObject)
        md100:addEventListener("touch", dragObject)
        -- ship:addEventListener("collision", feedShip)
        -- ship:addEventListener("touch", feedShip)

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
