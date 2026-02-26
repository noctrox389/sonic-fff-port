capsulecollected = false
position = 1

function onCreatePost()
    makeAnimatedLuaSprite('capsule', 'capsule', 400, 400)
    addAnimationByPrefix('capsule', 'capsule', 'ringcapsule', 24, true)
    addOffset('capsule', 'capsule', 0, 0)
    addAnimationByPrefix('capsule', 'explosion', 'explosion', 24, false)
    addOffset('capsule', 'explosion', 100, 30)
    addLuaSprite('capsule', false)
    setObjectOrder('capsule', getObjectOrder('boyfriendGroup') - 1)
    setProperty('capsule.visible', false)
        
    makeAnimatedLuaSprite('ringicon', 'capsule', getProperty('capsule.x') + 45, getProperty('capsule.y') + 120)
    addAnimationByPrefix('ringicon', 'icon', 'monitor icon', 24, true)
    addLuaSprite('ringicon', getObjectOrder('capsule') - 1)
    addLuaSprite('ringicon', false)
    setProperty('ringicon.visible', false)
end

function onEvent(name, v1, v2)
    if name == 'capsule' then
        capsulecollected = false
        playAnim('capsule', 'capsule', true)
        setProperty('capsule.visible', true)
        if v1 == '1' then
            position = 1
            setProperty('capsule.x', getProperty('dad.x') - 340)
            setProperty('capsule.y', -500)
            doTweenY('capsuleappear', 'capsule', 400, 2, 'backOut')
        end
        if v1 == '2' then
            position = 2
            setProperty('capsule.x', getProperty('boyfriend.x') + 440)
            setProperty('capsule.y', -500)
            doTweenY('capsuleappear', 'capsule', 400, 2, 'backOut')
        end
    end
end

function onUpdatePost()
    if getProperty('capsule.animation.curAnim.name') == 'explosion'
        and getProperty('capsule.animation.curAnim.finished') then
            setProperty('capsule.visible', false)
    end
    if callMethodFromClass('flixel.FlxG', 'mouse.overlaps', {instanceArg('capsule'), instanceArg('camGame')}) and mouseClicked() and getProperty('capsule.visible') then
        if getProperty('capsule.animation.curAnim.name') == 'capsule' and getProperty('capsule.animation.curAnim.name') == 'capsule' then
            playAnim('capsule', 'explosion', true)
            setProperty('ringicon.visible', true)
            setProperty('ringicon.x', getProperty('capsule.x') + 45)
            setProperty('ringicon.y', getProperty('capsule.y') + 120)
            doTweenY('ringiconappear', 'ringicon', getProperty('ringicon.y') - 170, 1.6, 'expoOut')
            runTimer('ringiconbye', 1)
            capsulecollected = true
            cancelTween('capsuleappear')
            cancelTween('capsulebye')
            cancelTween('capsulebye2')
            playSound('monitor')
            playSound('10rings', 0.8)
            setProperty('ringcountindicator.x', getProperty('ringcountindicator.x') + 10)
        end
    end
end

function onTimerCompleted(tag)
    if tag == 'ringiconbye' then
        doTweenAlpha('ringicondisappear', 'ringicon', 0, 0.6)
    end
    if tag == 'capsuledespawn' then
        doTweenY('capsulebye', 'capsule', -300, 2, 'backIn')
        if position == 1 then
            doTweenX('capsulebye2', 'capsule', getProperty('capsule.x') - 200, 2, 'cubeIn')
        elseif position == 2 then
            doTweenX('capsulebye2', 'capsule', getProperty('capsule.x') + 200, 2, 'cubeIn')
        end
    end
end

function onTweenCompleted(tag)
    if tag == 'capsulebye' then
        setProperty('capsule.visible', false)
    end
    if tag == 'capsuleappear' then
        runTimer('capsuledespawn', 2)
    end
    if tag == 'ringicondisappear' then
        setProperty('ringicon.visible', false)
        setProperty('ringicon.alpha', 1)
    end
end
        