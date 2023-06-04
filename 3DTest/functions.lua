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

local function createPoint(pointstable, x, y, z, label)
    local thispoint = {}
    thispoint.x = x
    thispoint.y = y
    thispoint.z = z
    thispoint.label = label
    table.insert(pointstable, thispoint)
end

local function createLineSegment(segmenttable, origin, destination)
    local thissegment = {}
    thissegment.origin = origin              -- the label of the first point
    thissegment.destination = destination         -- label
    table.insert(segmenttable, thissegment)
end

local function initialisePerson()
    local thisobject = {}
    thisobject.points = {}
    thisobject.segments = {}
    thisobject.objlabel = enum.partHead
    local originx = SCREEN_WIDTH / 2
    local originy = 300
    local originz = 0

    -- head
    local headwidth = 75
    local headheight = 90
    local headcentrex = originx + (headwidth / 2)
    createPoint(thisobject.points, originx, originy, originz, 1)
    createPoint(thisobject.points, originx + headwidth, originy, originz, 2)
    createPoint(thisobject.points, originx, originy + headheight, originz, 3)
    createPoint(thisobject.points, originx + headwidth, originy + headheight, originz, 4)

    createLineSegment(thisobject.segments, 1, 2)
    createLineSegment(thisobject.segments, 1, 3)
    createLineSegment(thisobject.segments, 3, 4)
    createLineSegment(thisobject.segments, 2, 4)

    table.insert(OBJECTS, thisobject)

    -- body
    local thisobject = {}
    thisobject.points = {}
    thisobject.segments = {}
    thisobject.objlabel = enum.partTorso

    local bodywidth = headwidth * 1.5
    local bodyheight = headheight * 2
    local bodyoriginx = headcentrex - (bodywidth / 2)
    local bodyoriginy = originy + headheight
    createPoint(thisobject.points, bodyoriginx, bodyoriginy, originz, 5)
    createPoint(thisobject.points, bodyoriginx + bodywidth, bodyoriginy, originz, 6)
    createPoint(thisobject.points, bodyoriginx, bodyoriginy + bodyheight, originz, 7)
    createPoint(thisobject.points, bodyoriginx + bodywidth, bodyoriginy + bodyheight, originz, 8)

    createLineSegment(thisobject.segments, 5, 6)
    createLineSegment(thisobject.segments, 5, 7)
    createLineSegment(thisobject.segments, 6, 8)
    createLineSegment(thisobject.segments, 7, 8)

    table.insert(OBJECTS, thisobject)

end

function functions.initialiseObject()
    initialisePerson()

end

local function getPointCoord(pointlabel)
    -- input: pointlabel is a text

    for k, Obj in pairs(OBJECTS) do
        for j, pt in pairs(Obj.points) do
            if pt.label == pointlabel then
                return pt.x, pt.y, pt.z
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

function functions.drawObjects()

    for k, Obj in pairs(OBJECTS) do
        -- draw points

        if Obj.objlabel == SELECTED_OBJECT then
            love.graphics.setColor(0,1,1,1)
        else
            love.graphics.setColor(1,1,1,1)
        end

        if ISO_MODE then
    		threederotation.changeObjectToIsometric(Obj)           -- updates isox and isoy
        end

        -- draw the points
        if DEV_MODE then
            for j, pt in pairs(Obj.points) do
                if ISO_MODE then
                    drawx = pt.isox
                    drawy = pt.isoy

                    -- love.graphics.setColor(1,1,1,1)
                    love.graphics.circle("fill", drawx, drawy, 5)
                else
                    local drawx = pt.x
                    local drawy = pt.y

                    if DEV_MODE then
                        -- love.graphics.setColor(1,1,1,1)
                        love.graphics.circle("fill", drawx, drawy, 5)
                    end

                    -- draw the centre of the object
                    if DEV_MODE then
                        local centrex, centrey, _ = threederotation.getObjectCentre(Obj)
                        -- love.graphics.setColor(1,0,0,1)
                        love.graphics.circle("line", centrex, centrey, 5)
                    end

                    -- print label (debugging only)
                    if DEV_MODE then
                        love.graphics.print(pt.label, drawx, drawy)
                    end
                end
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

                -- love.graphics.setColor(1,1,1,1)
                love.graphics.line(x1, y1, x2, y2)
            end
        end
    end
end

function functions.rotateDown()

    if SELECTED_OBJECT == enum.partHead then
        threederotation.rotateObjectXAxis(OBJECTS[1], -1, 3)		-- 1 deg
    elseif SELECTED_OBJECT == enum.partTorso then
        threederotation.rotateObjectXAxis(OBJECTS[1], -1, 7)		-- 1 deg
        threederotation.rotateObjectXAxis(OBJECTS[2], -1, 7)		-- 1 deg
    end
end

return functions
