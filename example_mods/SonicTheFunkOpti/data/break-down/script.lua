local hasjumped = false
local hashomed = false
local waitinganim = false

function onCreatePost()
    setProperty('ringcountindicator.x', 0)
    setProperty('canbehurt.x', 0)
    setProperty('canjumpindicator.x', 0)
    setProperty('canhomingindicator.x', 0)

    makeAnimatedLuaSprite('DADBALL', 'sketchfox ball', getProperty('dad.x') - 100 , getProperty('dad.y') + 200)
    addAnimationByPrefix('DADBALL','jump','sketchfox jump',20,true)
    addOffset('DADBALL', 'jump', 0, 0)
    addAnimationByPrefix('DADBALL','homing','sketchfox homing',20,true)
    addOffset('DADBALL', 'homing', -5, -85)
    addAnimationByPrefix('DADBALL','backwards','sketchfox Jumpbackwards',20,true)
    addOffset('DADBALL', 'backwards', -80, -10)
    addLuaSprite('DADBALL', true)
    indadY = getProperty('DADBALL.y')
    indadX = getProperty('DADBALL.x')
    setProperty('DADBALL.visible', false)

    makeAnimatedLuaSprite('action', 'tutorialtxt', 460, 150)
    addAnimationByPrefix('action','jump','TEXTjump',24,true)
    addOffset('action', 'jump', -20, -40)
    addAnimationByPrefix('action','homing','TXThomingattack',24,true)
    addOffset('action', 'homing', 0, 0)
    addAnimationByPrefix('action','mouse','INDICATORmouse',24,true)
    addOffset('action', 'mouse', 50, -50)
    setObjectCamera('action', 'HUD')
    addLuaSprite('action', true)
    playAnim('action', 'mouse', true)

    makeAnimatedLuaSprite('space', 'tutorialtxt', 490, 430)
    addAnimationByPrefix('space','space1','TXTspace',24,true)
    addOffset('space', 'space1', 0, 0)
    addAnimationByPrefix('space','space2','TXTspacE2',24,true)
    addOffset('space', 'space2', 60, 0)
    addAnimationByPrefix('space','mouse','TXTmouse',24,true)
    addOffset('space', 'mouse', 60, 0)
    setObjectCamera('space', 'HUD')
    addLuaSprite('space', true)
    playAnim('space', 'mouse', true)

    makeAnimatedLuaSprite('spaceKEY1', 'NOTE_assets-sonic', 550, 300)
    addAnimationByPrefix('spaceKEY1','space','SPACEKEY',24,true)
    addAnimationByIndices('spaceKEY1','spacepress','spacePRESS','0,1,2,3',24,false)
    setObjectCamera('spaceKEY1', 'HUD')
    addLuaSprite('spaceKEY1', true)
    playAnim('spaceKEY1', 'spacepress', true)
    
    makeAnimatedLuaSprite('result', 'winorlose', 400, 280)
    addAnimationByPrefix('result','win','TXTsuccess',24,true)
    addAnimationByPrefix('result','lose','TXTtryagain',24,true)
    setObjectCamera('result', 'HUD')
    addLuaSprite('result', true)
    playAnim('result', 'win', true)

    makeLuaSprite('yourturn', 'yourturn', 0, 0)
    addLuaSprite('yourturn', true)
    setProperty('yourturn.alpha', 0)

    setProperty('action.alpha', 0)
    setProperty('space.alpha', 0)
    setProperty('spaceKEY1.alpha', 0)
    setProperty('result.alpha', 0)

    camzoomdef = getProperty('camGame.zoom')
end

