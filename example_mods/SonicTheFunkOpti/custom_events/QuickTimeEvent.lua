local stuffcreated = false
function onEvent(name, value1, value2)
    if getProperty('eventsindicator.x') == 1 or getProperty('eventsindicator.x') == nil then
    cashout = 600
    isrepetition = false
    if name == 'QuickTimeEvent' then
        if stuffcreated == false then
            stuffcreated = true
            createdaStuff()
        end
        if dadName == 'shadow' then
            playAnim('dad', 'ready', false)
            setProperty('dad.specialAnim', true)
            --setProperty('dad.animation.curAnim.paused', false)
            runTimer('shadowanimatimer', 0.6)
        end
        shuffleKeys()
        if value1 ~= '' then
            timertimez = 480/bpm * value1
        else
            timertimez = 480/bpm
        end
        setProperty('eventtimebar.x', 700)
        scaleObject('eventtimebar', 470, 20)
        doTweenX('timelimit', 'eventtimebar.scale', 0.1, timertimez)
        doTweenX('timelimitX', 'eventtimebar', 935, timertimez)
        runTimer('timelimittimer', timertimez)
        if value2 ~= '' then
            repetitions = value2
        else
            repetitions = 0
        end
    end
end
end

function createdaStuff()
    key1turn = false
    key2turn = false
    key3turn = false
    key4turn = false

    makeLuaSprite('gunshot', 'gunshot', getProperty('dad.x') + 200,  getProperty('dad.y') + 50)
    addLuaSprite('gunshot', true)
    setProperty('gunshot.visible',false)

    makeLuaSprite('eventtimebarbg')
    makeGraphic('eventtimebarbg', 1, 1, '000000')
    scaleObject('eventtimebarbg', 490, 40)
    setProperty('eventtimebarbg.x', 690)
    setProperty('eventtimebarbg.y', 420)
    addLuaSprite('eventtimebarbg', false)
    setObjectCamera('eventtimebarbg', 'HUD')

    makeLuaSprite('eventtimebarbg2')
    makeGraphic('eventtimebarbg2', 1, 1, '40262d')
    scaleObject('eventtimebarbg2', 470, 20)
    setProperty('eventtimebarbg2.x', 700)
    setProperty('eventtimebarbg2.y', 430)
    addLuaSprite('eventtimebarbg2', false)
    setObjectCamera('eventtimebarbg2', 'HUD')

    makeLuaSprite('eventtimebar')
    makeGraphic('eventtimebar', 1, 1, 'ffbd59')
    scaleObject('eventtimebar', 470, 20)
    setProperty('eventtimebar.x', 700)
    setProperty('eventtimebar.y', 430)
    addLuaSprite('eventtimebar', false)
    setObjectCamera('eventtimebar', 'HUD')

    makeAnimatedLuaSprite('button1', 'NOTE_assets-sonic', 700, 300, true)
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
    makeAnimatedLuaSprite('splash1', 'quicktimesplash', 700 -43, 300 -40, true)
    setObjectCamera('splash1', 'HUD')
    addAnimationByPrefix('splash1', 'splash', 'quicktimesplash', 24, false)
    playAnim('splash1', 'splash', true)
    addLuaSprite('splash1', true)

    makeAnimatedLuaSprite('button2', 'NOTE_assets-sonic', 820, 300, true)
    setObjectCamera('button2', 'HUD')
    --regular animations
    addAnimationByPrefix('button2', '1', 'arrowLEFT', 24, true)
    addAnimationByPrefix('button2', '2', 'arrowDOWN', 24, true)
    addAnimationByPrefix('button2', '3', 'arrowUP', 24, true)
    addAnimationByPrefix('button2', '4', 'arrowRIGHT', 24, true)
    addAnimationByPrefix('button2', '5', 'SPACEKEY', 24, true)
    --press animations
    addAnimationByPrefix('button2', 'leftPress', 'left press', 24, false)
    addAnimationByPrefix('button2', 'downPress', 'down press', 24, false)
    addAnimationByPrefix('button2', 'upPress', 'up press', 24, false)
    addAnimationByPrefix('button2', 'rightPress', 'right press', 24, false)
    addAnimationByPrefix('button2', 'spacePress', 'spacePRESS', 24, false)
    playAnim('button2', 'space', true)
    scaleObject('button2', 0.7, 0.7)
    addLuaSprite('button2', true)
    makeAnimatedLuaSprite('splash2', 'quicktimesplash', 820 -43, 300 -40, true)
    setObjectCamera('splash2', 'HUD')
    addAnimationByPrefix('splash2', 'splash', 'quicktimesplash', 24, false)
    playAnim('splash2', 'splash', true)
    addLuaSprite('splash2', true)

    makeAnimatedLuaSprite('button3', 'NOTE_assets-sonic', 940, 300, true)
    setObjectCamera('button3', 'HUD')
    --regular animations
    addAnimationByPrefix('button3', '1', 'arrowLEFT', 24, true)
    addAnimationByPrefix('button3', '2', 'arrowDOWN', 24, true)
    addAnimationByPrefix('button3', '3', 'arrowUP', 24, true)
    addAnimationByPrefix('button3', '4', 'arrowRIGHT', 24, true)
    addAnimationByPrefix('button3', '5', 'SPACEKEY', 24, true)
    --press animations
    addAnimationByPrefix('button3', 'leftPress', 'left press', 24, false)
    addAnimationByPrefix('button3', 'downPress', 'down press', 24, false)
    addAnimationByPrefix('button3', 'upPress', 'up press', 24, false)
    addAnimationByPrefix('button3', 'rightPress', 'right press', 24, false)
    addAnimationByPrefix('button3', 'spacePress', 'spacePRESS', 24, false)
    playAnim('button3', 'left', true)
    scaleObject('button3', 0.7, 0.7)
    addLuaSprite('button3', true)
    makeAnimatedLuaSprite('splash3', 'quicktimesplash', 940 -43, 300 -40, true)
    setObjectCamera('splash3', 'HUD')
    addAnimationByPrefix('splash3', 'splash', 'quicktimesplash', 24, false)
    playAnim('splash3', 'splash', true)
    addLuaSprite('splash3', true)

    makeAnimatedLuaSprite('button4', 'NOTE_assets-sonic', 1060, 300, true)
    setObjectCamera('button4', 'HUD')
    --regular animations
    addAnimationByPrefix('button4', '1', 'arrowLEFT', 24, true)
    addAnimationByPrefix('button4', '2', 'arrowDOWN', 24, true)
    addAnimationByPrefix('button4', '3', 'arrowUP', 24, true)
    addAnimationByPrefix('button4', '4', 'arrowRIGHT', 24, true)
    addAnimationByPrefix('button4', '5', 'SPACEKEY', 24, true)
    --press animations
    addAnimationByPrefix('button4', 'leftPress', 'left press', 24, false)
    addAnimationByPrefix('button4', 'downPress', 'down press', 24, false)
    addAnimationByPrefix('button4', 'upPress', 'up press', 24, false)
    addAnimationByPrefix('button4', 'rightPress', 'right press', 24, false)
    addAnimationByPrefix('button4', 'spacePress', 'spacePRESS', 24, false)
    playAnim('button4', 'right', true)
    scaleObject('button4', 0.7, 0.7)
    addLuaSprite('button4', true)
    makeAnimatedLuaSprite('splash4', 'quicktimesplash', 1060 -43, 300 -40, true)
    setObjectCamera('splash4', 'HUD')
    addAnimationByPrefix('splash4', 'splash', 'quicktimesplash', 24, false)
    playAnim('splash4', 'splash', true)
    addLuaSprite('splash4', true)

    setProperty('button1.alpha', 0)
    setProperty('button2.alpha', 0)
    setProperty('button3.alpha', 0)
    setProperty('button4.alpha', 0)
    setProperty('splash1.alpha', 0)
    setProperty('splash2.alpha', 0)
    setProperty('splash3.alpha', 0)
    setProperty('splash4.alpha', 0)

    setProperty('eventtimebarbg.alpha', 0)
    setProperty('eventtimebarbg2.alpha', 0)
    setProperty('eventtimebar.alpha', 0)
