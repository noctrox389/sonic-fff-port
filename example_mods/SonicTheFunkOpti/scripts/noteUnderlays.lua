local dadr = getProperty('dad.healthColorArray[0]')
local dadg = getProperty('dad.healthColorArray[1]')
local dadb = getProperty('dad.healthColorArray[2]')
local dadColor = string.format('%02X%02X%02X', dadr, dadg, dadb)
local bfr = getProperty('boyfriend.healthColorArray[0]')
local bfg = getProperty('boyfriend.healthColorArray[1]')
local bfb = getProperty('boyfriend.healthColorArray[2]')
local bfColor = string.format('%02X%02X%02X', bfr, bfg, bfb)

underlayWidth = 485

bfUnderlayAlpha = 0.5
dadUnderlayAlpha = 0.5

singinganimBuddy = false
singinganimOpp = false

function onCreatePost()
    initSaveData('globalsave')
    bfUnderlayAlpha = getDataFromSave('globalsave', 'bfUnderlayAlpha', 0) / 100
    dadUnderlayAlpha = getDataFromSave('globalsave', 'dadUnderlayAlpha', 0) / 100

    littleBuddy = getDataFromSave('globalsave', 'littleplayer', 'OFF')
    littleOpponent = getDataFromSave('globalsave', 'littleopponent', 'OFF')

    littlebuddyX = getDataFromSave('globalsave', 'littlebuddyX', 800)
    littlebuddyY = getDataFromSave('globalsave', 'littlebuddyY', 380)

    
    littleopponentX = getDataFromSave('globalsave', 'littleopponentX', 350)
    littleopponentY = getDataFromSave('globalsave', 'littleopponentY', 380)

    objectorderLOL = 1
    if bfUnderlayAlpha ~= 0 then
        makeLuaSprite('bfnotesUnderlay', nil, 0, 0)
        makeGraphic('bfnotesUnderlay', underlayWidth, screenHeight, '000000')
        setObjectCamera('bfnotesUnderlay', 'camHUD')
        addLuaSprite('bfnotesUnderlay', false)
        setProperty('bfnotesUnderlay.alpha', bfUnderlayAlpha)
        setObjectOrder('bfnotesUnderlay', objectorderLOL)
        objectorderLOL = objectorderLOL + 1
    end
    if dadUnderlayAlpha ~= 0 then
        if not middlescroll then
            makeLuaSprite('dadnotesUnderlay', nil, 0, 0)
            makeGraphic('dadnotesUnderlay', underlayWidth, screenHeight, '000000')
            setObjectCamera('dadnotesUnderlay', 'camHUD')
            addLuaSprite('dadnotesUnderlay', false)
            setProperty('dadnotesUnderlay.alpha', bfUnderlayAlpha)
            setObjectOrder('dadnotesUnderlay', objectorderLOL)
            objectorderLOL = objectorderLOL + 1
        end
    end
    if littleBuddy ~= 'OFF' then
        makeAnimatedLuaSprite('littlebuddy', 'characters/littlebuddy', littlebuddyX, littlebuddyY)
        setObjectCamera('littlebuddy', 'camHUD')
        addAnimationByPrefix('littlebuddy', 'idle', 'little buddy idle', 24, false)
        addAnimationByPrefix('littlebuddy', 'down', 'little buddy down', 24, false)
        addAnimationByPrefix('littlebuddy', 'left', 'little buddy left', 24, false)
        addAnimationByPrefix('littlebuddy', 'right', 'little buddy right', 24, false)
        addAnimationByPrefix('littlebuddy', 'up', 'little buddy up', 24, false)
        addLuaSprite('littlebuddy', true)
        setProperty('littlebuddy.color', getColorFromHex(bfColor))
        setObjectOrder('littlebuddy', objectorderLOL)
        objectorderLOL = objectorderLOL + 1
    end
    if littleOpponent ~= 'OFF' then
        makeAnimatedLuaSprite('littleopponent', 'characters/littlebuddy', littleopponentX, littleopponentY)
        setObjectCamera('littleopponent', 'camHUD')
        addAnimationByPrefix('littleopponent', 'idle', 'little buddy idle', 24, false)
        addAnimationByPrefix('littleopponent', 'down', 'little buddy down', 24, false)
        addAnimationByPrefix('littleopponent', 'right', 'little buddy left', 24, false)
        addAnimationByPrefix('littleopponent', 'left', 'little buddy right', 24, false)
        addAnimationByPrefix('littleopponent', 'up', 'little buddy up', 24, false)
        addLuaSprite('littleopponent', true)
        setProperty('littleopponent.flipX', true)
        setProperty('littleopponent.color', getColorFromHex(dadColor))
        setObjectOrder('littleopponent', objectorderLOL)
        objectorderLOL = objectorderLOL + 1
    end
