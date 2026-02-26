local circleTrailCount = 0
trailActive = false
local baseTrailAlpha = 0.4
local currentTrailAlpha = baseTrailAlpha
local fadeTime = 0.4
local trailBlend = 'overlay'
local trailColor = '0349fc'
local trailAlphaDecay = 0.02
ringdir = 'right'

function onCreatePost()
    if boyfriendName == 'sketchhog' then
        trailColor = 'ffffff'
    end
    sonicInvis = false
    bfInvis = false
    ringsBF = 2
    ringsDAD = 15
    gameoversonic = false
    gameoversonic2 = false

    bfGAMEOVERy = getProperty('boyfriend.y')

    makeLuaSprite('eventsindicator') --
    makeGraphic('eventsindicator', 1, 1, 'ffffff') --0000ff
    setProperty('eventsindicator.alpha', 0)
    addLuaSprite('eventsindicator', false)
    setObjectCamera('eventsindicator', 'hud') 
    setProperty('eventsindicator.x', 1) --1=events enabled 0= events disabled

    makeLuaSprite('oppcanbehurt') --
    makeGraphic('oppcanbehurt', 1, 1, 'ffffff') --0000ff
    setProperty('oppcanbehurt.alpha', 0)
    addLuaSprite('oppcanbehurt', false)
    setObjectCamera('oppcanbehurt', 'hud')
    setProperty('oppcanbehurt.x', 1) --1=opponent can be hurt 0=opponent can't be hurt

    makeLuaSprite('canbehurt') --
    makeGraphic('canbehurt', 1, 1, 'ffffff') --0000ff
    setProperty('canbehurt.alpha', 0)
    addLuaSprite('canbehurt', false)
    setObjectCamera('canbehurt', 'hud')
    setProperty('canbehurt.x', 1) --1=can be hurt 0=can't be hurt

    makeLuaSprite('jumptrigger') --
    makeGraphic('jumptrigger', 1, 1, 'ffffff') --0000ff
    setProperty('jumptrigger.alpha', 0)
    addLuaSprite('jumptrigger', false)
    setObjectCamera('jumptrigger', 'hud')
    setProperty('jumptrigger.x', 0) --1=jump 

    makeLuaSprite('hurtRing') --
    makeGraphic('hurtRing', 1, 1, 'ffffff') --0000ff
    setProperty('hurtRing.alpha', 0)
    addLuaSprite('hurtRing', false)
    setObjectCamera('hurtRing', 'hud')
    setProperty('hurtRing.x', 0) --1=hurt 0=not hurt

    makeLuaSprite('deathindicator') --ringcountindicator
    makeGraphic('deathindicator', 1, 1, 'ffffff') --0000ff
    setProperty('deathindicator.alpha', 0)
    addLuaSprite('deathindicator', false)
    setObjectCamera('deathindicator', 'hud')
    setProperty('deathindicator.x', 0) --1=dead 0=alive

    makeLuaSprite('canjumpindicator') --
    makeGraphic('canjumpindicator', 1, 1, 'ffffff') --
    setProperty('canjumpindicator.alpha', 0)
    addLuaSprite('canjumpindicator', false)
    setObjectCamera('canjumpindicator', 'hud')
    setProperty('canjumpindicator.x', 1) --1=yes 0=no

    makeLuaSprite('canhomingindicator') --
    makeGraphic('canhomingindicator', 1, 1, 'ffffff') --
    setProperty('canhomingindicator.alpha', 0)
    addLuaSprite('canhomingindicator', false)
    setObjectCamera('canhomingindicator', 'hud')
    setProperty('canhomingindicator.x', 1) --1=yes 0=no

    makeLuaSprite('ringcountindicator')
    makeGraphic('ringcountindicator', 1, 1, 'ffffff')
    setProperty('ringcountindicator.alpha', 0)
    addLuaSprite('ringcountindicator', false)
    setObjectCamera('ringcountindicator', 'hud')
    setProperty('ringcountindicator.x', ringsBF)

    makeLuaSprite('oppringcountindicator')
    makeGraphic('oppringcountindicator', 1, 1, 'ffffff')
    setProperty('oppringcountindicator.alpha', 0)
    addLuaSprite('oppringcountindicator', false)
    setObjectCamera('oppringcountindicator', 'hud')
    setProperty('oppringcountindicator.x', ringsDAD)

    --setProperty('camera.zoom', 0.7)
    --getProperty('defaultCamZoom', 0.7)

    makeLuaSprite('cursor', 'cursor', 0, 0) 
    setObjectCamera('cursor', 'other')
    addLuaSprite('cursor', true)

	if ringsBF == 0 then
		runTimer('ringred', 0.5)
	end
	if ringsDAD == 0 then
		runTimer('ringreddad', 0.5)
	end
	if downscroll then
        makeLuaText('RINGCOUNTERBF', ringsBF, 2400, 0, 50)
        setTextSize('RINGCOUNTERBF', 45)
        setTextBorder('RINGCOUNTERBF', 5, '000000')
        setTextColor('RINGCOUNTERBF', 'ffffff')
        setTextFont('RINGCOUNTERBF', 'TestDrive.ttf')
        addLuaText('RINGCOUNTERBF', true)
        setObjectOrder('RINGCOUNTERBF', getObjectOrder('dadGroup') - 1)
    
        makeLuaText('RINGCOUNTERDAD', ringsDAD, 500, 0, 50)
        setTextSize('RINGCOUNTERDAD', 45)
        setTextBorder('RINGCOUNTERDAD', 5, '000000')
        setTextColor('RINGCOUNTERDAD', 'ffffff')
        setTextFont('RINGCOUNTERDAD', 'TestDrive.ttf')
        addLuaText('RINGCOUNTERDAD', true)
        setObjectOrder('RINGCOUNTERDAD', getObjectOrder('dadGroup') - 1)
    else
        makeLuaText('RINGCOUNTERBF', ringsBF, 2400, 0, 610)
        setTextSize('RINGCOUNTERBF', 45)
        setTextBorder('RINGCOUNTERBF', 5, '000000')
        setTextColor('RINGCOUNTERBF', 'ffffff')
        setTextFont('RINGCOUNTERBF', 'TestDrive.ttf')
        addLuaText('RINGCOUNTERBF', true)
        setObjectOrder('RINGCOUNTERBF', getObjectOrder('dadGroup') - 1)
    
        makeLuaText('RINGCOUNTERDAD', ringsDAD, 500, 0, 610)
        setTextSize('RINGCOUNTERDAD', 45)
        setTextBorder('RINGCOUNTERDAD', 5, '000000')
        setTextColor('RINGCOUNTERDAD', 'ffffff')
        setTextFont('RINGCOUNTERDAD', 'TestDrive.ttf')
        addLuaText('RINGCOUNTERDAD', true)
        setObjectOrder('RINGCOUNTERDAD', getObjectOrder('dadGroup') - 1)
    end

    if boyfriendName == 'bf' then
        makeAnimatedLuaSprite('BFBALL', 'bf spin', getProperty('boyfriend.x') - 40, getProperty('boyfriend.y') + 20)
        addAnimationByPrefix('BFBALL','ball bf','spin',30,true)
    elseif boyfriendName == 'sonic_player' then
        makeAnimatedLuaSprite('BFBALL', 'sonic spin', getProperty('boyfriend.x') + 35, getProperty('boyfriend.y') + 400)
        addAnimationByPrefix('BFBALL','spin','sonicball',24,true)
        addAnimationByPrefix('BFBALL','hurt','hurt',30,true)
    elseif boyfriendName == 'sketchhog' then
        makeAnimatedLuaSprite('BFBALL', 'sketchhog ball', getProperty('boyfriend.x') + 30, getProperty('boyfriend.y') + 400)
        addAnimationByPrefix('BFBALL','spin','sketchhog ball',30,true)
    elseif boyfriendName == 'sonic_run' then
        makeAnimatedLuaSprite('BFBALL', 'sonic spin', getProperty('boyfriend.x') + 40, getProperty('boyfriend.y') + 40)
        addAnimationByPrefix('BFBALL','spin','sonicball',24,true)
        addAnimationByPrefix('BFBALL','hurt','hurt',30,true)
        setProperty('BFBALL.flipX', true)
    end
	playAnim('BFBALL','spin',false)
    addLuaSprite('BFBALL', true)
    
    inbfY = getProperty('BFBALL.y')
    inbfX = getProperty('BFBALL.x')

    setProperty('BFBALL.visible', false)

    homingdone = false
    airborne = false

    makeAnimatedLuaSprite('BotonMobile', 'BotonSpaceMobile', 1150, 582)
    addAnimationByPrefix('BotonMobile', 'idle', 'BotonIdle', 24, true)
    addAnimationByPrefix('BotonMobile', 'pressed', 'BotonPressed', 24, false)
    setObjectCamera('BotonMobile', 'other')
    setProperty('BotonMobile.alpha', 0)
    addLuaSprite('BotonMobile')
