functions = {}

function functions.loadImages()
    -- IMAGE[enum.imageXXX] = love.graphics.newImage("assets/images/XXX.png")
end

function functions.loadFonts()
    FONT[enum.fontDefault] = love.graphics.newFont("assets/fonts/Vera.ttf", 12)
    FONT[enum.fontMedium] = love.graphics.newFont("assets/fonts/Vera.ttf", 14)
    FONT[enum.fontLarge] = love.graphics.newFont("assets/fonts/Vera.ttf", 18)
    FONT[enum.fontCorporate] = love.graphics.newFont("assets/fonts/CorporateGothicNbpRegular-YJJ2.ttf", 36)
    FONT[enum.fontalienEncounters48] = love.graphics.newFont("assets/fonts/aliee13.ttf", 48)

    love.graphics.setFont(FONT[enum.fontDefault])
end

function functions.loadAudio()
    -- AUDIO[enum.audioMainMenu] = love.audio.newSource("assets/audio/XXX.mp3", "stream")
end

local function initialiseBox()
    local thisobject = {}
    thisobject.points = {}
    thisobject.segments = {}

    local thispoint = {}
    thispoint.x = 600
    thispoint.y = 700
    thispoint.z = 0
    thispoint.label = 1
    table.insert(thisobject.points, thispoint)

    local thispoint = {}
    thispoint.x = 300
    thispoint.y = 800
    thispoint.z = 0
    thispoint.label = 2
    table.insert(thisobject.points, thispoint)

    local thispoint = {}
    thispoint.x = 300
    thispoint.y = 700
    thispoint.z = 0
    thispoint.label = 3
    table.insert(thisobject.points, thispoint)

    local thispoint = {}
    thispoint.x = 600
    thispoint.y = 800
    thispoint.z = 0
    thispoint.label = 4
    table.insert(thisobject.points, thispoint)

    -- ***  z-plane points
    local thispoint = {}
    thispoint.x = 600
    thispoint.y = 700
    thispoint.z = 200
    thispoint.label = 5
    table.insert(thisobject.points, thispoint)

    local thispoint = {}
    thispoint.x = 300
    thispoint.y = 800
    thispoint.z = 200
    thispoint.label = 6
    table.insert(thisobject.points, thispoint)

    local thispoint = {}
    thispoint.x = 300
    thispoint.y = 700
    thispoint.z = 200
    thispoint.label = 7
    table.insert(thisobject.points, thispoint)

    local thispoint = {}
    thispoint.x = 600
    thispoint.y = 800
    thispoint.z = 200
    thispoint.label = 8
    table.insert(thisobject.points, thispoint)

    -- line segments
    local thissegment = {}
    thissegment.origin = 1              -- the label of the first point
    thissegment.destination = 3         -- label
    table.insert(thisobject.segments, thissegment)
    local thissegment = {}
    thissegment.origin = 1              -- the label of the first point
    thissegment.destination = 4         -- label
    table.insert(thisobject.segments, thissegment)
    local thissegment = {}
    thissegment.origin = 1              -- the label of the first point
    thissegment.destination = 5         -- label
    table.insert(thisobject.segments, thissegment)

    local thissegment = {}
    thissegment.origin = 2              -- the label of the first point
    thissegment.destination = 3         -- label
    table.insert(thisobject.segments, thissegment)
    local thissegment = {}
    thissegment.origin = 2              -- the label of the first point
    thissegment.destination = 4         -- label
    table.insert(thisobject.segments, thissegment)
    local thissegment = {}
    thissegment.origin = 2              -- the label of the first point
    thissegment.destination = 6         -- label
    table.insert(thisobject.segments, thissegment)

    local thissegment = {}
    thissegment.origin = 3              -- the label of the first point
    thissegment.destination = 7         -- label
    table.insert(thisobject.segments, thissegment)

    local thissegment = {}
    thissegment.origin = 4              -- the label of the first point
    thissegment.destination = 8         -- label
    table.insert(thisobject.segments, thissegment)

    local thissegment = {}
    thissegment.origin = 5              -- the label of the first point
    thissegment.destination = 7         -- label
    table.insert(thisobject.segments, thissegment)
    local thissegment = {}
    thissegment.origin = 5              -- the label of the first point
    thissegment.destination = 8         -- label
    table.insert(thisobject.segments, thissegment)

    local thissegment = {}
    thissegment.origin = 6              -- the label of the first point
    thissegment.destination = 7         -- label
    table.insert(thisobject.segments, thissegment)
    local thissegment = {}
    thissegment.origin = 6              -- the label of the first point
    thissegment.destination = 8         -- label
    table.insert(thisobject.segments, thissegment)

    table.insert(OBJECTS, thisobject)
