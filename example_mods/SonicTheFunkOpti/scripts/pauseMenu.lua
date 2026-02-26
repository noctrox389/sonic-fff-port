local textScaling = 2
local timeease = 1
local easetype = 'expoOut'
local dadr = getProperty('dad.healthColorArray[0]')
local dadg = getProperty('dad.healthColorArray[1]')
local dadb = getProperty('dad.healthColorArray[2]')
local dadColor = string.format('%02X%02X%02X', dadr, dadg, dadb)
local bfr = getProperty('boyfriend.healthColorArray[0]')
local bfg = getProperty('boyfriend.healthColorArray[1]')
local bfb = getProperty('boyfriend.healthColorArray[2]')
local bfColor = string.format('%02X%02X%02X', bfr, bfg, bfb)
local curselected = 'continue'
local beatLength = (60 / 125) * 1000  -- 125 BPM = 480 ms per beat
local lastBeat = -1
local pauseCharTurn = 'opp' --player
pauseobjorder = 49
function onCreatePost()
    initSaveData('globalsave')
                prevsong = getDataFromSave('globalsave', 'lastSong')
                setDataFromSave('globalsave', 'lastSong', nil)
    if boyfriendName == 'sonic_player' or boyfriendName == 'sonic_run' or boyfriendName == 'sketchhog' then
        pauseCharacter2 = 'sonic'
    elseif boyfriendName == 'boyfriend' then
        pauseCharacter2 = 'bf'
    else
        pauseCharacter2 = 'bf'
    end
    if dadName == 'sonic_opp' or dadName == 'sketchhog' then
        pauseCharacter = 'sonic'
    elseif dadName == 'knuckles' then
        pauseCharacter = 'knuckles'
    elseif dadName == 'shadow' then
    pauseCharacter = 'shadow'
    elseif dadName == 'metalsonic' then
        pauseCharacter = 'metalsonic'
    elseif dadName == 'sketchfox' then
        pauseCharacter = 'tails'
    else
        pauseCharacter = 'sonic'
    end

    if songName == 'break down' or songName == 'Break Down' or songName == 'blueprint' or songName == 'Blueprint' then
         songCredit = 'MegaBaz'
    else
        songCredit = 'Jon SpeedArts'
    end
    precacheSound('../music/breakfast')

    makeLuaSprite('pauseOVERLAY', nil, 0, 0)
    makeGraphic('pauseOVERLAY', screenWidth, screenHeight, '201933')
    addLuaSprite('pauseOVERLAY', false)
    setBlendMode('pauseOVERLAY', 'multiply')
    setObjectCamera('pauseOVERLAY', 'other')
    pauseobjorder = pauseobjorder + 1
    setObjectOrder('pauseOVERLAY', pauseobjorder)
    setProperty('pauseOVERLAY.visible', false)
    setProperty('pauseOVERLAY.alpha', 0)

    logoX = 10
    logoY = 115
    logoinitialX = -383
    logofinishX = 10
    makeLuaSprite('logo', 'pause/soniclogo', logofinishX, logoY)
    addLuaSprite('logo', false)
    setObjectCamera('logo', 'other')
    pauseobjorder = pauseobjorder + 1
    setObjectOrder('logo', pauseobjorder)
    setProperty('logo.visible', false)

    pauseBarY = 40
    pauseBar1X = -450
    makeLuaSprite('pauseBAR1', 'pause/pauseBar', pauseBarX, pauseBarY)
    addLuaSprite('pauseBAR1', false)
    setObjectCamera('pauseBAR1', 'other')
    pauseobjorder = pauseobjorder + 1
    setObjectOrder('pauseBAR1', pauseobjorder)
    setProperty('pauseBAR1.visible', false)

    pauseBarX = 20
    makeLuaText('PAUSEtxt', string.upper(songName)..' - '..songCredit, 700*textScaling, pauseBarX, pauseBarY)
    setTextSize('PAUSEtxt', 40*textScaling)
    setTextColor('PAUSEtxt', 'ffffff')
    setTextBorder('PAUSEtxt', 5*textScaling, '000000')
    setTextAlignment('PAUSEtxt', 'left')
    scaleObject('PAUSEtxt', 1/textScaling, 1/textScaling)
    setTextFont('PAUSEtxt', 'Kimberley.ttf')
    setObjectCamera('PAUSEtxt', 'other')
    pauseobjorder = pauseobjorder + 1
    setObjectOrder('PAUSEtxt', pauseobjorder)
    addLuaText('PAUSEtxt', false)
    setProperty('PAUSEtxt.antialiasing', true)
    setProperty('PAUSEtxt.visible', false)

    squaresBottomY = 580
    makeLuaSprite('squaresBottom', 'pause/bgsquares', -10, squaresBottomY)
    addLuaSprite('squaresBottom', false)
    scaleObject('squaresBottom', 2,2)
    setObjectCamera('squaresBottom', 'other')
    pauseobjorder = pauseobjorder + 1
    setObjectOrder('squaresBottom', pauseobjorder)
    setProperty('squaresBottom.visible', false)
    setProperty('squaresBottom.x', -10)
    setProperty('squaresBottom.color', getColorFromHex('ffffff'))
    squaresspeed = 1

    squaresSideX = -230
    squaresSideY = 10
    makeLuaSprite('squaresSide1', 'pause/squares selection1', squaresSideX, squaresSideY)
    addLuaSprite('squaresSide1', false)
    setObjectCamera('squaresSide1', 'other')
    pauseobjorder = pauseobjorder + 1
    setObjectOrder('squaresSide1', pauseobjorder)
    setProperty('squaresSide1.visible', false)
    setProperty('squaresSide1.color', getColorFromHex(dadColor))
    --
    makeLuaSprite('squaresSide2', 'pause/squares selection2', squaresSideX, squaresSideY)
    addLuaSprite('squaresSide2', false)
    setObjectCamera('squaresSide2', 'other')
    pauseobjorder = pauseobjorder + 1
    setObjectOrder('squaresSide2', pauseobjorder)
    setProperty('squaresSide2.visible', false)
    
    selectionsX = 40
    selectionsY = 300
    makeLuaSprite('continue', 'pause/continue', selectionsX, selectionsY)
    addLuaSprite('continue', false)
    setObjectCamera('continue', 'other')
    pauseobjorder = pauseobjorder + 1
    setObjectOrder('continue', pauseobjorder)
    setProperty('continue.visible', false)

    makeLuaSprite('restart', 'pause/restart', selectionsX, selectionsY +100)
    addLuaSprite('restart', false)
    setObjectCamera('restart', 'other')
    pauseobjorder = pauseobjorder + 1
    setObjectOrder('restart', pauseobjorder)
    setProperty('restart.visible', false)

    makeLuaSprite('options', 'pause/options', selectionsX, selectionsY +200)
    addLuaSprite('options', false)
    setObjectCamera('options', 'other')
    pauseobjorder = pauseobjorder + 1
    setObjectOrder('options', pauseobjorder)
    setProperty('options.visible', false)
    
    makeLuaSprite('exit', 'pause/exit', selectionsX, selectionsY +300)
    addLuaSprite('exit', false)
    setObjectCamera('exit', 'other')
    pauseobjorder = pauseobjorder + 1
    setObjectOrder('exit', pauseobjorder)
    setProperty('exit.visible', false)

    makeAnimatedLuaSprite('hand', 'pause/selection glove', selectionsX, selectionsY)
    addAnimationByPrefix('hand', 'bop', 'selection glove', 30, true)
    addLuaSprite('hand', false)
    setObjectCamera('hand', 'other')
    pauseobjorder = pauseobjorder + 1
    setObjectOrder('hand', pauseobjorder)
    setProperty('hand.visible', false)

    characterY = 200
    characterX = 680
    if pauseCharacter == 'sonic' then
        characterY = 200
        characterX = 680
    elseif pauseCharacter == 'metalsonic' then
        characterY = 180
        characterX = 700
    elseif pauseCharacter == 'bf' then
        characterY = 200
        characterX = 780
    elseif pauseCharacter == 'shadow' then
        characterY = 170
        characterX = 780
    elseif pauseCharacter == 'knuckles' then
        characterY = 200
        characterX = 720
    elseif pauseCharacter == 'tails' then
        characterY = 200
        characterX = 720
    end
    makeLuaSprite('characterPause', 'renders/'..pauseCharacter, characterX + 450, characterY + 450)
    addLuaSprite('characterPause', false)
    setObjectOrder('characterPause', 69)
    scaleObject('characterPause', 2,2)
    setObjectCamera('characterPause', 'other')
    setProperty('characterPause.visible', false)

    if pauseCharacter2 == 'sonic' then
        character2Y = 200
        character2X = 680
    elseif pauseCharacter2 == 'bf' then
        character2Y = 200
        character2X = 780
    end
    makeLuaSprite('characterPause2', 'renders/'..pauseCharacter2, character2X + 450, character2Y + 450)
    addLuaSprite('characterPause2', false)
    setObjectOrder('characterPause2', 69)
    scaleObject('characterPause2', 2,2)
    setObjectCamera('characterPause2', 'other')
    setProperty('characterPause2.visible', false)

    makeLuaSprite('cursorNEW', 'cursor', 0, 0) 
    setObjectCamera('cursorNEW', 'other')
    addLuaSprite('cursorNEW', true)
    setProperty('cursorNEW.visible', false)

    if pauseCharacter == 'sonic' or pauseCharacter == 'bf' then
        setProperty('characterPause.flipX', true)
    end
    if pauseCharacter2 == 'sonic' or pauseCharacter2 == 'bf' then
        setProperty('characterPause2.flipX', true)
    end
    setProperty('characterPause.visible', false)
