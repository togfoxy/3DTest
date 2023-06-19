entity = {}

local function getPlayersEntity()
    for k, ent in pairs(ENTITIES) do
        if ent.guid == PLAYER_GUID then
            return ent
        end
    end
    error()
    return nil
end

local function getObjectCentre(object)
    -- get the average x/y/z for all points in the object to determine the centre of that object
    local sumx, sumy, sumz, sumcount = 0,0,0,0
    for k, point in pairs(object.points) do
        sumx = sumx + point.x
        sumy = sumy + point.y
        sumz = sumz + point.z
        sumcount = sumcount + 1
    end
    return sumx/sumcount, sumy/sumcount, sumz/sumcount
end

local function getPlayersCentre()
    -- returns the avg x/y/z of the players entity
    local playerEntity = getPlayersEntity()

    local sumx, sumy, sumz, sumcount = 0,0,0,0
    for k, object in pairs(playerEntity.objects) do
        local avgx, avgy, avgz = getObjectCentre(object)
        sumx = sumx + avgx
        sumy = sumy + avgy
        sumz = sumz + avgz
        sumcount = sumcount + 1
    end
    return sumx/sumcount, sumy / sumcount, (sumz/ sumcount)
end

local function getPointCoord(pointlabel, view)
    -- input: pointlabel is a text
    -- input: view = enum

    if view == nil then error() end

    for i, ent in pairs(ENTITIES) do
        for k, Obj in pairs(ent.objects) do
            for j, pt in pairs(Obj.points) do
                if pt.label == pointlabel then
                    if view == enum.viewFront then
                        return pt.frontx, pt.fronty, pt.frontz
                    elseif view == enum.viewSide then
                        return pt.sidex, pt.sidey, pt.sidez
                    elseif view == enum.viewTop then
                        return pt.topx, pt.topy, pt.topz
                    elseif view == enum.viewIso then
                        return pt.isox, pt.isoy, pt.isoz
                    end
                end
            end
        end
    end
end

local function addObjectsToPlayerEntity(playerentity)
    local thisobject = {}
    thisobject.points = {}
    thisobject.segments = {}

    if true then    -- box
        local thispoint = {x = 600, y = 700, z = 0, label = 1}
        table.insert(thisobject.points, thispoint)

        local thispoint = {x = 500, y = 800, z = 0, label = 2}
        table.insert(thisobject.points, thispoint)

        local thispoint = {x = 500, y = 700, z = 0, label = 3}
        table.insert(thisobject.points, thispoint)

        local thispoint = {x = 600, y = 750, z = 0, label = 4}
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
    end

    -- line segments
    if true then
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
    end
    table.insert(playerentity.objects, thisobject)
end

local function addObjectsToEnemyEntity(thisentity)

    local thisobject = {}
    thisobject.points = {}
    thisobject.segments = {}

    local thispoint = {x = 700, y = 700, z = 250, label = 51}
    table.insert(thisobject.points, thispoint)

    local thissegment = {}
    thissegment.origin = 1              -- the label of the first point
    thissegment.destination = 3         -- label
    table.insert(thisobject.segments, thissegment)

    table.insert(thisentity.objects, thisobject)
end

function entity.initialiseEntities()
    -- an entity is like a person and can have many objects. Objects are formed by points and segments

    local thisentity = {}
    -- add the player entity
    thisentity.guid = cf.getGUID()
    PLAYER_GUID = thisentity.guid
    thisentity.objects = {}

    addObjectsToPlayerEntity(thisentity)
    table.insert(ENTITIES, thisentity)

    --! add other entities here
    local thisentity = {}
    -- add the player entity
    thisentity.guid = cf.getGUID()
    thisentity.objects = {}

    addObjectsToEnemyEntity(thisentity)
    table.insert(ENTITIES, thisentity)
end

local function updateSideView(Obj)
    -- determine the centre of the object based on two axis
    local playerx, playery, playerz = getPlayersCentre()
    local centrex = playerz
    local centrey = playery

    local offsetx = sideframecentrex - centrex
    local offsety = sideframecentrey - centrey

    -- update points
    for j, pt in pairs(Obj.points) do
        local drawx = pt.z + offsetx
        local drawy = pt.y + offsety
        pt.sidex = drawx
        pt.sidey = drawy
    end
end

local function updateTopView2(Obj)
    -- determine the centre of the player entity
    local playerx, playery, playerz = getPlayersCentre()
    local offsetx = topframecentrex - playerx
    local offsety = topframecentrey + playerz

    -- update points
    for j, pt in pairs(Obj.points) do
        pt.topx = offsetx + pt.x
        pt.topy = offsety + (pt.z * -1)
    end
end

