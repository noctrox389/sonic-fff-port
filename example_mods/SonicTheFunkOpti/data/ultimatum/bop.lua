local invisnotes = false
local hittablenote = false
local slowdowntime = false
function onCreatePost()
    bfX1 = getPropertyFromGroup('playerStrums', 0, 'x')
    bfX2 = getPropertyFromGroup('playerStrums', 1, 'x')
    bfX3 = getPropertyFromGroup('playerStrums', 2, 'x')
    bfX4 = getPropertyFromGroup('playerStrums', 3, 'x')

    dadX1 = getPropertyFromGroup('opponentStrums', 0, 'x')
    dadX2 = getPropertyFromGroup('opponentStrums', 1, 'x')
    dadX3 = getPropertyFromGroup('opponentStrums', 2, 'x')
    dadX4 = getPropertyFromGroup('opponentStrums', 3, 'x')

    --setProperty('boyfriend.danceEveryNumBeats', 4)
    --setProperty('dad.danceEveryNumBeats', 4)

    setProperty('boyfriend.danceEveryNumBeats', 2)
    setProperty('dad.danceEveryNumBeats', 2)

    --dadNote1
    if downscroll then
        dadY3 = 550
    else
        dadY3 = 60
    end
    makeAnimatedLuaSprite('dadNote1', 'NOTE_assets-sonic', dadX3, dadY3, true)
    addAnimationByIndices('dadNote1', '3', 'green', '0', 24, true)
    playAnim('dadNote1', '3', true)
    setObjectCamera('dadNote1', 'HUD')
    scaleObject('dadNote1', 0.7, 0.7)
    addLuaSprite('dadNote1', true)
    --dadNote2
    if downscroll then
        dadY2 = 370
    else
        dadY2 = 240
    end
    makeAnimatedLuaSprite('dadNote2', 'NOTE_assets-sonic', dadX2, dadY2, true)
    addAnimationByIndices('dadNote2', '3', 'blue', '0', 24, true)
    playAnim('dadNote2', '3', true)
    setObjectCamera('dadNote2', 'HUD')
    scaleObject('dadNote2', 0.7, 0.7)
    addLuaSprite('dadNote2', true)
    --dadNote3
    if downscroll then
        dadY1 = 170
    else
        dadY1 = 440
    end
    makeAnimatedLuaSprite('dadNote3', 'NOTE_assets-sonic', dadX1, dadY1, true)
    addAnimationByIndices('dadNote3', '3', 'purple', '0', 24, true)
    playAnim('dadNote3', '3', true)
    setObjectCamera('dadNote3', 'HUD')
    scaleObject('dadNote3', 0.7, 0.7)
    addLuaSprite('dadNote3', true)

    ---bf notes
    makeAnimatedLuaSprite('bfNote1', 'NOTE_assets-sonic', bfX2, dadY3, true)
    addAnimationByIndices('bfNote1', '3', 'blue', '0', 24, true)
    playAnim('bfNote1', '3', true)
    setObjectCamera('bfNote1', 'HUD')
    scaleObject('bfNote1', 0.7, 0.7)
    addLuaSprite('bfNote1', true)

    makeAnimatedLuaSprite('bfNote2', 'NOTE_assets-sonic', bfX4, dadY2, true)
    addAnimationByIndices('bfNote2', '3', 'red', '0', 24, true)
    playAnim('bfNote2', '3', true)
    setObjectCamera('bfNote2', 'HUD')
    scaleObject('bfNote2', 0.7, 0.7)
    addLuaSprite('bfNote2', true)

    makeAnimatedLuaSprite('bfNote3', 'NOTE_assets-sonic', bfX1, dadY1, true)
    addAnimationByIndices('bfNote3', '3', 'purple', '0', 24, true)
    playAnim('bfNote3', '3', true)
    setObjectCamera('bfNote3', 'HUD')
    scaleObject('bfNote3', 0.7, 0.7)
    addLuaSprite('bfNote3', true)

    setProperty('dadNote1.visible', false)
    setProperty('dadNote2.visible', false)
    setProperty('dadNote3.visible', false)

    setProperty('bfNote1.visible', false)
    setProperty('bfNote2.visible', false)
    setProperty('bfNote3.visible', false)
