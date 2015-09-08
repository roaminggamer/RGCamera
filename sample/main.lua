-- =============================================================
-- Copyright Roaming Gamer, LLC. 2009-2015
-- =============================================================
-- RGEasy Inputs - One Touch Example
-- =============================================================
-- 								License
-- =============================================================
--[[
	> RGEasyInputs is free to use.
	> RGEasyInputs is free to edit.
	> RGEasyInputs is free to use in a free or commercial game.
	> RGEasyInputs is free to use in a free or commercial non-game app.
	> RGEasyInputs is free to use without crediting the author (credits are still appreciated).
	> RGEasyInputs is free to use without crediting the project (credits are still appreciated).
	> RGEasyInputs is NOT free to sell for anything.
	> RGEasyInputs is NOT free to credit yourself with.
]]
-- =============================================================
display.setStatusBar(display.HiddenStatusBar)  -- Hide that pesky bar
io.output():setvbuf("no") -- Don't use buffer for console messages
-- =============================================================


-- =============================================================
-- Step 1. - Load RGCamera 
-- =============================================================
local camera = require "RGCamera"

-- =============================================================
-- Step 2. - The example
-- =============================================================

--
-- Tip: Camera selection is at bottom of this file.
-- 

--
-- a. Set up some useful variables
--
local centerX 	= display.contentCenterX
local centerY 	= display.contentCenterY
local w 		= display.contentWidth
local h 		= display.contentHeight
local fullw 	= display.actualContentWidth
local fullh 	= display.actualContentHeight

local left 		= centerX - fullw/2
local right 	= centerX + fullw/2
local top 		= centerY - fullh/2
local bottom 	= centerY + fullh/2



--
-- b. Create rendering layers for our game with this
--    final Layer Order (bottom-to-top)
--
--[[

	display.currentStage\
						|---\underlay
						|
						|---\content 
						|
						|---\overlay

--]]
layers 				= display.newGroup()
layers.underlay 	= display.newGroup()
layers.content 		= display.newGroup()
layers.overlay 		= display.newGroup()
layers:insert( layers.underlay )
layers:insert( layers.content )
layers:insert( layers.overlay )


--
-- c. Randomly populate the world with random circles
--
for i = 1, 250 do
	local x = math.random( left - fullw, right + fullw )
	local y = math.random( top - fullw, bottom + fullw )
	local radius = math.random(10,15)
	local tmp = display.newCircle( layers.content, x, y, radius )
	tmp:setFillColor( math.random(), math.random(), math.random() )
	tmp.alpha = 0.25
end

--
-- d. 'Frame' legal bounds of 'world'
--
local tmp = display.newRect( layers.content, centerX, centerY, fullw, fullh )
tmp:setFillColor(0,0,0,0)
tmp:setStrokeColor(1,0,0)
tmp.strokeWidth = 2



--
-- e. Create a 'player' as the camera target
--
local player = display.newImageRect( layers.content, "smiley.png", 40, 40)
player.x = centerX
player.y = centerY

--
-- f. Move the player randomly
--
local spd = 20
player.moveX = math.random(-spd,spd)/5
player.moveY = math.random(-spd,spd)/5
player.enterFrame = function( self )
	self.x = self.x + self.moveX
	self.y = self.y + self.moveY

	if( self.x < left ) then 
		self.x = self.x + 1 
		self.moveX = spd/5
	end
	if( self.x > right ) then 
		self.x = self.x - 1 
		self.moveX = -spd/5
	end
	if( self.y < top ) then 
		self.y = self.y + 1 
		self.moveY = spd/5
	end
	if( self.y > bottom ) then 
		self.y = self.y - 1 
		self.moveY = -spd/5
	end
end
Runtime:addEventListener( "enterFrame", player )

--
-- g. Attach a camera to the player and the 'world'
--
-- Uncomment any ONE of the following lines to see that camera in action
--
camera.tracking( player, layers.content )
--camera.tracking( player, layers.content, { lockX = true, lockY = false } )
--camera.tracking( player, layers.content, { lockX = false, lockY = true } )
--camera.trackingLooseSquare( player, layers.content, { boundarySize = 100 } )
--camera.trackingLooseSquare( player, layers.content, { boundarySize = 160 } )
--camera.trackingLooseCircle( player, layers.content, { debugEn = true } )
--camera.trackingLooseCircle( player, layers.content, { bufferSize = fullh/2, deadRadius = 0, debugEn = true } )
--camera.trackingLooseCircle( player, layers.content, { bufferSize = 10, deadRadius = fullh/2 - 10, debugEn = true } )