end

function shuffleKeys()
    if not eventactive then
        if boyfriendName == 'bf' then
            playAnim('boyfriend', 'idle')
        end
    end
    if isrepetition then
        cashout = cashout + 600
        setProperty('eventtimebar.x', 700)
        scaleObject('eventtimebar', 470, 20)
        doTweenX('timelimit', 'eventtimebar.scale', 0.1, timertimez)
        doTweenX('timelimitX', 'eventtimebar', 935, timertimez)
        runTimer('timelimittimer', timertimez)
    end
    --eventtimebarbg
    doTweenAlpha('button1out', 'button1', 1, 0.5)
    doTweenAlpha('button2out', 'button2', 1, 0.5)
    doTweenAlpha('button3out', 'button3', 1, 0.5)
    doTweenAlpha('eventtimebarbgout', 'eventtimebarbg', 1, 0.5)
    doTweenAlpha('eventtimebarbg2out', 'eventtimebarbg2', 1, 0.5)
    doTweenAlpha('eventtimebarout', 'eventtimebar', 1, 0.5)

    doTweenAlpha('button4out', 'button4', 1, 0.5)
    if getProperty('canjumpindicator.x') == 1 then
        setcanjumpfalse = true
        setProperty('canjumpindicator.x', 0)
    end
    setProperty('boyfriend.stunned', true)
    playAnim('button1', getRandomInt(1, 5))
    playAnim('button2', getRandomInt(1, 5))
    playAnim('button3', getRandomInt(1, 5))
    playAnim('button4', getRandomInt(1, 5))
    
    eventactive = true
    quicktimewin = false

    key1turn = true
    key2turn = false
    key3turn = false
    key4turn = false