end

function goodNoteHit(id, dir, noteType, sus)
    if hittablenote then
        if noteType == 'trailNote' and dir == 1 then
            setProperty('bfNote1.visible', false)
        end
        if noteType == 'trailNote' and dir == 3 then
            setProperty('bfNote2.visible', false)
        end
        if noteType == 'trailNote' and dir == 0 then
            setProperty('bfNote3.visible', false)
        end
    end
end

function onStepHit()
    if getProperty('resultsscreen.x') == 0 then
        if curStep == 640 then
            setProperty('boyfriend.danceEveryNumBeats', 4)
            setProperty('dad.danceEveryNumBeats', 4)
        end
        if curStep == 896 then
            setProperty('boyfriend.danceEveryNumBeats', 2)
            setProperty('dad.danceEveryNumBeats', 2)
        end
        if curStep == 1024 then
            setProperty('boyfriend.danceEveryNumBeats', 4)
            setProperty('dad.danceEveryNumBeats', 4)
        end
        if curStep == 1296 then
            setProperty('boyfriend.danceEveryNumBeats', 4)
            setProperty('dad.danceEveryNumBeats', 4)
        end
        if curStep == 752 then
            slowdowntime = true
        end
        if curStep == 760 then --760
            setProperty('dadNote1.visible', true)
            setProperty('dadNote2.visible', true)
            setProperty('dadNote3.visible', true)
            if downscroll then
                setProperty('dadNote1.y', getProperty('dadNote1.y') - 900)
                setProperty('dadNote2.y', getProperty('dadNote2.y') - 900)
                setProperty('dadNote3.y', getProperty('dadNote3.y') - 900)
            else
                setProperty('dadNote1.y', getProperty('dadNote1.y') + 900)
                setProperty('dadNote2.y', getProperty('dadNote2.y') + 900)
                setProperty('dadNote3.y', getProperty('dadNote3.y') + 900)
            end
            doTweenY('dadNote1Y', 'dadNote1', dadY3, 1.5, 'cubeOut')
            doTweenY('dadNote2Y', 'dadNote2', dadY2, 1.5, 'cubeOut')
            doTweenY('dadNote3Y', 'dadNote3', dadY1, 1.5, 'cubeOut')
        end
        if curStep == 776 then
            setProperty('dadNote1.visible', false)
        end
        if curStep == 800 then
            setProperty('dadNote2.visible', false)
        end
        if curStep == 816 then
            setProperty('dadNote3.visible', false)
        end
        -- bf notes from chaos control appear
        if curStep == 822 then --760
            hittablenote = true
            setProperty('bfNote1.visible', true)
            setProperty('bfNote2.visible', true)
            setProperty('bfNote3.visible', true)
            if downscroll then
                setProperty('bfNote1.y', getProperty('bfNote1.y') - 900)
                setProperty('bfNote2.y', getProperty('bfNote2.y') - 900)
                setProperty('bfNote3.y', getProperty('bfNote3.y') - 900)
            else
                setProperty('bfNote1.y', getProperty('bfNote1.y') + 900)
                setProperty('bfNote2.y', getProperty('bfNote2.y') + 900)
                setProperty('bfNote3.y', getProperty('bfNote3.y') + 900)
            end
            doTweenY('bfNote1Y', 'bfNote1', dadY3, 1.5, 'cubeOut')
            doTweenY('bfNote2Y', 'bfNote2', dadY2, 1.5, 'cubeOut')
            doTweenY('bfNote3Y', 'bfNote3', dadY1, 1.5, 'cubeOut')
        end
        if curStep == 768 then --768
            if downscroll then
                y = 50
            else
                y = 570
            end
            timetoflip = curBpm/30
            easetypearrows = 'quadInOut'
            noteTweenY('bfTween1', 0, y, timetoflip, easetypearrows)
            noteTweenY('bfTween2', 1, y, timetoflip, easetypearrows)
            noteTweenY('bfTween3', 2, y, timetoflip, easetypearrows)
            noteTweenY('bfTween4', 3, y, timetoflip, easetypearrows)
        end
        if curStep == 832 then
            if downscroll then
                y = 50
            else
                y = 570
            end
            timetoflip = curBpm/30
            easetypearrows = 'quadInOut'
            noteTweenY('dadTween1', 4, y, timetoflip, easetypearrows)
            noteTweenY('dadTween2', 5, y, timetoflip, easetypearrows)
            noteTweenY('dadTween3', 6, y, timetoflip, easetypearrows)
            noteTweenY('dadTween4', 7, y, timetoflip, easetypearrows)
        end
        if curStep == 768 then
            invisnotes = true
        end
        if curStep == 844 then
            if getProperty('bfNote1.visible') == true then
                doTweenAlpha('bfNote1AL', 'bfNote1', 0, 0.5)
            end
        end
        if curStep == 867 then
            if getProperty('bfNote2.visible') == true then
                doTweenAlpha('bfNote2AL', 'bfNote2', 0, 0.5)
            end
        end
        if curStep == 884 then
            if getProperty('bfNote3.visible') == true then
                doTweenAlpha('bfNote3AL', 'bfNote3', 0, 0.5)
            end
        end
    
        if curStep == 880 then
            invisnotes = false
        end
    
        if curStep == 896 then
            if downscroll then
                y = 570
            else
                y = 50
            end
            timetoflip = curBpm/120
            easetypearrows = 'cubeOut'
            noteTweenY('bfTween1', 0, y, timetoflip, easetypearrows)
            noteTweenY('bfTween2', 1, y, timetoflip, easetypearrows)
            noteTweenY('bfTween3', 2, y, timetoflip, easetypearrows)
            noteTweenY('bfTween4', 3, y, timetoflip, easetypearrows)
            noteTweenY('dadTween1', 4, y, timetoflip, easetypearrows)
            noteTweenY('dadTween2', 5, y, timetoflip, easetypearrows)
            noteTweenY('dadTween3', 6, y, timetoflip, easetypearrows)
            noteTweenY('dadTween4', 7, y, timetoflip, easetypearrows)
        end
        if curStep == 1016 then
            slowdowntime = false
        end
    end