end

function onTweenCompleted(t, l, ll)
    if t == 'squaresBottomMove' then
        setProperty('squaresBottom.x', -10)
        doTweenX('squaresBottomMove', 'squaresBottom', -77, squaresspeed)
    end
    if t == 'logoMove' then
        setProperty('logo.x', logoinitialX)
        doTweenX('logoMove', 'logo', logofinishX, squaresspeed * 4)
    end
end

function onTimerCompleted(t, l, ll)
    if t == 'handanim' then
        runTimer('handanim', 0.03)
        if getProperty('hand.animation.curAnim.curFrame') < 16 then
            setProperty('hand.animation.curAnim.curFrame', getProperty('hand.animation.curAnim.curFrame') + 1)
        else
            setProperty('hand.animation.curAnim.curFrame', 1)
        end
    end
    if t == 'startPause' then
        --runTimer('pauseBpmHit', 60/125, 0)
    end
    if t == 'pauseBpmHit' then
        --setProperty('hand.animation.curAnim.curFrame', 1)
        --setProperty("camOther.zoom",1.02)
        --doTweenZoom('camerabop', 'camOther', 1, 1, 'expoOut');
    end
end



function onPause()
    if not getPropertyFromClass('states.PlayState', 'chartingMode') then
        openCustomSubstate('pauseMenu', true)
        return Function_Stop
    else
        return Function_Continue
    end
