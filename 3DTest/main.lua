GAME_VERSION = "0.01"

inspect = require 'lib.inspect'
-- https://github.com/kikito/inspect.lua

res = require 'lib.resolution_solution'
-- https://github.com/Vovkiv/resolution_solution

Camera = require 'lib.cam11.cam11'
-- https://notabug.org/pgimeno/cam11

bitser = require 'lib.bitser'
-- https://github.com/gvx/bitser

nativefs = require 'lib.nativefs'
-- https://github.com/EngineerSmith/nativefs

lovelyToasts = require 'lib.lovelyToasts'
-- https://github.com/Loucee/Lovely-Toasts

-- these are core modules
require 'lib.buttons'
require 'enums'
require 'constants'
fun = require 'functions'
cf = require 'lib.commonfunctions'
ent = require 'entity'

require 'threederotation'

function love.resize(w, h)
	res.resize(w, h)
end

function love.keyreleased( key, scancode )
	if key == "escape" then
		cf.removeScreen(SCREEN_STACK)
	end

	if key == "i" then
		ISO_MODE = not ISO_MODE
	end
end

function love.load()

	_ = love.window.setFullscreen( true )
	res.init({width = 1920, height = 1080, mode = 2})

	local _, _, flags = love.window.getMode()
	local width, height = love.window.getDesktopDimensions(flags.display)
	res.setMode(width, height, {resizable = true})

	constants.load()		-- also loads enums
	fun.loadFonts()
    fun.loadAudio()
	fun.loadImages()

	-- mainmenu.loadButtons()

	cam = Camera.new(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2, 1)
	cam:setZoom(ZOOMFACTOR)
	cam:setPos(TRANSLATEX,	TRANSLATEY)

	love.window.setTitle("3D Test " .. GAME_VERSION)

	love.keyboard.setKeyRepeat(true)

	cf.addScreen(enum.sceneMainMenu, SCREEN_STACK)

	lovelyToasts.canvasSize = {SCREEN_WIDTH, SCREEN_HEIGHT}
	lovelyToasts.options.tapToDismiss = true
	lovelyToasts.options.queueEnabled = true
	-- =============================================

	ent.initialiseEntities()
end

function love.draw()
    res.start()
	-- cam:attach()

	-- draw the frames
	love.graphics.getColor(1,1,1,0.25)
	love.graphics.rectangle("line", sideframex, sideframey, sideframewidth, sideframeheight)
	love.graphics.print("Side", sideframex + 5, sideframey + 5)

    love.graphics.rectangle("line", topframex, topframey, topframewidth, topframeheight)
	love.graphics.print("Top", topframex + 5, topframey + 5)

	love.graphics.rectangle("line", frontframex, frontframey, frontframewidth, frontframeheight)
	love.graphics.print("Front", frontframex + 5, frontframey + 5)

	-- cycle through all entities and draw the objects, points and segments within
    for k, entity in pairs(ENTITIES) do
		ent.draw(entity)
    end

	-- cam:detach()
    res.stop()
end

function love.update(dt)

	--! update the three views
	-- cycle through all entities and update the four co-ordinates
	for k, entity in pairs(ENTITIES) do
		ent.updatePoints(entity)
	end

	if love.keyboard.isDown("up") then
		for _, Obj in pairs(OBJECTS) do
			threederotation.rotateObjectXAxis(Obj, 1)		-- 1 deg
		end
	end

	if love.keyboard.isDown("down") then
		threederotation.rotateObjectXAxis(OBJECTS[1], -1)		-- 1 deg
	end

	if love.keyboard.isDown("left") then
		threederotation.rotateObjectYAxis(OBJECTS[1], -1)
	end
	if love.keyboard.isDown("right") then
		threederotation.rotateObjectYAxis(OBJECTS[1], 1)
	end

	if love.keyboard.isDown("delete") then
		threederotation.rotateObjectZAxis(OBJECTS[1], -1)
	end
	if love.keyboard.isDown("pagedown") then
		threederotation.rotateObjectZAxis(OBJECTS[1], 1)
	end

	cam:setZoom(ZOOMFACTOR)
end
