constants = {}

function constants.load()

    GAME_VERSION = "1.0"

    SCREEN_STACK = {}

    -- SCREEN_WIDTH, SCREEN_HEIGHT = love.window.getDesktopDimensions(1)
    SCREEN_WIDTH, SCREEN_HEIGHT = res.getGame()

    -- camera
    ZOOMFACTOR = 0.7
    TRANSLATEX = cf.round(SCREEN_WIDTH / 2)		-- starts the camera in the middle of the ocean
    TRANSLATEY = cf.round(SCREEN_HEIGHT / 2)	-- need to round because this is working with pixels

    cam = nil       -- camera
    AUDIO = {}
    MUSIC_TOGGLE = true     --! will need to build these features later
    SOUND_TOGGLE = true

    IMAGE = {}
    FONT = {}

    -- set the folders based on fused or not fused
    savedir = love.filesystem.getSourceBaseDirectory()
    if love.filesystem.isFused() then
        savedir = savedir .. "\\savedata\\"
    else
        savedir = savedir .. "/FormulaSpeed/savedata/"
    end

    enums.load()
    -- add extra items below this line

    ENTITIES = {}           -- entities contain objects
    OBJECTS = {}

    PLAYER_GUID = nil

    DEV_MODE = true             --! move to love.load()

    -- frame data
    topframex = 5
    topframey = 5
    topframewidth = 500
    topframeheight = 590
    topframecentrex = topframex + (topframewidth / 2)
    topframecentrey = topframey + (topframeheight / 2)

    sideframex = 510
    sideframey = 600
    sideframewidth = 500
    sideframeheight = 450
    sideframecentrex = sideframex + (sideframewidth / 2)
    sideframecentrey = sideframey + (sideframeheight / 2)

    frontframex = 5
    frontframey = 600
    frontframewidth = 500
    frontframeheight = 450
    frontframecentrex = frontframewidth / 2 + frontframex
    frontframecentrey = frontframeheight / 2 + frontframey

    isoframecentrex = 1100
    isoframecentrey = 300
end

return constants