end

local function initialisePerson()
    local thisobject = {}
    thisobject.points = {}
    thisobject.segments = {}

    local thispoint = {}
    thispoint.x = 1000
    thispoint.y = 600
    thispoint.z = 0
    thispoint.label = 1
    table.insert(thisobject.points, thispoint)

    local thispoint = {}
    thispoint.x = 1000
    thispoint.y = 700
    thispoint.z = 0
    thispoint.label = 2
    table.insert(thisobject.points, thispoint)

    local thispoint = {}
    thispoint.x = 975
    thispoint.y = 800
    thispoint.z = 0
    thispoint.label = 3
    table.insert(thisobject.points, thispoint)

    local thispoint = {}
    thispoint.x = 1025
    thispoint.y = 800
    thispoint.z = 0
    thispoint.label = 4
    table.insert(thisobject.points, thispoint)

    local thissegment = {}
    thissegment.origin = 1              -- the label of the first point
    thissegment.destination = 2         -- label
    table.insert(thisobject.segments, thissegment)

    local thissegment = {}
    thissegment.origin = 2              -- the label of the first point
    thissegment.destination = 3         -- label
    table.insert(thisobject.segments, thissegment)

    local thissegment = {}
    thissegment.origin = 2              -- the label of the first point
    thissegment.destination = 4         -- label
    table.insert(thisobject.segments, thissegment)

    table.insert(OBJECTS, thisobject)

end

function functions.initialiseObject()
    initialisePerson()
end

local function getPointCoord(pointlabel, view)
    -- input: pointlabel is a text
    -- input: view = enum

    if view == nil then error() end

    for k, Obj in pairs(OBJECTS) do
        for j, pt in pairs(Obj.points) do
            if pt.label == pointlabel then
                if view == enum.viewFront then
                    return pt.x, pt.y, pt.z
                elseif view == enum.viewSide then
                    return pt.sidex, pt.sidey, pt.sidez
                elseif view == enum.viewTop then
                    return pt.topx, pt.topy, pt.topz
                end
            end
        end
    end
end

local function getIsoPointCoord(pointlabel)
    -- input: pointlabel is a text

    for k, Obj in pairs(OBJECTS) do
        for j, pt in pairs(Obj.points) do
            if pt.label == pointlabel then
                return pt.isox, pt.isoy, pt.isoz
            end
        end
    end
end

local function updateSideView(Obj)

    local framex = 500
    local framey = 600
    local framewidth = 500
    local frameheight = 500
    local framecentrex = framex + (framewidth / 2)
    local framecentrey = framey + (frameheight / 2)

    -- determine the centre of the object based on two axis
    local sumy, sumz, sumpoints = 0,0,0
    for j, pt in pairs(Obj.points) do
        -- sumx = sumx + pt.x
        sumy = sumy + pt.y
        sumz = sumz + pt.z
        sumpoints = sumpoints + 1
    end
    local centrex = sumz/sumpoints
    local centrey = sumy/sumpoints

    local offsetx = framecentrex - centrex
    local offsety = framecentrey - centrey

    -- update points
    for j, pt in pairs(Obj.points) do
        local drawx = pt.z + offsetx
        local drawy = pt.y + offsety
        pt.sidex = drawx
        pt.sidey = drawy
    end