end

function onSongStart()
    setProperty('BotonMobile.alpha', 1)
end

function sonicJump()
    airborne = true
    setProperty('boyfriend.visible', false)
    if boyfriendName == 'bf' then
        setProperty('BFBALL.y', getProperty('BFBALL.y') - 60)
        doTweenY('boyfriendJUMP', 'BFBALL', getProperty('BFBALL.y') - 300, 0.4, 'quadOut')
    elseif boyfriendName == 'sonic_player' then
        setProperty('BFBALL.y', getProperty('BFBALL.y') - 60)
        doTweenY('boyfriendJUMP', 'BFBALL', getProperty('BFBALL.y') - 500, 0.4, 'quadOut')
    elseif boyfriendName == 'sketchhog' then
        setProperty('BFBALL.y', getProperty('BFBALL.y') - 20)
        doTweenY('boyfriendJUMP', 'BFBALL', getProperty('BFBALL.y') - 300, 0.4, 'quadOut')
    elseif boyfriendName == 'sonic_run' then
        setProperty('BFBALL.y', getProperty('BFBALL.y') - 20)
        doTweenY('boyfriendJUMP', 'BFBALL', getProperty('BFBALL.y') - 430, 0.4, 'quadOut')
    end
    setProperty('BFBALL.visible', true)

    playAnim('BFBALL','spin',false)
    if boyfriendName ~= 'sketchhog' then
        playSound('jump', 0.5, true)
    else
        playSound('jumpsketchhog', 0.9, true)
    end
    setProperty('boyfriend.specialAnim', true)
    doTweenX('animcomp', 'gf', getProperty('gf.x'), 0.8)

    --setProperty('BFBALL.origin.y',400)
    setProperty('BFBALL.scale.y', 1.4)
    doTweenY('bfballScaleTweenYNope', 'BFBALL.scale', 1, 0.5, 'expoOut')
    
    setProperty('BFBALL.scale.x', 0.6)
    doTweenX('bfballScaleTweenXNope', 'BFBALL.scale', 1, 0.5, 'expoOut')