function onStepHit()
    --JUMP
    if getProperty('resultsscreen.x') == 0 then
        if curStep == 160 then
            doTweenZoom('camzoom1', 'camGame', camzoomdef + 0.2, 2, 'cubeOut')
            for i = 0,7 do
                noteTweenAlpha('notessAlpha'..i, i, 0, 0.5, 'quadInOut')
            end
            setProperty('strumsBlocked', {true, true, true, true})
        end
        if curStep == 192 then
            setProperty('yourturn.x', getProperty('dad.x') + 150)
            setProperty('yourturn.y', getProperty('dad.y') + 200)
            doTweenAlpha('yourturnalpha', 'yourturn', 1, 0.4)
            doTweenZoom('camzoom2', 'camGame', camzoomdef, 2, 'quadInOut')
            doTweenAlpha('actionalpha', 'action', 1, 0.5)
            playAnim('action', 'jump', true)
            doTweenAlpha('spacealpha', 'space', 1, 0.5)
            playAnim('space', 'space1', true)
            doTweenAlpha('spaceKEY1alpha', 'spaceKEY1', 1, 0.5)
            playAnim('spaceKEY1', 'space', true)
        end
        if curStep == 204 then
            doTweenAlpha('yourturnalpha', 'yourturn', 0, 0.4)
            dadJump()
        end
        if curStep == 224 then
            setProperty('yourturn.x', getProperty('boyfriend.x') + 100)
            setProperty('yourturn.y', getProperty('boyfriend.y') + 150)
            doTweenAlpha('yourturnalpha', 'yourturn', 1, 0.4)
            setProperty('canjumpindicator.x', 1)
            canjump = true
            if getProperty('action.alpha') ~= 1 then
                doTweenAlpha('actionalpha', 'action', 1, 0.5)
                doTweenAlpha('spacealpha', 'space', 1, 0.5)
                doTweenAlpha('spaceKEY1alpha', 'spaceKEY1', 1, 0.5)
            end
        end
        if curStep == 288 and not hasjumped then--30.05
            skipTime = 30050
            runHaxeCode([[game.setSongTime(]]..(skipTime)..[[)]])
        end
        if curStep == 272 and not hasjumped then
            waitinganim = true
            badResult()
            setProperty('canjumpindicator.x', 0)
            canjump = false
        elseif curStep == 272 and hasjumped then
            for i = 0,7 do
                noteTweenAlpha('notessAlpha'..i, i, 1, 0.5, 'quadInOut')
            end
            setProperty('strumsBlocked', {false, false, false, false})
        end
        -- HOMING ATTACK
        if curStep == 320 then
            setProperty('yourturn.x', getProperty('dad.x') + 150)
            setProperty('yourturn.y', getProperty('dad.y') + 200)
            doTweenAlpha('yourturnalpha', 'yourturn', 1, 0.4)
            doTweenAlpha('actionalpha', 'action', 1, 0.5)
            playAnim('action', 'homing', true)
            doTweenAlpha('spacealpha', 'space', 1, 0.5)
            playAnim('space', 'space2', true)
            doTweenAlpha('spaceKEY1alpha', 'spaceKEY1', 1, 0.5)
            playAnim('spaceKEY1', 'space', true)
            for i = 0,7 do
                noteTweenAlpha('notessAlpha'..i, i, 0, 0.5, 'quadInOut')
            end
            setProperty('strumsBlocked', {true, true, true, true})
        end
        if curStep == 332 then --
            doTweenAlpha('yourturnalpha', 'yourturn', 0, 0.4)
            dadHoming()
        end
        if curStep == 352 then
            setProperty('yourturn.x', getProperty('boyfriend.x') + 100)
            setProperty('yourturn.y', getProperty('boyfriend.y') + 150)
            doTweenAlpha('yourturnalpha', 'yourturn', 1, 0.4)
            if getProperty('action.alpha') ~= 1 then
                doTweenAlpha('actionalpha', 'action', 1, 0.5)
                doTweenAlpha('spacealpha', 'space', 1, 0.5)
                doTweenAlpha('spaceKEY1alpha', 'spaceKEY1', 1, 0.5)
            end
            setProperty('canjumpindicator.x', 1)
            setProperty('canhomingindicator.x', 1)
            canhoming = true
        end
        if curStep == 396 and not hashomed then
            setProperty('canjumpindicator.x', 0)
            setProperty('canhomingindicator.x', 0)
            canhoming = false
        end
        if curStep == 400 and not hashomed then
            waitinganim = true
            badResult()
        elseif curStep == 400 and hashomed then
            for i = 0,7 do
                noteTweenAlpha('notessAlpha'..i, i, 1, 0.5, 'quadInOut')
            end
            setProperty('strumsBlocked', {false, false, false, false})
        end
        if curStep == 416 and not hashomed then
            skipTime = 47140
            runHaxeCode([[game.setSongTime(]]..(skipTime)..[[)]])
        end
        if curStep == 448 then
            doTweenAlpha('actionalpha', 'action', 1, 0.5)
            playAnim('action', 'mouse', true)
            doTweenAlpha('spacealpha', 'space', 1, 0.5)
            playAnim('space', 'mouse', true)
            for i = 0,7 do
                noteTweenAlpha('notessAlpha'..i, i, 0, 0.5, 'quadInOut')
            end
            setProperty('strumsBlocked', {true, true, true, true})
            if getProperty('ringcountindicator.x') < 3 then
                setProperty('giveringz.x', 1)
            end
        end
        if curStep == 452 then
            if getProperty('ringcountindicator.x') < 3 then
                setProperty('giveringz.x', 1)
            end
        end
        if curStep == 456 then
            if getProperty('ringcountindicator.x') < 3 then
                setProperty('giveringz.x', 1)
            end
        end
        if curStep == 460 then
            setProperty('canbehurt.x', 1)
            dadHoming()
            setProperty('yourturn.x', getProperty('boyfriend.x') + 150)
            setProperty('yourturn.y', getProperty('boyfriend.y') + 200)
            doTweenAlpha('yourturnalpha', 'yourturn', 1, 0.4)
        end
        if curStep == 512 and getProperty('ringcountindicator.x') == 0 then --60.00
            waitinganim = true
            skipTime = 60000
            runHaxeCode([[game.setSongTime(]]..(skipTime)..[[)]])
            badResult()
        elseif curStep == 512 and getProperty('ringcountindicator.x') ~= 0 then
            doTweenAlpha('yourturnalpha', 'yourturn', 0, 0.4)
            waitinganim = false
            playAnim('boyfriend', 'idle')
            for i = 0,7 do
                noteTweenAlpha('notessAlpha'..i, i, 1, 0.5, 'quadInOut')
            end
            setProperty('strumsBlocked', {false, false, false, false})
            runTimer('dingtimer', 0.01)
        end
        if curStep == 544 then
            doTweenZoom('camzoom3', 'camGame', camzoomdef + 0.2, 17.15, 'quadIn')
        end
        if curStep == 538 then
            doTweenZoom('camzoom3', 'camGame', camzoomdef - 0.04, 0.7, 'quadInOut')
        end
        if curStep == 544 then
            doTweenZoom('camzoom3', 'camGame', camzoomdef + 0.2, 17.15, 'cubeOut')
            setProperty('defaultCamZoom', camzoomdef + 0.2)
        end
        if curStep == 687 then
            canjump = false
            canhoming = false
        end
    end