end
function onUpdatePost()
        -- Detectar clic en BotonMobile
    local botonClicked = false
    local mouseOver = (getMouseX('other') > getProperty('BotonMobile.x') and 
    getMouseX('other') < getProperty('BotonMobile.x') + getProperty('BotonMobile.width') and 
    getMouseY('other') > getProperty('BotonMobile.y') and 
    getMouseY('other') < getProperty('BotonMobile.y') + getProperty('BotonMobile.height'))

    if mouseOver and mouseClicked('left') then
        botonClicked = true
        playAnim('BotonMobile', 'pressed', true)
        runTimer('resetBotonAnim', 0.1)
    end

    -- Función auxiliar para verificar si se presionó la tecla correcta (incluyendo botón)
    function isCorrectKeyPressed(requiredKey)
        if requiredKey == 'accept' then
            return keyJustPressed('accept') or botonClicked
        else
            return keyJustPressed(requiredKey)
        end
    end

    -- Función auxiliar para verificar si se presionó una tecla incorrecta (incluyendo botón)
    function isWrongKeyPressed(requiredKey, excludedKey)
        if requiredKey == 'LEFT' then
            return keyJustPressed('down') or keyJustPressed('up') or keyJustPressed('right') or 
                   (requiredKey ~= 'accept' and botonClicked) or keyJustPressed('accept')
        elseif requiredKey == 'DOWN' then
            return keyJustPressed('left') or keyJustPressed('up') or keyJustPressed('right') or 
                   (requiredKey ~= 'accept' and botonClicked) or keyJustPressed('accept')
        elseif requiredKey == 'UP' then
            return keyJustPressed('down') or keyJustPressed('left') or keyJustPressed('right') or 
                   (requiredKey ~= 'accept' and botonClicked) or keyJustPressed('accept')
        elseif requiredKey == 'RIGHT' then
            return keyJustPressed('down') or keyJustPressed('up') or keyJustPressed('left') or 
                   (requiredKey ~= 'accept' and botonClicked) or keyJustPressed('accept')
        elseif requiredKey == 'accept' then
            return keyJustPressed('down') or keyJustPressed('up') or keyJustPressed('right') or keyJustPressed('left')
        end
        return false
    end

    -- BUTTON 1
    if key1turn then
        if getProperty('button1.animation.curAnim.name') == '1' then
            key1 = 'LEFT'
        elseif getProperty('button1.animation.curAnim.name') == '2' then
            key1 = 'DOWN'
        elseif getProperty('button1.animation.curAnim.name') == '3' then
            key1 = 'UP'
        elseif getProperty('button1.animation.curAnim.name') == '4' then
            key1 = 'RIGHT'
        elseif getProperty('button1.animation.curAnim.name') == '5' then
            key1 = 'accept'
        end
        
        -- Verificar tecla correcta
        if isCorrectKeyPressed(key1) then
            runTimer('key1correct', 0.01)
            doTweenAlpha('button1out', 'button1', 0, 0.5)
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
        
        -- Verificar tecla incorrecta
        if isWrongKeyPressed(key1) then
            if eventactive then
                quickTimeFail()
            end
        end
    end

    -- BUTTON 2
    if key2turn then
        if getProperty('button2.animation.curAnim.name') == '1' then
            key2 = 'LEFT'
        elseif getProperty('button2.animation.curAnim.name') == '2' then
            key2 = 'DOWN'
        elseif getProperty('button2.animation.curAnim.name') == '3' then
            key2 = 'UP'
        elseif getProperty('button2.animation.curAnim.name') == '4' then
            key2 = 'RIGHT'
        elseif getProperty('button2.animation.curAnim.name') == '5' then
            key2 = 'accept'
        end
        
        if isCorrectKeyPressed(key2) then
            runTimer('key2correct', 0.01)
            doTweenAlpha('button2out', 'button2', 0, 0.5)
            if key2 == 'LEFT' then
                playAnim('button2', 'leftPress', false)
            elseif key2 == 'DOWN' then
                playAnim('button2', 'downPress', false)
            elseif key2 == 'UP' then
                playAnim('button2', 'upPress', false)
            elseif key2 == 'RIGHT' then
                playAnim('button2', 'rightPress', false)
            elseif key2 == 'accept' then
                playAnim('button2', 'spacePress', false)
            end
        end
        
        if isWrongKeyPressed(key2) then
            if eventactive then
                quickTimeFail()
            end
        end
    end

    -- BUTTON 3
    if key3turn then
        if getProperty('button3.animation.curAnim.name') == '1' then
            key3 = 'LEFT'
        elseif getProperty('button3.animation.curAnim.name') == '2' then
            key3 = 'DOWN'
        elseif getProperty('button3.animation.curAnim.name') == '3' then
            key3 = 'UP'
        elseif getProperty('button3.animation.curAnim.name') == '4' then
            key3 = 'RIGHT'
        elseif getProperty('button3.animation.curAnim.name') == '5' then
            key3 = 'accept'
        end
        
        if isCorrectKeyPressed(key3) then
            runTimer('key3correct', 0.01)
            doTweenAlpha('button3out', 'button3', 0, 0.5)
            if key3 == 'LEFT' then
                playAnim('button3', 'leftPress', false)
            elseif key3 == 'DOWN' then
                playAnim('button3', 'downPress', false)
            elseif key3 == 'UP' then
                playAnim('button3', 'upPress', false)
            elseif key3 == 'RIGHT' then
                playAnim('button3', 'rightPress', false)
            elseif key3 == 'accept' then
                playAnim('button3', 'spacePress', false)
            end
        end
        
        if isWrongKeyPressed(key3) then
            if eventactive then
                quickTimeFail()
            end
        end
    end

    -- BUTTON 4
    if key4turn then
        if getProperty('button4.animation.curAnim.name') == '1' then
            key4 = 'LEFT'
        elseif getProperty('button4.animation.curAnim.name') == '2' then
            key4 = 'DOWN'
        elseif getProperty('button4.animation.curAnim.name') == '3' then
            key4 = 'UP'
        elseif getProperty('button4.animation.curAnim.name') == '4' then
            key4 = 'RIGHT'
        elseif getProperty('button4.animation.curAnim.name') == '5' then
            key4 = 'accept'
        end
        
        if isCorrectKeyPressed(key4) then
            runTimer('key4correct', 0.01)
            doTweenAlpha('button4out', 'button4', 0, 0.5)
            if key4 == 'LEFT' then
                playAnim('button4', 'leftPress', false)
            elseif key4 == 'DOWN' then
                playAnim('button4', 'downPress', false)
            elseif key4 == 'UP' then
                playAnim('button4', 'upPress', false)
            elseif key4 == 'RIGHT' then
                playAnim('button4', 'rightPress', false)
            elseif key4 == 'accept' then
                playAnim('button4', 'spacePress', false)
            end
        end
        
        if isWrongKeyPressed(key4) then
            if eventactive then
                quickTimeFail()
            end
        end
    end
