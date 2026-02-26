danceDir = false
rougedance = false
rougehaslanded = false

eggmanscene1 = false
eggmanscene2 = false
eggfloatspeed = 0.7
eggease = 'sineInOut'
ARMX = 350
ARMY = -700
ARMYgrabbed = -340
function onCreatePost()
    --egg arm
    --front
    makeAnimatedLuaSprite('EGGARMfront', 'bgs/emerald altar/EGGARM', ARMX, ARMY)
    addAnimationByPrefix('EGGARMfront', 'open', 'armFRONT open', 24, false)
    addAnimationByPrefix('EGGARMfront', 'closing', 'armFRONT closing', 24, false)
    addAnimationByPrefix('EGGARMfront', 'closed', 'armFRONT closed', 24, false)
    addAnimationByPrefix('EGGARMfront', 'opening', 'armFRONT opening', 24, false)
    addLuaSprite('EGGARMfront')
    scaleObject('EGGARMfront', 2,2)
    playAnim('EGGARMfront', 'closed', false)
    setProperty('EGGARMfront.visible', false)
    setObjectOrder('EGGARMfront', getObjectOrder('masteremerald') + 1)
    --back
    makeAnimatedLuaSprite('EGGARMback', 'bgs/emerald altar/EGGARM', ARMX, ARMY)
    addAnimationByPrefix('EGGARMback', 'open', 'armBACK open', 24, false)
    addAnimationByPrefix('EGGARMback', 'closing', 'armBACK closing', 24, false)
    addAnimationByPrefix('EGGARMback', 'closed', 'armBACK closed', 24, false)
    addAnimationByPrefix('EGGARMback', 'opening', 'armBACK opening', 24, false)
    addLuaSprite('EGGARMback')
    scaleObject('EGGARMback', 2,2)
    playAnim('EGGARMback', 'closed', false)
    setProperty('EGGARMback.visible', false)
    setObjectOrder('EGGARMback', getObjectOrder('masteremerald') - 1)

    setObjectOrder('boyfriendGroup', getObjectOrder('dadGroup') - 1)
    rougeXNORMAL = getProperty('rouge.x')
    rougeYNORMAL = getProperty('rouge.y')

    eggYNORMAL = getProperty('eggman.y')

    setProperty('rouge.visible', false)
    setProperty('rouge.x', -900)
    setProperty('rouge.y', rougeYNORMAL - 200)
    playAnim('rouge', 'flying1', true)

    
    makeLuaSprite('flashbang', '', 0, 0)
    makeGraphic('flashbang', screenWidth, screenHeight, 'FFFFFF')
    setObjectCamera('flashbang', 'camOther')
    setProperty('flashbang.alpha', 0)
    addLuaSprite('flashbang', true)
    setObjectOrder('flashbang', 0)
end

function flashBang()
    setProperty('flashbang.alpha', 1)
    doTweenAlpha('flashbangFade', 'flashbang', 0, 0.7, 'linear')
end

function onStepHit()
    if curStep == 504 then
        setProperty('canjumpindicator.x', 0)
    end
    if curStep == 576 then
        setProperty('canjumpindicator.x', 1)
    end
    if curStep == 577 then
        setProperty('eggman.flipX', true)
        setProperty('eggman.visible', true)
        setProperty('eggman.x', 1900)
        doTweenX('eggmanEMERALDIN', 'eggman', 750, 8)
        doTweenY('eggmanfloat1', 'eggman', eggYNORMAL + 10, eggfloatspeed, eggease)
    end
    if curStep == 58 then --knux camfollowpos (480, 525), sonic (695, 535)
        setProperty('cameraSpeed', 10)
        setProperty('camZooming', true)
        doTweenZoom('camzoomomomom', 'camGame', 1.1, 0.8, 'cubeOut')
        setProperty('defaultCamZoom', 1.1)
        triggerEvent('Camera Follow Pos', 480, 525)
        --eggman stuff
    end
    if curStep == 61 then
        setProperty('cameraSpeed', 10)
    end
    if curStep == 63 then
    end
    if curStep == 64 then
        
        flashBang()
        setProperty('cameraSpeed', 1)
        setProperty('defaultCamZoom', 0.65)
        setProperty('camZooming', true)
    end
    if curStep == 192 then--eggman appears
        setProperty('eggman.x', -800)
        setProperty('eggman.visible', true)
        doTweenX('eggman1', 'eggman', 1700, 14)
        doTweenY('eggmanfloat1', 'eggman', eggYNORMAL + 10, eggfloatspeed, eggease)
    end
    if curStep == 288 then
        doTweenZoom('camshenanigans1', 'camGame', 0.8, 0.28, 'cubeOut')
    end
    if curStep == 624 or curStep == 688 then
        doTweenZoom('dramazoom', 'camGame', 0.9, 1.72, 'cubeIn')
    end

    if curStep == 288 then
        doTweenZoom('camshenanigans1', 'camGame', 0.8, 0.28, 'cubeOut')
    end

    if curStep == 512 then
        doTweenX('punching1', 'dad', getProperty('dad.x') + 120, 0.5, 'cubeOut')
        doTweenX('punching2', 'boyfriend', getProperty('boyfriend.x') - 120, 0.5, 'cubeOut')
    end
    if curStep == 576 then--eggman appears 2nd time
        doTweenX('punching1', 'dad', getProperty('dad.x') - 120, 0.5, 'cubeOut')
        doTweenX('punching2', 'boyfriend', getProperty('boyfriend.x') + 120, 0.5, 'cubeOut')
    end
    if curStep == 888 then --ending surprised
        setProperty('cameraSpeed', 10)
    end
    if curStep == 895 then
        setProperty('cameraSpeed', 1)
    end


    if curStep == 736 or curStep == 800 then--knux camfollowpos (480, 525), sonic (695, 535), inbetween (587, 530)
        triggerEvent('Camera Follow Pos', 587, 530)
    end
    if curStep == 768 or curStep == 832 then
        triggerEvent('Camera Follow Pos')
    end

    if curStep == 317 then
        setProperty('rouge.visible', true)
        doTweenX('rougeINTWEEN', 'rouge', rougeXNORMAL, 5, 'linear')
    end
    if curStep == 511 then
        playAnim('rouge', 'liftoff', false)
        runTimer('rougeANIM2', 0.35)
        rougedance = false
        --playSound('ring')
    end
