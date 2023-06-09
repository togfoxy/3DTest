threederotation = {}

function threederotation.getObjectCentre(Obj)
    -- returns x/y/z
    local sumx, sumy, sumz, sumpoints = 0,0,0,0

    if Obj.points == nil then
        -- print(inspect(Obj))
        -- error()
    end

    for j, pt in pairs(Obj.points) do
        sumx = sumx + pt.x
        sumy = sumy + pt.y
        sumz = sumz + pt.z
        sumpoints = sumpoints + 1
    end
    return sumx / sumpoints, sumy / sumpoints, sumz / sumpoints
end

local function getRelativeObject(Obj)
    -- for the given object, normalise the points with respect to the centre of that object
    -- those those normal points inside the same obj

    Obj.centrex, Obj.centrey, Obj.centrez = threederotation.getObjectCentre(Obj)
    local newObj = {}
    newObj.points = {}
    for j, pt in pairs(Obj.points) do
        thispoint = {}
        thispoint.x = pt.x
        thispoint.y = pt.y
        thispoint.z = pt.z
        thispoint.label = pt.label

        -- normalise thispoint
        pt.normalx = pt.x - Obj.centrex
        pt.normaly = pt.y - Obj.centrey
        pt.normalz = pt.z - Obj.centrez
    end
end

local function setNewXY(pt, x2, y2, z2)
    -- this is a common function that takes adjusted xyz and moves them into the real object xyz
    pt.newx = x2
    pt.newy = y2
    pt.newz = z2

    pt.deltax = pt.normalx - pt.newx
    pt.deltay = pt.normaly - pt.newy
    pt.deltaz = pt.normalz - pt.newz

    -- apply the delta on the new object to the old object
    pt.x = pt.x + pt.deltax
    pt.y = pt.y + pt.deltay
    pt.z = pt.z + pt.deltaz

end
function threederotation.rotateObjectXAxis(Obj, angle)

    -- get the relative x/y for each point and store inside same obj
    getRelativeObject(Obj)

    -- transform this new object around its own centre
    for j, pt in pairs(Obj.points) do
       local x2,y2,z2 = threederotation.rotatePointXAxis(pt, angle)
       setNewXY(pt, x2,y2,z2)
    end
end

function threederotation.rotateObjectYAxis(Obj, angle)
    -- get the relative x/y for each point and store inside same obj
    getRelativeObject(Obj)

    for j, pt in pairs(Obj.points) do
       local x2,y2,z2 = threederotation.rotatePointYAxis(pt, angle)
       setNewXY(pt, x2,y2,z2)
    end
end

function threederotation.rotateObjectZAxis(Obj, angle)
    getRelativeObject(Obj)

    for j, pt in pairs(Obj.points) do
       local x2,y2,z2 = threederotation.rotatePointZAxis(pt, angle)
       setNewXY(pt, x2,y2,z2)
    end
end

function threederotation.rotatePointXAxis(point, angle)
    -- point has x,y,z
    -- angle is in degs and then converted to rads
    -- returns 3 new points

    local anglerad = math.rad(angle)

    local x1 = point.normalx
    local y1 = point.normaly
    local z1 = point.normalz

    local x2 = x1
    local y2 = x1 * 0 + y1 * math.cos(anglerad) + (z1 * -1 * math.sin(anglerad))
    local z2 = 0 + y1 * math.sin(anglerad) + z1 * math.cos(anglerad)

    return x2, y2, z2
end
function threederotation.rotatePointYAxis(point, angle)
    local anglerad = math.rad(angle)
    local x1 = point.normalx
    local y1 = point.normaly
    local z1 = point.normalz

    -- print(inspect(point))

    local x2 = x1 * math.cos(anglerad) + 0 + z1 * math.sin(anglerad)
    local y2 = x1 * 0 + y1 * 1 + y1 * 0
    local z2 = x1 * (-1 * math.sin(anglerad)) + y1 * 0 + z1 * math.cos(anglerad)

    return x2, y2, z2
end
function threederotation.rotatePointZAxis(point, angle)
    local anglerad = math.rad(angle)
    local x1 = point.normalx
    local y1 = point.normaly
    local z1 = point.normalz

    local x2 =  x1 * math.cos(anglerad) + y1 * (-1 * math.sin(anglerad)) + z1 * 0
    local y2 = x1 * math.sin(anglerad) + y1 * math.cos(anglerad) + z1 * 0
    local z2 = x1 * 0 + y1 * 0 + z1 * 1

    return x2, y2, z2
end

function threederotation.updateIsoView(Obj)
    -- returns nothing
    for j, pt in pairs(Obj.points) do

        pt.isox = (pt.x - (pt.z * -1)) / math.sqrt(2)
        pt.isoy = (pt.x + 2 * pt.y + (pt.z * -1)) / math.sqrt(6)

    end
end

return threederotation
