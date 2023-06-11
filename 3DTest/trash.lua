
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
