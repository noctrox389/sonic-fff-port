local badfuture = true
local bfCamX = xx2
local bfCamY = yy2

function onCreate()
    setProperty('dad.idleSuffix', '-alt')
    playIdleDAD()
end

function onCreatePost()


    setProperty('isCameraOnForcedPos', true)
    setProperty('boyfriend.idleSuffix', '-ready')
    setProperty('canjumpindicator.x', 0)
    playIdleBF()

    --setProperty('oppcanbehurt.x', 0)


    makeLuaSprite('future') --
    makeGraphic('future', 1, 1, 'ffffff') --0000ff
    setProperty('future.alpha', 0)
    addLuaSprite('future', false)
    setObjectCamera('future', 'hud') --1=good future 0=bad future
    setProperty('future.x', 0)

    bfXpos = getProperty('boyfriend.x')
    dadXpos = getProperty('dad.x')
    setProperty('boyfriend.x', dadXpos)
    setProperty('dad.x', bfXpos)

    makeLuaSprite('flashbang', '', 0, 0)
    makeGraphic('flashbang', screenWidth, screenHeight, 'FFFFFF')
    setObjectCamera('flashbang', 'camHUD')
    setProperty('flashbang.alpha', 0)
    addLuaSprite('flashbang', true)
    setObjectOrder('flashbang', 0)
end

function playIdleBF()
    playAnim('boyfriend', 'idle' .. (getProperty('boyfriend.idleSuffix') or ''), true)
end
function playIdleDAD()
    playAnim('dad', 'idle' .. (getProperty('dad.idleSuffix') or ''), true)
end

function onTweenCompleted(tag)
    if tag == 'BFTWEENX' then
        doTweenX('BFTWEENX2', 'boyfriend', bfXpos, 1, 'cubeInOut')
        doTweenX('DADTWEENX2', 'dad', dadXpos, 1, 'cubeInOut')
    end
end

function flashBang()
    setProperty('flashbang.alpha', 1)
    doTweenAlpha('flashbangFade', 'flashbang', 0, 0.7, 'linear')
end

function onSectionHit()
    if curSection == 7 then
    end
    if curSection == 8 then
        setProperty('canjumpindicator.x', 1)
        flashBang()
        setProperty('isCameraOnForcedPos', false)
        setProperty('dad.x', dadXpos - 700)
        doTweenX('DADTWEENX', 'dad', dadXpos + 100, 1, 'cubeOut')
        doTweenX('BFTWEENX', 'boyfriend', bfXpos + 100, 1, 'cubeOut')
        setProperty('boyfriend.idleSuffix', '')
        setProperty('dad.idleSuffix', '')
        playIdleBF()
        playIdleDAD()
    end
    if curSection == 72 then --timetraveling
        flashBang()
        setProperty('bgscene.x', 1) --0=present 1=time traveling 2=past 3=good future 4= bad future
    end
    if curSection == 79 then
        setProperty('boyfriend.idleSuffix', '-alt')
        playIdleBF()
        flashBang()
        setProperty('bgscene.x', 2) --0=present 1=time traveling 2=past 3=good future 4= bad future
    end
    if curSection == 104 then --step 1664, beat 415, section 104
        flashBang()
        setProperty('bgscene.x', 1) --0=present 1=time traveling 2=past 3=good future 4= bad future
        setProperty('boyfriend.idleSuffix', '')
        playIdleBF()
        if badfuture then
            setProperty('future.x', 0)
            --
        else
            setProperty('camZooming', false)
            setProperty('eventsindicator.x', 0)
            setProperty('future.x', 1)
            skipTime = 216500
            runHaxeCode([[game.setSongTime(]]..(skipTime)..[[)]])
        end
    end
    if curSection == 111 and getProperty('future.x') == 0 then
        flashBang()
        setProperty('bgscene.x', 4) --0=present 1=time traveling 2=past 3=good future 4= bad future
    end
    if curSection == 146 then
        setProperty('camZooming', true)
        setProperty('eventsindicator.x', 1)
        setProperty('boyfriend.idleSuffix', '')
        playIdleBF()
        flashBang()
        setProperty('bgscene.x', 1) --0=present 1=time traveling 2=past 3=good future 4= bad future
        updateIgnoreNotes()
    end
    if curSection == 153 then
        setProperty('boyfriend.idleSuffix', '-alt')
        playIdleBF()
        flashBang()
        setProperty('bgscene.x', 3) --0=present 1=time traveling 2=past 3=good future 4= bad future
        updateIgnoreNotes()
    end
end

function onSongStart()
    setProperty('canjumpindicator.x', 0)
end

function updateIgnoreNotes()
    for i = 0, getProperty('unspawnNotes.length') - 1 do
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'IgnoreNote' and not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
            setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true)
            setPropertyFromGroup('unspawnNotes', i, 'blockHit', true)
        end
    end
end


function onBeatHit()
    if curBeat == 415 then
        if badfuture then
            --
        else
            setProperty('canbehurt.x', 0)
            for i = 0, getProperty('unspawnNotes.length')-1 do
                setProperty('unspawnNotes['..i..'].ignoreNote', true)
                setProperty('unspawnNotes['..i..'].ratingDisabled', true)
            end
            setProperty('camZoomingMult', 0)
        end
    end
    if curBeat == 558 then
        if badfuture then
            endSong()
            callMethod('opponentVocals.pause', {''})
            callMethod('vocals.pause', {''})
            for i = 0, getProperty('unspawnNotes.length')-1 do
                setProperty('unspawnNotes['..i..'].ignoreNote', true)
                setProperty('unspawnNotes['..i..'].ratingDisabled', true)
            end
        end
    end
    if curBeat == 584 then
        if not badfuture then
            setProperty('canbehurt.x', 1)
            for i = 0, getProperty('unspawnNotes.length')-1 do
                setProperty('unspawnNotes['..i..'].ignoreNote', false)
                setProperty('unspawnNotes['..i..'].ratingDisabled', false)
            end
            setProperty('camZoomingMult', 1)
        end
    end
end

function onUpdatePost()
    if getProperty('bosshealth.x') == 0 then
        badfuture = false
    else
        badfuture = true
    end
end

function onTimerCompleted(tag)
    if tag == 'reenableevents' then
            setProperty('eventsindicator.x', 1)
    end
end