end

--function onUpdate() if keyJustPressed('pause') then openCustomSubstate('pauseMenu', true) end end

function onCustomSubstateCreate(name)
    if name == 'pauseMenu' then
        if pauseCharTurn == 'opp' then
            setProperty('squaresSide1.color', getColorFromHex(dadColor))
            setProperty('characterPause.visible', true)
            pauseCharTurn = 'player'
        elseif pauseCharTurn == 'player' then
            setProperty('squaresSide1.color', getColorFromHex(bfColor))
            setProperty('characterPause2.visible', true)
            pauseCharTurn = 'opp'
        end
        setProperty('cursor.visible', false)
        setProperty('BotonPauseMobile.alpha', 1)
        setProperty('BotonMobile.alpha', 0)
        setProperty('BotonPauseMobile.x', 1350)
        setProperty('BotonPauseMobile.y', 782)
        doTweenX('BotonPauseMobile.x', 'BotonPauseMobile', 1150, 1, 'expoOut')
        doTweenY('BotonPauseMobile.y', 'BotonPauseMobile', 582, 1, 'expoOut')
        setProperty('cursorNEW.visible', true)
        runTimer('startPause', 0.01)
        runTimer('handanim', 0.03)
        curselected = 'continue'
        setProperty('continue.color', getColorFromHex('ffffff'))
        setProperty('restart.color', getColorFromHex('ffffff'))
        setProperty('options.color', getColorFromHex('ffffff'))
        setProperty('exit.color', getColorFromHex('ffffff'))

        setProperty('hand.alpha', 0)
        doTweenAlpha('handIN', 'hand', 1, timeease, easetype)
        setProperty('hand.visible', true)

        setProperty('hand.x', selectionsX)
        setProperty('hand.y', selectionsY)
        selectionscale = 1.2
        colorunselected = '575757'
        scaleObject('continue', 1, 1)
        scaleObject('restart', 1, 1)
        scaleObject('options', 1, 1)
        scaleObject('exit', 1, 1)

        setProperty('continue.origin.x', 0)
        setProperty('restart.origin.x', 0)
        setProperty('options.origin.x', 0)
        setProperty('exit.origin.x', 0)

        setProperty('continue.visible', true)
        setProperty('restart.visible', true)
        setProperty('options.visible', true)
        setProperty('exit.visible', true)
        setProperty('continue.x', selectionsX - 600)
        doTweenX('continueIN', 'continue', selectionsX, timeease, easetype)
        setProperty('restart.x', selectionsX - 600)
        doTweenX('restartIN', 'restart', selectionsX, timeease * 0.9, easetype)
        setProperty('options.x', selectionsX - 600)
        doTweenX('optionsIN', 'options', selectionsX, timeease * 0.8, easetype)
        setProperty('exit.x', selectionsX - 600)
        doTweenX('exitIN', 'exit', selectionsX, timeease * 0.7, easetype)

        playSound('../music/breakfast', 0.5, 'pausemus')
        --local pauseLength = getSoundLength('pausemus')
        soundFadeIn('pausemus', 1)
        setSoundTime('pausemus', pausesongPos)
        
        setProperty('characterPause.x', characterX + 450)
        setProperty('characterPause.y', characterY + 450)
        doTweenX('characterPauseXIN', 'characterPause', characterX, timeease, easetype)
        doTweenY('characterPauseYIN', 'characterPause', characterY, timeease, easetype)
        
        setProperty('characterPause2.x', character2X + 450)
        setProperty('characterPause2.y', character2Y + 450)
        doTweenX('characterPause2XIN', 'characterPause2', character2X, timeease, easetype)
        doTweenY('characterPause2YIN', 'characterPause2', character2Y, timeease, easetype)

        setProperty('squaresSide1.visible', true)
        setProperty('squaresSide1.x', squaresSideX - 280)
        doTweenX('squaresSide1IN1', 'squaresSide1', squaresSideX, timeease, easetype)
        setProperty('squaresSide1.y', squaresSideY + 280)
        doTweenY('squaresSide1IN2', 'squaresSide1', squaresSideY, timeease, easetype)
        
        setProperty('squaresSide2.visible', true)
        setProperty('squaresSide2.x', squaresSideX - 280)
        doTweenX('squaresSide2IN1', 'squaresSide2', squaresSideX, timeease, easetype)
        setProperty('squaresSide2.y', squaresSideY + 280)
        doTweenY('squaresSide2IN2', 'squaresSide2', squaresSideY, timeease, easetype)



        playSound('scrollMenu', 1)

        setProperty('pauseOVERLAY.visible', true)
        setProperty('pauseOVERLAY.alpha', 0)
        doTweenAlpha('pauseOVERLAYIN', 'pauseOVERLAY', 0.6, timeease, easetype)

        setProperty('logo.y', logoY - 250)
        doTweenY('logoIN', 'logo', logoY, timeease, easetype)
        setProperty('logo.x', logoinitialX)
        doTweenX('logoMove', 'logo', logofinishX, squaresspeed * 4)
        setProperty('logo.visible', true)
        

        setProperty('pauseBAR1.visible', true)
        setProperty('pauseBAR1.y', pauseBarY - 250)
        doTweenY('pauseBAR1IN', 'pauseBAR1', pauseBarY, timeease, easetype)
        setProperty('pauseBAR1.x', -10)
        doTweenX('pauseBAR1IN2', 'pauseBAR1', pauseBar1X, timeease, easetype)

        setProperty('PAUSEtxt.visible', true)
        setProperty('PAUSEtxt.y', pauseBarY - 250)
        doTweenY('PAUSEtxtIN1', 'PAUSEtxt', pauseBarY, timeease, easetype)
        setProperty('PAUSEtxt.x', pauseBar1X - 500)
        doTweenX('PAUSEtxtIN2', 'PAUSEtxt', pauseBarX, timeease, easetype)

        setProperty('squaresBottom.x', -10)
        doTweenX('squaresBottomMove', 'squaresBottom', -77, squaresspeed)

        setProperty('squaresBottom.visible', true)
        setProperty('squaresBottom.y', squaresBottomY + 200)
        doTweenY('squaresBottomIN', 'squaresBottom', squaresBottomY, timeease, easetype)
    end
