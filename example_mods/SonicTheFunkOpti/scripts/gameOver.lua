firstgameover = true
cameraboppin = false
beatallowed = true
canselect = false
GOselection = 'yes'
selectionminsize = 0.5
gameovermusicactive = false
caninput = true

beatLength = (60 / 87) * 1000
lastBeat = -1

function onCreatePost()
    setProperty('canReset', false)

    makeLuaSprite('gameoveractive') --
    makeGraphic('gameoveractive', 1, 1, 'ffffff') --0000ff
    setProperty('gameoveractive.alpha', 0)
    addLuaSprite('gameoveractive', false)
    setObjectCamera('gameoveractive', 'hud')
    setProperty('gameoveractive.x', 0) --0 not active 1 active
end


function gameOverExit()
    canselect = false
    runTimer('gameoverExit', 0.3)
    playSound('cancelMenu')
    beatallowed = false
    soundFadeOut(nil, 1, 0)
end

function gameoverRetry()
    setProperty('spinGO.scale.y', 1.4* 0.7)
    doTweenY('spinGOScaleTweenYNope', 'spinGO.scale', 1 * 0.7, 0.5, 'expoOut')
    setProperty('spinGO.scale.x', 0.6 * 0.7)
    doTweenX('spinGOScaleTweenXNope', 'spinGO.scale', 1 * 0.7, 0.5, 'expoOut')

    setProperty('spinGO.visible', true)
    setProperty('sonicGO.visible', false)
    if GOselection == 'yes' then
        playSound('continue')
        doTweenX('speentweenX', 'spinGO', GOspinX + 350, 0.8, 'quadIn')
    elseif GOselection == 'no' then
        playSound('giveup')
        doTweenX('speentweenX', 'spinGO', GOspinX - 350, 0.8, 'quadIn')
    end
    doTweenY('spintween1', 'spinGO', getProperty('spinGO.y') - 350, 0.5, 'quadOut')
    playSound('jump')
    runTimer('retrytimer1', 1)
    doTweenAlpha('NOCOLOR', 'GOno', 0, 0.4)
    doTweenAlpha('YESCOLOR', 'GOyes', 0, 0.4)
    doTweenAlpha('STAR1IN', 'GOstar1', 0, 0.4)
    doTweenAlpha('STAR2IN', 'GOstar2', 0, 0.4)
    canselect = false
    beatallowed = false
    --soundFadeOut(nil, 0.01, 0)
    stopSound('gameovermusic')

end

