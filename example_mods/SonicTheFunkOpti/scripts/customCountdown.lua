local camchanged = false
local jumpalreadyblocked = false
function onCreatePost()

    defaultcamzoom = getProperty('defaultCamZoom')
    if curStage == 'gray-hill' then
        setProperty('sunflower.visible', false)
        setProperty('flower.visible', false)
    elseif curStage == 'speedway' then
        setProperty('PRESENTfloorfront.visible', false)
        setProperty('PRESENTspotlight1.visible', false)
        setProperty('PRESENTspotlight2.visible', false)
    end
    setProperty('camHUD.alpha', 0)
    setProperty('camFollow.x', getProperty('gf.x') + 350)
    setProperty('camFollow.y', getProperty('gf.y') + 380)
    if curStage == 'speedway' then
        --
    else
        setProperty('isCameraOnForcedPos', true)
        camchanged = true
    end
    bfdefaultcolor = 'ffffff'
    daddefaultcolor = 'ffffff'
    gfdefaultcolor = 'ffffff'
    makeLuaSprite('countdownUnderlay', nil, getProperty('gf.x') -800, -240)
    makeGraphic('countdownUnderlay', screenWidth + 1300, screenHeight + 500, 'ffffff')
    setObjectCamera('countdownUnderlay', 'cameraGame')
    setScrollFactor('countdownUnderlay', 0, 0)
    addLuaSprite('countdownUnderlay', false)

    setProperty('boyfriend.color', getColorFromHex('000000'))
    setProperty('dad.color', getColorFromHex('000000'))
    if getProperty('gf.visible') == true then
        setProperty('gf.color', getColorFromHex('000000'))
    end
    makeLuaSprite('flashbangcountdown', '', 0, 0)
    makeGraphic('flashbangcountdown', screenWidth, screenHeight, 'FFFFFF')
    setObjectCamera('flashbangcountdown', 'camOther')
    setProperty('flashbangcountdown.alpha', 0)
    addLuaSprite('flashbangcountdown', true)
    setObjectOrder('flashbangcountdown', 1)
    runTimer('penisjump', 0.00001)

    --numbers
    
    makeAnimatedLuaSprite('customcountdown1', 'customcountdown', 500, 170)
    addAnimationByPrefix('customcountdown1', '1', 'one OFF', 24, false)
    addOffset('customcountdown1', '1', -49, 0)
    addAnimationByPrefix('customcountdown1', '2', 'two OFF', 24, false)
    addOffset('customcountdown1', '2', 8, 0)
    addAnimationByPrefix('customcountdown1', '3', 'three OFF', 24, false)
    addOffset('customcountdown1', '3', 0, 0)
    playAnim('customcountdown1', '3', true)
    addLuaSprite('customcountdown1', true)
    setObjectCamera('customcountdown1', 'other')
    setProperty('customcountdown1.visible', false)
    
    makeAnimatedLuaSprite('customcountdown2', 'customcountdown', 500, 170)
    addAnimationByPrefix('customcountdown2', '1', 'one ON', 24, false)
    addOffset('customcountdown2', '1', -49, 0)
    addAnimationByPrefix('customcountdown2', '2', 'two ON', 24, false)
    addOffset('customcountdown2', '2', 8, 0)
    addAnimationByPrefix('customcountdown2', '3', 'three ON', 24, false)
    addOffset('customcountdown2', '3', 0, 0)
    playAnim('customcountdown2', '3', true)
    addLuaSprite('customcountdown2', true)
    setObjectCamera('customcountdown2', 'other')
    setProperty('customcountdown2.visible', false)
    
    kickitX = 30
    kickitY = 200
    makeAnimatedLuaSprite('kickit', 'customcountdown', 30, 200)
    addAnimationByPrefix('kickit', 'kickit', 'kick it', 24, true)
    addOffset('kickit', 'kickit', -220, 0)
    addLuaSprite('kickit', true)
    playAnim('kickit', 'loop')
    setObjectCamera('kickit', 'other', true)
    setProperty('kickit.visible', false)
