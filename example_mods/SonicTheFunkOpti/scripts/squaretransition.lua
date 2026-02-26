local transSquares = {}
local transitionSpeed = 1
local squareScaleDuration = 0.4
local maxSize = 1.6
local minSize = 0.01
local easeTypeOut = 'quadOut'
local easeTypeIn = 'quadIn'

local squareSize = 80
local spacing = 10
local screenWidth = 1280
local screenHeight = 720
local columns = math.floor(screenWidth / (squareSize + spacing)) + 1
local rows = math.floor(screenHeight / (squareSize + spacing)) + 1

local function clearSquares()
    for _, name in ipairs(transSquares) do
        if doesLuaSpriteExist(name) then
            removeLuaSprite(name, true)
        end
    end
    transSquares = {}
end

local function createSquares()
    local newSquares = {}
    local count = 0

    for y = 0, rows - 1 do
        for x = 0, columns - 1 do
            local squareN = 'transSquare' .. count .. '_' .. tostring(math.random(1, 99999))
            local posX = x * (squareSize + spacing)
            local posY = y * (squareSize + spacing)

            makeLuaSprite(squareN, '', posX, posY)
            makeGraphic(squareN, squareSize, squareSize, '000000')
            setObjectCamera(squareN, 'camOther')
            setProperty(squareN .. '.angle', 45)
            setProperty(squareN .. '.antialiasing', true)
            setProperty(squareN .. '.alpha', 0)
            setProperty(squareN .. '.scale.x', minSize)
            setProperty(squareN .. '.scale.y', minSize)
            addLuaSprite(squareN, false)

            table.insert(newSquares, squareN)
            count = count + 1
            if luaSpriteExists('pauseOVERLAY') then
                setObjectOrder(squareN, getObjectOrder('pauseOVERLAY') - 1)
            else
                if luaSpriteExists('cursor') then
                    setObjectOrder(squareN, getObjectOrder('cursor') + 1)
                end
            end
            if luaSpriteExists('gameoveractive') and getProperty('gameoveractive.x') == 1 then
                setObjectOrder(squareN, getObjectOrder('GOshoe2') + 1)
            end
        end
    end

    return newSquares
end

function transIn()
    transSquares = createSquares()

    local delayPerRow = transitionSpeed / 16

    for i, name in ipairs(transSquares) do
        setProperty(name .. '.alpha', 0)
        setProperty(name .. '.scale.x', minSize)
        setProperty(name .. '.scale.y', minSize)

        local y = getProperty(name .. '.y')
        local rowIndex = math.floor(y / (squareSize + spacing))
        local delay = rowIndex * delayPerRow

        runTimer(name .. '_start', delay)
    end
end

function transOut()
    clearSquares()
    transSquares = createSquares()

    local delayPerRow = transitionSpeed / 16

    for i, name in ipairs(transSquares) do
        setProperty(name .. '.alpha', 1)
        setProperty(name .. '.scale.x', maxSize)
        setProperty(name .. '.scale.y', maxSize)

        local y = getProperty(name .. '.y')
        local rowIndex = math.floor(y / (squareSize + spacing))
        local delay = rowIndex * delayPerRow

        runTimer(name .. '_hide', delay)
    end
end

function onTimerCompleted(tag)
    if stringEndsWith(tag, '_start') then
        local name = tag:sub(1, #tag - 6)
        setProperty(name .. '.alpha', 1)
        doTweenX(name .. '_growX', name .. '.scale', maxSize, squareScaleDuration, easeTypeIn)
        doTweenY(name .. '_growY', name .. '.scale', maxSize, squareScaleDuration, easeTypeIn)
    elseif stringEndsWith(tag, '_hide') then
        local name = tag:sub(1, #tag - 5)
        doTweenX(name .. '_shrinkX', name .. '.scale', minSize, squareScaleDuration, easeTypeOut)
        doTweenY(name .. '_shrinkY', name .. '.scale', minSize, squareScaleDuration, easeTypeOut)
        runTimer(name .. '_penistransition', squareScaleDuration)
    elseif stringEndsWith(tag, '_penistransition') then
        local name = tag:sub(1, #tag - 16)
        setProperty(name .. '.alpha', 0)
        if doesLuaSpriteExist(name) then
            removeLuaSprite(name, true)
        end
        for i = #transSquares, 1, -1 do
            if transSquares[i] == name then
                table.remove(transSquares, i)
                break
            end
        end
    end
end

function onCreatePost()
    makeLuaSprite('transInIndicator')
    makeGraphic('transInIndicator', 1, 1, 'ffffff')
    setProperty('transInIndicator.alpha', 0)
    addLuaSprite('transInIndicator', false)
    setObjectCamera('transInIndicator', 'hud')
    setProperty('transInIndicator.x', 0)

    makeLuaSprite('transOutIndicator')
    makeGraphic('transOutIndicator', 1, 1, 'ffffff')
    setProperty('transOutIndicator.alpha', 0)
    addLuaSprite('transOutIndicator', false)
    setObjectCamera('transOutIndicator', 'hud')
    setProperty('transOutIndicator.x', 0)


    setPropertyFromClass('flixel.addons.transition.FlxTransitionableState', 'skipNextTransOut', true)
    if luaSpriteExists('menuIntroindicator') and getProperty('menuIntroindicator.x') == 0 then
    else
        transOut()
    end
end

function onUpdatePost()
    if getProperty('transInIndicator.x') == 1 then
        setProperty('transInIndicator.x', 0)
        transIn()
    end
    if getProperty('transOutIndicator.x') == 1 then
        setProperty('transOutIndicator.x', 0)
        transOut()
    end
end