end

local function updateTopView(Obj)
    local framex = 5
    local framey = 5
    local framewidth = 500
    local frameheight = 590
    local framecentrex = framex + (framewidth / 2)
    local framecentrey = framey + (frameheight / 2)

    -- determine the centre of the object based on two axis
    local sumx, sumz, sumpoints = 0,0,0
    for j, pt in pairs(Obj.points) do
        -- sumx = sumx + pt.x
        sumx = sumx + pt.x
        sumz = sumz + pt.z
        sumpoints = sumpoints + 1
    end
    local centrex = sumx/sumpoints
    local centrey = sumz/sumpoints

    local offsetx = framecentrex - centrex
    local offsety = framecentrey - centrey

    -- update points
    for j, pt in pairs(Obj.points) do
        local drawx = pt.x + offsetx        --! simplify this
        local drawy = pt.z + offsety
        pt.topx = drawx
        pt.topy = drawy
    end
end

local function drawTopView()

    local framex = 5
    local framey = 5
    local framewidth = 500
    local frameheight = 590
    local framecentrex = framex + (framewidth / 2)
    local framecentrey = framey + (frameheight / 2)

    -- draw frame
    love.graphics.getColor(1,1,1,1)
    love.graphics.rectangle("line", framex, framey, framewidth, frameheight)

    for k, Obj in pairs(OBJECTS) do
        updateTopView(Obj)
        -- draw points
        for j, pt in pairs(Obj.points) do
            local drawx = pt.sidex
            local drawy = pt.sidey

            love.graphics.setColor(1,1,1,1)
            love.graphics.circle("fill", drawx, drawy, 5)
            -- point label (debugging only)
            love.graphics.print(pt.label, drawx + 7, drawy + 4)
        end

        -- draw segments
        for k, seg in pairs(Obj.segments) do
        --
            local p1 = seg.origin               -- these are labels
            local p2 = seg.destination          -- these are labels
        --
            local x1, y1, x2, y2
            x1, y1, z1 = getPointCoord(p1, enum.viewTop)        -- p1 is a label
            x2, y2, z2 = getPointCoord(p2, enum.viewTop)        -- p1 is a label
        --

        --
            if x1 ~= nil then
                love.graphics.setColor(1,1,1,1)
                love.graphics.line(x1, y1, x2, y2)
            end
        end
    end
end

local function drawFrontView()
    -- currently includes the player image but eventually won't

    local framex = 5
    local framey = 600
    local framewidth = 500
    local frameheight = SCREEN_HEIGHT - framey - 5
    local framecentrex = framewidth / 2 + framex
    local framecentrey = frameheight / 2 + framey

    -- draw frame
    love.graphics.getColor(1,1,1,1)
    love.graphics.rectangle("line", framex, framey, framewidth, frameheight)

    for k, Obj in pairs(OBJECTS) do

        -- draw the centre of the object
        local centrex, centrey, _ = threederotation.getObjectCentre(Obj)        --! not right
        love.graphics.setColor(1,0,0,1)
        love.graphics.circle("line", centrex, centrey, 5)

        -- determine how to translate the object to the frame
        local offsetx = framecentrex - centrex
        local offsety = framecentrey - centrey

        -- draw points
        for j, pt in pairs(Obj.points) do
            local drawx = pt.x + offsetx
            local drawy = pt.y + offsety

            love.graphics.setColor(1,1,1,1)
            love.graphics.circle("fill", drawx, drawy, 5)
            -- point label (debugging only)
            love.graphics.print(pt.label, drawx + 7, drawy + 4)
        end

        -- draw segments
        for k, seg in pairs(Obj.segments) do

            local p1 = seg.origin               -- these are labels
            local p2 = seg.destination          -- these are labels

            local x1, y1, x2, y2
            x1, y1, z1 = getPointCoord(p1, enum.viewFront)        -- p1 is a label
            x2, y2, z2 = getPointCoord(p2, enum.viewFront)        -- p1 is a label

            -- translate the segment so it is inside the frame
            x1 = x1 + offsetx
            x2 = x2 + offsetx
            y1 = y1 + offsety
            y2 = y2 + offsety

            if x1 ~= nil then
                love.graphics.setColor(1,1,1,1)
                love.graphics.line(x1, y1, x2, y2)
            end
        end
    end
