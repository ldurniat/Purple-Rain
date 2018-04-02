------------------------------------------------------------------------------------------------
-- The Drops module.
--
-- @module  drops
-- @author Łukasz Durniat
-- @license MIT
-- @copyright Łukasz Durniat, Apr-2018
------------------------------------------------------------------------------------------------

-- ------------------------------------------------------------------------------------------ --
--                                 MODULE DECLARATION	                                      --						
-- ------------------------------------------------------------------------------------------ --

local M = {}

-- ------------------------------------------------------------------------------------------ --
--                                 REQUIRED MODULES	                                          --						
-- ------------------------------------------------------------------------------------------ --

local composer = require 'composer' 

-- ------------------------------------------------------------------------------------------ --
--                                 LOCALISED VARIABLES                                        --	
-- ------------------------------------------------------------------------------------------ --

local mRandom = math.random

local _T      = display.screenOriginY
local _B  	  = display.viewableContentHeight - display.screenOriginY
local _L  	  = display.screenOriginX
local _R  	  = display.viewableContentWidth - display.screenOriginX

-- ------------------------------------------------------------------------------------------ --
--                                 PRIVATE METHODS                                            --	
-- ------------------------------------------------------------------------------------------ --

------------------------------------------------------------------------------------------------
--- Re-maps a number from one range to another. 
--
-- @param value	The incoming value to be converted.
-- @param start1 Lower bound of the value's current range.
-- @param stop1	Upper bound of the value's current range.
-- @param start2 Lower bound of the value's target range.
-- @param stop2	Upper bound of the value's target range.
-- @return Remapped number.
------------------------------------------------------------------------------------------------
local function map( value, start1, stop1, start2, stop2 )

	return ( ( start2 - stop2 ) / ( start1 - stop1 ) * ( value - start1 ) + start2 )
	
end	

-- ------------------------------------------------------------------------------------------ --
--                                 PUBLIC METHODS                                             --	
-- ------------------------------------------------------------------------------------------ --

------------------------------------------------------------------------------------------------
-- Constructor function of Drops module.
--
-- @return The drop instance.
------------------------------------------------------------------------------------------------
function M.new()

	-- Get the current scene
	local scene  = composer.getScene( composer.getSceneName( 'current' ) )
	local parent = scene.view

	-- Basic properties
	local x      = mRandom( _L, _R )
	local y      = mRandom( _T - ( _B - _T ), _T )	
	local z      = mRandom( 0, 30 )
	local len    = map( z, 0, 30, 10, 30 ) 
	local speedY = map( z, 0, 30, 15, 30 )
	local thick  = map( z, 0, 30, 3, 8 )

	-- Create drop
	local instance = display.newLine( parent, x, y, x, y + len )
	instance:setStrokeColor( 138 / 255, 43 / 255, 226 / 255 )
	instance.strokeWidth = thick
 
	function instance:fall()

		self:translate( 0, speedY )

		-- Add gravity effect
		speedY = speedY + 0.05

		if self.y > _B then

			self.y = mRandom( -100 + _T, _T )
			speedY = map( z, 0, 30,  15, 30 )

		end	

	end		

	function instance:destroy()	

		display.remove( self )
		self = nil
		
	end	

	return instance
	
end	

return M