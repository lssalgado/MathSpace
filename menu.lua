local composer = require( "composer" )
local statsController = require"statsController"

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
saveData = {}
function goToGoldenMat(event)
    if event.phase == 'began' then
        composer.removeScene('goldenMat')
        composer.removeScene('quiz')
        composer.removeScene('ships')
        print('hide')
        options = { params={ counter=0, combo0=0, starAmount0= 0  } }
        composer.gotoScene('goldenMat', options)

    end
end

function goToSettings(event)
  if event.phase == 'began' then
      composer.gotoScene('settings')
  end
end

function goToQuiz(event)
    if event.phase == 'began' then
      composer.removeScene('goldenMat')
      composer.removeScene('quiz')
      composer.removeScene('ships')
      options = {params={rightCounter = 0, wrongCounter = 0, difficulty = 0, combo0=0, starAmount0= 0 }}
      composer.gotoScene( 'quiz' , options )
    end
end

function goToShips(event)
    if event.phase == 'began' then
      composer.removeScene('goldenMat')
      composer.removeScene('quiz')
      composer.removeScene('ships')
      options = {params={ difficulty0 = 1, starAmount0= 0 }}
      composer.gotoScene( 'ships' , options )
    end
end

function goTo(event)
  if event.phase == 'began' then
    print("####################### Entrou no GoTO")
    composer.removeScene('goldenMat')
    composer.removeScene('quiz')
    composer.removeScene('ships')
    print("saveData[1] = ".. saveData[1])
    if tonumber(saveData[1]) == 3 then
      options = {params={ difficulty0 = tonumber(saveData[2]), starAmount0= tonumber(saveData[3]) }}
      timer.performWithDelay(500, composer.gotoScene( 'ships' , options ))

    elseif tonumber(saveData[1]) == 2 then
      options = {params={rightCounter = tonumber(saveData[2]), wrongCounter = tonumber(saveData[3]), difficulty = tonumber(saveData[4]), combo0=tonumber(saveData[5]), starAmount0= tonumber(saveData[6]) }}
      composer.gotoScene( 'quiz' , options )

    elseif tonumber(saveData[1]) == 1 then
      print("Entrando com saveData = 1")
      options = { params={ counter=tonumber(saveData[2]), combo0=tonumber(saveData[3]), starAmount0=tonumber(saveData[4])  } }
      composer.gotoScene('goldenMat', options)
    else
      options = { params={ counter=0, combo0=0, starAmount0= 0  } }
      composer.gotoScene('goldenMat', options)
    end
  end
end

 local name = 'Espaço Matemático'

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
        -- statsController.resetStats()
        statsController.parseStats()
        -- composer.removeScene('ships')
        -- gameName = display.newText({
        --     text = name,
        --     x = display.contentCenterX,
        --     y = 50,
        --     -- width = 128,
        --     font = native.systemFont,
        --     fontSize = 48,
        --     align = "right"})
        -- continueButton = display.newRect(display.contentCenterX, display.contentCenterY + 60, display.contentWidth, display.contentHeight -50)
        -- -- continueButton.isVisible = false
        -- self.view:insert(continueButton)
        -- print ("criou continuebutton")



        background = display.newImageRect("BG.png", display.contentWidth, display.contentHeight - 45)
        background.x = display.contentCenterX
        background.y = display.contentCenterY
        sceneGroup:insert(background)

        modo1 = display.newImageRect("modo1.png", 75, 50)
        modo1.x = display.contentCenterX - 135
        modo1.y = display.contentCenterY + 80
        sceneGroup:insert(modo1)

        modo2 = display.newImageRect("modo2.png", 75, 50)
        modo2.x = display.contentCenterX - 50
        modo2.y = display.contentCenterY + 80
        sceneGroup:insert(modo2)

        modo3 = display.newImageRect("modo3.png", 75, 50)
        modo3.x = display.contentCenterX + 35
        modo3.y = display.contentCenterY + 80
        sceneGroup:insert(modo3)

        continueButton = display.newImageRect("continuar.png", 75, 50)
        continueButton.x = display.contentCenterX + 120
        continueButton.y = display.contentCenterY + 80
        sceneGroup:insert(continueButton)

        invisibleMenuButton = display.newImageRect("Settings-Button-2400px.png", 50, 50)
        invisibleMenuButton.y = 55
        invisibleMenuButton.x = display.contentWidth - 30
        self.view:insert(invisibleMenuButton)



        local path = system.pathForFile( "history.txt", system.CachesDirectory )
        local file = io.open( path, "r" )
        print(path)
        if file then
          saveData= {}
          save = file:read( "*a" )
          for word in save:gmatch("%w+") do
            table.insert(saveData, word)
            -- print('word = ' .. word)
          end

          for i=1,table.getn(saveData) do
            print('word = ' .. saveData[i])
          end
          io.close( file )
        end

        continueButton:addEventListener('touch', goTo)
        modo1:addEventListener('touch', goToGoldenMat)
        modo2:addEventListener('touch', goToQuiz)
        modo3:addEventListener('touch', goToShips)
        invisibleMenuButton:addEventListener('touch', goToSettings)

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen


        -- gameName:addEventListener('touch', goToGoldenMat)

        -- continueButton:addEventListener('touch', goTo)
        -- invisibleMenuButton:addEventListener('touch', goToSettings)
        -- background:addEventListener('touch', goToQuiz)
        -- background:addEventListener('touch', goToShips)


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