function onUpdatePost()
    if getProperty('gameoveractive.x') == 1 then
            --music looping
        
        if getProperty('explosion.animation.curAnim.name') == 'explosion' and getProperty('explosion.animation.curAnim.finished') then
            setProperty('explosion.visible', false)
        end
        if firstgameover then
            setProperty('eventsindicator.x', 0)
            firstgameover = false
            createGameOver()
        end
        if canselect then
                    -- HOVER PARA SELECCIONAR EN GAME OVER
        if canselect and caninput then
            local mouseX = getMouseX('other')
            local mouseY = getMouseY('other')
            local previousSelection = GOselection
            
            -- Detectar hover sobre YES
            if mouseX > getProperty('GOyes.x') and mouseX < getProperty('GOyes.x') + getProperty('GOyes.width') 
            and mouseY > getProperty('GOyes.y') and mouseY < getProperty('GOyes.y') + getProperty('GOyes.height') then
                if GOselection ~= 'yes' then
                    GOselection = 'yes'
                    playSound('scrollMenu')
                    
                    -- Actualizar visualmente (mismo código que cuando usas teclas)
                    doTweenAlpha('NOCOLOR', 'GOno', 0.4, 0.2)
                    doTweenColor('YESCOLOR', 'GOyes', 1, 0.2)
                    doTweenX('YESsize1', 'GOyes.scale', 0.9, 0.4, 'cubeOut')
                    doTweenY('YESsize2', 'GOyes.scale', 0.9, 0.4, 'cubeOut')
                    doTweenX('NOsize1', 'GOno.scale', selectionminsize, 0.4, 'cubeOut')
                    doTweenY('NOsize2', 'GOno.scale', selectionminsize, 0.4, 'cubeOut')

                    doTweenX('GOstar1x', 'GOstar1', getProperty('GOyes.x') - 50, 0.5, 'cubeOut')
                    doTweenX('GOstar2x', 'GOstar2', getProperty('GOyes.x') + 138, 0.5, 'cubeOut')
                    doTweenY('GOstar1y', 'GOstar1', getProperty('GOyes.y'), 0.5, 'cubeOut')
                    doTweenY('GOstar2y', 'GOstar2', getProperty('GOyes.y'), 0.5, 'cubeOut')
                end
            end
            
            -- Detectar hover sobre NO
            if mouseX > getProperty('GOno.x') and mouseX < getProperty('GOno.x') + getProperty('GOno.width') 
            and mouseY > getProperty('GOno.y') and mouseY < getProperty('GOno.y') + getProperty('GOno.height') then
                if GOselection ~= 'no' then
                    GOselection = 'no'
                    playSound('scrollMenu')
                    
                    -- Actualizar visualmente
                    doTweenAlpha('NOCOLOR', 'GOno', 1, 0.2)
                    doTweenAlpha('YESCOLOR', 'GOyes', 0.4, 0.2)
                    doTweenX('YESsize1', 'GOyes.scale', selectionminsize, 0.4, 'cubeOut')
                    doTweenY('YESsize2', 'GOyes.scale', selectionminsize, 0.4, 'cubeOut')
                    doTweenX('NOsize1', 'GOno.scale', 0.9, 0.4, 'cubeOut')
                    doTweenY('NOsize2', 'GOno.scale', 0.9, 0.4, 'cubeOut')

                    doTweenX('GOstar1x', 'GOstar1', getProperty('GOno.x') - 50, 0.5, 'cubeOut')
                    doTweenX('GOstar2x', 'GOstar2', getProperty('GOno.x') + 90, 0.5, 'cubeOut')
                    doTweenY('GOstar1y', 'GOstar1', getProperty('GOno.y'), 0.5, 'cubeOut')
                    doTweenY('GOstar2y', 'GOstar2', getProperty('GOno.y'), 0.5, 'cubeOut')
                end
            end
        end
        
        -- CLIC PARA SELECCIONAR EN GAME OVER
        if canselect and caninput and mouseClicked('left') then
            local mouseX = getMouseX('other')
            local mouseY = getMouseY('other')
            
            -- Clic en YES
            if mouseX > getProperty('GOyes.x') and mouseX < getProperty('GOyes.x') + getProperty('GOyes.width') 
            and mouseY > getProperty('GOyes.y') and mouseY < getProperty('GOyes.y') + getProperty('GOyes.height') then
                GOselection = 'yes'
                gameoverRetry()
                return
            end
            
            -- Clic en NO
            if mouseX > getProperty('GOno.x') and mouseX < getProperty('GOno.x') + getProperty('GOno.width') 
            and mouseY > getProperty('GOno.y') and mouseY < getProperty('GOno.y') + getProperty('GOno.height') then
                GOselection = 'no'
                gameoverRetry()
                return
            end
        end
        if caninput then
            if keyJustPressed('back') then
                gameoverRetry()
            end
            if keyJustPressed('accept') then
                gameoverRetry()
            end
            if keyJustPressed('ui_up') or keyJustPressed('ui_down') then
                playSound('scrollMenu')
                if GOselection == 'yes' then
                    doTweenAlpha('NOCOLOR', 'GOno', 1, 0.2)
                    doTweenAlpha('YESCOLOR', 'GOyes', 0.4, 0.2)
                    doTweenX('YESsize1', 'GOyes.scale', selectionminsize, 0.4, 'cubeOut')
                    doTweenY('YESsize2', 'GOyes.scale', selectionminsize, 0.4, 'cubeOut')
                    doTweenX('NOsize1', 'GOno.scale', 0.9, 0.4, 'cubeOut')
                    doTweenY('NOsize2', 'GOno.scale', 0.9, 0.4, 'cubeOut')

                    doTweenX('GOstar1x', 'GOstar1', getProperty('GOno.x') - 50, 0.5, 'cubeOut')
                    doTweenX('GOstar2x', 'GOstar2', getProperty('GOno.x') + 90, 0.5, 'cubeOut')
                    doTweenY('GOstar1y', 'GOstar1', getProperty('GOno.y'), 0.5, 'cubeOut')
                    doTweenY('GOstar2y', 'GOstar2', getProperty('GOno.y'), 0.5, 'cubeOut')
                    GOselection = 'no'
                elseif GOselection == 'no' then
                    doTweenAlpha('NOCOLOR', 'GOno', 0.4, 0.2)
                    doTweenColor('YESCOLOR', 'GOyes', 1, 0.2)
                    doTweenX('YESsize1', 'GOyes.scale', 0.9, 0.4, 'cubeOut')
                    doTweenY('YESsize2', 'GOyes.scale', 0.9, 0.4, 'cubeOut')
                    doTweenX('NOsize1', 'GOno.scale', selectionminsize, 0.4, 'cubeOut')
                    doTweenY('NOsize2', 'GOno.scale', selectionminsize, 0.4, 'cubeOut')

                    doTweenX('GOstar1x', 'GOstar1', getProperty('GOyes.x') - 50, 0.5, 'cubeOut')
                    doTweenX('GOstar2x', 'GOstar2', getProperty('GOyes.x') + 138, 0.5, 'cubeOut')
                    doTweenY('GOstar1y', 'GOstar1', getProperty('GOyes.y'), 0.5, 'cubeOut')
                    doTweenY('GOstar2y', 'GOstar2', getProperty('GOyes.y'), 0.5, 'cubeOut')
                    GOselection = 'yes'
                end
            end
        end
    end
        if gameovermusicactive then
            local currentTime = getProperty('sound_gameovermusic.time')
            local fullLength = getProperty('sound_gameovermusic.length')
            local currentBeat = math.floor(currentTime / beatLength)
            if currentBeat > lastBeat then
                lastBeat = currentBeat
                onBeatHitCustom(currentBeat)
            end
        end
    end