end

function onTimerCompleted(tag)
    if tag == 'key1correct' then
        playAnim('splash1', 'splash', true)
        setProperty('splash1.alpha', 1)
        setProperty('splash1.angle', getRandomInt(0, 360))
        playSound('quicktimeHit', 0.7)
        key1turn = false
        key2turn = true
    end
    if tag == 'key2correct' then
        playAnim('splash2', 'splash', true)
        setProperty('splash2.alpha', 1)
        setProperty('splash2.angle', getRandomInt(0, 360))
        playSound('quicktimeHit', 0.7)
        key2turn = false
        key3turn = true
    end
    if tag == 'key3correct' then
        playAnim('splash3', 'splash', true)
        setProperty('splash3.alpha', 1)
        setProperty('splash3.angle', getRandomInt(0, 360))
        playSound('quicktimeHit', 0.7)
        key3turn = false
        key4turn = true
    end
    if tag == 'key4correct' then
        playAnim('splash4', 'splash', true)
        setProperty('splash4.alpha', 1)
        setProperty('splash4.angle', getRandomInt(0, 360))
        playSound('quicktimeHit', 0.7)
        key4turn = false
        if repetitions == 0 then
            quickTimeWin()
        else
            repeatQTE()
        end
    end
    if tag == 'quicktimewin' then
        playSound('quicktimeGood', 0.6)
        runTimer('quicktimewin2', 0.2)
    end
    if tag == 'quicktimewin2' then
        if boyfriendName == 'bf' then
            playAnim('boyfriend', 'hey')
            setProperty('boyfriend.specialAnim', true)
            playSound('bfyeah', 1)
        end
    end
    if tag == 'timelimittimer' then
        quickTimeFail()
    end
    if tag == 'repeatqte' then
        shuffleKeys()
    end
    if tag == 'shadowanimatimer' then
        if getProperty('dad.animation.curAnim.name') == 'ready' then
            setProperty('dad.animation.curAnim.paused', true)
        end
    end
