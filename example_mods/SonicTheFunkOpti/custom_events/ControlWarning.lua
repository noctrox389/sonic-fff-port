function onCreate()
    makeAnimatedLuaSprite('controlsindicators', 'indicators', 410, 250)
    addAnimationByPrefix('controlsindicators', 'mouse', 'INDICATORmouse', 24, true)
    addOffset('controlsindicators', 'mouse', 0, 0)
    addAnimationByPrefix('controlsindicators', 'keyboard', 'INDICATORkeyboard', 24, true)
    addOffset('controlsindicators', 'keyboard', -30, 30)
    setObjectCamera('controlsindicators', 'camHUD')
    addLuaSprite('controlsindicators', true)
    setProperty('controlsindicators.visible', false)
    --setObjectOrder('controlsindicators', 0)
end

function onEvent(name, v1, v2)
    if name == 'ControlWarning' then
        if v1 ~= '' or v1 ~= ' ' then
            setProperty('controlsindicators.visible', true)
            setProperty('controlsindicators.alpha', 0)
            doTweenAlpha('controlsappear', 'controlsindicators', 1, 0.5)
            runTimer('controlwarning', 3)
            if v1 == 'mouse' then
                playAnim('controlsindicators', 'mouse')
            elseif v1 == 'keyboard' then
                playAnim('controlsindicators', 'keyboard')
            end
        end
    end
end

function onTimerCompleted(tag)
    if tag == 'controlwarning' then
        doTweenAlpha('controlsdisappear', 'controlsindicators', 0, 0.5)
    end
end

function onTweenCompleted(tag)
    if tag == 'controlsdisappear' then
        setProperty('controlsindicators.visible', false)
    end
end