------------------------------------------------------------------------------------------------
-- The Game module.
--
-- @module  game
-- @author Łukasz Durniat
-- @license MIT
-- @copyright Łukasz Durniat, Mar-2018
------------------------------------------------------------------------------------------------

-- ------------------------------------------------------------------------------------------ --
--                                 REQUIRED MODULES                                             --                
-- ------------------------------------------------------------------------------------------ --
 
local composer  = require 'composer' 
local drops     = require 'scene.game.lib.drops' 

-- ------------------------------------------------------------------------------------------ --
--                                 MODULE DECLARATION                                       --                 
-- ------------------------------------------------------------------------------------------ --

local scene = composer.newScene()

-- ------------------------------------------------------------------------------------------ --
--                                 LOCALISED VARIABLES                                        --   
-- ------------------------------------------------------------------------------------------ --

-- ------------------------------------------------------------------------------------------ --
--                                 PRIVATE METHODS                                            --   
-- ------------------------------------------------------------------------------------------ --

-- ------------------------------------------------------------------------------------------ --
--                                 PUBLIC METHODS                                             --   
-- ------------------------------------------------------------------------------------------ --

local rain = {}

function scene:create( event )

   for i=1, 300 do rain[i] = drops.new() end   

end

local function enterFrame( event )

   for i=1, 300 do rain[i]:fall() end   

end 
 
function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if phase == 'will' then

      -- Add listener
      Runtime:addEventListener( 'enterFrame', enterFrame )

   elseif phase == 'did' then

   end

end
 
function scene:hide( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if phase == 'will' then

   elseif phase == 'did' then

      -- Remove listener
      Runtime:removeEventListener( 'enterFrame', enterFrame )

   end
   
end

function scene:destroy( event )

    for i=1, 300 do rain[i]:destroy() end

    rain = nil   
 
end
 
scene:addEventListener( 'create', scene )
scene:addEventListener( 'show', scene )
scene:addEventListener( 'hide', scene )
scene:addEventListener( 'destroy', scene )
 
return scene