local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
rightCounter = 0
combo = 0
starAmount = 0
function goToShips(event)
        print('hide')
        composer.gotoScene('ships')
        -- composer.gotoScene('goldenMat')
end

function goToQuiz(event)
      options = {params={rightCounter = 0, wrongCounter = 0, difficulty = 0, combo0=combo, starAmount0= starAmount }}
      composer.gotoScene( 'quiz' , options )
end

function restartLevel()
  rightCounter = rightCounter + 1
  if rightCounter < 9 then
    options = { params={counter = rightCounter, combo0 = combo, starAmount0 = starAmount} }
    composer.gotoScene('goldenMat', options)
  elseif rightCounter >= 9 then
    goToQuiz()
  end

end

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
            isModal = true,
            params = {previous = 'goldenMat'}
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
    -- Code here runs when the scene is first created but has not yet appeared on screen

end


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        rightCounter = event.params.counter
        combo = event.params.combo0
        starAmount = event.params.starAmount0
        function loadImages()
          physics.stop()
          local background = display.newImageRect("lab.jpg",display.contentWidth,display.contentHeight)
          self.view:insert(background)
          background.x = display.contentCenterX
          background.y = display.contentCenterY

          grayBox = display.newImageRect("gray.png", 300 , 61)
          self.view:insert(grayBox)
          grayBox.x = display.contentCenterX
          grayBox.y = display.contentHeight - 70

          ship = display.newImageRect("ship.png", 69, 120)
          self.view:insert(ship)
          ship.x = display.contentCenterX
          ship.y = display.contentCenterY
          physics.addBody( ship, "dynamic")
          ship.gravityScale = 0

          container = display.newImageRect("container.png", 50, 120)
          self.view:insert(container)
          container.x = display.contentCenterX + 65
          container.y = display.contentCenterY


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

          centena = display.newImageRect("md100.png", 51, 51)
          centena.x = 70
          centena.y = 88
          centena.isVisible = false
          centena.alpha = 0.0
          self.view:insert(centena)

          starPoints = display.newImageRect("star1.png", 25, 25)
          starPoints.x = display.contentWidth - 20
          starPoints.y = display.contentHeight - 40
          self.view:insert(starPoints)

          starPointsText = display.newText({
              text = starAmount,
              x = display.contentWidth - 52,
              y = display.contentHeight - 40,
              -- width = 128,
              font = native.systemFont,
              fontSize = 24,
              align = "right"})
          self.view:insert(starPointsText)

          dezenas = {}
          unidades = {}
          cheeses = {}


          for i=1,10 do
            print('actual'..i)

            dezena = display.newImageRect("md10.png", 51, 51)
            dezena.x = 22 + (i * 10)
            dezena.y = 148
            dezena.isVisible = false
            dezena.alpha = 0.0
            self.view:insert(dezena)
            dezenas[i] = dezena

            unidade = display.newImageRect("md1.png", 51, 51)
            unidade.x = 22 + (i * 10)
            unidade.y = 188
            unidade.isVisible = false
            self.view:insert(unidade)
            unidades[i] = unidade

            if i < 10 then
              cheese = display.newImageRect("cheese.png", 45, 13)
              cheese.x = display.contentCenterX + 65
              cheese.y = display.contentCenterY + 64 - (13*i)
              cheese.isVisible = false
              self.view:insert(cheese)
              cheeses[i] = cheese
            end
          end

          for i=1,event.params.counter do
            cheeses[i].isVisible = true
          end

          local invisibleMenuButton = display.newImageRect("Settings-Button-2400px.png", 50, 50)
          invisibleMenuButton.y = 55
          invisibleMenuButton.x = display.contentWidth - 30
          self.view:insert(invisibleMenuButton)
          invisibleMenuButton:addEventListener("touch", returnToMenu)

          function removePointsAndTarget()
            if pointsDisplayMD then
              pointsDisplayMD:removeSelf()
            end
            if targetDisplay then
              targetDisplay:removeSelf()
            end
            for i=1,10 do
              unidades[i].isVisible = false
              dezenas[i].isVisible = false
            end
            centena.isVisible = false
            setPointsAndTarget()
          end

          function defineValue()
            if event.params.counter <3 then
              value = math.random(10, 19)
            elseif event.params.counter >= 3 and event.params.counter < 6  then
              value = math.random(25, 75)
            elseif event.params.counter >= 6 then
              value = math.random(100, 159)
            end
            return value
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
            targetDisplay.value = defineValue()
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
          if event.params.counter >= 3 then
            shipFilter1:removeSelf()
          end
          if event.params.counter >= 6 then
            shipFilter2:removeSelf()
          end
          if event.params.counter == 9 then
            shipFilter3:removeSelf()
          end
        end

        checkCounter()

        function dragObject(event)
          if event.phase == "began" then
            originalX = event.target.x
            originalY = event.target.y
            print("TOQUE COMEÇOU")
          elseif event.phase == "moved" then
             -- then drag our object
            event.target.x = event.x
            event.target.y = event.y
            print("TOQUE MOVEU")
          elseif event.phase == "ended" or event.phase == "cancelled" then

            print(event.x .. " " .. display.contentCenterX)
            print(event.y .. " " .. display.contentCenterY)
            print("TOQUE TERMINOU")
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

        function dragHandler(event)
          originalX = event.target.x
          originalY = event.target.y
          dragObject(event)
          event.target.x = event.target.originalX
          event.target.y = event.target.originalY
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

        unidadesVisiveis = 0
        dezenasVisiveis = 0
        centenasVisiveis = 0

        function enableUnidade()
          if unidadesVisiveis + 1 > 9 then
            unidades[unidadesVisiveis + 1].isVisible = true
            for i=1,10 do
              transition.fadeOut(unidades[i], {time=500})
            end
            unidadesVisiveis = 0
            enableDezena(1)
          else
            unidades[unidadesVisiveis + 1].isVisible = true
            unidadesVisiveis = unidadesVisiveis + 1
          end
        end

        function enableDezena(fade)
          print("fade = " .. fade)
          if fade == 0 then
            if dezenasVisiveis + 1 > 9 then
              dezenas[dezenasVisiveis + 1].alpha = 1.0
              dezenas[dezenasVisiveis + 1].isVisible = true
              for i=1,10 do
                transition.fadeOut(dezenas[i], {time=500})
              end
              dezenasVisiveis = 0
              enableCentena(1)
            else
              dezenas[dezenasVisiveis + 1].alpha = 1.0
              dezenas[dezenasVisiveis + 1].isVisible = true
              dezenasVisiveis = dezenasVisiveis + 1
            end
          else
            if dezenasVisiveis + 1 > 9 then
              dezenas[dezenasVisiveis + 1].isVisible = true
              transition.fadeIn(dezenas[dezenasVisiveis + 1], {time=700})
              for i=1,10 do
                transition.fadeOut(unidades[i], {time=500})
              end
              dezenasVisiveis = 0
              enableCentena(1)
            else
              dezenas[dezenasVisiveis + 1].isVisible = true
              transition.fadeIn(dezenas[dezenasVisiveis + 1], {time=700})
              dezenasVisiveis = dezenasVisiveis + 1
            end
          end
        end

        function enableCentena(fade)
          if fade == 0 then
            centena.alpha = 1.0
            centena.isVisible = true
          else
            centena.isVisible = true
            transition.fadeIn(centena, {time=700})
          end
        end

        star = {}

        function fadeStar()
          transition.fadeIn(star, {time=500, onComplete=scaleStar})
        end

        function scaleStar()
          transition.scaleTo(star, { xScale=0.5, yScale=0.5, time=200, onComplete=moveStar })
        end

        function moveStar()
          transition.moveTo(star, { x=display.contentWidth, y=display.contentHeight-10, time=700 })
        end

        function drawStars()

          md1:removeEventListener("touch", dragObject)
          md10:removeEventListener("touch", dragObject)
          md100:removeEventListener("touch", dragObject)

          if combo == 0 then
            print("combo = " .. combo)
            star = display.newImageRect("star1.png", 50, 50)
            star.x = display.contentCenterX
            star.y = display.contentCenterY
            star.alpha = 0
            fadeStar()
            self.view:insert(star)
            combo = 1
            starAmount = starAmount + 1
          elseif combo == 1 then
            print("combo = " .. combo)
            star = display.newImageRect("star2.png", 60, 50)
            star.x = display.contentCenterX
            star.y = display.contentCenterY
            star.alpha = 0
            fadeStar()
            transition.fadeIn(star, {time=700})

            self.view:insert(star)
            combo = 2
            starAmount = starAmount + 2
          elseif combo == 2 then
            print("combo = " .. combo)
            star = display.newImageRect("star3.png", 80, 50)
            star.x = display.contentCenterX
            star.y = display.contentCenterY
            star.alpha = 0
            fadeStar()
            transition.fadeIn(star, {time=700})
            self.view:insert(star)
            starAmount = starAmount + 3
          end
        end

        function feedShip(amount)

            if amount == 1 then
              enableUnidade()
            elseif amount == 10 then
              enableDezena(0)
            elseif amount == 100 then
              enableCentena(0)
            end
            enlargeShip()
            pointsDisplayMD.text = tonumber(pointsDisplayMD.text)+amount
            if tonumber( pointsDisplayMD.text) == tonumber( targetDisplay.value) then
              pointsDisplayMD:setFillColor(0,1,0)
              -- if event.params.counter == 2 then
              --   shipFilter3:removeSelf()
              -- end
              print("drawstars")
              drawStars()
              timer.performWithDelay( 1000, removePointsAndTarget )
              timer.performWithDelay( 2000, restartLevel )
            end

            if tonumber( pointsDisplayMD.text) > tonumber( targetDisplay.value) then
              pointsDisplayMD:setFillColor(1,0,0)
              combo = 0
              timer.performWithDelay( 500, removePointsAndTarget )
              -- targetDisplay.value = math.math.random(1, 500)
              -- targetDisplay.text = "/" .. targetDisplay.value
            end

        end

        function addListners()
          md1:addEventListener("touch", dragObject)
          md10:addEventListener("touch", dragObject)
          md100:addEventListener("touch", dragObject)
        end

        function moveHand()
        transition.moveTo(hand, { x = display.contentCenterX +24, y = display.contentHeight - 150, time = 700, onComplete = fadeOutHand})
        end

        function fadeOutHand()
          transition.fadeOut(hand, {time = 300, onComplete = addListners})
        end

        if rightCounter == 0 then
          print("rightCounter = " .. rightCounter)
          hand = display.newImageRect("handAndMd10.png", 81,81)
          hand.x = display.contentCenterX +24
          hand.y = display.contentHeight - 56
          hand.alpha = 0
          self.view:insert(hand)
          transition.fadeIn(hand, {time = 300, onComplete = moveHand})
        -- ship:addEventListener("collision", feedShip)
        -- ship:addEventListener("touch", feedShip)
        else
          print("rightCounter = " .. rightCounter)
          addListners()
        end

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
