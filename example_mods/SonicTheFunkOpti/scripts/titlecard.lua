local dadr = getProperty('dad.healthColorArray[0]')
local dadg = getProperty('dad.healthColorArray[1]')
local dadb = getProperty('dad.healthColorArray[2]')
local dadColor = string.format('%02X%02X%02X', dadr, dadg, dadb)
local bfr = getProperty('boyfriend.healthColorArray[0]')
local bfg = getProperty('boyfriend.healthColorArray[1]')
local bfb = getProperty('boyfriend.healthColorArray[2]')
local bfColor = string.format('%02X%02X%02X', bfr, bfg, bfb)
songCredit = 'Unknown'

titlebar1Y = 290
textX = 0
titlebar2X = 980
logoX = titlebar2X + 60



function onCreate()
    --removeLuaScript('scripts/customCountdown')
    if getPropertyFromClass('states.PlayState', 'chartingMode') then
        close()
    end
end

function onCreatePost()
    if getProperty('boyfriend.curCharacter') == 'sonic_player' or getProperty('boyfriend.curCharacter') == 'sonic_opp' or getProperty('boyfriend.curCharacter') == 'sonic_run' or getProperty('boyfriend.curCharacter') == 'sketchhog' then
        namepl = 'sonic'
    elseif getProperty('boyfriend.curCharacter') == 'bf' then
        namepl = 'boyfriend'
    elseif getProperty('boyfriend.curCharacter') == 'sketchfox' then
        namepl = 'tails'
    else
        namepl = getProperty('boyfriend.curCharacter')
    end
    if getProperty('dad.curCharacter') == 'sonic_player' or getProperty('dad.curCharacter') == 'sonic_opp' or getProperty('dad.curCharacter') == 'sonic_run' or getProperty('dad.curCharacter') == 'sketchhog' then
        nameopp = 'sonic'
    elseif getProperty('dad.curCharacter') == 'bf' then
        nameopp = 'boyfriend'
    elseif getProperty('dad.curCharacter') == 'sketchfox' then
        nameopp = 'tails'
    else
        nameopp = getProperty('dad.curCharacter')
    end

    if songName == 'Blueprint' then
        namepl = 'beast'
        nameopp = 'machine'
    end

    if songName == 'break down' or songName == 'Break Down' or songName == 'blueprint' or songName == 'Blueprint' then
         songCredit = 'MegaBaz'
    else
        songCredit = 'Jon SpeedArts'
    end
    makeLuaSprite('titlebar1bg', nil, 0, titlebar1Y - 15)
    makeGraphic('titlebar1bg', screenWidth, 185, 'ffffff')
    addLuaSprite('titlebar1bg', true)
    setObjectCamera('titlebar1bg', 'camHUD')
    setProperty('titlebar1bg.visible', false)

    makeLuaSprite('titlebar1', nil, 0, titlebar1Y)
    makeGraphic('titlebar1', screenWidth, 155, 'ffffff')
    addLuaSprite('titlebar1', true)
    setObjectCamera('titlebar1', 'camHUD')
    setProperty('titlebar1.color', getColorFromHex(dadColor))
    setProperty('titlebar1.visible', false)

    makeLuaSprite('titlebar2', nil, 0, titlebar1Y + 50)
    makeGraphic('titlebar2', screenWidth, 55, '000000')
    addLuaSprite('titlebar2', true)
    setObjectCamera('titlebar2', 'camHUD')
    setProperty('titlebar2.visible', false)

    makeLuaText('TITLECARDNAME', ' '..string.upper(songName), 700*2, textX, titlebar1Y)
    setTextSize('TITLECARDNAME', 80*2)
    setTextColor('TITLECARDNAME', 'ffffff')
    setTextBorder('TITLECARDNAME', 7*2, '000000')
    setTextAlignment('TITLECARDNAME', 'left')
    scaleObject('TITLECARDNAME', 1/2, 1/2)
    setTextFont('TITLECARDNAME', 'Kimberley.ttf')
    setObjectCamera('TITLECARDNAME', 'camHud')
    addLuaText('TITLECARDNAME', true)
    setProperty('TITLECARDNAME.antialiasing', true)
    setProperty('TITLECARDNAME.visible', false)

    makeLuaText('TITLECARDCREDIT', '  '..songCredit, 700*2, textX, titlebar1Y + 105)
    setTextSize('TITLECARDCREDIT', 30*2)
    setTextColor('TITLECARDCREDIT', '000000')
    setTextBorder('TITLECARDCREDIT', 4*2, 'ffffff')
    setTextAlignment('TITLECARDCREDIT', 'left')
    scaleObject('TITLECARDCREDIT', 1/2, 1/2)
    setTextFont('TITLECARDCREDIT', 'Kimberley.ttf')
    setObjectCamera('TITLECARDCREDIT', 'camHud')
    addLuaText('TITLECARDCREDIT', true)
    setProperty('TITLECARDCREDIT.antialiasing', true)
    setProperty('TITLECARDCREDIT.visible', false)

    makeLuaSprite('titlecardsquares', 'titlecardsquares', titlebar2X, 0)
    setObjectCamera('titlecardsquares', 'camHud')
    addLuaSprite('titlecardsquares', true)
    setProperty('titlecardsquares.visible', false)

    makeLuaSprite('logolol', 'logocompressed', logoX, 55)
    setObjectCamera('logolol', 'camHud')
    addLuaSprite('logolol', true)
    setProperty('logolol.visible', false)

    makeLuaText('textVS', string.upper(namepl)..'\n\nVS\n\n'..string.upper(nameopp), 160*2, logoX, 248)
    setTextSize('textVS', 30*2)
    setTextColor('textVS', 'ffffff')
    setTextAlignment('textVS', 'center')
    scaleObject('textVS', 1/2, 1/2)
    setTextFont('textVS', 'Kimberley.ttf')
    setObjectCamera('textVS', 'camHud')
    addLuaText('textVS', true)
    setProperty('textVS.antialiasing', true)
    setProperty('textVS.visible', false)