end

function dadJump()
    playAnim('spaceKEY1', 'spacepress', true)
    setProperty('dad.visible', false)
    setProperty('DADBALL.visible', true)
    setProperty('DADBALL.y', getProperty('DADBALL.y') - 20)
    doTweenY('dadJUMP', 'DADBALL', getProperty('DADBALL.y') - 350, 0.4, 'quadOut')
    playAnim('DADBALL','jump',true)

    setProperty('DADBALL.scale.y', 1.4)
    doTweenY('dadballScaleTweenYNope', 'DADBALL.scale', 1, 0.5, 'expoOut')
                    
    setProperty('DADBALL.scale.x', 0.6)
    doTweenX('dadballScaleTweenXNope', 'DADBALL.scale', 1, 0.5, 'expoOut')
end

function dadHoming()
    playAnim('spaceKEY1', 'spacepress', true)
    setProperty('dad.visible', false)
    setProperty('DADBALL.visible', true)
    setProperty('DADBALL.y', getProperty('DADBALL.y') - 20)
    doTweenY('dadJUMP', 'DADBALL', getProperty('DADBALL.y') - 350, 0.4, 'quadOut')
    playAnim('DADBALL','jump',true)
    runTimer('dadHOMINGTIMER', 0.55)

    setProperty('DADBALL.scale.y', 1.4)
    doTweenY('dadballScaleTweenYNope', 'DADBALL.scale', 1, 0.5, 'expoOut')
                    
    setProperty('DADBALL.scale.x', 0.6)
    doTweenX('dadballScaleTweenXNope', 'DADBALL.scale', 1, 0.5, 'expoOut')
end

function onUpdatePost()
    local mouseOver = (getMouseX('other') > getProperty('BotonMobile.x') and 
    getMouseX('other') < getProperty('BotonMobile.x') + getProperty('BotonMobile.width') and 
    getMouseY('other') > getProperty('BotonMobile.y') and 
    getMouseY('other') < getProperty('BotonMobile.y') + getProperty('BotonMobile.height'))

    if mouseOver and mousePressed('left') then
        if getProperty('BotonMobile.animation.curAnim.name') ~= 'pressed' then
            playAnim('BotonMobile', 'pressed', true)
        end
    else
        if getProperty('BotonMobile.animation.curAnim.name') ~= 'idle' then
            playAnim('BotonMobile', 'idle', true)
        end
    end
    
    if getProperty('resultsscreen.x') == 1 then
        close(true)
    end
    if getProperty('spaceKEY1.animation.name') == 'spacepress' and getProperty('spaceKEY1.animation.curAnim.finished') then
        playAnim('spaceKEY1', 'space')
    end
    if waitinganim then
        if getProperty('boyfriend.idleSuffix') == '' then
            setProperty('boyfriend.idleSuffix', '-alt')
        end
    else
        if getProperty('boyfriend.idleSuffix') == '-alt' then
            setProperty('boyfriend.idleSuffix', '')
        end
    end
    if canjump then
        if keyJustPressed('accept') or mouseClicked('left') then
            playAnim('spaceKEY1', 'spacepress', true)
            setProperty('canjumpindicator.x', 0)
            canjump = false
            runTimer('dingtimer', 1)
            hasjumped = true
            doTweenAlpha('yourturnalpha', 'yourturn', 0, 0.4)
        end
    end
    if canhoming then
        if keyJustPressed('accept') or mouseClicked('left') then
            playAnim('spaceKEY1', 'spacepress', true)
        end
        if objectsOverlap('BFBALL', 'dad') then
            doTweenAlpha('yourturnalpha', 'yourturn', 0, 0.4)
            setProperty('canjumpindicator.x', 0)
            setProperty('canhomingindicator.x', 0)
            canhoming = false
            runTimer('dingtimer', 1)
            hashomed = true
        end
    end