end
local beatteehee = true
function onBeatHitCustom(beat)
    --playSound('ring', 1)
        setProperty('hand.animation.curAnim.curFrame', 1)
    if beatteehee then
        beatteehee = false
        setProperty('camOther.zoom', 1.02)
        doTweenZoom('camZoomPause', 'camOther', 1, 3, 'expoOut')
    else
        beatteehee = true
    end
end

function onSoundFinished(tag)
    if tag == ('pausemus') then
        playSound('../music/breakfast', 0.5, 'pausemus')
        setSoundTime('pausemus', 1)
        lastBeat = -1
    end
end

function onCustomSubstateUpdate(name, e)
    if name == 'pauseMenu' then
        
	    setProperty('cursorNEW.x', getMouseX('other'))
	    setProperty('cursorNEW.y', getMouseY('other'))
        local currentTime = getProperty('sound_pausemus.time')
        local fullLength = getProperty('sound_pausemus.length')
        local currentBeat = math.floor(currentTime / beatLength)
        if currentBeat > lastBeat then
            lastBeat = currentBeat
            onBeatHitCustom(currentBeat)
        end
        if keyJustPressed('down') then
            playSound('scrollMenu', 1)
            if curselected == 'continue' then
                curselected = 'restart'
            elseif curselected == 'restart' then
                curselected = 'options'
            elseif curselected == 'options' then
                curselected = 'exit'
            elseif curselected == 'exit' then
                curselected = 'continue'
            end
        end

        if keyJustPressed('up') then
            playSound('scrollMenu', 1)
            if curselected == 'continue' then
                curselected = 'exit'
            elseif curselected == 'exit' then
                curselected = 'options'
            elseif curselected == 'options' then
                curselected = 'restart'
            elseif curselected == 'restart' then
                curselected = 'continue'
            end
        end

                -- HOVER PARA SELECCIONAR EN EL MENÚ DE PAUSA
        local mouseX = getMouseX('other')
        local mouseY = getMouseY('other')
        local previousSelected = curselected
        
        -- Detectar hover sobre CONTINUE
        if mouseX > getProperty('continue.x') and mouseX < getProperty('continue.x') + getProperty('continue.width') 
        and mouseY > getProperty('continue.y') and mouseY < getProperty('continue.y') + getProperty('continue.height') then
            if curselected ~= 'continue' then
                curselected = 'continue'
                playSound('scrollMenu', 1)
            end
        end
        
        -- Detectar hover sobre RESTART
        if mouseX > getProperty('restart.x') and mouseX < getProperty('restart.x') + getProperty('restart.width') 
        and mouseY > getProperty('restart.y') and mouseY < getProperty('restart.y') + getProperty('restart.height') then
            if curselected ~= 'restart' then
                curselected = 'restart'
                playSound('scrollMenu', 1)
            end
        end
        
        -- Detectar hover sobre OPTIONS
        if mouseX > getProperty('options.x') and mouseX < getProperty('options.x') + getProperty('options.width') 
        and mouseY > getProperty('options.y') and mouseY < getProperty('options.y') + getProperty('options.height') then
            if curselected ~= 'options' then
                curselected = 'options'
                playSound('scrollMenu', 1)
            end
        end
        
        -- Detectar hover sobre EXIT
        if mouseX > getProperty('exit.x') and mouseX < getProperty('exit.x') + getProperty('exit.width') 
        and mouseY > getProperty('exit.y') and mouseY < getProperty('exit.y') + getProperty('exit.height') then
            if curselected ~= 'exit' then
                curselected = 'exit'
                playSound('scrollMenu', 1)
            end
        end
        
        -- Si cambió la selección por hover, actualizar visualmente
        if previousSelected ~= curselected then
            -- El código de actualización visual ya se ejecuta en los ifs de curselected
            -- Solo necesitamos forzar una pequeña actualización
        end
        
        -- CLIC PARA SELECCIONAR (ejecutar acción)
        if mouseClicked('left') then
            -- Clic en CONTINUE
            if mouseX > getProperty('continue.x') and mouseX < getProperty('continue.x') + getProperty('continue.width') 
            and mouseY > getProperty('continue.y') and mouseY < getProperty('continue.y') + getProperty('continue.height') then
                closePauseMenu()
                return
            end
            
            -- Clic en RESTART
            if mouseX > getProperty('restart.x') and mouseX < getProperty('restart.x') + getProperty('restart.width') 
            and mouseY > getProperty('restart.y') and mouseY < getProperty('restart.y') + getProperty('restart.height') then
                if prevsong == 'Menu' then
                    setDataFromSave('globalsave', 'lastSong', 'Menu')
                end
                restartSong()
                return
            end
            
            -- Clic en OPTIONS
            if mouseX > getProperty('options.x') and mouseX < getProperty('options.x') + getProperty('options.width') 
            and mouseY > getProperty('options.y') and mouseY < getProperty('options.y') + getProperty('options.height') then
                stopSound('pausemus')
                local namereformat = songName:gsub("%s+", "-"):lower()
                setDataFromSave('globalsave', 'lastSong', namereformat)
                setPropertyFromClass('backend.Difficulty', 'list', {'normal'})
                loadSong('options', 0)
                return
            end
            
            -- Clic en EXIT
            if mouseX > getProperty('exit.x') and mouseX < getProperty('exit.x') + getProperty('exit.width') 
            and mouseY > getProperty('exit.y') and mouseY < getProperty('exit.y') + getProperty('exit.height') then
                stopSound('pausemus')
                setDataFromSave('globalsave', 'lastSong', songName)
                setDataFromSave('globalsave', 'lastSong', songName)
                setPropertyFromClass('backend.Difficulty', 'list', {'normal'})
                loadSong('menu', 0)
                return
            end
        end

        if curselected == 'continue' then
            doTweenX('gloveX', 'hand', selectionsX + 520, timeease, easetype)
            doTweenY('gloveY', 'hand', selectionsY, timeease, easetype)
            doTweenX('continueSIZE1', 'continue.scale', selectionscale, timeease, easetype)
            doTweenY('continueSIZE2', 'continue.scale', selectionscale, timeease, easetype)
            doTweenX('restartSIZE1', 'restart.scale', 1, timeease, easetype)
            doTweenY('restartSIZE2', 'restart.scale', 1, timeease, easetype)
            doTweenX('optionsSIZE1', 'options.scale', 1, timeease, easetype)
            doTweenY('optionsSIZE2', 'options.scale', 1, timeease, easetype)
            doTweenX('exitSIZE1', 'exit.scale', 1, timeease, easetype)
            doTweenY('exitSIZE2', 'exit.scale', 1, timeease, easetype)
            doTweenColor('continueCOLOR', 'continue', 'ffffff', timeease, easetype)
            doTweenColor('restartCOLOR', 'restart', colorunselected, timeease, easetype)
            doTweenColor('optionsCOLOR', 'options', colorunselected, timeease, easetype)
            doTweenColor('exitCOLOR', 'exit', colorunselected, timeease, easetype)
        elseif curselected == 'restart' then
            doTweenX('gloveX', 'hand', selectionsX + 470, timeease, easetype)
            doTweenY('gloveY', 'hand', selectionsY + 100, timeease, easetype)
            doTweenX('restartSIZE1', 'restart.scale', selectionscale, timeease, easetype)
            doTweenY('restartSIZE2', 'restart.scale', selectionscale, timeease, easetype)
            doTweenX('continueSIZE1', 'continue.scale', 1, timeease, easetype)
            doTweenY('continueSIZE2', 'continue.scale', 1, timeease, easetype)
            doTweenX('optionsSIZE1', 'options.scale', 1, timeease, easetype)
            doTweenY('optionsSIZE2', 'options.scale', 1, timeease, easetype)
            doTweenX('exitSIZE1', 'exit.scale', 1, timeease, easetype)
            doTweenY('exitSIZE2', 'exit.scale', 1, timeease, easetype)
            doTweenColor('restartCOLOR', 'restart', 'ffffff', timeease, easetype)
            doTweenColor('continueCOLOR', 'continue', colorunselected, timeease, easetype)
            doTweenColor('optionsCOLOR', 'options', colorunselected, timeease, easetype)
            doTweenColor('exitCOLOR', 'exit', colorunselected, timeease, easetype)
        elseif curselected == 'options' then
            doTweenX('gloveX', 'hand', selectionsX + 470, timeease, easetype)
            doTweenY('gloveY', 'hand', selectionsY + 200, timeease, easetype)
            doTweenX('optionsSIZE1', 'options.scale', selectionscale, timeease, easetype)
            doTweenY('optionsSIZE2', 'options.scale', selectionscale, timeease, easetype)
            doTweenX('continueSIZE1', 'continue.scale', 1, timeease, easetype)
            doTweenY('continueSIZE2', 'continue.scale', 1, timeease, easetype)
            doTweenX('restartSIZE1', 'restart.scale', 1, timeease, easetype)
            doTweenY('restartSIZE2', 'restart.scale', 1, timeease, easetype)
            doTweenX('exitSIZE1', 'exit.scale', 1, timeease, easetype)
            doTweenY('exitSIZE2', 'exit.scale', 1, timeease, easetype)
            doTweenColor('optionsCOLOR', 'options', 'ffffff', timeease, easetype)
            doTweenColor('continueCOLOR', 'continue', colorunselected, timeease, easetype)
            doTweenColor('restartCOLOR', 'restart', colorunselected, timeease, easetype)
            doTweenColor('exitCOLOR', 'exit', colorunselected, timeease, easetype)
        elseif curselected == 'exit' then
            doTweenX('gloveX', 'hand', selectionsX + 350, timeease, easetype)
            doTweenY('gloveY', 'hand', selectionsY + 300, timeease, easetype)
            doTweenX('exitSIZE1', 'exit.scale', selectionscale, timeease, easetype)
            doTweenY('exitSIZE2', 'exit.scale', selectionscale, timeease, easetype)
            doTweenX('continueSIZE1', 'continue.scale', 1, timeease, easetype)
            doTweenY('continueSIZE2', 'continue.scale', 1, timeease, easetype)
            doTweenX('restartSIZE1', 'restart.scale', 1, timeease, easetype)
            doTweenY('restartSIZE2', 'restart.scale', 1, timeease, easetype)
            doTweenX('optionsSIZE1', 'options.scale', 1, timeease, easetype)
            doTweenY('optionsSIZE2', 'options.scale', 1, timeease, easetype)
            doTweenColor('exitCOLOR', 'exit', 'ffffff', timeease, easetype)
            doTweenColor('continueCOLOR', 'continue', colorunselected, timeease, easetype)
            doTweenColor('restartCOLOR', 'restart', colorunselected, timeease, easetype)
            doTweenColor('optionsCOLOR', 'options', colorunselected, timeease, easetype)
        end

        --if getSoundTime('pausemus') >= getProperty('sound_pausemus.length') - 50 then
            --setSoundTime('pausemus', 1)
            --lastBeat = -1
        --end

        if songfinishedplaying and not getProperty('sound_pausemus.playing') then
            soundPlaying = false
            
        end
        

        if keyJustPressed('accept') then
            if curselected == 'continue' then
                closePauseMenu()
            elseif curselected == 'restart' then
                if prevsong == 'Menu' then
                    setDataFromSave('globalsave', 'lastSong', 'Menu')
                end
                restartSong()
            elseif curselected == 'options' then
                stopSound('pausemus')
                local namereformat = songName:gsub("%s+", "-"):lower()
                setDataFromSave('globalsave', 'lastSong', namereformat)

                setPropertyFromClass('backend.Difficulty', 'list', {'normal'})
                loadSong('options', 0)
                --openOptions()
            elseif curselected == 'exit' then
                stopSound('pausemus')
                --exitSong()
                
                setDataFromSave('globalsave', 'lastSong', songName)
                
                --if prevsong == 'Menu' then
                    setDataFromSave('globalsave', 'lastSong', songName)
                    setPropertyFromClass('backend.Difficulty', 'list', {'normal'})
            loadSong('menu', 0)
                --else
                    --setDataFromSave('globalsave', 'lastSong', nil)
                    --exitSong()
                --end
            end
        end

        if keyJustPressed('back') then
            closePauseMenu()
        end
    end