end

function onTweenCompleted(tag)
    if getProperty('eggman.visible') then
        if tag == 'eggmanfloat1' then
            doTweenY('eggmanfloat2', 'eggman', eggYNORMAL - 10, eggfloatspeed, eggease)
        end
        if tag == 'eggmanfloat2' then
            doTweenY('eggmanfloat1', 'eggman', eggYNORMAL + 10, eggfloatspeed, eggease)
        end

        if tag == 'eggman1' then
            setProperty('eggman.visible', false)
        end
    end
    if tag == 'rougeINTWEEN' then
        runTimer('rougeANIM1', 0.5)
        cancelTween('rougeLAND')
        playAnim('rouge', 'land', false)
        setProperty('rouge.x', rougeXNORMAL)
        setProperty('rouge.y', rougeYNORMAL)
    end
    if tag == 'rougeOUTTWEEN2' then
        setProperty('rouge.visible', false)
    end
    if tag == 'camshenanigans1' then
        triggerEvent('Add Camera Zoom', 0.1)
    end
    if tag == 'eggmanEMERALDIN' then
        playAnim('EGGARMback', 'open')
        playAnim('EGGARMfront', 'open')
        setProperty('EGGARMback.x', ARMX)
        setProperty('EGGARMback.y', ARMY)
        setProperty('EGGARMfront.x', ARMX)
        setProperty('EGGARMfront.y', ARMY)
        setProperty('EGGARMback.visible', true)
        setProperty('EGGARMfront.visible', true)
        doTweenY('EGGARMFRONTin', 'EGGARMfront', ARMYgrabbed, 2)
        doTweenY('EGGARMBACKin', 'EGGARMback', ARMYgrabbed, 2)
        runTimer('eggarmin', 2.2)
    end
    if tag == 'MASTEREMERALDout2' then
        setProperty('eggman.visible', false)
        setProperty('EGGARMback.visible', false)
        setProperty('EGGARMfront.visible', false)
        setProperty('masteremerald.visible', false)
    end
end

function onTimerCompleted(tag)
    if tag == 'eggarmin' then
        playAnim('EGGARMback', 'closing')
        playAnim('EGGARMfront', 'closing')
        runTimer('eggarmscene1', 0.5)
    end
    if tag == 'eggarmscene1' then
        runTimer('eggarmscene2', 1)
        triggerEvent('Screen Shake', '1,0.005', '0,0')
    end
    if tag == 'eggarmscene2' then
        local armpullout = 80
        local armpulloutduration = 1
        doTweenY('EGGARMBACKout', 'EGGARMback', getProperty('EGGARMback.y') - armpullout, armpulloutduration, 'cubeOut')
        doTweenY('EGGARMFRONTout', 'EGGARMfront', getProperty('EGGARMfront.y') - armpullout, armpulloutduration, 'cubeOut')
        doTweenY('MASTEREMERALDout', 'masteremerald', getProperty('masteremerald.y') - armpullout, armpulloutduration, 'cubeOut')
        runTimer('eggarmscene3', 1)
    end
    if tag == 'eggarmscene3' then
        armbye = -2000
        armbyeduration = 15
        doTweenX('EGGARMBACKout2', 'EGGARMback', getProperty('EGGARMback.x') + armbye, armbyeduration)
        doTweenX('EGGARMFRONTout2', 'EGGARMfront', getProperty('EGGARMfront.x') + armbye, armbyeduration)
        doTweenX('MASTEREMERALDout2', 'masteremerald', getProperty('masteremerald.x') + armbye, armbyeduration)
        doTweenX('EGGMANout2', 'eggman', getProperty('eggman.x') + armbye, armbyeduration)
    end
    if tag == 'rougeANIM1' then
        playAnim('rouge', 'danceLeft', true)
        rougedance = true
        danceDir = false
    end
    if tag == 'rougeANIM2' then
        playAnim('rouge', 'leaving', true)
        doTweenY('rougeOUTTWEEN1', 'rouge', rougeYNORMAL -200, 0.6, 'cubeOut')
        doTweenX('rougeOUTTWEEN2', 'rouge', rougeXNORMAL + 1300, 5, 'linear')
    end
end

function onUpdatePost()
    if not rougehaslanded then
        if getProperty('rouge.x') >= rougeXNORMAL - 100 then
            doTweenY('rougeLAND', 'rouge', rougeYNORMAL - 100, 0.35, 'cubeIn')
            rougehaslanded = true
        end
    end
end

danceDir = false
rougedance = false
function onBeatHit()
    if curBeat % 2 == 0 and getProperty('eggman.visible') then
        playAnim('eggman', 'idle')
    end
    if rougedance then
	    if danceDir then
	    	playAnim('rouge', 'danceLeft', true)
	    	danceDir = false
	    else
	    	playAnim('rouge', 'danceRight', true)
	    	danceDir = true
	    end
    end
end