end
-- -870, 440

function onSongStart()
        cancelTween('kickitalpha')
    removeLuaSprite('customcountdown1', true)
    removeLuaSprite('kickit', true)
    if not jumpalreadyblocked then
        setProperty('canjumpindicator.x', 1)
    end
    if curStage ~= 'speedway' then
        setProperty("camGame.zoom",defaultcamzoom + 0.3)
        doTweenZoom('camerazoomcountdown', 'camGame', defaultcamzoom, 2.1, 'expoOut');
    end
    setProperty('camHUD.alpha', 1)
    flashBang()
    setProperty('countdownUnderlay.visible', false)
    setProperty('boyfriend.color', getColorFromHex(bfdefaultcolor))
    setProperty('dad.color', getColorFromHex(daddefaultcolor))
    if camchanged then
        if mustHitSection then
            cameraSetTarget('boyfriend')
        else
            cameraSetTarget('dad')
        end
    end
    if getProperty('gf.visible') == true then
        setProperty('gf.color', getColorFromHex(gfdefaultcolor))
    end
    if curStage == 'gray-hill' then
        setProperty('sunflower.visible', true)
        setProperty('flower.visible', true)
    elseif curStage == 'speedway' then
        --setProperty('PRESENTfloorfront.visible', true)
        --setProperty('PRESENTspotlight1.visible', true)
        --setProperty('PRESENTspotlight2.visible', true)
    end
end

function onCountdownTick(counter)
    if counter == 0 then
        if camchanged then
            setProperty('isCameraOnForcedPos', false)
        end
        setProperty('customcountdown1.visible', true)
        setProperty('customcountdown2.visible', true)
        setProperty('kickit.visible', false)
        playAnim('customcountdown1', '3', true)
        playAnim('customcountdown2', '3', true)
        cancelTween('customcountdown2tween')
        setProperty('customcountdown2.alpha', 1)
        doTweenAlpha('customcountdown2tween', 'customcountdown2', 0, 0.4)
        --3
    elseif counter == 1 then
        playAnim('customcountdown1', '2', true)
        cancelTween('customcountdown2tween')
        setProperty('customcountdown2.alpha', 1)
        doTweenAlpha('customcountdown2tween', 'customcountdown2', 0, 0.4)

        playAnim('customcountdown1', '2', true)
        playAnim('customcountdown2', '2', true)
        doTweenZoom('camerazoomcountdown', 'camGame', defaultcamzoom + 3, 180/bpm, 'expoIn');
        --2
    elseif counter == 2 then
        cancelTween('customcountdown2tween')
        setProperty('customcountdown2.alpha', 1)
        doTweenAlpha('customcountdown2tween', 'customcountdown2', 0, 0.4)
        playAnim('customcountdown1', '1', true)
        playAnim('customcountdown2', '1', true)
        --1
    elseif counter == 3 then
        setProperty('customcountdown1.visible', false)
        playAnim('kickit', 'kickit', true)
        setProperty('kickit.visible', true)
        setProperty('kickit.x', -870)
        setProperty('kickit.y', 440)

        doTweenX('kickittween1', 'kickit', kickitX, 0.5, 'expoOut')
        doTweenY('kickittween2', 'kickit', kickitY, 0.5, 'expoOut')
        doTweenAlpha('kickitalpha', 'kickit', 0, 60/bpm, 'expoIn');
        --hit it
    end
end

function onTimerCompleted(tag)
    if tag == 'penisjump' then
        
        if getProperty('canjumpindicator.x') == 1 then
            setProperty('canjumpindicator.x', 0)
        else
            jumpalreadyblocked = true
        end
    end
end

function flashBang()
    setProperty('flashbangcountdown.alpha', 1)
    doTweenAlpha('flashbangFade', 'flashbangcountdown', 0, 0.7, 'linear')
end