end

function sonicHoming()
    trailActive = true
    cancelTween('boyfriendJUMP')
    cancelTween('boyfriendJUMP2')
    cancelTween('animcomp')
    runTimer('homingeffecttimer', 0.12)
    doTweenX('boyfriendHOMINGx', 'BFBALL', getProperty('dad.x') + 60, 0.15, 'linear')
    if boyfriendName == 'sketchhog' then
        doTweenY('boyfriendHOMINGy', 'BFBALL', getProperty('dad.y') + 200, 0.15, 'linear')
    else
        doTweenY('boyfriendHOMINGy', 'BFBALL', getProperty('dad.y') + 60, 0.15, 'linear')
    end
    if boyfriendName ~= 'sketchhog' then
        playSound('homing', 0.9, false)
    else
        playSound('homingsketchhog', 0.9, false)
    end

    homingdone = true
end

function spawnCircleTrail()
    if getProperty('BFBALL.alpha') == 0 then return end
    if circleTrailCount > 999 then circleTrailCount = 0 end

    local tag = 'circleTrail' .. circleTrailCount

    local x = getProperty('BFBALL.x')
    local y = getProperty('BFBALL.y')
    local scaleX = getProperty('BFBALL.scale.x')
    local scaleY = getProperty('BFBALL.scale.y')
    local flipX = getProperty('BFBALL.flipX')
    local offsetX = getProperty('BFBALL.offset.x')
    local offsetY = getProperty('BFBALL.offset.y')

    makeLuaSprite(tag, 'circleTrail', x, y)

    scaleObject(tag, scaleX, scaleY)
    setProperty(tag .. '.flipX', flipX)
    setProperty(tag .. '.offset.x', offsetX)
    setProperty(tag .. '.offset.y', offsetY)

    setProperty(tag .. '.alpha', currentTrailAlpha)
    setProperty(tag .. '.antialiasing', true)
    setBlendMode(tag, trailBlend)
    setProperty(tag .. '.color', getColorFromHex(trailColor))

    addLuaSprite(tag, false)
    setObjectOrder(tag, getObjectOrder('BFBALL') - 1)

    doTweenAlpha('fade' .. tag, tag, 0, fadeTime, 'linear')

    -- Next trail becomes dimmer
    currentTrailAlpha = math.max(0, currentTrailAlpha - trailAlphaDecay)
    circleTrailCount = circleTrailCount + 1
