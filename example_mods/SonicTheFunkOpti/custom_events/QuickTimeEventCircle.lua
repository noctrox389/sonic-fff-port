local circsize = 1
local circpositionX = 830 
local circpositionY = 220
local circoriginX = 70
local circoriginY = 70
local nointerruption = false
function onCreatePost()
    --circle bar
    makeLuaSprite('outline', 'circlefill/outline', circpositionX, circpositionY)
    setObjectCamera('outline', 'hud')
    addLuaSprite('outline', true)
    scaleObject('outline', circsize, circsize)
    
    makeLuaSprite('whitehalf1', 'circlefill/whitehalf1', circpositionX, circpositionY)
    setObjectCamera('whitehalf1', 'hud')
    addLuaSprite('whitehalf1', true)
    scaleObject('whitehalf1', circsize, circsize)
    
    makeLuaSprite('blackhalf', 'circlefill/blackhalf', circpositionX, circpositionY)
    setObjectCamera('blackhalf', 'hud')
    addLuaSprite('blackhalf', true)
    scaleObject('blackhalf', circsize, circsize)

    makeLuaSprite('whitehalf2', 'circlefill/whitehalf2', circpositionX, circpositionY)
    setObjectCamera('whitehalf2', 'hud')
    addLuaSprite('whitehalf2', true)
    scaleObject('whitehalf2', circsize, circsize)

    setProperty('outline.alpha', 0)
    setProperty('blackhalf.alpha', 0)
    setProperty('whitehalf1.alpha', 0)
    setProperty('whitehalf2.alpha', 0)

    --button animations --circpositionX = 830 circpositionY = 220
    makeAnimatedLuaSprite('button1', 'NOTE_assets-sonic', circpositionX + 70, circpositionY + 70, true)
    setObjectCamera('button1', 'HUD')
    --regular animations
    addAnimationByPrefix('button1', '1', 'arrowLEFT', 24, true)
    addAnimationByPrefix('button1', '2', 'arrowDOWN', 24, true)
    addAnimationByPrefix('button1', '3', 'arrowUP', 24, true)
    addAnimationByPrefix('button1', '4', 'arrowRIGHT', 24, true)
    addAnimationByPrefix('button1', '5', 'SPACEKEY', 24, true)
    --press animations
    addAnimationByPrefix('button1', 'leftPress', 'left press', 24, false)
    addAnimationByPrefix('button1', 'downPress', 'down press', 24, false)
    addAnimationByPrefix('button1', 'upPress', 'up press', 24, false)
    addAnimationByPrefix('button1', 'rightPress', 'right press', 24, false)
    addAnimationByPrefix('button1', 'spacePress', 'spacePRESS', 24, false)
    playAnim('button1', 'up', true)
    scaleObject('button1', 0.7, 0.7)
    addLuaSprite('button1', true)
    makeAnimatedLuaSprite('splash1', 'quicktimesplash', circpositionX + 70 -43, circpositionY + 70 -40, true)
    setObjectCamera('splash1', 'HUD')
    addAnimationByPrefix('splash1', 'splash', 'quicktimesplash', 24, false)
    playAnim('splash1', 'splash', true)
    addLuaSprite('splash1', true)
    
    setProperty('button1.alpha', 0)
    setProperty('splash1.alpha', 0)
    if dadName == 'metalsonic' then
        makeAnimatedLuaSprite('target', 'bomb', 0, 0, false)
        addAnimationByPrefix('target', 'target', 'target', 24, false)
        addAnimationByPrefix('target', 'explosion', 'explosion', 24, false)
        addLuaSprite('target', true)
        scaleObject('target')
        setProperty('target.visible', false)
    end
end

function onEvent(name, value1, value2)
    if getProperty('eventsindicator.x') == 1 or getProperty('eventsindicator.x') == nil then
        if name == 'QuickTimeEventCircle' then
            if value1 ~= '' then
                timersetz = 480/bpm * value1
            else
                timersetz = 480/bpm
            end
            if dadName == 'metalsonic' then
                setProperty('target.visible', true)
                playAnim('target', 'target', false)
                setProperty('target.x', getProperty('boyfriend.x') + 250)
                setProperty('target.y', getProperty('boyfriend.y') - 800)
                doTweenY('targetacquired', 'target', getProperty('boyfriend.y') + 100, 1, 'cubeOut')
            end
            runTimer('timelimittimer', timersetz)
            circleFill()
            shuffleKeys()
        end
    end
end