end

function repeatQTE()
    
    isrepetition = true
    repetitions = repetitions - 1
    runTimer('repeatqte', 0.1)
    doTweenAlpha('splash1out', 'splash1', 0, 0.1)
    doTweenAlpha('splash2out', 'splash2', 0, 0.1)
    doTweenAlpha('splash3out', 'splash3', 0, 0.1)
    doTweenAlpha('splash4out', 'splash4', 0, 0.1)

    cancelTimer('timelimittimer')
    cancelTween('timelimit')
    cancelTween('timelimitX')
    doTweenAlpha('eventtimebarbgout', 'eventtimebarbg', 0, 0.1)
    doTweenAlpha('eventtimebarbg2out', 'eventtimebarbg2', 0, 0.1)
    doTweenAlpha('eventtimebarout', 'eventtimebar', 0, 0.1)
end

function gunShot()
    playSound('gunshot')
    setProperty('gunshot.visible',true)
    setProperty('gunshot.x', getProperty('dad.x') + 250)
    setProperty('gunshot.y', getProperty('dad.y') + 400)
    doTweenX('gunshotshot', 'gunshot', getProperty('gunshot.x') + 1300, 0.25)
end

function onTweenCompleted(tag)
    if tag == 'gunshotshot' then
        setProperty('gunshot.visible',false)
    end