end

function onUpdatePost(elapsed)
    if slowdowntime then
        if getProperty('countermultiplier.x') >= 0 then
            setProperty('countermultiplier.x', getProperty('countermultiplier.x') - 0.5 * elapsed)
        end
        if getProperty('countermultiplier.x') < 0 then
            setProperty('countermultiplier.x', 0)
        end
    else
        if getProperty('countermultiplier.x') <= 1 then
            setProperty('countermultiplier.x', getProperty('countermultiplier.x') + 0.5 * elapsed)
        end
        if getProperty('countermultiplier.x') > 1 then
            setProperty('countermultiplier.x', 1)
        end
    end
    if getProperty('resultsscreen.x') == 1 then
        close(true)
    end
    if invisnotes then
        for i = 0, getProperty('notes.length') - 1 do
            setPropertyFromGroup('notes', i, 'alpha', 0)
        end
    else
        for i = 0, getProperty('notes.length') - 1 do
            setPropertyFromGroup('notes', i, 'alpha', 1)
        end
    end
end

function onBeatHit()
    if curBeat % 4 == 0 then
        if getProperty('dad.danceEveryNumBeats') == 2 then
            if getProperty('dad.animation.name') == 'idle' then
                playAnim('dad', 'idle', false)
                setProperty('dad.animation.curAnim.curFrame', 1)
            end
        end
        if getProperty('boyfriend.danceEveryNumBeats') == 2 then
            if getProperty('boyfriend.animation.name') == 'idle' then
                playAnim('boyfriend', 'idle', false)
                setProperty('boyfriend.animation.curAnim.curFrame', 1)
            end
        end
    end
end