function shuffleKeys()
    if not eventactive then
        if boyfriendName == 'bf' then
            playAnim('boyfriend', 'idle')
        end
    end
    doTweenAlpha('button1out', 'button1', 1, 0.5)
    if getProperty('canjumpindicator.x') == 1 then
        setcanjumpfalse = true
        setProperty('canjumpindicator.x', 0)
    end
    setProperty('boyfriend.stunned', true)
    playAnim('button1', getRandomInt(1, 5))
    
    eventactive = true
    quicktimewin = false
end

function explosionLol()
    cancelTween('targetacquired')
    setProperty('target.y', getProperty('boyfriend.y') + 80)
    setProperty('target.x', getProperty('boyfriend.x'))
    playAnim('target', 'explosion', false)
    playSound('damage', 0.8)
end

function onUpdatePost(elapsed)
    -- Optimizar detección del botón (solo calcular una vez por frame)
    local mouseX = getMouseX('other')
    local mouseY = getMouseY('other')
    local mouseClickedLeft = mouseClicked('left')
    
    local mouseOver = (mouseX > getProperty('BotonMobile.x') and 
                      mouseX < getProperty('BotonMobile.x') + getProperty('BotonMobile.width') and 
                      mouseY > getProperty('BotonMobile.y') and 
                      mouseY < getProperty('BotonMobile.y') + getProperty('BotonMobile.height'))
    
    local botonClicked = mouseOver and mouseClickedLeft
    
    if botonClicked then
        playAnim('BotonMobile', 'pressed', true)
        runTimer('resetBotonAnim', 0.1)
    end

    -- Resto del código de metalsonic (sin cambios)
    if dadName == 'metalsonic' then
        if getProperty('target.animation.name') == 'explosion' and getProperty('target.animation.curAnim.finished') then
            setProperty('target.visible', false)
        end
        if getProperty('scrollingspeedway.x') == 1 then
            if getProperty('target.animation.curAnim.name') == 'explosion' and getProperty('target.visible') then
                setProperty('target.x', getProperty('target.x') - 1500 * elapsed)
            end
        end
    end
    
    -- Resto del código de eventactive (sin cambios importantes)
    if eventactive then
        -- Cachear el nombre de la animación una sola vez
        local animName = getProperty('button1.animation.curAnim.name')
        if animName == '1' then
            key1 = 'LEFT'
        elseif animName == '2' then
            key1 = 'DOWN'
        elseif animName == '3' then
            key1 = 'UP'
        elseif animName == '4' then
            key1 = 'RIGHT'
        elseif animName == '5' then
            key1 = 'accept'
        end
        
        -- Resto del código igual...
        if keyJustPressed(key1) or (key1 == 'accept' and botonClicked) then
            quickTimeWin()
            playShootingAnim()
            if key1 == 'LEFT' then
                playAnim('button1', 'leftPress', false)
            elseif key1 == 'DOWN' then
                playAnim('button1', 'downPress', false)
            elseif key1 == 'UP' then
                playAnim('button1', 'upPress', false)
            elseif key1 == 'RIGHT' then
                playAnim('button1', 'rightPress', false)
            elseif key1 == 'accept' then
                playAnim('button1', 'spacePress', false)
            end
        end
        
        -- Optimizar las comprobaciones de teclas incorrectas
        local wrongKeyPressed = false
        if key1 == 'LEFT' then
            wrongKeyPressed = keyJustPressed('down') or keyJustPressed('up') or keyJustPressed('right') or keyJustPressed('accept') or (botonClicked and key1 ~= 'accept')
        elseif key1 == 'DOWN' then
            wrongKeyPressed = keyJustPressed('left') or keyJustPressed('up') or keyJustPressed('right') or keyJustPressed('accept') or (botonClicked and key1 ~= 'accept')
        elseif key1 == 'UP' then
            wrongKeyPressed = keyJustPressed('down') or keyJustPressed('left') or keyJustPressed('right') or keyJustPressed('accept') or (botonClicked and key1 ~= 'accept')
        elseif key1 == 'RIGHT' then
            wrongKeyPressed = keyJustPressed('down') or keyJustPressed('up') or keyJustPressed('left') or keyJustPressed('accept') or (botonClicked and key1 ~= 'accept')
        elseif key1 == 'accept' then
            wrongKeyPressed = keyJustPressed('down') or keyJustPressed('up') or keyJustPressed('right') or keyJustPressed('left')
        end
        
        if wrongKeyPressed and eventactive then
            quickTimeFail()
        end
    end
end

-- Variables para cachear valores
local lastNoInterruption = false
local lastDadAnim = ''
local notesProcessed = false

