function onCreatePost()
    makeLuaSprite('redlight', 'redlight', -10, -10)
    setObjectCamera('redlight', 'hud')
    addLuaSprite('redlight', true)
    setProperty('redlight.visible', false)
    setBlendMode('redlight', 'multiply')
    setProperty('redlight.alpha', 0)
end

function onEvent(name)
    if name == 'redlight' then
        cancelTween('redlighttween')
        cancelTween('redlighttween2')
        setProperty('redlight.visible', true)
        doTweenAlpha('redlighttween', 'redlight', 0.8, 0.1)
    end
end

function onTweenCompleted(tag)
    if tag == 'redlighttween' then
        doTweenAlpha('redlighttween2', 'redlight', 0, 2, 'expoOut')
    end
    if tag == 'redlighttween2' then
        setProperty('redlight.visible', false)
    end
end