end

function quickTimeWin()
    if dadName == 'shadow' then
        playAnim('dad', 'shoot', true)
        gunShot()
        setProperty('dad.specialAnim', true)
        playAnim('boyfriend', 'dodge1', true)
        setProperty('boyfriend.specialAnim', true)
    end
    setProperty('sickhitindicator.x', 1)
    addScore(cashout)
    if setcanjumpfalse then
        setProperty('canjumpindicator.x', 1)
        setcanjumpfalse = false
    end
    setProperty('boyfriend.stunned', false)
    eventactive = false
    quicktimewin = true
    runTimer('quicktimewin', 0.1)
    doTweenAlpha('splash1out', 'splash1', 0, 0.5)
    doTweenAlpha('splash2out', 'splash2', 0, 0.5)
    doTweenAlpha('splash3out', 'splash3', 0, 0.5)
    doTweenAlpha('splash4out', 'splash4', 0, 0.5)

    cancelTimer('timelimittimer')
    cancelTween('timelimit')
    cancelTween('timelimitX')
    doTweenAlpha('eventtimebarbgout', 'eventtimebarbg', 0, 0.5)
    doTweenAlpha('eventtimebarbg2out', 'eventtimebarbg2', 0, 0.5)
    doTweenAlpha('eventtimebarout', 'eventtimebar', 0, 0.5)
end

function quickTimeFail()
    if dadName == 'shadow' then
        playAnim('dad', 'shoot', true)
        gunShot()
        setProperty('dad.specialAnim', true)
        playAnim('boyfriend', 'hurt', true)
        setProperty('boyfriend.specialAnim', true)
    end
    setProperty('shithitindicator.x', 1)
    if setcanjumpfalse then
        setProperty('canjumpindicator.x', 1)
        setcanjumpfalse = false
    end
    setProperty('boyfriend.stunned', false)
    eventactive = false
    addMisses(1)
    addScore(-600)
    setProperty('hurtRing.x', 1)
    key1turn = false
    key2turn = false
    key3turn = false
    key4turn = false
    playSound('quicktimeBad', 0.4)
    doTweenAlpha('button1out', 'button1', 0, 0.5)
    doTweenAlpha('button2out', 'button2', 0, 0.5)
    doTweenAlpha('button3out', 'button3', 0, 0.5)
    doTweenAlpha('button4out', 'button4', 0, 0.5)
    doTweenAlpha('splash1out', 'splash1', 0, 0.5)
    doTweenAlpha('splash2out', 'splash2', 0, 0.5)
    doTweenAlpha('splash3out', 'splash3', 0, 0.5)
    doTweenAlpha('splash4out', 'splash4', 0, 0.5)

    cancelTimer('timelimittimer')
    cancelTween('timelimit')
    cancelTween('timelimitX')
    doTweenAlpha('eventtimebarbgout', 'eventtimebarbg', 0, 0.5)
    doTweenAlpha('eventtimebarbg2out', 'eventtimebarbg2', 0, 0.5)
    doTweenAlpha('eventtimebarout', 'eventtimebar', 0, 0.5)
end