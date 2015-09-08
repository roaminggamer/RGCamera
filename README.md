RGCamera
============

(This module works with or without SSK present.)

RGCamera (part of the SSK library) is a module for creating simple 'camera' systems in Corona SDK.  It provides these cameras and can be easily extended:
 * tracking - A camera that tracks the target exactly with no delay or offset.  
 * loose Square - Similar to tracking, but only moves world if tracked object intersects 'buffer' region.
 * loose Circle - Similar to loose square but using circular bounding regions.
 

Basic Usage
-----------

##### Require the code
```lua
local camera = require "RGCamera"
```

##### Create Some Display Groups
```lua
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
```


##### Create An Object To 'Track'
```lua
local player = display.newImageRect( layers.content, "smiley.png", 40, 40)
player.x = display.contentCenterX
player.y = display.contentCenterY
```


##### Attach A Camera
```lua
camera.tracking( player, layers.content, { lockX = true, lockY = false } )
```



Tracking Camera
-----------
##### Syntax
```lua
camera.tracking( trackObj, world, params )	
```
 * trackObj - Object to track with camera.  World moves around this object.
 * world - Display group that is considered to contain all world objects and sub-groups.
 * params - (Optional) table containing settings.


##### params settings.
 * centered (false) - Force camera to center tracking object on screen.  Otherwise camera assumes starting position of player is center of camera space.
 * lockX (false) - Do not track in the x-axis.
 * lockY (false) - Do not track in the x-axis.


Loose Square Tracking Camera
-----------
##### Syntax
```lua
camera.trackingLooseSquare( trackObj, world, params )	
```
 * trackObj - Object to track with camera.  World moves around this object.
 * world - Display group that is considered to contain all world objects and sub-groups.
 * params - (Optional) table containing settings.


##### params settings.
 * minDelta (0.2) - Error margin for detecting boundary.
 * boundarySize (100) - Size of edge buffer (boundary).  Once the object intrudes on this space, the camera will start to move.  The movement increases from 0% to 100% tracking as the trackObj gets close to the edge of the screen.
 

Loose Circle Tracking Camera
-----------
##### Syntax
```lua
camera.trackingLooseCircle( trackObj, world, params )	
```
 * trackObj - Object to track with camera.  World moves around this object.
 * world - Display group that is considered to contain all world objects and sub-groups.
 * params - (Optional) table containing settings.


##### params settings.
 * debugEn (false) - Draw deadzone and buffer limits.  Shown in cyan and red respectively.
 * deadRadius (100) - Pixel radius of area in which camera does not track object movment at all. (0% tracking zone).
 * bufferSize - Pixel buffer around deadzone in which tracking occurs.  Tracking starts at 0% on edge of deadRadius, and increases to 100% by the time object reaches edge of deadRadius + bufferSize.
 