end

function onStepHit()
    if curStep % 4 == 0 then
        if cameraboppin then
            --runTimer('GOcamzoomtimer', 0.36)
        end
    end
end

function onBeatHitCustom(currentBeat)
        if beatallowed then
            playAnim('sonicGO', 'idle', false)
            playAnim('gameovermonitor', 'on', false)
            playAnim('gameovermonitorEGG', 'on', false)
            setProperty('camOther.zoom', 1.02)
            doTweenZoom('camZoomPause', 'camOther', 1, 3, 'expoOut')
        end
end

function createGameOver()
    endSong()
    precacheSound('../music/gameOver')
    setProperty('camGame.visible', false)
    setProperty('playerVocals.volume', 0)
    setProperty('cursor.visible', false)
    runTimer('initiateGameover', 4.23)
    playSound('fnf_loss_sfx', 1, 'initiateGameover')

    makeLuaSprite('gameoverOVERLAY', nil, 0, 0)
    makeGraphic('gameoverOVERLAY', screenWidth, screenHeight, '000000')
    setProperty('gameoverOVERLAY.alpha', 0)
    addLuaSprite('gameoverOVERLAY', false)
    setProperty('gameoverOVERLAY.camera', instanceArg('camOther'), false, true)

    YoffsetGO = 700

    GObgY = 150
    makeLuaSprite('gameoverbackground', 'gameover/bg', 250, GObgY)
    setObjectCamera('gameoverbackground', 'camOther')
    setProperty('gameoverbackground.scale.x', 1.8)
    setProperty('gameoverbackground.scale.y', 1.8)
    addLuaSprite('gameoverbackground', true)
    setProperty('gameoverbackground.visible', false)
    
    GOfloorY = 150
    makeAnimatedLuaSprite('gameoverfloor', 'gameover/floor', 320, GOfloorY + YoffsetGO)
    addAnimationByPrefix('gameoverfloor', 'off', 'floor OFF', 24, false)
    addAnimationByPrefix('gameoverfloor', 'on', 'floor ON', 24, false)
    playAnim('gameoverfloor', 'off', false)
    setObjectCamera('gameoverfloor', 'camOther')
    setProperty('gameoverfloor.scale.x', 0.9)
    setProperty('gameoverfloor.scale.y', 0.9)
    addLuaSprite('gameoverfloor', true)

    GOmonitorY = 345
    if boyfriendName == 'bf' then
    makeAnimatedLuaSprite('gameovermonitor', 'gameover/monitorBF', 865, GOmonitorY+ YoffsetGO * 1.1) --  
    addAnimationByPrefix('gameovermonitor', 'off', 'monitor off', 24, false)
    addOffset('gameovermonitor', 'off', 0, 0)
    addAnimationByPrefix('gameovermonitor', 'on', 'monitor on bf', 24, false)
    addOffset('gameovermonitor', 'on', 160, 33)
    addAnimationByPrefix('gameovermonitor', 'broken', 'monitor broken', 24, false)
    addOffset('gameovermonitor', 'broken', 0, -50)
    playAnim('gameovermonitor', 'off', false)
    setObjectCamera('gameovermonitor', 'camOther')
    setProperty('gameovermonitor.scale.x', 0.9)
    setProperty('gameovermonitor.scale.y', 0.9)
    addLuaSprite('gameovermonitor', true)
    setProperty('gameovermonitor.color', getColorFromHex('343C5F'))
    
    makeAnimatedLuaSprite('gameovermonitorEGG', 'gameover/monitorDAD', 205, GOmonitorY+ YoffsetGO * 1.1) --  
    addAnimationByPrefix('gameovermonitorEGG', 'off', 'monitor EGG off', 24, false)
    addOffset('gameovermonitorEGG', 'off', 0, 0)
    addAnimationByPrefix('gameovermonitorEGG', 'on', 'monitor DAD on', 24, false)
    addOffset('gameovermonitorEGG', 'on', 0, 33)
    addAnimationByPrefix('gameovermonitorEGG', 'broken', 'monitor EGG broken', 24, false)
    addOffset('gameovermonitorEGG', 'broken', 0, -50)
    playAnim('gameovermonitorEGG', 'off', false)
    setObjectCamera('gameovermonitorEGG', 'camOther')
    setProperty('gameovermonitorEGG.scale.x', 0.9)
    setProperty('gameovermonitorEGG.scale.y', 0.9)
    addLuaSprite('gameovermonitorEGG', true)
    setProperty('gameovermonitorEGG.color', getColorFromHex('343C5F'))
    
    makeAnimatedLuaSprite('gameovericon', 'gameover/monitorBF', 894, GOmonitorY + 30)
    addAnimationByPrefix('gameovericon', 'icon', 'monitor bf only', 24, false)
    setObjectCamera('gameovericon', 'camOther')
    setProperty('gameovericon.scale.x', 0.9)
    setProperty('gameovericon.scale.y', 0.9)
    addLuaSprite('gameovericon', true)
    setProperty('gameovericon.visible', false)

    makeAnimatedLuaSprite('gameovericonEGG', 'gameover/monitorDAD', 278, GOmonitorY + 30)
    addAnimationByPrefix('gameovericonEGG', 'icon', 'monitor DAD dad only', 24, false)
    setObjectCamera('gameovericonEGG', 'camOther')
    setProperty('gameovericonEGG.scale.x', 0.9)
    setProperty('gameovericonEGG.scale.y', 0.9)
    addLuaSprite('gameovericonEGG', true)
    setProperty('gameovericonEGG.visible', false)
    else --sonic
    makeAnimatedLuaSprite('gameovermonitor', 'gameover/monitor', 865, GOmonitorY+ YoffsetGO * 1.1) --  
    addAnimationByPrefix('gameovermonitor', 'off', 'monitor off', 24, false)
    addOffset('gameovermonitor', 'off', 0, 0)
    addAnimationByPrefix('gameovermonitor', 'on', 'monitor on', 24, false)
    addOffset('gameovermonitor', 'on', 160, 33)
    addAnimationByPrefix('gameovermonitor', 'broken', 'monitor broken', 24, false)
    addOffset('gameovermonitor', 'broken', 0, -50)
    playAnim('gameovermonitor', 'off', false)
    setObjectCamera('gameovermonitor', 'camOther')
    setProperty('gameovermonitor.scale.x', 0.9)
    setProperty('gameovermonitor.scale.y', 0.9)
    addLuaSprite('gameovermonitor', true)
    setProperty('gameovermonitor.color', getColorFromHex('343C5F'))
    
    makeAnimatedLuaSprite('gameovermonitorEGG', 'gameover/monitorEGG', 205, GOmonitorY+ YoffsetGO * 1.1) --  
    addAnimationByPrefix('gameovermonitorEGG', 'off', 'monitor EGG off', 24, false)
    addOffset('gameovermonitorEGG', 'off', 0, 0)
    addAnimationByPrefix('gameovermonitorEGG', 'on', 'monitor EGG on', 24, false)
    addOffset('gameovermonitorEGG', 'on', 0, 33)
    addAnimationByPrefix('gameovermonitorEGG', 'broken', 'monitor EGG broken', 24, false)
    addOffset('gameovermonitorEGG', 'broken', 0, -50)
    playAnim('gameovermonitorEGG', 'off', false)
    setObjectCamera('gameovermonitorEGG', 'camOther')
    setProperty('gameovermonitorEGG.scale.x', 0.9)
    setProperty('gameovermonitorEGG.scale.y', 0.9)
    addLuaSprite('gameovermonitorEGG', true)
    setProperty('gameovermonitorEGG.color', getColorFromHex('343C5F'))
    
    makeAnimatedLuaSprite('gameovericon', 'gameover/monitor', 894, GOmonitorY + 30)
    addAnimationByPrefix('gameovericon', 'icon', 'monitor sonic only', 24, false)
    setObjectCamera('gameovericon', 'camOther')
    setProperty('gameovericon.scale.x', 0.9)
    setProperty('gameovericon.scale.y', 0.9)
    addLuaSprite('gameovericon', true)
    setProperty('gameovericon.visible', false)

    makeAnimatedLuaSprite('gameovericonEGG', 'gameover/monitorEGG', 278, GOmonitorY + 30)
    addAnimationByPrefix('gameovericonEGG', 'icon', 'monitor EGG eggman only', 24, false)
    setObjectCamera('gameovericonEGG', 'camOther')
    setProperty('gameovericonEGG.scale.x', 0.9)
    setProperty('gameovericonEGG.scale.y', 0.9)
    addLuaSprite('gameovericonEGG', true)
    setProperty('gameovericonEGG.visible', false)
    end

    

    GOcontinueY = 40
    makeAnimatedLuaSprite('gameoverCONTINUE', 'gameover/continue', 300, GOcontinueY - YoffsetGO)
    addAnimationByPrefix('gameoverCONTINUE', 'off', 'continue off', 24, false)
    addAnimationByPrefix('gameoverCONTINUE', 'on', 'continue on', 24, false)
    playAnim('gameoverCONTINUE', 'off', false)
    setObjectCamera('gameoverCONTINUE', 'camOther')
    setProperty('gameoverCONTINUE.scale.x', 0.9)
    setProperty('gameoverCONTINUE.scale.y', 0.9)
    addLuaSprite('gameoverCONTINUE', true)


    GOsonicY = 350
    if boyfriendName == 'bf' then
    makeAnimatedLuaSprite('sonicGO', 'gameover/bf', 430, GOsonicY + YoffsetGO)
    addAnimationByPrefix('sonicGO', 'idle', 'bf lying down', 24, false)
    addOffset('sonicGO', 'idle', 0, -30)
    addAnimationByPrefix('sonicGO', 'continue', 'bf continue', 24, false)
    addOffset('sonicGO', 'continue', -20, 100)
    addOffset('sonicGO', 'laying down', 0, 0)
    playAnim('sonicGO', 'laying down', false)
    setObjectCamera('sonicGO', 'camOther')
    setProperty('sonicGO.scale.x', 0.9)
    setProperty('sonicGO.scale.y', 0.9)
    addLuaSprite('sonicGO', true)
    setProperty('sonicGO.color', getColorFromHex('343C5F'))
    else
    makeAnimatedLuaSprite('sonicGO', 'gameover/sonic', 400, GOsonicY + YoffsetGO)
    addAnimationByPrefix('sonicGO', 'idle', 'sonic lying down', 24, false)
    addOffset('sonicGO', 'idle', 0, 0)
    addAnimationByPrefix('sonicGO', 'continue', 'sonic continue', 24, false)
    addOffset('sonicGO', 'continue', -60, 130)
    playAnim('sonicGO', 'idle', false)
    addOffset('sonicGO', 'laying down', 0, 0)
    playAnim('sonicGO', 'laying down', false)
    setObjectCamera('sonicGO', 'camOther')
    setProperty('sonicGO.scale.x', 0.9)
    setProperty('sonicGO.scale.y', 0.9)
    addLuaSprite('sonicGO', true)
    setProperty('sonicGO.color', getColorFromHex('343C5F'))
    end

    GOspinX = 450
    if boyfriendName == 'bf' then
    makeAnimatedLuaSprite('spinGO', 'bf spin', GOspinX, GOsonicY - 20)
    addAnimationByPrefix('spinGO', 'spin', 'spin instance 1', 24, true)
    addOffset('spinGO', 'spin', 0, 0)
    playAnim('spinGO', 'spin', true)
    setObjectCamera('spinGO', 'camOther')
    setProperty('spinGO.scale.x', 0.7)
    setProperty('spinGO.scale.y', 0.7)
    addLuaSprite('spinGO', true)
    setProperty('spinGO.visible', false)
    else
    makeAnimatedLuaSprite('spinGO', 'sonic spin', GOspinX, GOsonicY - 20)
    addAnimationByPrefix('spinGO', 'spin', 'sonicball', 24, true)
    addOffset('spinGO', 'spin', 0, 0)
    playAnim('spinGO', 'spin', true)
    setObjectCamera('spinGO', 'camOther')
    setProperty('spinGO.scale.x', 0.7)
    setProperty('spinGO.scale.y', 0.7)
    addLuaSprite('spinGO', true)
    setProperty('spinGO.visible', false)
    end


    makeAnimatedLuaSprite('explosion', 'bomb', 790, 280)
    addAnimationByPrefix('explosion', 'explosion', 'explosion', 24, false)
    setObjectCamera('explosion', 'camOther')
    setProperty('explosion.scale.x', 0.6)
    setProperty('explosion.scale.y', 0.6)
    addLuaSprite('explosion', true)
    setProperty('explosion.visible', false)

    makeAnimatedLuaSprite('GOyes', 'gameover/selection', 555, 210)
    addAnimationByPrefix('GOyes', 'yes', 'yestxt', 24, true)
    setObjectCamera('GOyes', 'camOther')
    setProperty('GOyes.origin.x', 70)
    setProperty('GOyes.scale.x', 0.9)
    setProperty('GOyes.scale.y', 0.9)
    addLuaSprite('GOyes', true)
    setProperty('GOyes.alpha', 0) --343C5F

    makeAnimatedLuaSprite('GOno', 'gameover/selection', 581, 273)
    addAnimationByPrefix('GOno', 'no', 'notxt', 24, true)
    setObjectCamera('GOno', 'camOther')
    setProperty('GOno.scale.x', selectionminsize)
    setProperty('GOno.scale.y', selectionminsize)
    addLuaSprite('GOno', true)
    setProperty('GOno.alpha', 0)

    makeAnimatedLuaSprite('GOstar1', 'gameover/selection', getProperty('GOyes.x') - 50, getProperty('GOyes.y'))
    addAnimationByPrefix('GOstar1', 'star', 'selection star', 24, true)
    setObjectCamera('GOstar1', 'camOther')
    setProperty('GOstar1.scale.x', 0.9)
    setProperty('GOstar1.scale.y', 0.9) 
    addLuaSprite('GOstar1', true)
    setProperty('GOstar1.alpha', 0)

    makeAnimatedLuaSprite('GOstar2', 'gameover/selection', getProperty('GOyes.x') + 138, getProperty('GOyes.y'))
    addAnimationByPrefix('GOstar2', 'star', 'selection star', 24, true)
    setObjectCamera('GOstar2', 'camOther')
    setProperty('GOstar2.scale.x', 0.9)
    setProperty('GOstar2.scale.y', 0.9)
    addLuaSprite('GOstar2', true)
    setProperty('GOstar2.alpha', 0)
    
    GOshoesY = 750
    if boyfriendName == 'bf' then
    makeAnimatedLuaSprite('GOshoe1', 'gameover/bfshoes', 400, GOshoesY)
    addAnimationByPrefix('GOshoe1', 'shoe1', 'bf shoe1', 24, true)
    setObjectCamera('GOshoe1', 'camOther')
    setProperty('GOshoe1.scale.x', 0.9)
    setProperty('GOshoe1.scale.y', 0.9)
    addLuaSprite('GOshoe1', true)
    setProperty('GOshoe1.visible', false)

    makeAnimatedLuaSprite('GOshoe2', 'gameover/bfshoes', 600, GOshoesY)
    addAnimationByPrefix('GOshoe2', 'shoe2', 'bf shoe2', 24, true)
    setObjectCamera('GOshoe2', 'camOther')
    setProperty('GOshoe2.scale.x', 0.9)
    setProperty('GOshoe2.scale.y', 0.9)
    addLuaSprite('GOshoe2', true)
    setProperty('GOshoe2.visible', false)
    else
    makeAnimatedLuaSprite('GOshoe1', 'gameover/shoes', 400, GOshoesY)
    addAnimationByPrefix('GOshoe1', 'shoe1', 'sonic shoe1', 24, true)
    setObjectCamera('GOshoe1', 'camOther')
    setProperty('GOshoe1.scale.x', 0.9)
    setProperty('GOshoe1.scale.y', 0.9)
    addLuaSprite('GOshoe1', true)
    setProperty('GOshoe1.visible', false)

    makeAnimatedLuaSprite('GOshoe2', 'gameover/shoes', 600, GOshoesY)
    addAnimationByPrefix('GOshoe2', 'shoe2', 'sonic shoe2', 24, true)
    setObjectCamera('GOshoe2', 'camOther')
    setProperty('GOshoe2.scale.x', 0.9)
    setProperty('GOshoe2.scale.y', 0.9)
    addLuaSprite('GOshoe2', true)
    setProperty('GOshoe2.visible', false)
    end

    tweentimeGO = 4.2
    tweentypeGO = 'expoOut'
    
    playAnim('sonicGO', 'idle', false)
    doTweenY('sonicinGO', 'sonicGO', GOsonicY, tweentimeGO, tweentypeGO)
    doTweenY('monitorinGO', 'gameovermonitor', GOmonitorY, tweentimeGO, tweentypeGO)
    doTweenY('monitorEGGinGO', 'gameovermonitorEGG', GOmonitorY, tweentimeGO, tweentypeGO)
    doTweenY('floorinGO', 'gameoverfloor', GOfloorY, tweentimeGO, tweentypeGO)
    doTweenY('continueinGO', 'gameoverCONTINUE', GOcontinueY, tweentimeGO, tweentypeGO)
