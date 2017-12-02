local composer = require( "composer" )
local statsController = require"statsController"

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

function goToMenu(event)
  if event.phase == 'began' then
      print("####################### MANDANDO PARA MENU")
      -- composer.removeScene( 'ships' )
      local options = {
                  effect = "fade",
                  time = 500,
                  isModal = true}
      composer.removeScene( 'menu')
      composer.gotoScene('menu', options )
  end
end

function resetAllStats(event)
  if event.phase == 'began' then
      statsController.resetAllStats()
  end
end

function goToStats(event)
  if event.phase == 'began' then
      composer.gotoScene('stats')
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

        -- imageToMenu = display.newImageRect("darkBG.png", display.contentWidth, display.contentHeight)
        -- invisibleMenuButton.y = display.contentCenterX
        -- invisibleMenuButton.x = display.contentCenterY
        -- self.view:insert(imageToMenu)

        invisibleMenuButton = display.newImageRect("Arrow-Inverse-002-300px.png", 50, 50)
        invisibleMenuButton.y = 55
        invisibleMenuButton.x = 30
        self.view:insert(invisibleMenuButton)

        imageToStats = display.newRect(display.contentCenterX, display.contentCenterY - 50, 360, 30)
        imageToStats:setFillColor(1,1,1)
        self.view:insert(imageToStats)

        textToStats = display.newText({
            text = "Ver histórico de acertos e erros",
            x = display.contentCenterX,
            y = display.contentCenterY - 50,
            font = native.systemFont,
            fontSize = 24,
            align = "center"})
        textToStats:setFillColor(0,0,0)
        self.view:insert(textToStats)

        imageToReset = display.newRect(display.contentCenterX, display.contentCenterY + 50, 360, 30)
        imageToReset:setFillColor(1,1,1)
        self.view:insert(imageToReset)

        textToReset = display.newText({
            text = "Apagar todo o conteúdo salvo",
            x = display.contentCenterX,
            y = display.contentCenterY + 50,
            font = native.systemFont,
            fontSize = 24,
            align = "center"})
        textToReset:setFillColor(0,0,0)
        self.view:insert(textToReset)

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

        invisibleMenuButton:addEventListener('touch', goToMenu)
        imageToReset:addEventListener('touch', resetAllStats)
        imageToStats:addEventListener('touch', goToStats)

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
