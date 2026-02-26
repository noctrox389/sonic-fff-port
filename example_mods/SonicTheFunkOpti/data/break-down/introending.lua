function onCreatePost()
    defaultcamzoom = getProperty('defaultCamZoom')
    bgx = 260
    bgy = 270
    bgscale = 2.6
    makeLuaSprite('bgintro', 'bgs/room/bg', bgx, -100 + bgy)
    addLuaSprite('bgintro', true)
    --setObjectCamera('bgintro', 'camHUD')
    setScrollFactor('bgintro', 0, 0)
    setProperty('bgintro.scale.x', bgscale)
    setProperty('bgintro.scale.y', bgscale)
    setProperty('bgintro.visible', false)

    makeAnimatedLuaSprite('sonicBintro', 'bgs/room/sonic', bgx + 655, 120 + bgy)
    addLuaSprite('sonicBintro', true)
    addAnimationByPrefix('sonicBintro', 'idle', 'sonic idle', 24, false)
    addOffset('sonicBintro', 'idle', 0, 0)
    addAnimationByPrefix('sonicBintro', 'cheer', 'sonic cheer', 24, false)
    addOffset('sonicBintro', 'cheer', 0, 27)
    addAnimationByPrefix('sonicBintro', 'wink', 'sonic wink', 24, false)
    addOffset('sonicBintro', 'wink', 0, 13)
    --setObjectCamera('sonicBintro', 'camHUD')
    setScrollFactor('sonicBintro', 0, 0)
    setProperty('sonicBintro.scale.x', bgscale)
    setProperty('sonicBintro.scale.y', bgscale)
    setProperty('sonicBintro.visible', false)
    
    makeAnimatedLuaSprite('tailsBintro', 'bgs/room/tails', bgx - 170, 100 + bgy)
    addLuaSprite('tailsBintro', true)
    addAnimationByPrefix('tailsBintro', 'idle', 'tails idle', 24, false)
    addOffset('tailsBintro', 'idle', 0, 0)
    addAnimationByPrefix('tailsBintro', 'embarrassed', 'tails embarrassed', 24, true)
    addOffset('tailsBintro', 'embarrassed', -70, 24)
    --setObjectCamera('tailsBintro', 'camHUD')
    setScrollFactor('tailsBintro', 0, 0)
    setProperty('tailsBintro.scale.x', bgscale)
    setProperty('tailsBintro.scale.y', bgscale)
    setProperty('tailsBintro.visible', false)

    makeLuaSprite('gradient1', 'bgs/room/gradient1', bgx + 280, -200 + bgy)
    addLuaSprite('gradient1', true)
    --setObjectCamera('gradient1', 'camHUD')
    setScrollFactor('gradient1', 0, 0)
    setProperty('gradient1.scale.x', bgscale)
    setProperty('gradient1.scale.y', bgscale)
    setBlendMode('gradient1', 'add')
    setProperty('gradient1.alpha', 0.32)
    setProperty('gradient1.visible', false)

    makeAnimatedLuaSprite('screenmonitor', 'bgs/room/screen', -120 + 676, 35 + 30)
    addLuaSprite('screenmonitor', true)
    addAnimationByPrefix('screenmonitor', 'screen', 'screen', 24, true)
    --setObjectCamera('screenmonitor', 'camHUD')
    setScrollFactor('screenmonitor', 0, 0)
    setProperty('screenmonitor.scale.x', 1.3)
    setProperty('screenmonitor.scale.y', 1.3)
    setProperty('screenmonitor.visible', false)
    
    makeLuaSprite('gradient2', 'bgs/room/gradient2', bgx, 220 + bgy)
    addLuaSprite('gradient2', true)
    --setObjectCamera('gradient2', 'camHUD')
    setScrollFactor('gradient2', 0, 0)
    setProperty('gradient2.scale.x', bgscale)
    setProperty('gradient2.scale.y', bgscale)
    setBlendMode('gradient2', 'multiply')
    setProperty('gradient2.visible', false)
end

function onSongStart()
    playAnim('sonicBintro', 'idle', true)
    playAnim('tailsBintro', 'idle', true)
    setProperty('bgintro.visible', true)
    setProperty('sonicBintro.visible', true)
    setProperty('tailsBintro.visible', true)
    setProperty('gradient1.visible', true)
    setProperty('screenmonitor.visible', true)
    setProperty('gradient2.visible', true)
