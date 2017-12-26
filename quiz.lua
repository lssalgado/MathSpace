local composer = require( "composer" )
local statsController = require"statsController"

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
actualRightCounter = 0
actualWrongCounter = 0
combo = 0
starAmount = 0
function restartLevel()
  if rightOrWrong == true then
    counter = actualRightCounter + 1
    print('actualRightCounter is now ' .. counter)
    print('difficulty was '.. actualDifficulty .. ' and now is ' .. math.ceil(counter/3))
    if counter < 12 then
      options = { params={rightCounter = counter, wrongCounter = actualWrongCounter, difficulty = math.ceil(counter/3), combo0=combo, starAmount0= starAmount} }
      composer.gotoScene('quiz', options)
    elseif counter >= 12 then
      -- go to goldenMat
      -- options = { params={ counter=0 } }
      -- composer.gotoScene('goldenMat', options)

      -- go to ships
      print('hide')
      options = {params={ difficulty0 = 1, starAmount0= starAmount }}
      composer.gotoScene( 'ships' , options )
    end
  else
    counter = actualRightCounter
    options = { params={rightCounter = actualRightCounter, wrongCounter = actualWrongCounter, difficulty = math.ceil(counter/3), combo0=combo, starAmount0= starAmount} }
    composer.gotoScene('quiz', options)
  end

end

-- function goToMenu(event)
--     print('return to menu')
--     if event.phase == 'began' then
--         -- for k,v in pairs(ship) do
--         --     v:setLinearVelocity(0,0)
--         -- end
--         -- composer.removeScene('ships', true)
--         -- composer.gotoScene('menu')
--         local options = {
--             effect = "fade",
--             time = 500,
--             isModal = true,
--             params = {previous = 'goldenMat'}
--         }
--         -- composer.gotoScene( "menu", options )
--         composer.removeScene( 'menu' )
--         composer.removeScene( 'blankScene2' )
--         composer.gotoScene( 'blankScene2')
--     end
-- end

-- function goToMenu()
--     composer.gotoScene('blankScene2')
-- end

function goToMenu(event)
  if event.phase == "began" then
    composer.removeScene('menu')
    composer.gotoScene('menu')
  end
end