function onUpdate()
    -- Actualizar estado de nointerruption (esto es rápido)
    if getProperty('noanimindicator.x') == 1 then
        nointerruption = true
    elseif getProperty('noanimindicator.x') == 0 then
        nointerruption = false
    end
    
    -- SOLO procesar notas si cambió el estado de nointerruption
    if nointerruption ~= lastNoInterruption then
        local notesLength = getProperty('notes.length')
        for i = 0, notesLength - 1 do
            if not getPropertyFromGroup('notes', i, 'mustPress') then
                setPropertyFromGroup('notes', i, 'noAnimation', nointerruption)
            end
        end

        local unspawnLength = getProperty('unspawnNotes.length')
        for i = 0, unspawnLength - 1 do
            if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
                setPropertyFromGroup('unspawnNotes', i, 'noAnimation', nointerruption)
            end
        end
        lastNoInterruption = nointerruption
        notesProcessed = true
    end
    
    -- Verificar animación de dad (solo cuando es necesario)
    if nointerruption then
        local currentAnim = getProperty('dad.animation.curAnim.name')
        
        -- Solo verificar si cambió la animación
        if currentAnim ~= lastDadAnim then
            if currentAnim == 'shoot' then
                -- No hacer nada especial
            elseif currentAnim ~= 'shoot' then
                setProperty('noanimindicator.x', 0)
            end
            lastDadAnim = currentAnim
        end
        
        -- Verificar si terminó la animación de shoot
        if currentAnim == 'shoot' and getProperty('dad.animation.curAnim.finished') then
            setProperty('noanimindicator.x', 0)
            setProperty('dad.specialAnim', false)
        end
    end
end

function playShootingAnim()
    setProperty('noanimindicator.x', 1)
    playAnim('dad', 'shoot', true)
    setProperty('dad.specialAnim', true)
end

function onTimerCompleted(tag)
    if tag == 'whitehalfangle' then
        setProperty('whitehalf2.alpha', 1)
        runTimer('disscircle', timersetz / 2)
        doTweenAngle('whitehalf2angle', 'whitehalf2', 180, timersetz / 2)
    end
    if tag == 'disscircle' then

        doTweenAlpha('splash1out', 'splash1', 0, 0.5)
        doTweenAlpha('button1out', 'button1', 0, 0.5)
    end
    if tag == 'timelimittimer' then
        quickTimeFail()
    end
    if tag == 'getreadycircle' then
        setProperty('whitehalf1.angle', 0)
        setProperty('whitehalf2.angle', 0)
        setProperty('outline.alpha', 1)
        setProperty('blackhalf.alpha', 1)
        setProperty('whitehalf1.alpha', 1)
        setProperty('whitehalf2.alpha', 0)
        runTimer('whitehalfangle', timersetz / 2)
        doTweenAngle('whitehalf1angle', 'whitehalf1', 180, timersetz / 2)

        scaleamountcirc = 0.8
        scaletimecirc = 0.6
        easetypecirc = 'cubeOut'
        doTweenX('outlinex', 'outline.scale', scaleamountcirc, scaletimecirc, easetypecirc)
        doTweenY('outliney', 'outline.scale', scaleamountcirc, scaletimecirc, easetypecirc)

        doTweenX('whitehalf1x', 'whitehalf1.scale', scaleamountcirc, scaletimecirc, easetypecirc)
        doTweenY('whitehalf1y', 'whitehalf1.scale', scaleamountcirc, scaletimecirc, easetypecirc)
    
        doTweenX('whitehalf2x', 'whitehalf2.scale', scaleamountcirc, scaletimecirc, easetypecirc)
        doTweenY('whitehalf2y', 'whitehalf2.scale', scaleamountcirc, scaletimecirc, easetypecirc)
    
        doTweenX('blackhalfx', 'blackhalf.scale', scaleamountcirc, scaletimecirc, easetypecirc)
        doTweenY('blackhalfy', 'blackhalf.scale', scaleamountcirc, scaletimecirc, easetypecirc)
    end
    if tag == 'canjumptimer' then
        setProperty('canjumpindicator.x', 1)
        setcanjumpfalse = false
    end
    if tag == 'resetBotonAnim' then
        playAnim('BotonMobile', 'idle', true)
    end
end

function circleFill()
    doTweenX('outlinex', 'outline.scale', 0.1, 0.01)
    doTweenY('outliney', 'outline.scale', 0.1, 0.01)

    doTweenX('whitehalf1x', 'whitehalf1.scale', 0.1, 0.01)
    doTweenY('whitehalf1y', 'whitehalf1.scale', 0.1, 0.01)
    
    doTweenX('whitehalf2x', 'whitehalf2.scale', 0.1, 0.01)
    doTweenY('whitehalf2y', 'whitehalf2.scale', 0.1, 0.01)
    
    doTweenX('blackhalfx', 'blackhalf.scale', 0.1, 0.01)
    doTweenY('blackhalfy', 'blackhalf.scale', 0.1, 0.01)

    runTimer('getreadycircle', 0.01)