end

local function drawSideView()
    local framex = 510
    local framey = 600
    local framewidth = 500
    local frameheight = 500
    local framecentrex = framex + (framewidth / 2)
    local framecentrey = framey + (frameheight / 2)

    -- draw frame
    love.graphics.getColor(1,1,1,1)
    love.graphics.rectangle("line", framex, framey, framewidth, frameheight)
    love.graphics.circle("line", framecentrex, framecentrey, 5)

    for k, Obj in pairs(OBJECTS) do
        updateSideView(Obj)
        -- draw points
        for j, pt in pairs(Obj.points) do
            local drawx = pt.sidex
            local drawy = pt.sidey

            love.graphics.setColor(1,1,1,1)
            love.graphics.circle("fill", drawx, drawy, 5)
            -- point label (debugging only)
            love.graphics.print(pt.label, drawx + 7, drawy + 4)
        end

        -- draw segments
        for k, seg in pairs(Obj.segments) do
        --
            local p1 = seg.origin               -- these are labels
            local p2 = seg.destination          -- these are labels
        --
            local x1, y1, x2, y2
            x1, y1, z1 = getPointCoord(p1, enum.viewSide)        -- p1 is a label
            x2, y2, z2 = getPointCoord(p2, enum.viewSide)        -- p1 is a label
        --

        --
            if x1 ~= nil then
                love.graphics.setColor(1,1,1,1)
                love.graphics.line(x1, y1, x2, y2)
            end
        end
    end
end

function functions.drawObjects2()

    -- draw side view at bottom of screen
    drawSideView()

    -- draw top down view in top left corner of screen
    drawTopView()

    -- draw the forward view in bottom left of screen
    drawFrontView()


    -- draw iso top right corner of screen

end

function functions.drawObjects()

    for k, Obj in pairs(OBJECTS) do
        -- draw points

        if ISO_MODE then
    		threederotation.changeObjectToIsometric(OBJECTS[1])           -- updates isox and isoy
        end

        for j, pt in pairs(Obj.points) do
            if ISO_MODE then
                drawx = pt.isox
                drawy = pt.isoy

                love.graphics.setColor(1,1,1,1)
                love.graphics.circle("fill", drawx, drawy, 5)
            else
                local drawx = pt.x
                local drawy = pt.y

                love.graphics.setColor(1,1,1,1)
                love.graphics.circle("fill", drawx, drawy, 5)

                -- draw the centre of the object
                local centrex, centrey, _ = threederotation.getObjectCentre(Obj)
                love.graphics.setColor(1,0,0,1)
                love.graphics.circle("line", centrex, centrey, 5)

                -- point label (debugging only)
                -- love.graphics.print(pt.label, drawx, drawy)
            end
        end

        -- draw segments
        for k, seg in pairs(Obj.segments) do

            local p1 = seg.origin               -- these are labels
            local p2 = seg.destination          -- these are labels

            local x1, y1, x2, y2
            if ISO_MODE then
                x1, y1, z1 = getIsoPointCoord(p1)        -- p1 is a label
                x2, y2, z2 = getIsoPointCoord(p2)        -- p1 is a label
            else
                x1, y1, z1 = getPointCoord(p1)        -- p1 is a label
                x2, y2, z2 = getPointCoord(p2)        -- p1 is a label
            end

            if x1 ~= nil then

                love.graphics.setColor(1,1,1,1)
                love.graphics.line(x1, y1, x2, y2)
            end
        end
    end
end

return functions
