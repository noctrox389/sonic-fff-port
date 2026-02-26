-- Variables para el countdown de Metal Sonic
local tiredanim = false
local disablenoteanimations = false
local timertime = 0
local mutedsoundz = false
local trafficLight = 'trafficlightmetal'
local lastNoAnimState = false

function onCreatePost()
    -- Indicador para deshabilitar animaciones de notas
    makeLuaSprite('noanimindicator')
    makeGraphic('noanimindicator', 1, 1, 'ffffff')
    setProperty('noanimindicator.alpha', 0)
    addLuaSprite('noanimindicator', false)
    setObjectCamera('noanimindicator', 'hud')
    setProperty('noanimindicator.x', 0) -- 1=no anim, 0=anim

    -- Indicador para saber si el oponente puede ser dañado
    setProperty('oppcanbehurt.x', 0)

    -- Semáforo para el countdown
    makeAnimatedLuaSprite(trafficLight, 'trafficlight', 550, 250)
    addAnimationByPrefix(trafficLight, 'off', 'traffic light off', 24, false)
    addAnimationByPrefix(trafficLight, '3', 'traffic light 3', 24, false)
    addAnimationByPrefix(trafficLight, '2', 'traffic light 2', 24, false)
    addAnimationByPrefix(trafficLight, '1', 'traffic light 1', 24, false)
    addAnimationByPrefix(trafficLight, 'hitit', 'traffic light hit it', 24, false)
    addLuaSprite(trafficLight, true)
    setObjectCamera(trafficLight, 'camHUD')
    scaleObject(trafficLight, 1.3, 1.3)
    setProperty(trafficLight .. '.visible', false)
    setProperty(trafficLight .. '.alpha', 0)
end

function onBeatHit()
    timertime = 60 / curBpm
end

function onEvent(name, value1, value2)
    if name == 'MetalCountdown' then
        -- Configurar si el sonido está muteado
        mutedsoundz = (value1 == 'true')
        
        -- Sonido inicial (si no está muteado)
        if not mutedsoundz then
            playSound('intro3', 0.7)
        end
        
        -- Cancelar timers y tweens anteriores
        cancelTimer('hidetrafficlight')
        cancelTween('hidetrafficlight')
        
        -- Mostrar semáforo
        doTweenAlpha('showtrafficlight', trafficLight, 1, 0.5)
        setProperty(trafficLight .. '.visible', true)
        playAnim(trafficLight, '3', false)
        
        -- Iniciar countdown
        runTimer('dinguscountdown1', timertime)
    end
end

function onTimerCompleted(tag)
    if tag == 'dinguscountdown1' then
        if not mutedsoundz then
            playSound('intro2', 0.7)
        end
        playAnim(trafficLight, '2', false)
        runTimer('dinguscountdown2', timertime)
        
    elseif tag == 'dinguscountdown2' then
        if not mutedsoundz then
            playSound('intro1', 0.7)
        end
        if getProperty('dad.animation.curAnim.name') == 'idle' then
            playAnim('dad', 'tired', true)
            setProperty('dad.specialAnim', true)
        end
        playAnim(trafficLight, '1', false)
        setProperty('oppcanbehurt.x', 1)
        setProperty('smokeindicator.x', 1)
        doTweenColor('dadcolorz', 'dad', 'e36d81', 0.3)
        runTimer('dinguscountdown3', timertime)
        
    elseif tag == 'dinguscountdown3' then
        if not mutedsoundz then
            playSound('introGo', 0.7)
        end
        playAnim(trafficLight, 'hitit', false)
        runTimer('dinguscountdown4', timertime * 4)
        runTimer('hidetrafficlight', timertime * 2)
        
    elseif tag == 'hidetrafficlight' then
        cancelTween('showtrafficlight')
        doTweenAlpha('hidetrafficlight', trafficLight, 0, 0.5)
        
    elseif tag == 'dinguscountdown4' then
        setProperty('oppcanbehurt.x', 0)
        doTweenColor('dadcolorz', 'dad', 'ffffff', 0.3)
        setProperty('smokeindicator.x', 0)
        
    elseif tag == 'singinanims' then
        setProperty('noanimindicator.x', 0)
        setProperty('dad.specialAnim', false)
    end
end

function onTweenCompleted(tag)
    if tag == 'hidetrafficlight' then
        setProperty(trafficLight .. '.visible', false)
    end
end

function disableSingingAnim()
    setProperty('noanimindicator.x', 1)
    runTimer('singinanims', timertime * 5)
end

function onUpdatePost()
    -- Actualizar estado de deshabilitación de animaciones
    local currentNoAnim = getProperty('noanimindicator.x') == 1
    disablenoteanimations = currentNoAnim
    
    -- SOLO procesar notas si cambió el estado
    if currentNoAnim ~= lastNoAnimState then
        local notesLength = getProperty('notes.length')
        for i = 0, notesLength - 1 do
            if not getPropertyFromGroup('notes', i, 'mustPress') then
                setPropertyFromGroup('notes', i, 'noAnimation', currentNoAnim)
            end
        end

        local unspawnLength = getProperty('unspawnNotes.length')
        for i = 0, unspawnLength - 1 do
            if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
                setPropertyFromGroup('unspawnNotes', i, 'noAnimation', currentNoAnim)
            end
        end
        lastNoAnimState = currentNoAnim
    end
    
    -- Verificar si hay que desactivar las animaciones bloqueadas
    if disablenoteanimations then
        local dadAnim = getProperty('dad.animation.curAnim.name')
        if dadAnim ~= 'shoot' and dadAnim ~= 'tired' then
            setProperty('noanimindicator.x', 0)
        end
    end
end