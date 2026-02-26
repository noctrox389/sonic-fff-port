function onCreatePost()
    if dadName == 'metalsonic' then
        makeAnimatedLuaSprite('jet', 'characters/metal/metal_jet')
        addAnimationByPrefix('jet', 'jet', 'jet', 24, true)
        playAnim('jet', 'jet', true)
        addLuaSprite('jet', true)
    else
        close()
    end
end
Xoffset = 0
Yoffset = 0
function onUpdatePost()
    if getProperty('dad.animation.curAnim.name') == 'shoot' then
        setObjectOrder('jet', getObjectOrder('dadGroup') + 1)
    else
        setObjectOrder('jet', getObjectOrder('dadGroup') - 1)
    end
    if getProperty('dad.animation.curAnim.name') == 'idle-alt' or getProperty('dad.animation.curAnim.name') == 'powerup' then
        setProperty('jet.visible', false)
    else
        setProperty('jet.visible', true)
    end

    if getProperty('dad.animation.curAnim.name') == 'idle' then
        Xoffset = -130
        Yoffset = 80
    elseif getProperty('dad.animation.curAnim.name') == 'singUP' then
        Xoffset = -120
        Yoffset = 20
    elseif getProperty('dad.animation.curAnim.name') == 'singDOWN' then
        Xoffset = -80
        Yoffset = 200
    elseif getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
        Xoffset = 80
        Yoffset = 100
    elseif getProperty('dad.animation.curAnim.name') == 'singLEFT' then
        Xoffset = -250
        Yoffset = 100
    elseif getProperty('dad.animation.curAnim.name') == 'tired' then
        Xoffset = -120
        Yoffset = 90
    elseif getProperty('dad.animation.curAnim.name') == 'shoot' then
        Xoffset = -100
        Yoffset = 95
    end
    setProperty('jet.x', getProperty('dad.x') + Xoffset - 140)
    setProperty('jet.y', getProperty('dad.y') + Yoffset - 100)
    setProperty('jet.alpha', getProperty('dad.alpha'))
end