end
ringvolume = 1
function ringSound()
    if ringdir == 'right' then
        if boyfriendName ~= 'sketchhog' then
            playSound('ringright', ringvolume)
        else
            playSound('ringsketchhogright', ringvolume)
        end
        ringdir = 'left'
    elseif ringdir == 'left' then
        if boyfriendName ~= 'sketchhog' then
            playSound('ringleft', ringvolume)
        else
            playSound('ringsketchhogleft', ringvolume)
        end
        ringdir = 'right'
    end
end

function onUpdatePost()
    if getProperty('resultsscreen.x') == 1 then
        setProperty('cursor.visible', false)
		close()
	end
    if trailActive then
        spawnCircleTrail()
    else
        currentTrailAlpha = baseTrailAlpha
    end
	if getProperty('giveringz.x') == 1 then
        
		setProperty('giveringz.x', 0)
		setProperty('ringcountindicator.x', getProperty('ringcountindicator.x') + 1)
        ringSound()
	end
    if getProperty('hurtRing.x') == 1 then
        setProperty('hurtRing.x', 0)
        if not bfInvis then
            sonicNoteMiss()
            setProperty('deployringindicator.x', 1)
        end
    end
    if getProperty('jumptrigger.x') == 1 then
        setProperty('jumptrigger.x', 0)
        sonicJump()
    end
    ringsBF = getProperty('ringcountindicator.x')
    ringsDAD = getProperty('oppringcountindicator.x')
	setTextString('RINGCOUNTERBF', ringsBF)
	setTextString('RINGCOUNTERDAD', ringsDAD)
    bfY = getProperty('BFBALL.y')
    bfX = getProperty('BFBALL.x')
    
	setProperty('cursor.x', getMouseX('other'))
	setProperty('cursor.y', getMouseY('other'))
        if gameoversonic == false then
            if getProperty('canjumpindicator.x') == 1 then
                if keyJustPressed('accept') and airborne == false then
                    sonicJump()
                end

                if getProperty('canhomingindicator.x') == 1 then
                   if keyJustPressed('accept') and bfY ~= inbfY and airborne == true and homingdone == false then
                    sonicHoming()
                   end
                end

    local mouseOver = (getMouseX('other') > getProperty('BotonMobile.x') and 
                       getMouseX('other') < getProperty('BotonMobile.x') + getProperty('BotonMobile.width') and 
                       getMouseY('other') > getProperty('BotonMobile.y') and 
                       getMouseY('other') < getProperty('BotonMobile.y') + getProperty('BotonMobile.height'))

    if mouseOver and mousePressed('left') then
        if getProperty('BotonMobile.animation.curAnim.name') ~= 'pressed' then
            playAnim('BotonMobile', 'pressed', true)
        end
        if mouseClicked('left') then
            if airborne == false then
                sonicJump()
            end
            if getProperty('canhomingindicator.x') == 1 then
                if bfY ~= inbfY and airborne == true and homingdone == false then
                    sonicHoming()
                end
            end
        end
    else
        if getProperty('BotonMobile.animation.curAnim.name') ~= 'idle' then
            playAnim('BotonMobile', 'idle', true)
        end
    end


                if getProperty('boyfriend.visible') == true then
                    bfY = inbfY
                    airborne = false
                else
                end
            elseif getProperty('canjumpindicator.x') == 0 then
                --
            end
        
            if ringsBF == 0 then
                setProperty('iconP1.animation.curAnim.curFrame',1)
                ringflashBF = true
            else
                setProperty('iconP1.animation.curAnim.curFrame',0)
                setTextColor('RINGCOUNTERBF', 'ffffff')
                ringflashBF = false
            end
            if luaSpriteExists('bosshealth') then
                if getProperty('bosshealth.x') == 0 then
                    setProperty('iconP2.animation.curAnim.curFrame',1)
                    ringflashDAD = true
                else
                    setProperty('iconP2.animation.curAnim.curFrame',0)
                    setTextColor('RINGCOUNTERDAD', 'ffffff')
                    ringflashDAD = false
               end
            else
                if ringsDAD == 0 then
                    setProperty('iconP2.animation.curAnim.curFrame',1)
                    ringflashDAD = true
                else
                    setProperty('iconP2.animation.curAnim.curFrame',0)
                    setTextColor('RINGCOUNTERDAD', 'ffffff')
                    ringflashDAD = false
               end
            end
        end
        if gameovseq == true then
            setProperty('isCameraOnForcedPos', true)
        end  
