function onCreatePost()
    ---
        dadX1 = getPropertyFromGroup('opponentStrums', 0, 'x')
        dadX2 = getPropertyFromGroup('opponentStrums', 1, 'x')
        dadX3 = getPropertyFromGroup('opponentStrums', 2, 'x')
        dadX4 = getPropertyFromGroup('opponentStrums', 3, 'x')
------------------
        dadY1 = getPropertyFromGroup('opponentStrums', 0, 'y')
        dadY2 = getPropertyFromGroup('opponentStrums', 1, 'y')
        dadY3 = getPropertyFromGroup('opponentStrums', 2, 'y')
        dadY4 = getPropertyFromGroup('opponentStrums', 3, 'y')

        
        bfX1 = getPropertyFromGroup('playerStrums', 0, 'x')
        bfX2 = getPropertyFromGroup('playerStrums', 1, 'x')
        bfX3 = getPropertyFromGroup('playerStrums', 2, 'x')
        bfX4 = getPropertyFromGroup('playerStrums', 3, 'x')
------------------
        bfY1 = getPropertyFromGroup('playerStrums', 0, 'y')
        bfY2 = getPropertyFromGroup('playerStrums', 1, 'y')
        bfY3 = getPropertyFromGroup('playerStrums', 2, 'y')
        bfY4 = getPropertyFromGroup('playerStrums', 3, 'y')

    --hold1
    makeAnimatedLuaSprite('DADglowLEFT', 'NOTES_holdglow', dadX1 + 5, dadY1 + 20)
    setObjectCamera('DADglowLEFT', 'hud')
    addAnimationByPrefix('DADglowLEFT', 'glowanim', 'leftHOLDGLOW', 18, true)
    addLuaSprite('DADglowLEFT', true)
    --hold2
    makeAnimatedLuaSprite('DADglowDOWN', 'NOTES_holdglow', dadX2 + 5, dadY2 + 20)
    setObjectCamera('DADglowDOWN', 'hud')
    addAnimationByPrefix('DADglowDOWN', 'glowanim', 'downHOLDGLOW', 18, true)
    addLuaSprite('DADglowDOWN', true)
    --hold3
    makeAnimatedLuaSprite('DADglowUP', 'NOTES_holdglow', dadX3 + 5, dadY3 + 20)
    setObjectCamera('DADglowUP', 'hud')
    addAnimationByPrefix('DADglowUP', 'glowanim', 'upHOLDGLOW', 18, true)
    addLuaSprite('DADglowUP', true)
    --hold4
    makeAnimatedLuaSprite('DADglowRIGHT', 'NOTES_holdglow', dadX4 + 5, dadY4 + 20)
    setObjectCamera('DADglowRIGHT', 'hud')
    addAnimationByPrefix('DADglowRIGHT', 'glowanim', 'rightHOLDGLOW', 18, true)
    addLuaSprite('DADglowRIGHT', true)


    --hold1
    makeAnimatedLuaSprite('BFglowLEFT', 'NOTES_holdglow', bfX1 + 5, bfY1 + 20)
    setObjectCamera('BFglowLEFT', 'hud')
    addAnimationByPrefix('BFglowLEFT', 'glowanim', 'leftHOLDGLOW', 18, true)
    addLuaSprite('BFglowLEFT', true)
    --hold2
    makeAnimatedLuaSprite('BFglowDOWN', 'NOTES_holdglow', bfX2 + 5, bfY2 + 20)
    setObjectCamera('BFglowDOWN', 'hud')
    addAnimationByPrefix('BFglowDOWN', 'glowanim', 'downHOLDGLOW', 18, true)
    addLuaSprite('BFglowDOWN', true)
    --hold3
    makeAnimatedLuaSprite('BFglowUP', 'NOTES_holdglow', bfX3 + 5, bfY3 + 20)
    setObjectCamera('BFglowUP', 'hud')
    addAnimationByPrefix('BFglowUP', 'glowanim', 'upHOLDGLOW', 18, true)
    addLuaSprite('BFglowUP', true)
    --hold4
    makeAnimatedLuaSprite('BFglowRIGHT', 'NOTES_holdglow', bfX4 + 5, bfY4 + 20)
    setObjectCamera('BFglowRIGHT', 'hud')
    addAnimationByPrefix('BFglowRIGHT', 'glowanim', 'rightHOLDGLOW', 18, true)
    addLuaSprite('BFglowRIGHT', true)

    setProperty('BFglowLEFT.alpha', 0)
    setProperty('BFglowDOWN.alpha', 0)
    setProperty('BFglowUP.alpha', 0)
    setProperty('BFglowRIGHT.alpha', 0)

    setProperty('DADglowLEFT.alpha', 0)
    setProperty('DADglowDOWN.alpha', 0)
    setProperty('DADglowUP.alpha', 0)
    setProperty('DADglowRIGHT.alpha', 0)
end

function goodNoteHit(memberIndex, noteData, noteType, isSustainNote)
    if isSustainNote then
        if noteData == 0 then
            setProperty('BFglowLEFT.alpha', 1)
            runTimer('BFlefttimer', 0.2)
        end
        if noteData == 1 then
            setProperty('BFglowDOWN.alpha', 1)
            runTimer('BFdowntimer', 0.2)
        end
        if noteData == 2 then
            setProperty('BFglowUP.alpha', 1)
            runTimer('BFuptimer', 0.2)
        end
        if noteData == 3 then
            setProperty('BFglowRIGHT.alpha', 1)
            runTimer('BFrighttimer', 0.2)
        end
    end
end

function opponentNoteHit(memberIndex, noteData, noteType, isSustainNote)
    if isSustainNote then
        if noteData == 0 then
            setProperty('DADglowLEFT.alpha', 1)
            runTimer('DADlefttimer', 0.2)
        end
        if noteData == 1 then
            setProperty('DADglowDOWN.alpha', 1)
            runTimer('DADdowntimer', 0.2)
        end
        if noteData == 2 then
            setProperty('DADglowUP.alpha', 1)
            runTimer('DADuptimer', 0.2)
        end
        if noteData == 3 then
            setProperty('DADglowRIGHT.alpha', 1)
            runTimer('DADrighttimer', 0.2)
        end
    end
end


function onTimerCompleted(tag)
    if tag == 'BFlefttimer' then
        doTweenAlpha('BFleftALPHA', 'BFglowLEFT', 0, 0.2)
    end
    if tag == 'BFdowntimer' then
        doTweenAlpha('BFdownALPHA', 'BFglowDOWN', 0, 0.2)
    end
    if tag == 'BFuptimer' then
        doTweenAlpha('BFupALPHA', 'BFglowUP', 0, 0.2)
    end
    if tag == 'BFrighttimer' then
        doTweenAlpha('BFrightALPHA', 'BFglowRIGHT', 0, 0.2)
    end
    ---
    
    if tag == 'DADlefttimer' then
        doTweenAlpha('DADleftALPHA', 'DADglowLEFT', 0, 0.2)
    end
    if tag == 'DADdowntimer' then
        doTweenAlpha('DADdownALPHA', 'DADglowDOWN', 0, 0.2)
    end
    if tag == 'DADuptimer' then
        doTweenAlpha('DADupALPHA', 'DADglowUP', 0, 0.2)
    end
    if tag == 'DADrighttimer' then
        doTweenAlpha('DADrightALPHA', 'DADglowRIGHT', 0, 0.2)
    end
end
    
    