end

titlecardsquarespeed = 0.6
titlecardspeed = 1
function onSongStart()
    if songName ~= 'Break Down' then
        titleCard()
    end
end

function onSectionHit()
    if songName == 'Break Down' and curSection == 2 then
        titleCard()
    end
end

function titleCard()
    setProperty('TITLECARDCREDIT.visible', true)
    setProperty('TITLECARDNAME.visible', true)
    setProperty('titlebar2.visible', true)
    setProperty('titlebar1.visible', true)
    setProperty('titlebar1bg.visible', true)
    setProperty('titlecardsquares.visible', true)
    setProperty('logolol.visible', true)
    setProperty('textVS.visible', true)
    
    runTimer('titlecardTimer', 3)

    setProperty('titlebar1.scale.y', 0.01)
    doTweenY('titlebar1TweenY1', 'titlebar1.scale', 1, titlecardspeed, 'expoOut')
    setProperty('titlebar1bg.scale.y', 0.01)
    doTweenY('titlebar1bgTweenY1', 'titlebar1bg.scale', 1, titlecardspeed, 'expoOut')
    setProperty('titlebar2.scale.y', 0.01)
    doTweenY('titlebar2TweenY1', 'titlebar2.scale', 1, titlecardspeed, 'expoOut')

    setProperty('TITLECARDNAME.x', textX - 500)
    doTweenX('songnameIN', 'TITLECARDNAME', textX, titlecardspeed, 'expoOut')

    setProperty('TITLECARDCREDIT.x', textX + 1300)
    doTweenX('songcreditIN', 'TITLECARDCREDIT', textX, titlecardspeed, 'expoOut')

    doTweenY('titlecardsquaresY', 'titlecardsquares', -53, titlecardsquarespeed, 'linear')

    setProperty('titlecardsquares.x', titlebar2X - 1250)
    doTweenX('titlecardsquaresX', 'titlecardsquares', titlebar2X, titlecardspeed, 'expoOut')

    setProperty('logolol.x', logoX - 1250)
    doTweenX('logololX', 'logolol', logoX, titlecardspeed, 'expoOut')
    setProperty('textVS.x', logoX - 1250)
    doTweenX('textVSX', 'textVS', logoX, titlecardspeed, 'expoOut')
end

function onTimerCompleted(tag)
    if tag == 'titlecardTimer' then
        doTweenY('titlebar1TweenY2', 'titlebar1.scale', 0.01, titlecardspeed, 'expoIn')
        doTweenY('titlebar1bgTweenY2', 'titlebar1bg.scale', 0.01, titlecardspeed, 'expoIn')
        doTweenY('titlebar2TweenY2', 'titlebar2.scale', 0.01, titlecardspeed, 'expoIn')
    
        doTweenX('songnameIN', 'TITLECARDNAME', textX + 1300, titlecardspeed, 'expoIn')
        doTweenX('songcreditIN', 'TITLECARDCREDIT', textX - 250, titlecardspeed, 'expoIn')
    
        doTweenX('titlecardsquaresX', 'titlecardsquares', titlebar2X + 450, titlecardspeed, 'expoIn')
        doTweenX('logololX', 'logolol', logoX + 450, titlecardspeed, 'expoIn')
        doTweenX('textVSX', 'textVS', logoX + 450, titlecardspeed, 'expoIn')
    end
end

function onTweenCompleted(tag)
    if tag == 'titlebar2TweenY2' then
        setProperty('TITLECARDCREDIT.visible', false)
        setProperty('TITLECARDNAME.visible', false)
        setProperty('titlebar2.visible', false)
        setProperty('titlebar1.visible', false)
        setProperty('titlebar1bg.visible', false)
        setProperty('titlecardsquares.visible', false)
        setProperty('logolol.visible', false)
        setProperty('textVS.visible', false)
    end
    if tag == 'titlecardsquaresY' and getProperty('titlecardsquares.visible') then
        setProperty('titlecardsquares.y', 0)
        doTweenY('titlecardsquaresY', 'titlecardsquares', -53, titlecardsquarespeed, 'linear')
    end
end