end

function onTweenCompleted(tag)
    if tag:find('fade') then
        local spr = tag:gsub('fade', '')
        removeLuaSprite(spr, true)
    end
    if tag == 'boyfriendJUMP' then
        doTweenY('boyfriendJUMP2', 'BFBALL', inbfY, 0.4, 'quadIn')
    end
    if tag == 'animcomp' then
        airborne = false
        homingdone = false
        playSound('land', 0.6)
        playAnim('boyfriend', 'idle' .. (getProperty('boyfriend.idleSuffix') or ''), true)
        setProperty('BFBALL.visible', false)
        setProperty('boyfriend.visible', true)
        if boyfriendName == 'bf' then
            setProperty('boyfriend.scale.y', 1.8)
            doTweenY('bfScaleTweenYNope', 'boyfriend.scale', 2, 0.5, 'expoOut')
            setProperty('boyfriend.scale.x', 2.2)
            doTweenX('bfScaleTweenXNope', 'boyfriend.scale', 2, 0.5, 'expoOut')
        elseif boyfriendName == 'sonic_player' then
            setProperty('boyfriend.scale.y', 1.9)
            doTweenY('bfScaleTweenYNope', 'boyfriend.scale', 2, 0.5, 'expoOut')
            setProperty('boyfriend.scale.x', 2.1)
            doTweenX('bfScaleTweenXNope', 'boyfriend.scale', 2, 0.5, 'expoOut')
        elseif boyfriendName == 'sketchhog' then
            setProperty('boyfriend.scale.y', 1.8)
            doTweenY('bfScaleTweenYNope', 'boyfriend.scale', 2, 0.5, 'expoOut')
            setProperty('boyfriend.scale.x', 2.2)
            doTweenX('bfScaleTweenXNope', 'boyfriend.scale', 2, 0.5, 'expoOut')
        end
    end
    if tag == 'boyfriendHOMINGy' then -- 
        if getProperty('oppcanbehurt.x') == 1 then
            if boyfriendName ~= 'sketchhog' then
                playSound('hit1', 0.4)
            else
                playSound('hitsketchhog', 0.4)
            end
    
            if ringsDAD == 0 and sonicInvis == false then
                playAnim('dad', 'hurt', true)
                setProperty('dad.specialAnim', true)
            end
            
            if sonicInvis then
                setProperty('dad.scale.y', 1.8)
                doTweenY('dadScaleTweenYNope', 'dad.scale', 2, 0.7, 'bounceOut')
                
                setProperty('dad.scale.x', 2.2)
                doTweenX('dadScaleTweenXNope', 'dad.scale', 2, 0.7, 'bounceOut')
            end
        else
            setProperty('hurtRing.x', 1)
            if not bfInvis then
                playAnim('BFBALL', 'hurt', true)
            end
            --
        end
        doTweenY('boyfriendJUMP', 'BFBALL', getProperty('BFBALL.y') - 300, 0.4, 'quadOut')
        doTweenX('boyfriendHOMINGx2', 'BFBALL', inbfX, 1, 'quadOut')
        doTweenX('animcomp', 'gf', getProperty('gf.x'), 0.8)
    end
    if tag == 'boyfriendHOMINGy' and sonicInvis == false and ringsDAD > 0 then
        if getProperty('oppcanbehurt.x') == 1 then
            if boyfriendName ~= 'sketchhog' then
                playSound('hitsonic', 0.8)
            else
                playSound('hitsketchhog', 0.4)
            end
            playAnim('dad', 'hurt', true)
            setProperty('dad.specialAnim', true)
            runTimer('ringred', 0.01)
            runTimer('ringreddad', 0.01)
            setProperty('ringcountindicator.x', getProperty('ringcountindicator.x') + 1)
            setProperty('oppringcountindicator.x', getProperty('oppringcountindicator.x') - 1)
            if luaSpriteExists('bosshealth') then
                if getProperty('bosshealth.x') > 0 then
                    setProperty('bosshealth.x', getProperty('bosshealth.x') - 1)
                end
            end
            playSound('ring', 0.9)
            sonicInvis = true
            runTimer('sonicInvincibilityflash', 0.01)
            runTimer('sonicInvincibility', 3)
        else
            if getProperty('dad.name') ~= 'metalsonic' then
                playSound('metalBlock')
                playAnim('dad', 'powerup', true)
                setProperty('dad.specialAnim', true)
            end
            setProperty('hurtRing.x', 1)
            --
        end
    end

    -- GAME OVER
    if tag == 'gameov1' then
        doTweenY('gameov2', 'boyfriend', bfGAMEOVERy + 1200, 1, 'quadIn')
    end
    if tag == 'gameov2' then

        makeLuaSprite('gameoverbgblue')
        makeGraphic('gameoverbgblue', 1920, 1080, '0000ff') --0000ff
        --makeGraphic('gameoverbgblue', 1920, 1080, '0000ff') --0000ff
        --scaleObject('gameoverbgblue', 800, 100)
        setProperty('gameoverbgblue.alpha', 0)
        addLuaSprite('gameoverbgblue', false)
        --setProperty('gameoverbgblue.x', 240)
        --setProperty('gameoverbgblue.y', 550)
        setProperty('gameoverbgblue.camera', instanceArg('camOther'), false, true)
        --setObjectOrder('gameoverbgblue', 1)
        doTweenAlpha('gameovscreenblue', 'gameoverbgblue', 1, 1)
        setBlendMode('gameoverbgblue', 'multiply')
        
        makeLuaSprite('gameoverbg')
        makeGraphic('gameoverbg', 1920, 1080, '000000') --0000ff
        --scaleObject('gameoverbg', 800, 100)
        setProperty('gameoverbg.alpha', 0)
        addLuaSprite('gameoverbg', false)
        --setProperty('gameoverbg.x', 240)
        --setProperty('gameoverbg.y', 550)
        setProperty('gameoverbg.camera', instanceArg('camOther'), false, true)
        --setObjectOrder('subtitlesbg', 1)
        doTweenAlpha('gameovscreen', 'gameoverbg', 1, 1.5)
    end
    if tag == 'gameovscreen' then
        --setProperty('health', 0)
        setProperty('gameoveractive.x', 1) 
        gameoversonic2 = true
    end