end

function badResult()
    if getProperty('resultsscreen.x') == 0 then
        doTweenAlpha('resultalpha', 'result', 1, 0.5)
        playAnim('result', 'lose')
        runTimer('resulttimer', 1)
        playSound('quicktimeBad', 0.4)
        if getProperty('action.alpha') ~= 0 then
            doTweenAlpha('actionalpha', 'action', 0, 0.3)
            doTweenAlpha('spacealpha', 'space', 0, 0.3)
            doTweenAlpha('spaceKEY1alpha', 'spaceKEY1', 0, 0.3)
        end
    end
end

function onTimerCompleted(tag)
    if tag == 'dingtimer' then
        if getProperty('resultsscreen.x') == 0 then
            if waitinganim then
                waitinganim = false
            end
            playSound('quicktimeGood', 0.6)
            playAnim('boyfriend', 'hey')
            setProperty('boyfriend.specialAnim', true)
            playAnim('dad', 'hey')
            setProperty('dad.specialAnim', true)
            
            doTweenAlpha('actionalpha', 'action', 0, 0.5)
            doTweenAlpha('spacealpha', 'space', 0, 0.5)
            doTweenAlpha('spaceKEY1alpha', 'spaceKEY1', 0, 0.5)
            
            doTweenAlpha('resultalpha', 'result', 1, 0.5)
            playAnim('result', 'win')
            runTimer('resulttimer', 1)
            
            if getProperty('action.alpha') ~= 0 then
                doTweenAlpha('actionalpha', 'action', 0, 0.3)
                doTweenAlpha('spacealpha', 'space', 0, 0.3)
                doTweenAlpha('spaceKEY1alpha', 'spaceKEY1', 0, 0.3)
            end
        end
    end
    if tag == 'resulttimer' then
        doTweenAlpha('resultalpha', 'result', 0, 0.5)
    end
    if tag == 'dadHOMINGTIMER' then
        playAnim('spaceKEY1', 'spacepress', true)
        playAnim('DADBALL','homing',true)
        cancelTween('dadJUMP')
        cancelTween('dadJUMP2')
        doTweenX('dadHOMINGx', 'DADBALL', getProperty('boyfriend.x') - 60, 0.15, 'linear')
        doTweenY('dadHOMINGy', 'DADBALL', getProperty('boyfriend.y') + 200, 0.15, 'linear')
    end
    if tag == 'hurtringz' then
        setProperty('canbehurt.x', 0)
    end
end

function onTweenCompleted(tag)
    if tag == 'camzoom1' then
        setProperty('camGame.zoom', camzoomdef + 0.2)
    end
    if tag == 'camzoom2' then
        setProperty('camGame.zoom', camzoomdef)
    end
    if tag == 'dadJUMP' then
        doTweenY('dadJUMP2', 'DADBALL', indadY, 0.4, 'quadIn')
    end
    if tag == 'dadJUMP2' then
        setProperty('DADBALL.visible', false)
        setProperty('dad.visible', true)
        setProperty('dad.scale.y', 1.8)
        doTweenY('dadScaleTweenYNope', 'dad.scale', 2, 0.5, 'expoOut')
        setProperty('dad.scale.x', 2.2)
        playSound('land', 0.6)
        playAnim('dad', 'idle', true)
    end
    if tag == 'dadHOMINGx' then
        if getProperty('canbehurt.x') == 1 then
            setProperty('deployringindicator.x', 2)
            runTimer('hurtringz', 0.1)
        end
        playAnim('boyfriend', 'hurt')
        setProperty('boyfriend.specialAnim', true)
        doTweenY('dadJUMP', 'DADBALL', getProperty('DADBALL.y') - 300, 0.4, 'quadOut')
        doTweenX('dadHOMINGx2', 'DADBALL', indadX, 1, 'quadOut')
        playAnim('DADBALL', 'backwards')
    end
end