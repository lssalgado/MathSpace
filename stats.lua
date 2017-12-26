local composer = require( "composer" )
local statsController = require"statsController"

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

function goToSettings(event)
  if event.phase == 'began' then
      composer.gotoScene('settings')
  end
end

function resetStats(event)
  if event.phase == 'began' then
    statsController.resetStats()
    composer.gotoScene( 'stats')
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

        darkBG = display.newImageRect("darkBG.png", display.contentWidth, display.contentHeight)
        darkBG.x = display.contentCenterX
        darkBG.y = display.contentCenterY - 10
        self.view:insert(darkBG)

        invisibleMenuButton = display.newImageRect("Arrow-Inverse-002-300px.png", 50, 50)
        invisibleMenuButton.y = 55
        invisibleMenuButton.x = 30
        self.view:insert(invisibleMenuButton)

        invisibleResetButton = display.newImageRect("exitX.png", 100, 50)
        invisibleResetButton.y = 55
        invisibleResetButton.x = display.contentWidth - 40
        self.view:insert(invisibleResetButton)

        statsData = statsController.parseStats()

        points = {}
        for i=1,6 do
          points[i] = display.newText({
              text = statsData[i],
              x = display.contentCenterX,
              y = display.contentCenterY -33 + (17 * (i-1)),
              font = native.systemFont,
              fontSize = 10,
              align = "center"})
          points[i]:setFillColor(0,0,0)
          self.view:insert(points[i])
        end

        for i=1,10 do
          points[i] = display.newText({
              text = statsData[i+6],
              x = display.contentCenterX + 84,
              y = display.contentCenterY -33 + (17 * (i-1)),
              font = native.systemFont,
              fontSize = 10,
              align = "center"})
          points[i]:setFillColor(0,0,0)
          self.view:insert(points[i])
        end

        for i=1,8 do
          points[i] = display.newText({
              text = statsData[i+16],
              x = display.contentCenterX + 168,
              y = display.contentCenterY -33 + (17 * (i-1)),
              font = native.systemFont,
              fontSize = 10,
              align = "center"})
          points[i]:setFillColor(0,0,0)
          self.view:insert(points[i])
        end


    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

        invisibleMenuButton:addEventListener('touch', goToSettings)
        invisibleResetButton:addEventListener('touch', resetStats)

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