end

function onEndSong()
    setProperty('BotonMobile.alpha', 0)
    if gameovseq then
        return Function_Stop
    end
    if not gameovseq then
        runTimer('resultsTimerHA', 1)
    end
end


function onTimerCompleted(tag) --
    if tag == 'homingeffecttimer' then
        if trailActive then
            trailActive = false
        end

    end
    -- SONIC INVINCIBILITY
    if tag == 'resultsTimerHA' then
        setProperty('cursor.visible', false)--cursor RINGCOUNTERBF RINGCOUNTERDAD
        setProperty('RINGCOUNTERBF.visible', false)
        setProperty('RINGCOUNTERDAD.visible', false)
    end
    if tag == 'sonicInvincibilityflash' and sonicInvis == true then
        if getProperty('dad.animation.curAnim.name') ~= 'hurt' then
            setProperty('dad.alpha', 0)
        else
            setProperty('dad.alpha', 1)
        end
        runTimer('sonicInvincibilityflash2', 0.1)
    end
    if tag == 'sonicInvincibilityflash2' and sonicInvis == true then
        if getProperty('dad.animation.curAnim.name') ~= 'hurt' then
            setProperty('dad.alpha', 1)
        else
            setProperty('dad.alpha', 1)
        end
        runTimer('sonicInvincibilityflash', 0.1)
    end
    if tag == 'sonicInvincibility' then
        setProperty('dad.alpha', 1)
        sonicInvis = false
    end

    -- BF INVINCIBILITY
    if tag == 'bfInvincibilityflash' and bfInvis == true then
        if getProperty('boyfriend.animation.curAnim.name') ~= 'hurt' then
            if not string.find(getProperty('boyfriend.animation.curAnim.name'), 'miss') then
                setProperty('boyfriend.alpha', 0)
            else
                setProperty('boyfriend.alpha', 1)
            end
            if getProperty('BFBALL.animation.curAnim.name') ~= 'hurt' then
                setProperty('BFBALL.alpha', 0)
            else
                setProperty('boyfriend.alpha', 1)
            end
        end
        runTimer('bfInvincibilityflash2', 0.1)
    end
    if tag == 'bfInvincibilityflash2' and bfInvis == true then
        if getProperty('boyfriend.animation.curAnim.name') ~= 'hurt' then
            if not string.find(getProperty('boyfriend.animation.curAnim.name'), 'miss') then
                setProperty('boyfriend.alpha', 1)
            end
            if getProperty('BFBALL.animation.curAnim.name') ~= 'hurt' then
                setProperty('BFBALL.alpha', 1)
            end
        end
        runTimer('bfInvincibilityflash', 0.1)
    end
    if tag == 'bfInvincibility' then
        setProperty('boyfriend.alpha', 1)
        setProperty('BFBALL.alpha', 1)
        bfInvis = false
    end

	if tag == 'ringred' and ringsBF == 0 and ringflashBF == true then
		setTextColor('RINGCOUNTERBF', 'ed1539')
		runTimer('ringred2', 0.5)
	end
	if tag == 'ringred2' and ringsBF == 0 and ringflashBF == true then
		setTextColor('RINGCOUNTERBF', 'ffffff')
		runTimer('ringred', 0.5)
	end

	if tag == 'ringreddad' and ringsDAD == 0 and ringflashDAD == true then
		setTextColor('RINGCOUNTERDAD', 'ed1539')
		runTimer('ringred2dad', 0.5)
	end
	if tag == 'ringred2dad' and ringsDAD == 0 and ringflashDAD == true then
		setTextColor('RINGCOUNTERDAD', 'ffffff')
		runTimer('ringreddad', 0.5)
	end

    

    if tag == 'fadevocals' and getProperty('opponentVocals.volume') >= 0 then
        setProperty('opponentVocals.volume', getProperty('opponentVocals.volume') - 0.006)
        runTimer('fadevocals', 0.006)
    end