end

function onBeatHit()
    if curBeat % 2 == 0 then
        if not singinganimBuddy then
            playAnim('littlebuddy', 'idle', true)
        end
        if not singinganimOpp then
            playAnim('littleopponent', 'idle', true)
        end
    end
end

function onTimerCompleted(tag)
    if tag == 'idletimerbuddy' then
        singinganimBuddy = false
    end
    if tag == 'idletimeropponent' then
        singinganimOpp = false
    end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    singinganimBuddy = true
    if direction == 0 then--left
        runTimer('idletimerbuddy', bpm / 240)
        playAnim('littlebuddy', 'left', true)
    elseif direction == 1 then--down
        runTimer('idletimerbuddy', bpm / 240)
        playAnim('littlebuddy', 'down', true)
    elseif direction == 2 then--up
        runTimer('idletimerbuddy', bpm / 240)
        playAnim('littlebuddy', 'up', true)
    elseif direction == 3 then--right
        runTimer('idletimerbuddy', bpm / 240)
        playAnim('littlebuddy', 'right', true)
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    singinganimOpp = true
    if direction == 0 then--left
        runTimer('idletimeropponent', bpm / 240)
        playAnim('littleopponent', 'left', true)
    elseif direction == 1 then--down
        runTimer('idletimeropponent', bpm / 240)
        playAnim('littleopponent', 'down', true)
    elseif direction == 2 then--up
        runTimer('idletimeropponent', bpm / 240)
        playAnim('littleopponent', 'up', true)
    elseif direction == 3 then--right
        runTimer('idletimeropponent', bpm / 240)
        playAnim('littleopponent', 'right', true)
    end
end

function onUpdatePost()
    if bfUnderlayAlpha ~= 0 then
        setProperty('bfnotesUnderlay.x', getPropertyFromGroup('playerStrums', 0, 'x') - 20)
        setProperty('bfnotesUnderlay.alpha', getPropertyFromGroup('playerStrums', 0, 'alpha') * bfUnderlayAlpha)
        if getPropertyFromGroup('playerStrums', 0, 'visible') == true then
            setProperty('bfnotesUnderlay.visible', true)
        else
            setProperty('bfnotesUnderlay.visible', false)
        end
    end
    if dadUnderlayAlpha ~= 0 then
        setProperty('dadnotesUnderlay.x', getPropertyFromGroup('opponentStrums', 0, 'x') - 20)
        setProperty('dadnotesUnderlay.alpha', getPropertyFromGroup('opponentStrums', 0, 'alpha') * dadUnderlayAlpha)
        if getPropertyFromGroup('opponentStrums', 0, 'visible') == true then
            setProperty('dadnotesUnderlay.visible', true)
        else
            setProperty('dadnotesUnderlay.visible', false)
        end
    end
    if littleBuddy ~= 'OFF' then
        if callMethodFromClass('flixel.FlxG', 'mouse.overlaps', {instanceArg('littlebuddy'), instanceArg('camHUD')}) and mouseClicked() then
            chaoNoise()
            
            setProperty('littlebuddy.origin.y', 200)
            setProperty('littlebuddy.scale.x', 1.2)
            doTweenX('littlebuddyBOOP1', 'littlebuddy.scale', 1, 0.5, 'bounceOut')
            setProperty('littlebuddy.scale.y', 0.9)
            doTweenY('littlebuddyBOOP2', 'littlebuddy.scale', 1, 0.5, 'bounceOut')
        end
    end
    if littleBuddy ~= 'OFF' then
        if callMethodFromClass('flixel.FlxG', 'mouse.overlaps', {instanceArg('littleopponent'), instanceArg('camHUD')}) and mouseClicked() then
            chaoNoise()
            
            setProperty('littleopponent.origin.y', 200)
            setProperty('littleopponent.scale.x', 1.2)
            doTweenX('littleopponentBOOP1', 'littleopponent.scale', 1, 0.5, 'bounceOut')
            setProperty('littleopponent.scale.y', 0.9)
            doTweenY('littleopponentBOOP2', 'littleopponent.scale', 1, 0.5, 'bounceOut')
        end
    end
end

function chaoNoise()
    playSound('honk', 0.3)
end