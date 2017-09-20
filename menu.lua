local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

function goToShips(event)
    if event.phase == 'began' then
        print('hide')
        -- composer.gotoScene('ships')
        options = { params={ counter=0 } }
        composer.gotoScene('goldenMat', options)

    end
end

function goToQuiz(event)
    if event.phase == 'began' then
      options = {params={rightCounter = 0, wrongCounter = 0, difficulty = 0 }}
      composer.gotoScene( 'quiz' , options )
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
        composer.removeScene('ships')
        -- gameName = display.newText({
        --     text = name,
        --     x = display.contentCenterX,
        --     y = 50,
        --     -- width = 128,
        --     font = native.systemFont,
        --     fontSize = 48,
        --     align = "right"})
        background = display.newImageRect("BG.png", display.contentWidth, display.contentHeight - 45)
        background.x = display.contentCenterX
        background.y = display.contentCenterY
        -- sceneGroup:insert(gameName)
        sceneGroup:insert(background)
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen


        -- gameName:addEventListener('touch', goToShips)

        background:addEventListener('touch', goToShips)
        -- background:addEventListener('touch', goToQuiz)


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