end

function quickTimeWin()
    setProperty('jumptrigger.x', 1)
    playAnim('splash1', 'splash', true)
    setProperty('splash1.alpha', 1)
    if dadName ~= 'metalsonic' then
        playSound('quicktimeGood', 0.7)
    else
        explosionLol()
    end
    setProperty('sickhitindicator.x', 1)
    addScore(cashout)
    if setcanjumpfalse then
        runTimer('canjumptimer', 0.85)
    end
    setProperty('boyfriend.stunned', false)
    eventactive = false
    quicktimewin = true

    cancelTimer('whitehalfangle')
    cancelTimer('disscircle')
    cancelTimer('timelimittimer')

    cancelTween('whitehalf1angle')
    cancelTween('whitehalf2angle')
    
    runTimer('disscircle', 0.2)

    resetCircle(0.01, 1.2, 'cubeOut')
    fadeOutCircle(0.3)
end


function quickTimeFail()
    playShootingAnim()
    setProperty('shithitindicator.x', 1)
    if setcanjumpfalse then
        runTimer('canjumptimer', 0.85)
    end
    setProperty('boyfriend.stunned', false)
    eventactive = false
    addMisses(1)
    addScore(-600)
    if not getProperty('cpuControlled') then
        setProperty('hurtRing.x', 1)
    end
    if getProperty('ringcountindicator.x') ~= 0 then
        playAnim('boyfriend', 'hurt')
    end
    setProperty('boyfriend.specialAnim', true)
    if dadName ~= 'metalsonic' then
        playSound('quicktimeBad', 0.7)
    else
        explosionLol()
    end
    doTweenAlpha('button1out', 'button1', 0, 0.5)
    doTweenAlpha('splash1out', 'splash1', 0, 0.5)

    cancelTimer('whitehalfangle')
    cancelTimer('disscircle')
    cancelTimer('timelimittimer')

    cancelTween('whitehalf1angle')
    cancelTween('whitehalf2angle')
    
    runTimer('disscircle', 0.01)

    scaleamountcirc = 0.01
        scaletimecirc = 1.2
        easetypecirc = 'cubeOut'
        doTweenX('outlinex', 'outline.scale', scaleamountcirc, scaletimecirc, easetypecirc)
        doTweenY('outliney', 'outline.scale', scaleamountcirc, scaletimecirc, easetypecirc)

        doTweenX('whitehalf1x', 'whitehalf1.scale', scaleamountcirc, scaletimecirc, easetypecirc)
        doTweenY('whitehalf1y', 'whitehalf1.scale', scaleamountcirc, scaletimecirc, easetypecirc)
    
        doTweenX('whitehalf2x', 'whitehalf2.scale', scaleamountcirc, scaletimecirc, easetypecirc)
        doTweenY('whitehalf2y', 'whitehalf2.scale', scaleamountcirc, scaletimecirc, easetypecirc)
    
        doTweenX('blackhalfx', 'blackhalf.scale', scaleamountcirc, scaletimecirc, easetypecirc)
        doTweenY('blackhalfy', 'blackhalf.scale', scaleamountcirc, scaletimecirc, easetypecirc)

        dissrate = 0.3
        doTweenAlpha('diss1', 'outline', 0, dissrate)
        doTweenAlpha('diss2', 'whitehalf1', 0, dissrate)
        doTweenAlpha('diss3', 'whitehalf2', 0, dissrate)
        doTweenAlpha('diss4', 'blackhalf', 0, dissrate)
end

function resetCircle(scaleAmount, time, easeType)
    doTweenX('outlinex', 'outline.scale', scaleAmount, time, easeType)
    doTweenY('outliney', 'outline.scale', scaleAmount, time, easeType)
    doTweenX('whitehalf1x', 'whitehalf1.scale', scaleAmount, time, easeType)
    doTweenY('whitehalf1y', 'whitehalf1.scale', scaleAmount, time, easeType)
    doTweenX('whitehalf2x', 'whitehalf2.scale', scaleAmount, time, easeType)
    doTweenY('whitehalf2y', 'whitehalf2.scale', scaleAmount, time, easeType)
    doTweenX('blackhalfx', 'blackhalf.scale', scaleAmount, time, easeType)
    doTweenY('blackhalfy', 'blackhalf.scale', scaleAmount, time, easeType)
end

function fadeOutCircle(rate)
    doTweenAlpha('diss1', 'outline', 0, rate)
    doTweenAlpha('diss2', 'whitehalf1', 0, rate)
    doTweenAlpha('diss3', 'whitehalf2', 0, rate)
    doTweenAlpha('diss4', 'blackhalf', 0, rate)
end