end

function noteMissPress()
    setProperty('health', 1)
    if not bfInvis then
        sonicNoteMiss()
        setProperty('deployringindicator.x', 1)
    end
end

function noteMiss()
    setProperty('health', 1)
    if not bfInvis then
        sonicNoteMiss()
        setProperty('deployringindicator.x', 1)
    end
end

function sonicNoteMiss()
    setProperty('health', 1)
    if getProperty('canbehurt.x') == 1 then
        if ringsBF > 0 and bfInvis == false and gameoversonic == false then
            runTimer('ringred', 0.5)
            bfInvis = true
            runTimer('bfInvincibilityflash', 0.01)
            runTimer('bfInvincibility', 3)
        end
        if ringsBF == 0 and bfInvis == false and gameoversonic == false then
            sonicGameOver()
        else
            setProperty('health', 1)
        end
        if gameoversonic == true then
            --setProperty('cameraSpeed', 20)
            --setProperty('health', 1)
        end
    end
end

function sonicGameOver()
    setProperty('opponentVocals.volume', getProperty('opponentVocals.volume') - 0.01)
            runTimer('fadevocals', 0.01)
            stopSound('Voices-opponent')
            --setProperty('opponentVocals.volume', 0)
            setProperty('vocals.volume', 0)
            cancelTween('boyfriendJUMP')
            cancelTween('boyfriendJUMP2')
            cancelTween('animcomp')
            if getProperty('BFBALL.visible') == true then
                setProperty('boyfriend.y', getProperty('BFBALL.y'))
                setProperty('boyfriend.x', getProperty('BFBALL.x'))
                setProperty('BFBALL.visible', false)
                setProperty('boyfriend.visible', true)
            end
            setProperty('boyfriend.stunned', true)
            setProperty('boyfriend.specialAnim', true)
            doTweenAlpha('camHUDdis', 'camHUD', 0, 1)
                playAnim('boyfriend', 'die')
            setObjectOrder('boyfriendGroup', getObjectOrder('boyfriendGroup') + 50)
            setProperty('boyfriend.hasMissAnimations', false) 
            setProperty('canPause', false)
            setProperty('canReset', false)
            setProperty('deathindicator.x', 1)
            gameovseq = true
            soundFadeOut(Inst, 2, 0)
            soundFadeOut('opponentVocals', 2, 0)
            soundFadeOut(Voices, 2, 0)
            playSound('hurt', 1)
            gameoversonic = true
            doTweenY('gameov1', 'boyfriend', getProperty('boyfriend.y') - 300, 0.6, 'quadOut')
            setProperty('isCameraOnForcedPos', true)
            --setProperty('health', 0)
        end

function onGameOver()
    gameoversonic = true
end