local function updateFrontView(Obj)
    -- translates the native x/y so it is inside the frame

    -- get centre of the object for translation purposes
    local playerx, playery, playerz = getPlayersCentre()
    local centrex = playerx
    local centrey = playery

    -- determine how to translate the object to the frame
    local offsetx = frontframecentrex - centrex
    local offsety = frontframecentrey - centrey

    -- update points
    for j, pt in pairs(Obj.points) do
        pt.frontx = pt.x + offsetx
        pt.fronty = pt.y + offsety
    end
end

local function updateIsoView(Obj)

    threederotation.updateIsoView(Obj)      -- transforms raw to iso but doesn't offset to frame

    local objx, objy, objz = threederotation.getObjectCentre(Obj)
    local offsetx = isoframecentrex - objx
    local offsety = isoframecentrey - objy

    -- update points
    for j, pt in pairs(Obj.points) do
        pt.isox = pt.isox + offsetx
        pt.isoy = pt.isoy + offsety
    end
end

local function drawTopView(pt)
    -- draws one point
    local drawx = pt.topx
    local drawy = pt.topy

    love.graphics.setColor(1,1,1,1)
    love.graphics.circle("fill", drawx, drawy, 5)
    love.graphics.print(pt.label, drawx + 7, drawy + 4)

    love.graphics.circle("line", topframecentrex, topframecentrey, 3)
end

local function drawSideView(pt)
    -- draws one point
    local drawx = pt.sidex
    local drawy = pt.sidey

    love.graphics.setColor(1,1,1,1)
    love.graphics.circle("fill", drawx, drawy, 5)
    -- point label (debugging only)
    love.graphics.print(pt.label, drawx + 7, drawy + 4)
end

local function drawFrontView(pt)
    local drawx = pt.frontx
    local drawy = pt.fronty

    love.graphics.setColor(1,1,1,1)
    love.graphics.circle("fill", drawx, drawy, 5)
    -- point label (debugging only)
    love.graphics.print(pt.label, drawx + 7, drawy + 4)
end

local function drawIsoView(pt)
    love.graphics.setColor(1,1,1,1)
    love.graphics.circle("fill", pt.isox, pt.isoy, 5)
    if DEV_MODE then
        love.graphics.print(pt.label, pt.isox + 7, pt.isoy + 4)
    end
end

local function drawPoint(point)
    -- draws the provided point on all four frames
    drawTopView(point)
    drawFrontView(point)
    drawSideView(point)
    drawIsoView(point)
end

local function drawSegment(seg)
    local p1 = seg.origin               -- these are labels
    local p2 = seg.destination          -- these are labels

    local x1, y1, x2, y2
    x1, y1, z1 = getPointCoord(p1, enum.viewTop)        -- p1 is a label. translates points for different frames
    x2, y2, z2 = getPointCoord(p2, enum.viewTop)        -- p1 is a label
    if x1 ~= nil and x2 ~= nil then                                   --! need to work out how this can be nil
        love.graphics.setColor(1,1,1,1)
        love.graphics.line(x1, y1, x2, y2)
    end

    local x1, y1, x2, y2
    x1, y1, z1 = getPointCoord(p1, enum.viewFront)        -- p1 is a label. translates points for different frames
    x2, y2, z2 = getPointCoord(p2, enum.viewFront)        -- p1 is a label
    if x1 ~= nil and x2 ~= nil then                                   -- can be nil when more segments than points (which is bad)
        love.graphics.setColor(1,1,1,1)
        love.graphics.line(x1, y1, x2, y2)
    end

    local x1, y1, x2, y2
    x1, y1, z1 = getPointCoord(p1, enum.viewSide)        -- p1 is a label. translates points for different frames
    x2, y2, z2 = getPointCoord(p2, enum.viewSide)        -- p1 is a label
    if x1 ~= nil and x2 ~= nil then                                   --! need to work out how this can be nil
        love.graphics.setColor(1,1,1,1)
        love.graphics.line(x1, y1, x2, y2)
    end

    -- iso view
    local x1, y1, x2, y2
    x1, y1, z1 = getPointCoord(p1, enum.viewIso)        -- p1 is a label. translates points for different frames
    x2, y2, z2 = getPointCoord(p2, enum.viewIso)        -- p1 is a label
    if x1 ~= nil and x2 ~= nil then                                   --! need to work out how this can be nil
        love.graphics.setColor(1,1,1,1)
        love.graphics.line(x1, y1, x2, y2)
    end
end

function entity.draw(entity)
    for j, object in pairs(entity.objects) do
        for h, point in pairs(object.points) do
            drawPoint(point)
        end
        for h, segment in pairs(object.segments) do
            drawSegment(segment)            -- draw all segments for all frames
        end
    end
end

function entity.updatePoints(entity)
    -- updates all the translations so they are ready for draw()
    for j, object in pairs(entity.objects) do
        updateSideView(object)
        updateTopView2(object)
        updateFrontView(object)         -- the front view is the native view so no translation needed
        updateIsoView(object)
    end
end

return entity