end

function openOptions()
    runHaxeCode([[
        import backend.MusicBeatState;
        import options.OptionsState;
        var pauseMusic = new flixel.sound.FlxSound();
        try {
            var pauseSong:String = getPauseSong();
            if(pauseSong != null) pauseMusic.loadEmbedded(Paths.music(pauseSong), true, true);
        }
        catch(e:Dynamic) {}
        pauseMusic.volume = 0;
        pauseMusic.play(false, FlxG.random.int(0, Std.int(pauseMusic.length / 2)));
        MusicBeatState.switchState(new options.OptionsState());
            if(ClientPrefs.data.pauseMusic != 'None')
            {
                FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.data.pauseMusic)),pauseMusic.volume);
                FlxTween.tween(FlxG.sound.music,{volume: 1}, 0.8);
                FlxG.sound.music.time = pauseMusic.time;
            }
            OptionsState.onPlayState = true;
    ]])
end

function closePauseMenu(number)
    pausesongPos =  getSoundTime('pausemus')
    
    setProperty('cursor.visible', true)
    setProperty('cursorNEW.visible', false)
    setProperty('BotonPauseMobile.alpha', 0)
    setProperty('BotonMobile.alpha', 1)

    stopSound('pausemus')
    cancelTimer('handanim')
    cancelTween('pauseOVERLAYIN')
    cancelTween('pauseBAR1IN')
    cancelTween('pauseBAR1IN2')
    cancelTween('PAUSEtxtIN1')
    cancelTween('PAUSEtxtIN2')
    cancelTween('characterPauseXIN')
    cancelTween('characterPauseYIN')
    cancelTween('characterPause2XIN')
    cancelTween('characterPause2YIN')
    cancelTween('squaresBottomIN')
    cancelTween('squaresBottomMove')
    cancelTween('squaresSide1IN1')
    cancelTween('squaresSide1IN2')
    cancelTween('squaresSide2IN1')
    cancelTween('squaresSide2IN2')
    cancelTween('logoIN')
    cancelTween('logoMove')
    cancelTween('handIN')
    --buttons
    cancelTween('continueSIZE1')
    cancelTween('continueSIZE2')
    cancelTween('restartSIZE1')
    cancelTween('restartSIZE2')
    cancelTween('optionsSIZE1')
    cancelTween('optionsSIZE2')
    cancelTween('exitSIZE1')
    cancelTween('exitSIZE2')
    cancelTween('continueCOLOR')
    cancelTween('restartCOLOR')
    cancelTween('optionsCOLOR')
    cancelTween('exitCOLOR')
    cancelTween('continueIN')
    cancelTween('restartIN')
    cancelTween('optionsIN')
    cancelTween('exitIN')
    --
    setProperty('continue.visible', false)
    setProperty('restart.visible', false)
    setProperty('options.visible', false)
    setProperty('exit.visible', false)
    setProperty('logo.visible', false)
    setProperty('squaresSide1.visible', false)
    setProperty('squaresSide2.visible', false)
    setProperty('pauseBAR1.visible', false)
    setProperty('PAUSEtxt.visible', false)
    setProperty('squaresBottom.visible', false)
    setProperty('characterPause.visible', false)
    setProperty('characterPause2.visible', false)
    setProperty('pauseOVERLAY.visible', false)
    setProperty('hand.visible', false)
    --local curOption = number or 0
    closeCustomSubstate()
    if curselected == 'options' then
        --openOptions()
    end
    if curselected == 'exit' then
        soundFadeOut('pausemus', 1)
    end


    closePauseStuff() 
end


function closePauseStuff() 

end