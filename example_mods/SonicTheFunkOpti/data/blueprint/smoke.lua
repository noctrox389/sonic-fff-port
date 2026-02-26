
smoke = false
local smokeTimer = 0
local smokeSpawnRate = 0.25
local smokeDuration = 1
function onCreatePost()
    makeLuaSprite('smokeindicator') --
    makeGraphic('smokeindicator', 1, 1, 'ffffff') --0000ff
    setProperty('smokeindicator.alpha', 0)
    addLuaSprite('smokeindicator', false)
    setObjectCamera('smokeindicator', 'hud')
    setProperty('smokeindicator.x', 0) --1=smoke 0=no smoke
end

function onUpdatePost()
    if getProperty('bosshealth.x') == 0  and getProperty('smokeindicator.x') == 0 then
        setProperty('smokeindicator.x', 1)
    end
    if getProperty('bosshealth.x') == 0  and getProperty('oppcanbehurt.x') == 0 then
        setProperty('oppcanbehurt.x', 1)
    end
    if getProperty('smokeindicator.x') == 1 then
        smoke = true
    else
       smoke = false
    end
end

function onUpdate(elapsed)
    if smoke then
        smokeTimer = smokeTimer + elapsed

        if smokeTimer >= smokeSpawnRate then
            smokeTimer = 0
            spawnSmoke()
        end
    else
        smokeTimer = 0
    end
end

function spawnSmoke()
    local smokeID = 'smoke' .. getRandomInt(0, 999999)

    local dadX = getProperty('dad.x') - 150
    local dadY = getProperty('dad.y') - 100

    -- Create animated sprite
    makeAnimatedLuaSprite(smokeID, 'smoke', dadX + getRandomInt(100, 200), dadY + getRandomInt(100, 200))
    addAnimationByPrefix(smokeID, 'idle', 'smoke', 24, true) -- 24 FPS, looping
    objectPlayAnimation(smokeID, 'idle', true)
    addLuaSprite(smokeID, true)
    setObjectCamera(smokeID, 'game')
    setProperty(smokeID..'.alpha', 1)
    setProperty(smokeID..'.scale.x', 0.1)
    setProperty(smokeID..'.scale.y', 0.1)

    -- Random offset left & up
    local offsetX = getRandomInt(-100, 150)
    local offsetY = getRandomInt(-150, -100)

    -- Tween movement
    doTweenX(smokeID..'x', smokeID, dadX + offsetX, smokeDuration, 'cubeOut')
    doTweenY(smokeID..'y', smokeID, dadY + offsetY, smokeDuration, 'sineOut')

    -- Tween alpha (fade out)
    doTweenAlpha(smokeID..'alpha', smokeID, 0, smokeDuration, 'linear')
    
    doTweenX(smokeID..'sizeX', smokeID..'.scale', 1, smokeDuration/2, 'cubeOut')
    doTweenY(smokeID..'sizeY', smokeID..'.scale', 1, smokeDuration/2, 'cubeOut')

    -- Remove sprite after duration
    runTimer(smokeID..'kill', smokeDuration)
end

function onTimerCompleted(tag)
    if string.find(tag, 'kill') then
        removeLuaSprite(tag:gsub('kill', ''), true)
    end
end