end


function onSoundFinished(tag)
    if tag == 'initiateGameover' then
        doTweenAlpha('NOCOLOR', 'GOno', 0.4, 0.4)
        doTweenAlpha('YESCOLOR', 'GOyes', 1, 0.4)
        doTweenAlpha('STAR1IN', 'GOstar1', 1, 0.4)
        doTweenAlpha('STAR2IN', 'GOstar2', 1, 0.4)
        canselect = true
        cameraboppin = true
       setPropertyFromClass('backend.Conductor', 'bpm', 87)
        playSound('../music/gameOver', 1, 'gameovermusic')
        setSoundTime('gameovermusic', 1)
        gameovermusicactive = true
        setProperty('gameoverbackground.visible', true)
        setProperty('gameoverbackground.alpha', 0)
        doTweenAlpha('GObgfadein', 'gameoverbackground', 1, 0.4)
        setProperty('sonicGO.color', getColorFromHex('ffffff'))
        setProperty('gameovermonitor.color', getColorFromHex('ffffff'))
        playAnim('gameovermonitor', 'on', false)
        setProperty('gameovermonitorEGG.color', getColorFromHex('ffffff'))
        playAnim('gameovermonitorEGG', 'on', false)
        playAnim('gameoverfloor', 'on', false)
        playAnim('gameoverCONTINUE', 'on', false)
    end
    --looping
    if tag == ('gameovermusic') then
        playSound('../music/gameOver', 1, 'gameovermusic')
        setSoundTime('gameovermusic', 1)
        lastBeat = -1
    end