pause = 0


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
        actualDifficulty = event.params.difficulty
        actualWrongCounter = event.params.wrongCounter
        actualRightCounter = event.params.rightCounter
        combo = event.params.combo0
        starAmount = event.params.starAmount0
        controller = 0

         correctSound = audio.loadSound( "correct.mp3" )
         wrongSound = audio.loadSound( "wrong.wav" )

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        saveData1 = "2 " .. actualRightCounter .. " " .. actualWrongCounter .. " " .. actualDifficulty .. " " .. combo .. " " .. starAmount

        local path = system.pathForFile( "history.txt", system.CachesDirectory )
        print('saveData1 = '.. saveData1)
        file = io.open(path, "w")
        if file then
          file:write(saveData1)
          io.close( file )
        end

        file = io.open(path, "r")
        if file then
          print("Conteudo = ".. file:read("*a"))
          io.close( file )
        end



        background = display.newImageRect("lab.jpg",display.contentWidth,display.contentHeight)
        self.view:insert(background)
        background.x = display.contentCenterX
        background.y = display.contentCenterY

        litleStars = {}

        function drawLitleStars()
          starsToDisplay = starAmount
          if starAmount >= 50 then
            starsToDisplay = 50
          end
          for i=1,starsToDisplay do
            litleStar = display.newImageRect("litleStar.png",10, 10)
            -- print("litleStar = "..litleStar)
            self.view:insert(litleStar)
            litleStar.x = math.random(5,display.contentWidth - 5)
            litleStar.y = math.random(5,display.contentHeight - 5)
            transition.blink(litleStar, {time=1500})
            litleStars[i] = litleStar
          end
        end

        drawLitleStars()

        starPoints = display.newImageRect("star1.png", 25, 25)
        starPoints.x = display.contentWidth - 20
        starPoints.y = display.contentHeight - 40
        self.view:insert(starPoints)

        print("starAmount = " .. starAmount)
        starPointsText = display.newText({
            text = starAmount,
            x = display.contentWidth - 52,
            y = display.contentHeight - 40,
            -- width = 128,
            font = native.systemFont,
            fontSize = 24,
            align = "right"})
        self.view:insert(starPointsText)

        math.randomseed( os.time() )

        function rollResult(a,b)
          result = math.random(a,b)
          if result == answer then
            if (result - 1) > 0 then
              result = result - 1
            else
              result = result + 1
            end
          end
        end

        function defineEquation0()
          isRight = math.random(0, 1)

          equation = math.random(1, 10)
          answer = equation


          if isRight == 0 then -- false
            rollResult(1, 10)
            operation = '    =     ' .. result
          else
            operation = '    =     ' .. answer
          end

        end

        function defineEquation1()
          isRight = math.random(0, 1)

          equation = math.random(20, 50)
          answer = equation


          if isRight == 0 then -- false
            rollResult(20,50)
            operation = '    =     ' .. result
          else
            operation = '    =     ' .. answer
          end

        end

        function defineEquation2()
          isRight = math.random(0, 1)

          equation = math.random(100,250)
          answer = equation


          if isRight == 0 then -- false
            rollResult(100,250)
            operation = '= ' .. result
          else
            operation = '= ' .. answer
          end
        end

        function defineEquation3()
          isRight = math.random(0, 1)

          equation = math.random(1,100)
          answer = equation


          plusOrMinus = math.random(0,1)

          if plusOrMinus == 0 then
            operation = '- '
          else
            operation = '+ '
          end


          if isRight == 0 then -- false
            rollResult(1,100)
            otherNumber = result
            rollResult(1,150)
            if (equation + otherNumber) == result or (equation - otherNumber) == result then
              rollResult(1, 150)
            end
            operation = operation .. otherNumber .. ' = ' .. result
          else
            rollResult(1,150)
            otherNumber = result - equation
            if otherNumber < 0 then
              operation =  ' ' .. otherNumber .. ' = ' .. result
            else
              operation =  '+ ' .. otherNumber .. ' = ' .. result
            end
          end
        end

        function defineEquation4()
          isRight = math.random(0, 1)

          equation = math.random(1,20)
          answer = equation


          plusOrMinus = math.random(2,3)

          if plusOrMinus == 0 then
            operation = '- '
          elseif plusOrMinus == 1 then
            operation = '+ '
          elseif plusOrMinus == 2 then
            operation = '÷ '
          elseif plusOrMinus == 3 then
            operation = 'x '
          end

          function correctFirstNumber(actual, divisor)
            answer = actual + 1
            equation = answer
            if (answer % divisor) > 0 then
              correctFirstNumber(answer, divisor)
            end
          end

          if isRight == 0 then -- false
            if plusOrMinus == 0 or plusOrMinus == 1 then
              rollResult(1,20)
              otherNumber = result
              rollResult(1,10)
              if (equation + otherNumber) == result or (equation - otherNumber) == result then
                rollResult(1, 10)
              end
              operation = operation .. otherNumber .. ' = ' .. result
            else
              if plusOrMinus == 2 then
                rollResult(1,20)
                otherNumber = math.random(1,10)
                if equation / otherNumber == result then
                  if (otherNumber - 1 )> 0 then
                    otherNumber = otherNumber - 1
                  else
                    otherNumber = otherNumber + 1
                  end
                end
                operation = '÷ ' .. otherNumber .. ' = ' .. result
              elseif plusOrMinus == 3 then
                rollResult(1,100)
                otherNumber = math.random(1,10)
                if equation * otherNumber == result then
                  if (otherNumber - 1 )> 0 then
                    otherNumber = otherNumber - 1
                  else
                    otherNumber = otherNumber + 1
                  end
                end
                operation = 'x ' .. otherNumber .. ' = ' .. result
              end
            end
          else
            rollResult(1,250)
            if plusOrMinus == 0 or plusOrMinus == 1 then
              otherNumber = result - equation
              if otherNumber < 0 then
                operation =  ' ' .. otherNumber .. ' = ' .. result
              else
                operation =  '+ ' .. otherNumber .. ' = ' .. result
              end
            else
              equation = math.random(1, 20)
              answer = equation
              otherNumber = math.random(1, 10)
              if plusOrMinus == 2 then
                if (equation % otherNumber) > 0 then
                  correctFirstNumber(equation, otherNumber)
                end
                result = equation / otherNumber
                operation = '÷ ' .. otherNumber .. ' = ' .. result
              elseif plusOrMinus == 3 then
                result = equation * otherNumber
                operation = 'x ' .. otherNumber .. ' = ' .. result
              end
            end
          end
        end

        function callForEquation(dif)
          -- if dif > 1 then
          --   dif = dif + 1
          -- end
          if  dif == 0 then
            print("dif = 0")
            defineEquation0()
          elseif dif == 1 then
            print("dif = 1")
            defineEquation1()
          elseif dif == 2 then
            print("dif = 2")
            defineEquation2()
          elseif dif == 3 then
            print("dif = 3")
            defineEquation3()
          elseif dif == 4 then
            print("dif = 4")
            defineEquation4()
          end
        end

        callForEquation(actualDifficulty)

        function loadImages(total)
          hundreds = (total - (total % 100))/ 100
          dozens = ((total -( hundreds*100))- (total% 10))/10
          units = (total - (hundreds*100)) - (dozens*10)

          print(total)
          print(hundreds)
          print(dozens)
          print(units)

          amount = hundreds + dozens + units

          if dozens == 0 then
            if hundreds == 0 then
              for i=1,units do
                if (i%2) > 0 and i >= 3 then
                  previousPosition = previousPosition + 30
                  unit = display.newImageRect("md1.png", 102 , 102)
                  unit.x = previousPosition
                  unit.y = display.contentCenterY
                  self.view:insert(unit)
                elseif i == 1 then
                  previousPosition = (display.contentCenterX/2) - (6 * units)
                  unit = display.newImageRect("md1.png", 102 , 102)
                  unit.x = (display.contentCenterX/2) - (6 * units)
                  unit.y = display.contentCenterY
                  self.view:insert(unit)
                else
                  previousPosition = previousPosition + 15
                  unit = display.newImageRect("md1.png", 102 , 102)
                  unit.x = previousPosition
                  unit.y = display.contentCenterY
                  self.view:insert(unit)
                end
              end
            elseif units == 0 then
              for i=1,hundreds do
                hundred = display.newImageRect("md100.png", 76, 76)
                hundred.x = display.contentCenterX/2  - (20 * (hundreds-1)) + ((i-1)* 86)
                hundred.y = display.contentCenterY
                self.view:insert(hundred)
                -- body...
              end
            else
              for i=1,units do
                if (i%2) > 0 and i >= 3 then
                  previousPosition = previousPosition + 30
                  unit = display.newImageRect("md1.png", 102 , 102)
                  unit.x = previousPosition
                  unit.y = display.contentCenterY+ 25
                  self.view:insert(unit)
                elseif i == 1 then
                  previousPosition = (display.contentCenterX/2) - (6 * units)
                  unit = display.newImageRect("md1.png", 102 , 102)
                  unit.x = (display.contentCenterX/2) - (6 * units)
                  unit.y = display.contentCenterY+ 25
                  self.view:insert(unit)
                else
                  previousPosition = previousPosition + 15
                  unit = display.newImageRect("md1.png", 102 , 102)
                  unit.x = previousPosition
                  unit.y = display.contentCenterY+ 25
                  self.view:insert(unit)
                end
              end
              for i=1,hundreds do
                hundred = display.newImageRect("md100.png", 76, 76)
                hundred.x = display.contentCenterX/2  - (20 * (hundreds-1)) + ((i-1)* 86)
                hundred.y = display.contentCenterY-46
                self.view:insert(hundred)
                -- body...
              end
            end
          else
            for i=1,hundreds do
              hundred = display.newImageRect("md100.png", 76, 76)
              hundred.x = display.contentCenterX/2  - (20 * (hundreds-1)) + ((i-1)* 86)
              hundred.y = display.contentCenterY - 81
              self.view:insert(hundred)
              -- body...
            end
            for i=1,dozens do
              if (i%2) > 0 and i >= 3 then
                previousPosition = previousPosition + 30
                dozen = display.newImageRect("md10.png", 76 , 76)
                dozen.x = previousPosition
                dozen.y = display.contentCenterY
                self.view:insert(dozen)
              elseif i == 1 then
                previousPosition = (display.contentCenterX/2) - (6 * dozens)
                dozen = display.newImageRect("md10.png", 76 , 76)
                dozen.x = (display.contentCenterX/2) - (6 * dozens)
                dozen.y = display.contentCenterY
                self.view:insert(dozen)
              else
                previousPosition = previousPosition + 15
                dozen = display.newImageRect("md10.png", 76 , 76)
                dozen.x = previousPosition
                dozen.y = display.contentCenterY
                self.view:insert(dozen)
              end
              -- body...
            end
            for i=1,units do
              if (i%2) > 0 and i >= 3 then
                previousPosition = previousPosition + 30
                unit = display.newImageRect("md1.png", 102 , 102)
                unit.x = previousPosition
                unit.y = display.contentCenterY+55
                self.view:insert(unit)
              elseif i == 1 then
                previousPosition = (display.contentCenterX/2) - (6 * units)
                unit = display.newImageRect("md1.png", 102 , 102)
                unit.x = (display.contentCenterX/2) - (6 * units)
                unit.y = display.contentCenterY+55
                self.view:insert(unit)
              else
                previousPosition = previousPosition + 15
                unit = display.newImageRect("md1.png", 102 , 102)
                unit.x = previousPosition
                unit.y = display.contentCenterY+55
                self.view:insert(unit)
              end
            end
          end

        end

        function drawQuestion()
          loadImages(answer)
          -- dResult = display.newText({
          --     text = equation,
          --     x = display.contentCenterX + (display.contentCenterX/4) ,
          --     y = display.contentCenterY,
          --     -- width = 128,
          --     font = native.systemFont,
          --     fontSize = 48,
          --     align = "right"})
          -- self.view:insert(dResult)

          dEquals = display.newText({
              text = operation,
              x = display.contentCenterX *1.4 + 20 ,
              y = display.contentCenterY,
              -- width = 128,
              font = native.systemFont,
              fontSize = 48,
              align = "right"})
              dEquals:setFillColor(0,0,0)
          self.view:insert(dEquals)
        end

        function drawButtons()
          rightButton = display.newImageRect("rightButton.png", 60, 60 )
          rightButton.x = display.contentCenterX *0.5
          rightButton.y = display.contentCenterY + (display.contentCenterY/2)+20
          self.view:insert(rightButton)

          wrongButton = display.newImageRect("wrongButton.png", 60, 60 )
          wrongButton.x = display.contentCenterX * 1.50
          wrongButton.y = display.contentCenterY + (display.contentCenterY/2)+20
          self.view:insert(wrongButton)
        end

        drawQuestion()
        drawButtons()

        function displayResultCorrect()
          correct = display.newImageRect( "rightButton.png" , 100 , 100 )
          correct.x = display.contentCenterX
          correct.y = display.contentCenterY
          self.view:insert(correct)
        end

        function displayResultFalse()
          wrong = display.newImageRect( "wrongButton.png" , 100 , 100 )
          wrong.x = display.contentCenterX
          wrong.y = display.contentCenterY
          self.view:insert(wrong)
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

        function addError()
          if  actualDifficulty == 0 then
            position = 8
          elseif actualDifficulty == 1 then
            position = 10
          elseif actualDifficulty == 2 then
            position = 12
          elseif actualDifficulty == 3 then
            position = 14
          elseif actualDifficulty == 4 then
            position = 16
          end
          statsController.addStats(position)
        end

        function addSucess()
          print('actualDifficulty =================== ' .. actualDifficulty)
          if  actualDifficulty == 0 then
            position = 7
          elseif actualDifficulty == 1 then
            position = 9
          elseif actualDifficulty == 2 then
            position = 11
          elseif actualDifficulty == 3 then
            position = 13
          elseif actualDifficulty == 4 then
            position = 15
          end
          statsController.addStats(position)
        end

        function checkRight(event)
          -- if event.phase == "began" then
          -- elseif event.phase == "moved" then
          -- elseif event.phase == "ended" or event.phase == "canceled" then
            print("ENTROOOOYU")
            if isRight == 1 and controller == 0 then
               correctChannel = audio.stop( correctSound )
               correctChannel = audio.play( correctSound )
              controller = 1
              rightButton:removeEventListener("tap",checkRight)
              wrongButton:removeEventListener("tap",checkWrong)
              displayResultCorrect()
              rightOrWrong = true
              drawStars()
              addSucess()
              timer.performWithDelay( 2000, restartLevel)
              return
            elseif controller == 0 then
              controller = 1
              local wrongChannel = audio.stop( wrongSound )
              local wrongChannel = audio.play( wrongSound )
              rightButton:removeEventListener("tap",checkRight)
              wrongButton:removeEventListener("tap",checkWrong)
              displayResultFalse()
              rightOrWrong = false
              combo = 0
              addError()
              timer.performWithDelay( 500, restartLevel)
              return
            end

          -- end
        end

        function checkWrong()
          if isRight == 0 and controller == 0 then
             correctChannel = audio.stop( correctSound )
             correctChannel = audio.play( correctSound )
            controller = 1
            rightButton:removeEventListener("tap",checkRight)
            wrongButton:removeEventListener("tap",checkWrong)
            displayResultCorrect()
            rightOrWrong = true
            drawStars()
            addSucess()
            timer.performWithDelay( 2000, restartLevel)
          elseif controller == 0 then
            local wrongChannel = audio.stop( wrongSound )
            local wrongChannel = audio.play( wrongSound )
            controller = 1
            rightButton:removeEventListener("tap",checkRight)
            wrongButton:removeEventListener("tap",checkWrong)
            displayResultFalse()
            rightOrWrong = false
            combo = 0
            addError()
            timer.performWithDelay( 500, restartLevel)
          end
        end

        local invisibleMenuButton = display.newImageRect("Settings-Button-2400px.png", 50, 50)
        invisibleMenuButton.y = 55
        invisibleMenuButton.x = display.contentWidth - 30
        self.view:insert(invisibleMenuButton)

        imageToMenu = display.newRect(display.contentCenterX, display.contentCenterY, 240, 30)
        imageToMenu:setFillColor(0,0,0)
        imageToMenu.isVisible = false
        self.view:insert(imageToMenu)

        textToMenu = display.newText({
            text = "Voltar Ao Menu Inicial",
            x = display.contentCenterX,
            y = display.contentCenterY,
            font = native.systemFont,
            fontSize = 24,
            align = "center"})
        textToMenu:setFillColor(1,1,1)
        textToMenu.isVisible = false
        self.view:insert(textToMenu)

        function returnToMenu(event)
            if event.phase == 'began' then
              if pause == 0 then
                pause = 1
                physics.pause()
                imageToMenu.isVisible = true
                textToMenu.isVisible = true
                imageToMenu:addEventListener("touch", goToMenu)

              else
                pause = 0
                physics.start()
                imageToMenu.isVisible = false
                textToMenu.isVisible = false
                imageToMenu:removeEventListener("touch", goToMenu)

              end
            end
        end

        invisibleMenuButton:addEventListener("touch", returnToMenu)

        function addListenersFora()
          rightButton:addEventListener("touch", checkRight)
          wrongButton:addEventListener("touch", checkWrong)
          rightButton:addEventListener("tap", checkRight)
          wrongButton:addEventListener("tap", checkWrong)
        end

        timer.performWithDelay( 200, addListenersFora)

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