end

function onBeatHit()
    if getProperty('sonicBintro.animation.name') == 'idle' and getProperty('sonicBintro.animation.curAnim.finished') then
        playAnim('sonicBintro', 'idle', false)
    end
    if getProperty('tailsBintro.animation.name') == 'idle' and getProperty('tailsBintro.animation.curAnim.finished') then
        playAnim('tailsBintro', 'idle', false)
    end
    if getProperty('sonicBintro.animation.name') == 'cheer' and getProperty('sonicBintro.animation.curAnim.finished') then
        playAnim('sonicBintro', 'cheer', true)
    end

    if curBeat == 4 then
        local intro1tween = 'expoIn'
        doTweenZoom('camzoomlol', 'camGame', 2, 2.14, intro1tween)
        doTweenAlpha('flashbackin', 'flashbangcountdown', 1, 2.14, intro1tween)
        doTweenY('bgintroY', 'bgintro', getProperty('bgintro.y') + 240, 2.14, intro1tween)
        doTweenY('sonicBintroY', 'sonicBintro', getProperty('sonicBintro.y') + 240, 2.14, intro1tween)
        doTweenY('tailsBintroY', 'tailsBintro', getProperty('tailsBintro.y') + 240, 2.14, intro1tween)
        doTweenY('gradient1Y', 'gradient1', getProperty('gradient1.y') + 240, 2.14, intro1tween)
        doTweenY('gradient2Y', 'gradient2', getProperty('gradient2.y') + 240, 2.14, intro1tween)
        doTweenY('screenmonitorY', 'screenmonitor', getProperty('screenmonitor.y') + 240, 2.14, intro1tween)
    end
    if curBeat == 7 then
        playAnim('sonicBintro', 'wink', true)
    end
    if curBeat == 8 then
        doTweenAlpha('flashbackin', 'flashbangcountdown', 0, 0.4)--defaultcamzoom
        setProperty('camGame.zoom',1)
        doTweenZoom('camzoomlol', 'camGame', defaultcamzoom, 2, 'expoOut')
    setProperty('bgintro.visible', false)
    setProperty('sonicBintro.visible', false)
    setProperty('tailsBintro.visible', false)
    setProperty('gradient1.visible', false)
    setProperty('screenmonitor.visible', false)
    setProperty('gradient2.visible', false)
    end
    if curBeat == 180 then
        local intro1tween = 'expoIn'
        doTweenZoom('camzoomlol', 'camGame', 2, 2.14, intro1tween)
        doTweenAlpha('flashbackin', 'flashbangcountdown', 1, 2.14, intro1tween)
    end
    if curBeat == 184 then
        playAnim('sonicBintro', 'cheer', true)
        playAnim('tailsBintro', 'embarrassed', true)
    setProperty('bgintro.visible', true)
    setProperty('sonicBintro.visible', true)
    setProperty('tailsBintro.visible', true)
    setProperty('gradient1.visible', true)
    setProperty('screenmonitor.visible', true)
    setProperty('gradient2.visible', true)
        local intro1tween = 'expoOut'
        doTweenZoom('camzoomlol', 'camGame', 0.7, 2.14, intro1tween)
        
        setProperty('defaultCamZoom', 0.7)
        doTweenAlpha('flashbackin', 'flashbangcountdown', 0, 2.14, intro1tween)
        doTweenY('bgintroY', 'bgintro', getProperty('bgintro.y') - 240, 2.14, intro1tween)
        doTweenY('sonicBintroY', 'sonicBintro', getProperty('sonicBintro.y') - 240, 2.14, intro1tween)
        doTweenY('tailsBintroY', 'tailsBintro', getProperty('tailsBintro.y') - 240, 2.14, intro1tween)
        doTweenY('gradient1Y', 'gradient1', getProperty('gradient1.y') - 240, 2.14, intro1tween)
        doTweenY('gradient2Y', 'gradient2', getProperty('gradient2.y') - 240, 2.14, intro1tween)
        doTweenY('screenmonitorY', 'screenmonitor', getProperty('screenmonitor.y') - 240, 2.14, intro1tween)
    end
end

