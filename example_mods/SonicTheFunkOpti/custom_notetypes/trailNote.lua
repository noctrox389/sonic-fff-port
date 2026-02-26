local shadowCount = 0
local trailTimers = {}
local lingering = {}

local shadowAlpha = 0.4               
local trailFloatDistance = 100        
local trailFloatTime = 0.8            
local lingerTime = 1.3                

function goodNoteHit(id, dir, noteType, sus)
    if noteType == "trailNote" and not sus then
        handleTrailNote("boyfriend", dir)
    end
end

function opponentNoteHit(id, dir, noteType, sus)
    if noteType == "trailNote" and not sus then
        handleTrailNote("dad", dir)
    end
end

function handleTrailNote(char, dir)
    startTrail(char)
    lingerOnFrame(char, dir)
end

function startTrail(char)
    trailTimers[char] = {
        remaining = 3,
        trailAlpha = shadowAlpha 
    }
end

function onBeatHit()
    for char, data in pairs(trailTimers) do
        if data.remaining > 0 then
            createTrail(char, data.trailAlpha)
            data.trailAlpha = data.trailAlpha - 0.05 
            if data.remaining <= 1 then
                trailTimers[char] = nil
            end
            data.remaining = data.remaining - 1
        end
    end
end

-- Linger on frame 3 of sing animation
function lingerOnFrame(char, dir)
    if lingering[char] then return end  

    local animName = getSingAnim(dir, char)
    playAnim(char, animName, true)
    setProperty(char .. '.specialAnim', true) 

    runTimer("linger_" .. char, lingerTime) 
    lingering[char] = true

    runTimer("pause_" .. char, 0.03)
end

function onTimerCompleted(tag)
    if tag:find("pause_") then
        local char = tag:gsub("pause_", "")
        objectPlayAnimation(char, getProperty(char .. ".animation.curAnim.name"), false)
        setProperty(char .. ".animation.curAnim.curFrame", 2) -- frame 3 (0-indexed)
        setProperty(char .. ".animation.curAnim.paused", true)

    elseif tag:find("linger_") then
        local char = tag:gsub("linger_", "")
        setProperty(char .. '.specialAnim', false)  
        setProperty(char .. ".animation.curAnim.paused", false)
        lingering[char] = false
    end
end

function getSingAnim(dir, char)
    local directions = { "LEFT", "DOWN", "UP", "RIGHT" }
    return "sing" .. directions[dir + 1]
end

function createTrail(char, alpha)
    if getProperty(char .. ".alpha") == 0 then
        return
    end

    if shadowCount > 999 then shadowCount = 0 end
    local tag = "trailCopy" .. shadowCount

    local image = getProperty(char .. ".imageFile")
    local frameName = getProperty(char .. ".animation.frameName")
    local x = getProperty(char .. ".x")
    local y = getProperty(char .. ".y")
    local scaleX = getProperty(char .. ".scale.x")
    local scaleY = getProperty(char .. ".scale.y")
    local flipX = getProperty(char .. ".flipX")
    local offsetX = getProperty(char .. ".offset.x")
    local offsetY = getProperty(char .. ".offset.y")

    makeAnimatedLuaSprite(tag, image, x, y)
    addAnimationByPrefix(tag, "copy", frameName, 0, false)
    playAnim(tag, "copy", true)

    scaleObject(tag, scaleX, scaleY)
    setProperty(tag .. ".flipX", flipX)
    setProperty(tag .. ".offset.x", offsetX)
    setProperty(tag .. ".offset.y", offsetY)
    setProperty(tag .. ".alpha", alpha)
    setBlendMode(tag, "add")

    addLuaSprite(tag, false)
    setObjectOrder(tag, getObjectOrder(char .. "Group") - 1)

    doTweenY("trailMove" .. tag, tag, y - trailFloatDistance, trailFloatTime, "quadOut")
    doTweenAlpha("trailFade" .. tag, tag, 0, trailFloatTime, "quadIn")

    shadowCount = shadowCount + 1
end

function onTweenCompleted(tag)
    if tag:find("trailFade") then
        local spr = tag:gsub("trailFade", "")
        removeLuaSprite(spr, true)
    end
end