end

function onTimerCompleted(tag)
    if tag == 'retrytimer1' then
    end
    if tag == 'retrytimer2' then
        if GOselection == 'yes' then
            doTweenAlpha('icondissGO', 'gameovericon', 0, 0.4)
        elseif GOselection == 'no' then
            doTweenAlpha('iconEGGdissGO', 'gameovericonEGG', 0, 0.4)
        end
        if GOselection == 'yes' then
            runTimer('retrytimer3', 1.4)
        elseif GOselection == 'no' then
            runTimer('retrytimer3', 2)
        end
    end
    if tag == 'retrytimer3' then
        caninput = false
        setProperty('transInIndicator.x', 1)
        runTimer('loadmenu', 0.9)
    end
    if tag == 'loadmenu' then
        if GOselection == 'yes' then
            restartSong()
        elseif GOselection == 'no' then
            local namereformat = songName:gsub("%s+", "-"):lower()
            setDataFromSave('globalsave', 'lastSong', songName)
            setPropertyFromClass('backend.Difficulty', 'list', {'normal'})
            loadSong('menu', 0)
        end
    end
end

function onTweenCompleted(tag)
    if tag == 'spintween1' then
        doTweenY('spintween2', 'spinGO', getProperty('spinGO.y') + 200, 0.3, 'quadIn')
    end
    if tag == 'spintween2' then
        doTweenY('spintween3', 'spinGO', getProperty('spinGO.y') - 200, 0.3, 'quadOut')
        doTweenX('speentweenX', 'spinGO', GOspinX, 1, 'quadOut')

    setProperty('explosion.visible', true)
        runTimer('retrytimer2', 1)
        playSound('monitor', 1)
        if GOselection == 'yes' then
            setProperty('gameovericon.visible', true)
            doTweenY('iconupGO', 'gameovericon', getProperty('gameovericon.y') - 100, 1, 'expoOut')
            playAnim('gameovermonitor', 'broken', false)
            setProperty('explosion.x', 790)
        elseif GOselection == 'no' then
            setProperty('gameovericonEGG.visible', true)
            doTweenY('iconupGO', 'gameovericonEGG', getProperty('gameovericonEGG.y') - 100, 1, 'expoOut')
            playAnim('gameovermonitorEGG', 'broken', false)
            setProperty('explosion.x', 200)
        end
    playAnim('explosion', 'explosion', false)
    end
    if tag == 'spintween3' then
        if GOselection == 'yes' then
            doTweenY('spintween4', 'spinGO', getProperty('spinGO.y') + 350, 0.5, 'quadIn')
        elseif GOselection == 'no' then
            doTweenY('spintween4', 'spinGO', getProperty('spinGO.y') + 700, 0.8, 'quadIn')
        end
    end
    if tag == 'spintween4' then
        setProperty('spinGO.visible', false)
        if GOselection == 'yes' then
            setProperty('sonicGO.visible', true)
            playAnim('sonicGO', 'continue', false)
        elseif GOselection == 'no' then
            --giveup animation
            setProperty('GOshoe1.visible', true)
            setProperty('GOshoe2.visible', true)
            doTweenY('GOshoe1IN', 'GOshoe1', GOshoesY - 550, 0.7, 'quadOut')
            doTweenY('GOshoe2IN', 'GOshoe2', GOshoesY - 550, 0.7, 'quadOut')
            doTweenAngle('GOshoe1ANGLE', 'GOshoe1', 260, 1.7, 'quadOut')
            doTweenAngle('GOshoe2ANGLE', 'GOshoe2', 260, 1.7, 'quadOut')
        end
    end
    if tag == 'GOshoe1IN' then
            doTweenY('GOshoe1IN2', 'GOshoe1', GOshoesY, 0.7, 'quadIn')
            doTweenY('GOshoe2IN2', 'GOshoe2', GOshoesY, 0.7, 'quadIn')
    end
    if tag == 'GOshoe1IN2' then
            setProperty('GOshoe1.visible', false)
            setProperty('GOshoe2.visible', false)
    end
end