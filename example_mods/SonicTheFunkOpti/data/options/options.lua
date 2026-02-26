keyboard = {
    ['LEFT'] = 37,
    ['UP'] = 38,
    ['RIGHT'] = 39,
    ['DOWN'] = 40,
    ['SHIFT'] = 16,
    ['CONTROL'] = 17,
    ['ALT'] = 18,
    ['SPACE'] = 32,
    ['0'] = 48,
    ['1'] = 49,
    ['2'] = 50,
    ['3'] = 51,
    ['4'] = 52,
    ['5'] = 53,
    ['6'] = 54,
    ['7'] = 55,
    ['8'] = 56,
    ['9'] = 57,
    ['ENTER'] = 13,
    ['BCKSPC'] = 8,
    ['ESCAPE'] = 27,
    ['A'] = 65,
    ['B'] = 66,
    ['C'] = 67,
    ['D'] = 68,
    ['E'] = 69,
    ['F'] = 70,
    ['G'] = 71,
    ['H'] = 72,
    ['I'] = 73,
    ['J'] = 74,
    ['K'] = 75,
    ['L'] = 76,
    ['M'] = 77,
    ['N'] = 78,
    ['O'] = 79,
    ['P'] = 80,
    ['Q'] = 81,
    ['R'] = 82,
    ['S'] = 83,
    ['T'] = 84,
    ['U'] = 85,
    ['V'] = 86,
    ['W'] = 87,
    ['X'] = 88,
    ['Y'] = 89,
    ['Z'] = 90,
    ['SEMICOLON'] = 186,
    ['COMMA'] = 188,
    ['PERIOD'] = 190,
    ['SLASH'] = 191,
    ['GRAVEACCENT'] = 192,
    ['LBRACKET'] = 219,
    ['RBRACKET'] = 221,
    ['QUOTE'] = 222,
    ['F1'] = 112,
    ['F2'] = 113,
    ['F3'] = 114,
    ['F4'] = 115,
    ['F5'] = 116,
    ['F6'] = 117,
    ['F7'] = 118,
    ['F8'] = 119,
    ['F9'] = 120,
    ['F10'] = 121,
    ['F11'] = 122,
    ['F12'] = 123
}
fpsEnabled = runHaxeCode([[
                            return ClientPrefs.data.showFPS;
                        ]])
lolcaching = runHaxeCode([[
                            return ClientPrefs.data.cacheOnGPU;
                        ]])
                        if lolcaching then
                        caching = false
                        else
                            caching = true
                        end
local lolowQ = runHaxeCode([[
    return ClientPrefs.data.lowQuality;
]])
                        if lolowQ then
                        lowQ = false
                        else
                            lowQ = true
                        end

                    local maxfpsallowed = 144
                    local minfpsallowed = 60
                    
local rightHoldTime = 0
local leftHoldTime = 0
local repeatDelay = 0.4
local repeatRate = 0.06

downscrolldetect = getPropertyFromClass('backend.ClientPrefs', 'data.downScroll')
                    dowscrollY = 570
                    upscrollY = 50

curMenu = 'options'
openeaseTime = 1
local caninput = true

littlebuddyX = getDataFromSave('globalsave', 'littlebuddyX', 800)
littlebuddyY = getDataFromSave('globalsave', 'littlebuddyY', 380)

littleopponentX = getDataFromSave('globalsave', 'littleopponentX', 350)
littleopponentY = getDataFromSave('globalsave', 'littleopponentY', 380)
defaultBUDDYY = 380
defaultBUDDYX = 800
DEFAULTOPPONENTX = 350
local dragging = false

local scrollSpeed = 0.8
local easetype = 'expoOut'

controlspage = 1
pagechanged = false
pageselection = false
hoveringreset = false

local optionsState = 'options' -- modoptions
local selectionoptions = 1
local selectionscontrolsoptions = 1
local selectionsvisualsoptions = 1
local selectionsmodoptions = 0

local bindselection = 1

rebinding = false


function onTimerCompleted(tag)
    if tag == 'musictimer' then
        playMusic('options', 1, true)
    end
    if tag == 'resetinput' then
        caninput = true
    end
    if tag == 'rebindtimer' then
        rebinding = true
    end
    if tag == 'exitoptions' then
        confirmed = true
            setDataFromSave('globalsave', 'lastSong', songName)
            if prevsong == 'menu' or prevsong == 'Menu' or prevsong == 'options' or prevsong == nil then
                loadSong('menu', -1)
            else
                if diffselection == '-easy' then
                    setPropertyFromClass('backend.Difficulty', 'list', {'easy'})
                elseif diffselection == '' then
                    setPropertyFromClass('backend.Difficulty', 'list', {'normal'})
                elseif diffselection == '-encore' then
                    setPropertyFromClass('backend.Difficulty', 'list', {'encore'})
                end
                loadSong(prevsong, 0)
            end
    end
    if tag == 'resetButtonAnim' then
        playAnim('BotonOptionsMobile', 'idle', true)
    end
end

function onCreate()
        -- cursor
    makeLuaSprite('cursor', 'cursor', 0, 0)
    setObjectCamera('cursor', 'other')
    addLuaSprite('cursor', true)

    precacheMusic('options')
    removeLuaScript('scripts/titlecard')
    removeLuaScript('scripts/noteUnderlays')
    removeLuaScript('scripts/pauseMenu')
    removeLuaScript('scripts/homing attack')
    removeLuaScript('scripts/sonic UI')
    removeLuaScript('scripts/results')
    removeLuaScript('scripts/customCountdown')
    setProperty('skipCountdown', true)

    initSaveData('globalsave')
    diffselection = getDataFromSave('globalsave', 'lastDifficulty', '')
    prevsong = getDataFromSave('globalsave', 'lastSong', nil)
    setDataFromSave('globalsave', 'lastSong', nil)
end

function onEndSong()
    if not confirmed then
        return Function_Stop
    end
end

function onCreatePost()
    stopSound()
    runTimer('musictimer', 0.1)
    setProperty('canReset', false)
    setProperty('canPause', false)
    setProperty('boyfriend.stunned', true)
    setProperty('boyfriend.visible', false)
    setProperty('dad.visible', false)
    setProperty('gf.visible', false)

    -- hide HUD
    setProperty('scoreTxt.visible', false)
    setProperty('timeBar.visible', false)
    setProperty('timeTxt.visible', false)
    -- setObjectCamera('timeTxt', 'hud')
    setProperty('timeBarBG.visible', false)
    setProperty('iconP1.visible', false)
    setProperty('healthBar.visible', false)
    setProperty('healthBarBG.visible', false)
    setProperty('iconP2.visible', false)

    -- hide NOTES
    for i = 0, 7 do
        noteTweenAlpha('notessAlpha' .. i, i, 0, 0.01, 'quadInOut')
    end

    -- make sprites
    OPbgX = -550 -- -550
    OPbgY = -50 -- -50

    bgspeed = 9

    makeLuaSprite('optionsbg', 'menus/options/options bg', OPbgX, OPbgY)
    setObjectCamera('optionsbg', 'hud')
    scaleObject('optionsbg', 2,2)
    addLuaSprite('optionsbg', false)
    doTweenX('optionsbgtween1', 'optionsbg', OPbgX - 300, bgspeed)
    doTweenY('optionsbgtween2', 'optionsbg', OPbgY - 300, bgspeed)

    squaresTopY = -600
    makeLuaSprite('squaresTop', 'pause/bgsquares', -10, squaresTopY)
    addLuaSprite('squaresTop', false)
    setObjectCamera('squaresTop', 'hud')
    setProperty('squaresTop.x', -10)
    scaleObject('squaresTop', 2,2)
    setProperty('squaresTop.flipY', true)
    setProperty('squaresTop.color', getColorFromHex('000000'))
    squaresspeed = 1
    setProperty('squaresTop.x', -10)
    doTweenX('squaresTopMove', 'squaresTop', -77, squaresspeed)

    squaresBottomY = 600
    makeLuaSprite('squaresBottom', 'pause/bgsquares', -10, squaresBottomY)
    addLuaSprite('squaresBottom', false)
    setObjectCamera('squaresBottom', 'hud')
    setProperty('squaresBottom.x', -10)
    scaleObject('squaresBottom', 2,2)
    setProperty('squaresBottom.color', getColorFromHex('000000'))
    squaresspeed = 1
    setProperty('squaresBottom.x', -77)
    doTweenX('squaresBottomMove', 'squaresBottom', -10, squaresspeed)



    -- OPTIONS STUFF
    underlayWidth = 485
    bfUnderlayAlpha = 0.5
    dadUnderlayAlpha = 0.5
    makeLuaSprite('bfnotesUnderlay', nil, 0, 0)
    makeGraphic('bfnotesUnderlay', underlayWidth, screenHeight, '000000')
    setObjectCamera('bfnotesUnderlay', 'camHUD')
    addLuaSprite('bfnotesUnderlay', false)
    setProperty('bfnotesUnderlay.x', getPropertyFromGroup('playerStrums', 0, 'x') - 20)
    setProperty('bfnotesUnderlay.alpha', 0)

    if not middlescroll then
        makeLuaSprite('dadnotesUnderlay', nil, 0, 0)
        makeGraphic('dadnotesUnderlay', underlayWidth, screenHeight, '000000')
        setObjectCamera('dadnotesUnderlay', 'camHUD')
        addLuaSprite('dadnotesUnderlay', false)
        setProperty('dadnotesUnderlay.x', getPropertyFromGroup('opponentStrums', 0, 'x') - 20)
        setProperty('dadnotesUnderlay.alpha', 0)
    end


    -- esc thing

    backTXTY = 30
    backTXTX = 90

    backICONY = 20
    backICONX = 20
    makeLuaSprite('back', 'extras/back', backICONX, backICONY)
    setObjectCamera('back', 'hud')
    addLuaSprite('back', false)

    makeLuaText('backtxtt', 'ESC', 100 * 2, backTXTX, backTXTY)
    setTextSize('backtxtt', 45 * 2)
    scaleObject('backtxtt', 0.5, 0.5)
    setTextBorder('backtxtt', 5 * 2, '000000')
    setTextColor('backtxtt', 'ffffff')
    setTextFont('backtxtt', 'Kimberley.ttf')
    addLuaText('backtxtt', false)
    --

    makeAnimatedLuaSprite('littlebuddy', 'characters/littlebuddy', littlebuddyX, littlebuddyY)
    setObjectCamera('littlebuddy', 'camHUD')
    addAnimationByPrefix('littlebuddy', 'idle', 'little buddy idle', 24, false)
    addLuaSprite('littlebuddy', false)
    playAnim('littlebuddy', 'idle', true)
    setProperty('littlebuddy.x', littlebuddyX + 500)
    setProperty('littlebuddy.alpha', 0)
    if getDataFromSave('globalsave', 'littleplayer', 'OFF') == 'ON' then
        
        buddyalpha = 1
    else
        buddyalpha = 0
    end

    makeAnimatedLuaSprite('littleopponent', 'characters/littlebuddy', littleopponentX, littleopponentY)
    setObjectCamera('littleopponent', 'camHUD')
    addAnimationByPrefix('littleopponent', 'idle', 'little buddy idle', 24, false)
    addLuaSprite('littleopponent', false)
    setProperty('littleopponent.flipX', true)
    playAnim('littleopponent', 'idle', true)
    setProperty('littleopponent.x', littleopponentX - 500)
    setProperty('littleopponent.alpha', 0)
    if getDataFromSave('globalsave', 'littleopponent', 'OFF') == 'ON' then
        oppalpha = 1
    else
        oppalpha = 0
    end

    for i = 1, 4 do --player
        makeAnimatedLuaSprite('NOTEZ'..i, 'NOTE_assets-sonic', getPropertyFromGroup('playerStrums', i - 1, 'x'), getPropertyFromGroup('playerStrums', i - 1, 'y'))
        setObjectCamera('NOTEZ'..i, 'camHUD')
        addAnimationByPrefix('NOTEZ'..i, 'noteup', 'arrowUP', 24, false)
        addAnimationByPrefix('NOTEZ'..i, 'notedown', 'arrowDOWN', 24, false)
        addAnimationByPrefix('NOTEZ'..i, 'noteleft', 'arrowLEFT', 24, false)
        addAnimationByPrefix('NOTEZ'..i, 'noteright', 'arrowRIGHT', 24, false)
        scaleObject('NOTEZ'..i, 0.7, 0.7)
        addLuaSprite('NOTEZ'..i, true)
    end
        playAnim('NOTEZ1', 'noteleft', 24, false)
        playAnim('NOTEZ2', 'notedown', 24, false)
        playAnim('NOTEZ3', 'noteup', 24, false)
        playAnim('NOTEZ4', 'noteright', 24, false)
    for i = 5, 8 do --opponent
        makeAnimatedLuaSprite('NOTEZ'..i, 'NOTE_assets-sonic', getPropertyFromGroup('opponentStrums', i - 5, 'x'), getPropertyFromGroup('opponentStrums', i - 5, 'y'))
        setObjectCamera('NOTEZ'..i, 'camHUD')
        addAnimationByPrefix('NOTEZ'..i, 'noteup', 'arrowUP', 24, false)
        addAnimationByPrefix('NOTEZ'..i, 'notedown', 'arrowDOWN', 24, false)
        addAnimationByPrefix('NOTEZ'..i, 'noteleft', 'arrowLEFT', 24, false)
        addAnimationByPrefix('NOTEZ'..i, 'noteright', 'arrowRIGHT', 24, false)
        scaleObject('NOTEZ'..i, 0.7, 0.7)
        addLuaSprite('NOTEZ'..i, true)
    end
        playAnim('NOTEZ5', 'noteleft', 24, false)
        playAnim('NOTEZ6', 'notedown', 24, false)
        playAnim('NOTEZ7', 'noteup', 24, false)
        playAnim('NOTEZ8', 'noteright', 24, false)


    for i = 1, 8 do
        if downscrolldetect then
            setProperty('NOTEZ' .. i .. '.y', dowscrollY + 200)
        else
            setProperty('NOTEZ' .. i .. '.y', upscrollY - 200)
        end
    end

    for i = 1, 4 do
        setProperty('NOTEZ' .. i .. '.alpha', getPropertyFromGroup('playerStrums', 0, 'alpha'))
    end
    for i = 5, 8 do
        setProperty('NOTEZ' .. i .. '.alpha', getPropertyFromGroup('opponentStrums', 0, 'alpha'))
    end

    OPTIONStxtX = 360
    OPTIONStxtY = 60
    makeLuaText('OPTIONStxt', 'OPTIONS', 600 * 2, OPTIONStxtX, OPTIONStxtY)
    setTextSize('OPTIONStxt', 80 * 2)
    scaleObject('OPTIONStxt', 0.5, 0.5)
    setTextAlignment('OPTIONStxt', 'center')
    setTextBorder('OPTIONStxt', 8 * 2, '000000')
    setTextColor('OPTIONStxt', 'ffffff')
    setTextFont('OPTIONStxt', 'Kimberley.ttf')
    addLuaText('OPTIONStxt', false)
    setProperty('OPTIONStxt.y', OPTIONStxtY - 200)

    option1X = 360
    option1Y = 170

    option2X = 360
    option2Y = 270

    option3X = 360
    option3Y = 370

    option4X = 360
    option4Y = 470

    -- controls
    bind1offset = 150
    bind2offset = 300
    controlsoptionsSUBX = 360
    controlsoptionsSUBY = 20
    controlsoptionsX = 360
    controlsoption1Y = 150
    controlsoption2Y = controlsoption1Y + 80
    controlsoption3Y = controlsoption1Y + 80 * 2
    controlsoption4Y = controlsoption1Y + 80 * 3
    controlsoption5Y = controlsoption1Y + 80 * 4
    bindsYoffset = 25

    separationA1 = 70
    controlsoptionA1Y = 140
    controlsoptionA2Y = controlsoptionA1Y + separationA1
    controlsoptionA3Y = controlsoptionA1Y + separationA1 * 2
    controlsoptionA4Y = controlsoptionA1Y + separationA1 * 3
    controlsoptionA5Y = controlsoptionA1Y + separationA1 * 4
    controlsoptionA6Y = controlsoptionA1Y + separationA1 * 5

    separationB1 = 100
    controlsoptionB1Y = 220
    controlsoptionB2Y = controlsoptionB1Y + separationB1
    controlsoptionB3Y = controlsoptionB1Y + separationB1 * 2

    controlsoptionsbindX = 760
    -- visuals
    visualsoptionsTXTX = 360
    visualsoptionsX = 300
    visualsoption1Y = 200
    visualsoption2Y = visualsoption1Y + 80
    visualsoption3Y = visualsoption1Y + 80 * 2
    -- other
    modoptionsX = 160
    modoptionsep = 70
    modoption0Y = 180
    modoption1Y = modoption0Y + modoptionsep
    modoption2Y = modoption0Y + modoptionsep * 2
    modoption3Y = modoption0Y + modoptionsep * 3
    modoption4Y = modoption0Y + modoptionsep * 4

    modmodifierX = 600

    makeLuaSprite('selectionOptions', nil, 0, option1Y + 5)
    makeGraphic('selectionOptions', screenWidth, 70, '000000')
    setObjectCamera('selectionOptions', 'hud')
    addLuaSprite('selectionOptions', false)
    setProperty('selectionOptions.alpha', 0.5)

    makeLuaSprite('selectionOptions2', nil, 750, option1Y + 5)
    makeGraphic('selectionOptions2', 165, 90, '000000')
    setObjectCamera('selectionOptions2', 'hud')
    addLuaSprite('selectionOptions2', false)
    setProperty('selectionOptions2.alpha', 0)

    makeLuaText('option1', 'Controls\n ', 600 * 2, option1X, option1Y)
    setTextSize('option1', 40 * 2)
    scaleObject('option1', 0.5, 0.5)
    setTextAlignment('option1', 'center')
    setTextBorder('option1', 5 * 2, '000000')
    setTextColor('option1', 'ffffff')
    setTextFont('option1', 'Kimberley.ttf')
    addLuaText('option1', false)
    setProperty('option1.x', option1X + 850)

    makeLuaText('option2', 'Visuals\n ', 600 * 2, option2X, option2Y)
    setTextSize('option2', 40 * 2)
    scaleObject('option2', 0.5, 0.5)
    setTextAlignment('option2', 'center')
    setTextBorder('option2', 5 * 2, '000000')
    setTextColor('option2', 'ffffff')
    setTextFont('option2', 'Kimberley.ttf')
    addLuaText('option2', false)
    setProperty('option2.x', option2X + 950)

    makeLuaText('option3', 'Other\n ', 600 * 2, option3X, option3Y)
    setTextSize('option3', 40 * 2)
    scaleObject('option3', 0.5, 0.5)
    setTextAlignment('option3', 'center')
    setTextBorder('option3', 5 * 2, '000000')
    setTextColor('option3', 'ffffff')
    setTextFont('option3', 'Kimberley.ttf')
    addLuaText('option3', false)
    setProperty('option3.x', option3X + 950)

    makeLuaText('option4', 'Reset Game Data\n ', 600 * 2, option3X, option4Y)
    setTextSize('option4', 40 * 2)
    scaleObject('option4', 0.5, 0.5)
    setTextAlignment('option4', 'center')
    setTextBorder('option4', 5 * 2, '000000')
    setTextColor('option4', 'ffffff')
    setTextFont('option4', 'Kimberley.ttf')
    addLuaText('option4', false)
    setProperty('option4.x', option3X + 950)

    if downscrolldetect then

        -- visuals
        makeLuaText('CONTROLSOPTIONStxt2', '1/1', 600 * 2, OPTIONStxtX, OPTIONStxtY + 50)
        setTextSize('CONTROLSOPTIONStxt2', 60 * 2)
        scaleObject('CONTROLSOPTIONStxt2', 0.5, 0.5)
        setTextAlignment('CONTROLSOPTIONStxt2', 'center')
        setTextBorder('CONTROLSOPTIONStxt2', 8 * 2, '000000')
        setTextColor('CONTROLSOPTIONStxt2', 'ffffff')
        setTextFont('CONTROLSOPTIONStxt2', 'Kimberley.ttf')
        addLuaText('CONTROLSOPTIONStxt2', false)
        setProperty('CONTROLSOPTIONStxt2.x', OPTIONStxtX - 1000)
        -- otheroptions
        makeLuaText('MODOPTIONStxt', 'OTHER OPTIONS', 600 * 2, OPTIONStxtX, OPTIONStxtY)
        setTextSize('MODOPTIONStxt', 80 * 2)
        scaleObject('MODOPTIONStxt', 0.5, 0.5)
        setTextAlignment('MODOPTIONStxt', 'center')
        setTextBorder('MODOPTIONStxt', 8 * 2, '000000')
        setTextColor('MODOPTIONStxt', 'ffffff')
        setTextFont('MODOPTIONStxt', 'Kimberley.ttf')
        addLuaText('MODOPTIONStxt', false)
        setProperty('MODOPTIONStxt.x', OPTIONStxtX - 1000)
    else
        -- otheroptions
        makeLuaText('MODOPTIONStxt', 'OTHER OPTIONS', 600 * 2, OPTIONStxtX, OPTIONStxtY + 500)
        setTextSize('MODOPTIONStxt', 80 * 2)
        scaleObject('MODOPTIONStxt', 0.5, 0.5)
        setTextAlignment('MODOPTIONStxt', 'center')
        setTextBorder('MODOPTIONStxt', 8 * 2, '000000')
        setTextColor('MODOPTIONStxt', 'ffffff')
        setTextFont('MODOPTIONStxt', 'Kimberley.ttf')
        addLuaText('MODOPTIONStxt', false)
        setProperty('MODOPTIONStxt.x', OPTIONStxtX - 1000)
    end
        -- controls
        makeLuaText('CONTROLSOPTIONStxt', 'CONTROLS', 600 * 2, OPTIONStxtX, OPTIONStxtY + 500)
        setTextSize('CONTROLSOPTIONStxt', 80 * 2)
        scaleObject('CONTROLSOPTIONStxt', 0.5, 0.5)
        setTextAlignment('CONTROLSOPTIONStxt', 'center')
        setTextBorder('CONTROLSOPTIONStxt', 8 * 2, '000000')
        setTextColor('CONTROLSOPTIONStxt', 'ffffff')
        setTextFont('CONTROLSOPTIONStxt', 'Kimberley.ttf')
        addLuaText('CONTROLSOPTIONStxt', false)
        setProperty('CONTROLSOPTIONStxt.x', OPTIONStxtX - 1000)

    -- visual options
        makeLuaText('VISUALSOPTIONStxt', 'VISUALS', 600 * 2, visualsoptionsTXTX, OPTIONStxtY )
        setTextSize('VISUALSOPTIONStxt', 80 * 2)
        scaleObject('VISUALSOPTIONStxt', 0.5, 0.5)
        setTextAlignment('VISUALSOPTIONStxt', 'center')
        setTextBorder('VISUALSOPTIONStxt', 8 * 2, '000000')
        setTextColor('VISUALSOPTIONStxt', 'ffffff')
        setTextFont('VISUALSOPTIONStxt', 'Kimberley.ttf')
        addLuaText('VISUALSOPTIONStxt', false)
        setProperty('VISUALSOPTIONStxt.x', OPTIONStxtX - 1000)

        makeLuaText('visualsoption1', ' FPS Cap:\n ', 600 * 2, visualsoptionsX, visualsoption1Y)
    setTextSize('visualsoption1', 40 * 2)
    scaleObject('visualsoption1', 0.5, 0.5)
    setTextAlignment('visualsoption1', 'left')
    setTextBorder('visualsoption1', 5 * 2, '000000')
    setTextColor('visualsoption1', 'ffffff')
    setTextFont('visualsoption1', 'Kimberley.ttf')
    addLuaText('visualsoption1', false)
    setProperty('visualsoption1.x', controlsoptionsX - 1150)

        makeLuaText('visualsoption1MODIFIER', ' ?\n ', 600 * 2, modmodifierX, visualsoption1Y + bindsYoffset)
    setTextSize('visualsoption1MODIFIER', 40 * 2)
    scaleObject('visualsoption1MODIFIER', 0.5, 0.5)
    setTextAlignment('visualsoption1MODIFIER', 'center')
    setTextBorder('visualsoption1MODIFIER', 5 * 2, '000000')
    setTextColor('visualsoption1MODIFIER', 'ffffff')
    setTextFont('visualsoption1MODIFIER', 'Kimberley.ttf')
    addLuaText('visualsoption1MODIFIER', false)
    setProperty('visualsoption1MODIFIER.x', controlsoptionsX - 1150)
        
        
        makeLuaText('visualsoption2', ' GPU Caching\n ', 600 * 2, visualsoptionsX, visualsoption2Y)
    setTextSize('visualsoption2', 40 * 2)
    scaleObject('visualsoption2', 0.5, 0.5)
    setTextAlignment('visualsoption2', 'left')
    setTextBorder('visualsoption2', 5 * 2, '000000')
    setTextColor('visualsoption2', 'ffffff')
    setTextFont('visualsoption2', 'Kimberley.ttf')
    addLuaText('visualsoption2', false)
    setProperty('visualsoption2.x', controlsoptionsX - 1150)


        makeLuaText('visualsoption2MODIFIER', ' ?\n ', 600 * 2, modmodifierX, visualsoption2Y + bindsYoffset)
    setTextSize('visualsoption2MODIFIER', 40 * 2)
    scaleObject('visualsoption2MODIFIER', 0.5, 0.5)
    setTextAlignment('visualsoption2MODIFIER', 'center')
    setTextBorder('visualsoption2MODIFIER', 5 * 2, '000000')
    setTextColor('visualsoption2MODIFIER', 'ffffff')
    setTextFont('visualsoption2MODIFIER', 'Kimberley.ttf')
    addLuaText('visualsoption2MODIFIER', false)
    setProperty('visualsoption2MODIFIER.x', controlsoptionsX - 1150)
        
        makeLuaText('visualsoption3', ' Low Quality Mode\n ', 600 * 2, visualsoptionsX, visualsoption3Y)
    setTextSize('visualsoption3', 40 * 2)
    scaleObject('visualsoption3', 0.5, 0.5)
    setTextAlignment('visualsoption3', 'left')
    setTextBorder('visualsoption3', 5 * 2, '000000')
    setTextColor('visualsoption3', 'ffffff')
    setTextFont('visualsoption3', 'Kimberley.ttf')
    addLuaText('visualsoption3', false)
    setProperty('visualsoption3.x', controlsoptionsX - 1150)


        makeLuaText('visualsoption3MODIFIER', ' ?\n ', 600 * 2, modmodifierX, visualsoption3Y + bindsYoffset)
    setTextSize('visualsoption3MODIFIER', 40 * 2)
    scaleObject('visualsoption3MODIFIER', 0.5, 0.5)
    setTextAlignment('visualsoption3MODIFIER', 'center')
    setTextBorder('visualsoption3MODIFIER', 5 * 2, '000000')
    setTextColor('visualsoption3MODIFIER', 'ffffff')
    setTextFont('visualsoption3MODIFIER', 'Kimberley.ttf')
    addLuaText('visualsoption3MODIFIER', false)
    setProperty('visualsoption3MODIFIER.x', controlsoptionsX - 1150)

    --SUBTITLE
    optionssubtitle1Y = 550
    optionssubtitle1X = 340
        makeLuaText('optionssubtitle1', ' HIGHLY Recommended to turn on if you have a decent GPU\n ', 700 * 2, optionssubtitle1X, optionssubtitle1Y)
        --For potato PCs, removes some assets and flashy effects so the game can run better
        --HIGHLY recommended to leave at 60 if you don't want slow-downs
    setTextSize('optionssubtitle1', 40 * 2)
    scaleObject('optionssubtitle1', 0.5, 0.5)
    setTextAlignment('optionssubtitle1', 'center')
    setTextBorder('optionssubtitle1', 5 * 2, 'ffffff')
    setTextColor('optionssubtitle1', '000000')
    setTextFont('optionssubtitle1', 'Kimberley.ttf')
    addLuaText('optionssubtitle1', false)
    setProperty('optionssubtitle1.alpha', 0.5)
    setProperty('optionssubtitle1.y', optionssubtitle1Y + 200)

    pagecounterNUMY = 620
    pagecounterNUMX = 790
        makeLuaText('pagecounterNUM', ' Page 1/3\n ', 700 * 2, pagecounterNUMX, pagecounterNUMY)
    setTextSize('pagecounterNUM', 40 * 2)
    scaleObject('pagecounterNUM', 0.5, 0.5)
    setTextAlignment('pagecounterNUM', 'center')
    setTextBorder('pagecounterNUM', 5 * 2, 'ffffff')
    setTextColor('pagecounterNUM', '000000')
    setTextFont('pagecounterNUM', 'Kimberley.ttf')
    addLuaText('pagecounterNUM', false)
    setProperty('pagecounterNUM.alpha', 0.5)
    setProperty('pagecounterNUM.y', pagecounterNUMY + 200)
        --idfk

    makeLuaText('controlsoptionsub1', 'NOTES\n ', 600 * 2, controlsoptionsSUBX, controlsoptionsSUBY)
    setTextSize('controlsoptionsub1', 80 * 2)
    scaleObject('controlsoptionsub1', 0.5, 0.5)
    setTextAlignment('controlsoptionsub1', 'center')
    setTextBorder('controlsoptionsub1', 10 * 2, '000000')
    setTextColor('controlsoptionsub1', 'ffffff')
    setTextFont('controlsoptionsub1', 'Kimberley.ttf')
    addLuaText('controlsoptionsub1', false)
    setProperty('controlsoptionsub1.x', controlsoptionsSUBX + 1150)

    -- other
    makeLuaText('controlsoptionsub3', ' OTHER\n ', 600 * 2, controlsoptionsSUBX, controlsoptionsSUBY)
    setTextSize('controlsoptionsub3', 80 * 2)
    scaleObject('controlsoptionsub3', 0.5, 0.5)
    setTextAlignment('controlsoptionsub3', 'center')
    setTextBorder('controlsoptionsub3', 10 * 2, '000000')
    setTextColor('controlsoptionsub3', 'ffffff')
    setTextFont('controlsoptionsub3', 'Kimberley.ttf')
    addLuaText('controlsoptionsub3', false)
    setProperty('controlsoptionsub3.x', controlsoptionsSUBX + 1150)

    makeLuaText('controlsoptionB1', ' Pause\n ', 600 * 2, controlsoptionsX, controlsoptionB1Y)
    setTextSize('controlsoptionB1', 40 * 2)
    scaleObject('controlsoptionB1', 0.5, 0.5)
    setTextAlignment('controlsoptionB1', 'left')
    setTextBorder('controlsoptionB1', 5 * 2, '000000')
    setTextColor('controlsoptionB1', 'ffffff')
    setTextFont('controlsoptionB1', 'Kimberley.ttf')
    addLuaText('controlsoptionB1', false)
    setProperty('controlsoptionB1.x', controlsoptionsX - 1150)

    makeLuaText('controlsoptionB1BIND1', ' S\n ', 600 * 2, controlsoptionsX, controlsoptionB1Y + bindsYoffset)
    setTextSize('controlsoptionB1BIND1', 40 * 2)
    scaleObject('controlsoptionB1BIND1', 0.5, 0.5)
    setTextAlignment('controlsoptionB1BIND1', 'center')
    setTextBorder('controlsoptionB1BIND1', 5 * 2, '000000')
    setTextColor('controlsoptionB1BIND1', 'ffffff')
    setTextFont('controlsoptionB1BIND1', 'Kimberley.ttf')
    addLuaText('controlsoptionB1BIND1', false)
    setProperty('controlsoptionB1BIND1.x', controlsoptionsX - 1150)

    makeLuaText('controlsoptionB1BIND2', ' S\n ', 600 * 2, controlsoptionsX, controlsoptionB1Y + bindsYoffset)
    setTextSize('controlsoptionB1BIND2', 40 * 2)
    scaleObject('controlsoptionB1BIND2', 0.5, 0.5)
    setTextAlignment('controlsoptionB1BIND2', 'center')
    setTextBorder('controlsoptionB1BIND2', 5 * 2, '000000')
    setTextColor('controlsoptionB1BIND2', 'ffffff')
    setTextFont('controlsoptionB1BIND2', 'Kimberley.ttf')
    addLuaText('controlsoptionB1BIND2', false)
    setProperty('controlsoptionB1BIND2.x', controlsoptionsX - 1150)

    makeLuaText('controlsoptionB2', ' Toggle FPS Counter\n ', 600 * 2, controlsoptionsX, controlsoptionB2Y)
    setTextSize('controlsoptionB2', 40 * 2)
    scaleObject('controlsoptionB2', 0.5, 0.5)
    setTextAlignment('controlsoptionB2', 'left')
    setTextBorder('controlsoptionB2', 5 * 2, '000000')
    setTextColor('controlsoptionB2', 'ffffff')
    setTextFont('controlsoptionB2', 'Kimberley.ttf')
    addLuaText('controlsoptionB2', false)
    setProperty('controlsoptionB2.x', controlsoptionsX - 1150)

    makeLuaText('controlsoptionB2BIND1', ' S\n ', 600 * 2, controlsoptionsX, controlsoptionB2Y + bindsYoffset)
    setTextSize('controlsoptionB2BIND1', 40 * 2)
    scaleObject('controlsoptionB2BIND1', 0.5, 0.5)
    setTextAlignment('controlsoptionB2BIND1', 'center')
    setTextBorder('controlsoptionB2BIND1', 5 * 2, '000000')
    setTextColor('controlsoptionB2BIND1', 'ffffff')
    setTextFont('controlsoptionB2BIND1', 'Kimberley.ttf')
    addLuaText('controlsoptionB2BIND1', false)
    setProperty('controlsoptionB2BIND1.x', controlsoptionsX - 1150)

    makeLuaText('controlsoptionB2BIND2', ' S\n ', 600 * 2, controlsoptionsX, controlsoptionB2Y + bindsYoffset)
    setTextSize('controlsoptionB2BIND2', 40 * 2)
    scaleObject('controlsoptionB2BIND2', 0.5, 0.5)
    setTextAlignment('controlsoptionB2BIND2', 'center')
    setTextBorder('controlsoptionB2BIND2', 5 * 2, '000000')
    setTextColor('controlsoptionB2BIND2', 'ffffff')
    setTextFont('controlsoptionB2BIND2', 'Kimberley.ttf')
    addLuaText('controlsoptionB2BIND2', false)
    setProperty('controlsoptionB2BIND2.x', controlsoptionsX - 1150)

    makeLuaText('controlsoptionB3', ' Reset To Default\n ', 600 * 2, controlsoptionsX, controlsoptionB3Y)
    setTextSize('controlsoptionB3', 40 * 2)
    scaleObject('controlsoptionB3', 0.5, 0.5)
    setTextAlignment('controlsoptionB3', 'center')
    setTextBorder('controlsoptionB3', 5 * 2, '000000')
    setTextColor('controlsoptionB3', 'ffffff')
    setTextFont('controlsoptionB3', 'Kimberley.ttf')
    addLuaText('controlsoptionB3', false)
    setProperty('controlsoptionB3.x', controlsoptionsX - 1150)
    -- UI
    makeLuaText('controlsoptionsub2', 'UI\n ', 600 * 2, controlsoptionsSUBX, controlsoptionsSUBY)
    setTextSize('controlsoptionsub2', 80 * 2)
    scaleObject('controlsoptionsub2', 0.5, 0.5)
    setTextAlignment('controlsoptionsub2', 'center')
    setTextBorder('controlsoptionsub2', 10 * 2, '000000')
    setTextColor('controlsoptionsub2', 'ffffff')
    setTextFont('controlsoptionsub2', 'Kimberley.ttf')
    addLuaText('controlsoptionsub2', false)
    setProperty('controlsoptionsub2.x', controlsoptionsSUBX + 1150)

    makeLuaText('controlsoptionA1', ' Left\n ', 600 * 2, controlsoptionsX, controlsoptionA1Y)
    setTextSize('controlsoptionA1', 40 * 2)
    scaleObject('controlsoptionA1', 0.5, 0.5)
    setTextAlignment('controlsoptionA1', 'left')
    setTextBorder('controlsoptionA1', 5 * 2, '000000')
    setTextColor('controlsoptionA1', 'ffffff')
    setTextFont('controlsoptionA1', 'Kimberley.ttf')
    addLuaText('controlsoptionA1', false)
    setProperty('controlsoptionA1.x', controlsoptionsX - 1150)

    -- binds
    makeLuaText('controlsoptionA1BIND1', ' A\n ', 600 * 2, controlsoptionsX, controlsoptionA1Y + bindsYoffset)
    setTextSize('controlsoptionA1BIND1', 40 * 2)
    scaleObject('controlsoptionA1BIND1', 0.5, 0.5)
    setTextAlignment('controlsoptionA1BIND1', 'center')
    setTextBorder('controlsoptionA1BIND1', 5 * 2, '000000')
    setTextColor('controlsoptionA1BIND1', 'ffffff')
    setTextFont('controlsoptionA1BIND1', 'Kimberley.ttf')
    addLuaText('controlsoptionA1BIND1', false)
    setProperty('controlsoptionA1BIND1.x', controlsoptionsX - 1150)
    --
    makeLuaText('controlsoptionA1BIND2', ' Left\n ', 600 * 2, controlsoptionsX, controlsoptionA1Y + bindsYoffset)
    setTextSize('controlsoptionA1BIND2', 40 * 2)
    scaleObject('controlsoptionA1BIND2', 0.5, 0.5)
    setTextAlignment('controlsoptionA1BIND2', 'center')
    setTextBorder('controlsoptionA1BIND2', 5 * 2, '000000')
    setTextColor('controlsoptionA1BIND2', 'ffffff')
    setTextFont('controlsoptionA1BIND2', 'Kimberley.ttf')
    addLuaText('controlsoptionA1BIND2', false)
    setProperty('controlsoptionA1BIND2.x', controlsoptionsX - 1150)

    makeLuaText('controlsoptionA2', ' Down\n ', 600 * 2, controlsoptionsX, controlsoptionA2Y)
    setTextSize('controlsoptionA2', 40 * 2)
    scaleObject('controlsoptionA2', 0.5, 0.5)
    setTextAlignment('controlsoptionA2', 'left')
    setTextBorder('controlsoptionA2', 5 * 2, '000000')
    setTextColor('controlsoptionA2', 'ffffff')
    setTextFont('controlsoptionA2', 'Kimberley.ttf')
    addLuaText('controlsoptionA2', false)
    setProperty('controlsoptionA2.x', controlsoptionsX - 1150)

    -- binds
    makeLuaText('controlsoptionA2BIND1', ' S\n ', 600 * 2, controlsoptionsX, controlsoptionA2Y + bindsYoffset)
    setTextSize('controlsoptionA2BIND1', 40 * 2)
    scaleObject('controlsoptionA2BIND1', 0.5, 0.5)
    setTextAlignment('controlsoptionA2BIND1', 'center')
    setTextBorder('controlsoptionA2BIND1', 5 * 2, '000000')
    setTextColor('controlsoptionA2BIND1', 'ffffff')
    setTextFont('controlsoptionA2BIND1', 'Kimberley.ttf')
    addLuaText('controlsoptionA2BIND1', false)
    setProperty('controlsoptionA2BIND1.x', controlsoptionsX - 1150)
    --
    makeLuaText('controlsoptionA2BIND2', ' Down\n ', 600 * 2, controlsoptionsX, controlsoptionA2Y + bindsYoffset)
    setTextSize('controlsoptionA2BIND2', 40 * 2)
    scaleObject('controlsoptionA2BIND2', 0.5, 0.5)
    setTextAlignment('controlsoptionA2BIND2', 'center')
    setTextBorder('controlsoptionA2BIND2', 5 * 2, '000000')
    setTextColor('controlsoptionA2BIND2', 'ffffff')
    setTextFont('controlsoptionA2BIND2', 'Kimberley.ttf')
    addLuaText('controlsoptionA2BIND2', false)
    setProperty('controlsoptionA2BIND2.x', controlsoptionsX - 1150)

    makeLuaText('controlsoptionA3', ' Up\n ', 600 * 2, controlsoptionsX, controlsoptionA3Y)
    setTextSize('controlsoptionA3', 40 * 2)
    scaleObject('controlsoptionA3', 0.5, 0.5)
    setTextAlignment('controlsoptionA3', 'left')
    setTextBorder('controlsoptionA3', 5 * 2, '000000')
    setTextColor('controlsoptionA3', 'ffffff')
    setTextFont('controlsoptionA3', 'Kimberley.ttf')
    addLuaText('controlsoptionA3', false)
    setProperty('controlsoptionA3.x', controlsoptionsX - 1150)

    -- binds
    makeLuaText('controlsoptionA3BIND1', ' W\n ', 600 * 2, controlsoptionsX, controlsoptionA3Y + bindsYoffset)
    setTextSize('controlsoptionA3BIND1', 40 * 2)
    scaleObject('controlsoptionA3BIND1', 0.5, 0.5)
    setTextAlignment('controlsoptionA3BIND1', 'center')
    setTextBorder('controlsoptionA3BIND1', 5 * 2, '000000')
    setTextColor('controlsoptionA3BIND1', 'ffffff')
    setTextFont('controlsoptionA3BIND1', 'Kimberley.ttf')
    addLuaText('controlsoptionA3BIND1', false)
    setProperty('controlsoptionA3BIND1.x', controlsoptionsX - 1150)
    --
    makeLuaText('controlsoptionA3BIND2', ' Up\n ', 600 * 2, controlsoptionsX, controlsoptionA3Y + bindsYoffset)
    setTextSize('controlsoptionA3BIND2', 40 * 2)
    scaleObject('controlsoptionA3BIND2', 0.5, 0.5)
    setTextAlignment('controlsoptionA3BIND2', 'center')
    setTextBorder('controlsoptionA3BIND2', 5 * 2, '000000')
    setTextColor('controlsoptionA3BIND2', 'ffffff')
    setTextFont('controlsoptionA3BIND2', 'Kimberley.ttf')
    addLuaText('controlsoptionA3BIND2', false)
    setProperty('controlsoptionA3BIND2.x', controlsoptionsX - 1150)

    makeLuaText('controlsoptionA4', ' Right\n ', 600 * 2, controlsoptionsX, controlsoptionA4Y)
    setTextSize('controlsoptionA4', 40 * 2)
    scaleObject('controlsoptionA4', 0.5, 0.5)
    setTextAlignment('controlsoptionA4', 'left')
    setTextBorder('controlsoptionA4', 5 * 2, '000000')
    setTextColor('controlsoptionA4', 'ffffff')
    setTextFont('controlsoptionA4', 'Kimberley.ttf')
    addLuaText('controlsoptionA4', false)
    setProperty('controlsoptionA4.x', controlsoptionsX - 1150)

    -- binds
    makeLuaText('controlsoptionA4BIND1', ' D\n ', 600 * 2, controlsoptionsX, controlsoptionA4Y + bindsYoffset)
    setTextSize('controlsoptionA4BIND1', 40 * 2)
    scaleObject('controlsoptionA4BIND1', 0.5, 0.5)
    setTextAlignment('controlsoptionA4BIND1', 'center')
    setTextBorder('controlsoptionA4BIND1', 5 * 2, '000000')
    setTextColor('controlsoptionA4BIND1', 'ffffff')
    setTextFont('controlsoptionA4BIND1', 'Kimberley.ttf')
    addLuaText('controlsoptionA4BIND1', false)
    setProperty('controlsoptionA4BIND1.x', controlsoptionsX - 1150)
    --
    makeLuaText('controlsoptionA4BIND2', ' Right\n ', 600 * 2, controlsoptionsX, controlsoptionA4Y + bindsYoffset)
    setTextSize('controlsoptionA4BIND2', 40 * 2)
    scaleObject('controlsoptionA4BIND2', 0.5, 0.5)
    setTextAlignment('controlsoptionA4BIND2', 'center')
    setTextBorder('controlsoptionA4BIND2', 5 * 2, '000000')
    setTextColor('controlsoptionA4BIND2', 'ffffff')
    setTextFont('controlsoptionA4BIND2', 'Kimberley.ttf')
    addLuaText('controlsoptionA4BIND2', false)
    setProperty('controlsoptionA4BIND2.x', controlsoptionsX - 1150)

    makeLuaText('controlsoptionA5', ' Accept\n ', 600 * 2, controlsoptionsX, controlsoptionA5Y)
    setTextSize('controlsoptionA5', 40 * 2)
    scaleObject('controlsoptionA5', 0.5, 0.5)
    setTextAlignment('controlsoptionA5', 'left')
    setTextBorder('controlsoptionA5', 5 * 2, '000000')
    setTextColor('controlsoptionA5', 'ffffff')
    setTextFont('controlsoptionA5', 'Kimberley.ttf')
    addLuaText('controlsoptionA5', false)
    setProperty('controlsoptionA5.x', controlsoptionsX - 1150)

    -- binds
    makeLuaText('controlsoptionA5BIND1', ' Space\n ', 600 * 2, controlsoptionsX, controlsoptionA5Y + bindsYoffset)
    setTextSize('controlsoptionA5BIND1', 40 * 2)
    scaleObject('controlsoptionA5BIND1', 0.5, 0.5)
    setTextAlignment('controlsoptionA5BIND1', 'center')
    setTextBorder('controlsoptionA5BIND1', 5 * 2, '000000')
    setTextColor('controlsoptionA5BIND1', 'ffffff')
    setTextFont('controlsoptionA5BIND1', 'Kimberley.ttf')
    addLuaText('controlsoptionA5BIND1', false)
    setProperty('controlsoptionA5BIND1.x', controlsoptionsX - 1150)
    --
    makeLuaText('controlsoptionA5BIND2', ' Enter\n ', 600 * 2, controlsoptionsX, controlsoptionA5Y + bindsYoffset)
    setTextSize('controlsoptionA5BIND2', 40 * 2)
    scaleObject('controlsoptionA5BIND2', 0.5, 0.5)
    setTextAlignment('controlsoptionA5BIND2', 'center')
    setTextBorder('controlsoptionA5BIND2', 5 * 2, '000000')
    setTextColor('controlsoptionA5BIND2', 'ffffff')
    setTextFont('controlsoptionA5BIND2', 'Kimberley.ttf')
    addLuaText('controlsoptionA5BIND2', false)
    setProperty('controlsoptionA5BIND2.x', controlsoptionsX - 1150)

    makeLuaText('controlsoptionA6', ' Back\n ', 600 * 2, controlsoptionsX, controlsoptionA6Y)
    setTextSize('controlsoptionA6', 40 * 2)
    scaleObject('controlsoptionA6', 0.5, 0.5)
    setTextAlignment('controlsoptionA6', 'left')
    setTextBorder('controlsoptionA6', 5 * 2, '000000')
    setTextColor('controlsoptionA6', 'ffffff')
    setTextFont('controlsoptionA6', 'Kimberley.ttf')
    addLuaText('controlsoptionA6', false)
    setProperty('controlsoptionA6.x', controlsoptionsX - 1150)

    -- binds
    makeLuaText('controlsoptionA6BIND1', ' BckSpc\n ', 600 * 2, controlsoptionsX, controlsoptionA6Y + bindsYoffset)
    setTextSize('controlsoptionA6BIND1', 40 * 2)
    scaleObject('controlsoptionA6BIND1', 0.5, 0.5)
    setTextAlignment('controlsoptionA6BIND1', 'center')
    setTextBorder('controlsoptionA6BIND1', 5 * 2, '000000')
    setTextColor('controlsoptionA6BIND1', 'ffffff')
    setTextFont('controlsoptionA6BIND1', 'Kimberley.ttf')
    addLuaText('controlsoptionA6BIND1', false)
    setProperty('controlsoptionA6BIND1.x', controlsoptionsX - 1150)
    --
    makeLuaText('controlsoptionA6BIND2', ' Escape\n ', 600 * 2, controlsoptionsX, controlsoptionA6Y + bindsYoffset)
    setTextSize('controlsoptionA6BIND2', 40 * 2)
    scaleObject('controlsoptionA6BIND2', 0.5, 0.5)
    setTextAlignment('controlsoptionA6BIND2', 'center')
    setTextBorder('controlsoptionA6BIND2', 5 * 2, '000000')
    setTextColor('controlsoptionA6BIND2', 'ffffff')
    setTextFont('controlsoptionA6BIND2', 'Kimberley.ttf')
    addLuaText('controlsoptionA6BIND2', false)
    setProperty('controlsoptionA6BIND2.x', controlsoptionsX - 1150)

    -- OTHER

    makeLuaText('controlsoption1', ' Left\n ', 600 * 2, controlsoptionsX, controlsoption1Y)
    setTextSize('controlsoption1', 40 * 2)
    scaleObject('controlsoption1', 0.5, 0.5)
    setTextAlignment('controlsoption1', 'left')
    setTextBorder('controlsoption1', 5 * 2, '000000')
    setTextColor('controlsoption1', 'ffffff')
    setTextFont('controlsoption1', 'Kimberley.ttf')
    addLuaText('controlsoption1', false)
    setProperty('controlsoption1.x', controlsoptionsX - 1150)

    -- binds
    makeLuaText('controlsoption1BIND1', ' X\n ', 600 * 2, controlsoptionsX, controlsoption1Y + bindsYoffset)
    setTextSize('controlsoption1BIND1', 40 * 2)
    scaleObject('controlsoption1BIND1', 0.5, 0.5)
    setTextAlignment('controlsoption1BIND1', 'center')
    setTextBorder('controlsoption1BIND1', 5 * 2, '000000')
    setTextColor('controlsoption1BIND1', 'ffffff')
    setTextFont('controlsoption1BIND1', 'Kimberley.ttf')
    addLuaText('controlsoption1BIND1', false)
    setProperty('controlsoption1BIND1.x', controlsoptionsX - 1150)
    --
    makeLuaText('controlsoption1BIND2', ' X\n ', 600 * 2, controlsoptionsX, controlsoption1Y + bindsYoffset)
    setTextSize('controlsoption1BIND2', 40 * 2)
    scaleObject('controlsoption1BIND2', 0.5, 0.5)
    setTextAlignment('controlsoption1BIND2', 'center')
    setTextBorder('controlsoption1BIND2', 5 * 2, '000000')
    setTextColor('controlsoption1BIND2', 'ffffff')
    setTextFont('controlsoption1BIND2', 'Kimberley.ttf')
    addLuaText('controlsoption1BIND2', false)
    setProperty('controlsoption1BIND2.x', controlsoptionsX - 1150)

    controlsvisualsoffset = -100
    makeAnimatedLuaSprite('controlsoption1VISUAL', 'NOTE_assets-sonic', controlsoptionsX + controlsvisualsoffset,
        controlsoption1Y + 0)
    addAnimationByPrefix('controlsoption1VISUAL', 'note', 'arrowLEFT', 24, false)
    scaleObject('controlsoption1VISUAL', 0.5, 0.5)
    setObjectCamera('controlsoption1VISUAL', 'hud')
    addLuaSprite('controlsoption1VISUAL', true)
    setProperty('controlsoption1VISUAL.x', controlsoptionsX + controlsvisualsoffset - 1150)

    --
    makeLuaText('controlsoption2', ' Down\n ', 600 * 2, controlsoptionsX, controlsoption2Y)
    setTextSize('controlsoption2', 40 * 2)
    scaleObject('controlsoption2', 0.5, 0.5)
    setTextAlignment('controlsoption2', 'left')
    setTextBorder('controlsoption2', 5 * 2, '000000')
    setTextColor('controlsoption2', 'ffffff')
    setTextFont('controlsoption2', 'Kimberley.ttf')
    addLuaText('controlsoption2', false)
    setProperty('controlsoption2.x', controlsoptionsX - 1150)
    -- binds
    makeLuaText('controlsoption2BIND1', ' X\n ', 600 * 2, controlsoptionsX, controlsoption2Y + bindsYoffset)
    setTextSize('controlsoption2BIND1', 40 * 2)
    scaleObject('controlsoption2BIND1', 0.5, 0.5)
    setTextAlignment('controlsoption2BIND1', 'center')
    setTextBorder('controlsoption2BIND1', 5 * 2, '000000')
    setTextColor('controlsoption2BIND1', 'ffffff')
    setTextFont('controlsoption2BIND1', 'Kimberley.ttf')
    addLuaText('controlsoption2BIND1', false)
    setProperty('controlsoption2BIND1.x', controlsoptionsX - 1150)
    --
    makeLuaText('controlsoption2BIND2', ' X\n ', 600 * 2, controlsoptionsX, controlsoption2Y + bindsYoffset)
    setTextSize('controlsoption2BIND2', 40 * 2)
    scaleObject('controlsoption2BIND2', 0.5, 0.5)
    setTextAlignment('controlsoption2BIND2', 'center')
    setTextBorder('controlsoption2BIND2', 5 * 2, '000000')
    setTextColor('controlsoption2BIND2', 'ffffff')
    setTextFont('controlsoption2BIND2', 'Kimberley.ttf')
    addLuaText('controlsoption2BIND2', false)
    setProperty('controlsoption2BIND2.x', controlsoptionsX - 1150)

    makeAnimatedLuaSprite('controlsoption2VISUAL', 'NOTE_assets-sonic', controlsoptionsX + controlsvisualsoffset,
        controlsoption2Y)
    addAnimationByPrefix('controlsoption2VISUAL', 'note', 'arrowDOWN', 24, false)
    scaleObject('controlsoption2VISUAL', 0.5, 0.5)
    setObjectCamera('controlsoption2VISUAL', 'hud')
    addLuaSprite('controlsoption2VISUAL', true)
    setProperty('controlsoption2VISUAL.x', controlsoptionsX + controlsvisualsoffset - 1150)

    makeLuaText('controlsoption3', ' Up\n ', 600 * 2, controlsoptionsX, controlsoption3Y)
    setTextSize('controlsoption3', 40 * 2)
    scaleObject('controlsoption3', 0.5, 0.5)
    setTextAlignment('controlsoption3', 'left')
    setTextBorder('controlsoption3', 5 * 2, '000000')
    setTextColor('controlsoption3', 'ffffff')
    setTextFont('controlsoption3', 'Kimberley.ttf')
    addLuaText('controlsoption3', false)
    setProperty('controlsoption3.x', controlsoptionsX - 1150)
    -- binds
    makeLuaText('controlsoption3BIND1', ' X\n ', 600 * 2, controlsoptionsX, controlsoption3Y + bindsYoffset)
    setTextSize('controlsoption3BIND1', 40 * 2)
    scaleObject('controlsoption3BIND1', 0.5, 0.5)
    setTextAlignment('controlsoption3BIND1', 'center')
    setTextBorder('controlsoption3BIND1', 5 * 2, '000000')
    setTextColor('controlsoption3BIND1', 'ffffff')
    setTextFont('controlsoption3BIND1', 'Kimberley.ttf')
    addLuaText('controlsoption3BIND1', false)
    setProperty('controlsoption3BIND1.x', controlsoptionsX - 1150)
    --
    makeLuaText('controlsoption3BIND2', ' X\n ', 600 * 2, controlsoptionsX, controlsoption3Y + bindsYoffset)
    setTextSize('controlsoption3BIND2', 40 * 2)
    scaleObject('controlsoption3BIND2', 0.5, 0.5)
    setTextAlignment('controlsoption3BIND2', 'center')
    setTextBorder('controlsoption3BIND2', 5 * 2, '000000')
    setTextColor('controlsoption3BIND2', 'ffffff')
    setTextFont('controlsoption3BIND2', 'Kimberley.ttf')
    addLuaText('controlsoption3BIND2', false)
    setProperty('controlsoption3BIND2.x', controlsoptionsX - 1150)

    makeAnimatedLuaSprite('controlsoption3VISUAL', 'NOTE_assets-sonic', controlsoptionsX + controlsvisualsoffset,
        controlsoption3Y)
    addAnimationByPrefix('controlsoption3VISUAL', 'note', 'arrowUP', 24, false)
    scaleObject('controlsoption3VISUAL', 0.5, 0.5)
    setObjectCamera('controlsoption3VISUAL', 'hud')
    addLuaSprite('controlsoption3VISUAL', true)
    setProperty('controlsoption3VISUAL.x', controlsoptionsX + controlsvisualsoffset - 1150)

    makeLuaText('controlsoption4', ' Right\n ', 600 * 2, controlsoptionsX, controlsoption4Y)
    setTextSize('controlsoption4', 40 * 2)
    scaleObject('controlsoption4', 0.5, 0.5)
    setTextAlignment('controlsoption4', 'left')
    setTextBorder('controlsoption4', 5 * 2, '000000')
    setTextColor('controlsoption4', 'ffffff')
    setTextFont('controlsoption4', 'Kimberley.ttf')
    addLuaText('controlsoption4', false)
    setProperty('controlsoption4.x', controlsoptionsX - 1150)
    -- binds
    makeLuaText('controlsoption4BIND1', ' X\n ', 600 * 2, controlsoptionsX, controlsoption4Y + bindsYoffset)
    setTextSize('controlsoption4BIND1', 40 * 2)
    scaleObject('controlsoption4BIND1', 0.5, 0.5)
    setTextAlignment('controlsoption4BIND1', 'center')
    setTextBorder('controlsoption4BIND1', 5 * 2, '000000')
    setTextColor('controlsoption4BIND1', 'ffffff')
    setTextFont('controlsoption4BIND1', 'Kimberley.ttf')
    addLuaText('controlsoption4BIND1', false)
    setProperty('controlsoption4BIND1.x', controlsoptionsX - 1150)
    --
    makeLuaText('controlsoption4BIND2', ' X\n ', 600 * 2, controlsoptionsX, controlsoption4Y + bindsYoffset)
    setTextSize('controlsoption4BIND2', 40 * 2)
    scaleObject('controlsoption4BIND2', 0.5, 0.5)
    setTextAlignment('controlsoption4BIND2', 'center')
    setTextBorder('controlsoption4BIND2', 5 * 2, '000000')
    setTextColor('controlsoption4BIND2', 'ffffff')
    setTextFont('controlsoption4BIND2', 'Kimberley.ttf')
    addLuaText('controlsoption4BIND2', false)
    setProperty('controlsoption4BIND2.x', controlsoptionsX - 1150)

    makeAnimatedLuaSprite('controlsoption4VISUAL', 'NOTE_assets-sonic', controlsoptionsX + controlsvisualsoffset,
        controlsoption4Y)
    addAnimationByPrefix('controlsoption4VISUAL', 'note', 'arrowRIGHT', 24, false)
    scaleObject('controlsoption4VISUAL', 0.5, 0.5)
    setObjectCamera('controlsoption4VISUAL', 'hud')
    addLuaSprite('controlsoption4VISUAL', true)
    setProperty('controlsoption4VISUAL.x', controlsoptionsX + controlsvisualsoffset - 1150)

    makeLuaText('controlsoption5', ' Jump\n ', 600 * 2, controlsoptionsX, controlsoption5Y)
    setTextSize('controlsoption5', 40 * 2)
    scaleObject('controlsoption5', 0.5, 0.5)
    setTextAlignment('controlsoption5', 'left')
    setTextBorder('controlsoption5', 5 * 2, '000000')
    setTextColor('controlsoption5', 'ffffff')
    setTextFont('controlsoption5', 'Kimberley.ttf')
    addLuaText('controlsoption5', false)
    setProperty('controlsoption5.x', controlsoptionsX - 1150)
    -- binds
    makeLuaText('controlsoption5BIND1', ' Space\n ', 600 * 2, controlsoptionsX, controlsoption5Y + bindsYoffset)
    setTextSize('controlsoption5BIND1', 40 * 2)
    scaleObject('controlsoption5BIND1', 0.5, 0.5)
    setTextAlignment('controlsoption5BIND1', 'center')
    setTextBorder('controlsoption5BIND1', 5 * 2, '000000')
    setTextColor('controlsoption5BIND1', 'ffffff')
    setTextFont('controlsoption5BIND1', 'Kimberley.ttf')
    addLuaText('controlsoption5BIND1', false)
    setProperty('controlsoption5BIND1.x', controlsoptionsX - 1150)
    --
    makeLuaText('controlsoption5BIND2', ' - - -\n ', 600 * 2, controlsoptionsX, controlsoption5Y + bindsYoffset)
    setTextSize('controlsoption5BIND2', 40 * 2)
    scaleObject('controlsoption5BIND2', 0.5, 0.5)
    setTextAlignment('controlsoption5BIND2', 'center')
    setTextBorder('controlsoption5BIND2', 5 * 2, '000000')
    setTextColor('controlsoption5BIND2', 'ffffff')
    setTextFont('controlsoption5BIND2', 'Kimberley.ttf')
    addLuaText('controlsoption5BIND2', false)
    setProperty('controlsoption5BIND2.x', controlsoptionsX - 1150)

    makeAnimatedLuaSprite('controlsoption5VISUAL', 'NOTE_assets-sonic', controlsoptionsX + controlsvisualsoffset,
        controlsoption5Y)
    addAnimationByPrefix('controlsoption5VISUAL', 'note', 'SPACEKEY', 24, false)
    scaleObject('controlsoption5VISUAL', 0.5, 0.5)
    setObjectCamera('controlsoption5VISUAL', 'hud')
    addLuaSprite('controlsoption5VISUAL', true)
    setProperty('controlsoption5VISUAL.x', controlsoptionsX + controlsvisualsoffset - 1150)
    -- other options
    makeLuaText('modoption0', 'Downscroll\n ', 600 * 2, modoptionsX, modoption0Y)
    setTextSize('modoption0', 40 * 2)
    scaleObject('modoption0', 0.5, 0.5)
    setTextAlignment('modoption0', 'left')
    setTextBorder('modoption0', 5 * 2, '000000')
    setTextColor('modoption0', 'ffffff')
    setTextFont('modoption0', 'Kimberley.ttf')
    addLuaText('modoption0', false)
    setProperty('modoption0.x', modoptionsX - 1150)

    if downscrolldetect then
        makeLuaText('modoption0MODIFIER', 'ON\n ', 600 * 2, modmodifierX, modoption0Y)
    else
        makeLuaText('modoption0MODIFIER', 'OFF\n ', 600 * 2, modmodifierX, modoption0Y)
    end
    setTextSize('modoption0MODIFIER', 40 * 2)
    scaleObject('modoption0MODIFIER', 0.5, 0.5)
    setTextAlignment('modoption0MODIFIER', 'center')
    setTextBorder('modoption0MODIFIER', 5 * 2, '000000')
    setTextColor('modoption0MODIFIER', 1)
    setTextFont('modoption0MODIFIER', 'Kimberley.ttf')
    addLuaText('modoption0MODIFIER', false)
    setProperty('modoption0MODIFIER.x', modmodifierX - 1150)

    makeLuaText('modoption1', 'Player Note Underlay\n ', 600 * 2, modoptionsX, modoption1Y)
    setTextSize('modoption1', 40 * 2)
    scaleObject('modoption1', 0.5, 0.5)
    setTextAlignment('modoption1', 'left')
    setTextBorder('modoption1', 5 * 2, '000000')
    setTextColor('modoption1', 'ffffff')
    setTextFont('modoption1', 'Kimberley.ttf')
    addLuaText('modoption1', false)
    setProperty('modoption1.x', modoptionsX - 1150)

    makeLuaText('modoption1MODIFIER', '100%\n ', 600 * 2, modmodifierX, modoption1Y)
    setTextSize('modoption1MODIFIER', 40 * 2)
    scaleObject('modoption1MODIFIER', 0.5, 0.5)
    setTextAlignment('modoption1MODIFIER', 'center')
    setTextBorder('modoption1MODIFIER', 5 * 2, '000000')
    setTextColor('modoption1MODIFIER', 1)
    setTextFont('modoption1MODIFIER', 'Kimberley.ttf')
    addLuaText('modoption1MODIFIER', false)
    setProperty('modoption1MODIFIER.x', modmodifierX - 1150)

    makeLuaText('modoption2', 'Opponent Note Underlay\n ', 600 * 2, modoptionsX, modoption2Y)
    setTextSize('modoption2', 40 * 2)
    scaleObject('modoption2', 0.5, 0.5)
    setTextAlignment('modoption2', 'left')
    setTextBorder('modoption2', 5 * 2, '000000')
    setTextColor('modoption2', 'ffffff')
    setTextFont('modoption2', 'Kimberley.ttf')
    addLuaText('modoption2', false)
    setProperty('modoption2.x', modoptionsX - 1150)

    makeLuaText('modoption2MODIFIER', '100%\n ', 600 * 2, modmodifierX, modoption2Y)
    setTextSize('modoption2MODIFIER', 40 * 2)
    scaleObject('modoption2MODIFIER', 0.5, 0.5)
    setTextAlignment('modoption2MODIFIER', 'center')
    setTextBorder('modoption2MODIFIER', 5 * 2, '000000')
    setTextColor('modoption2MODIFIER', 1)
    setTextFont('modoption2MODIFIER', 'Kimberley.ttf')
    addLuaText('modoption2MODIFIER', false)
    setProperty('modoption2MODIFIER.x', modmodifierX - 1150)

    makeLuaText('modoption3', 'Little Buddy\n ', 600 * 2, modoptionsX, modoption3Y)
    setTextSize('modoption3', 40 * 2)
    scaleObject('modoption3', 0.5, 0.5)
    setTextAlignment('modoption3', 'left')
    setTextBorder('modoption3', 5 * 2, '000000')
    setTextColor('modoption3', 'ffffff')
    setTextFont('modoption3', 'Kimberley.ttf')
    addLuaText('modoption3', false)
    setProperty('modoption3.x', modoptionsX - 1150)

    makeLuaText('modoption3MODIFIER', 'ON\n ', 600 * 2, modmodifierX, modoption3Y)
    setTextSize('modoption3MODIFIER', 40 * 2)
    scaleObject('modoption3MODIFIER', 0.5, 0.5)
    setTextAlignment('modoption3MODIFIER', 'center')
    setTextBorder('modoption3MODIFIER', 5 * 2, '000000')
    setTextColor('modoption3MODIFIER', 1)
    setTextFont('modoption3MODIFIER', 'Kimberley.ttf')
    addLuaText('modoption3MODIFIER', false)
    setProperty('modoption3MODIFIER.x', modmodifierX - 1150)

    makeLuaText('modoption4', 'Little Opponent\n ', 600 * 2, modoptionsX, modoption4Y)
    setTextSize('modoption4', 40 * 2)
    scaleObject('modoption4', 0.5, 0.5)
    setTextAlignment('modoption4', 'left')
    setTextBorder('modoption4', 5 * 2, '000000')
    setTextColor('modoption4', 'ffffff')
    setTextFont('modoption4', 'Kimberley.ttf')
    addLuaText('modoption4', false)
    setProperty('modoption4.x', modoptionsX - 1150)

    makeLuaText('modoption4MODIFIER', 'ON\n ', 600 * 2, modmodifierX, modoption4Y)
    setTextSize('modoption4MODIFIER', 40 * 2)
    scaleObject('modoption4MODIFIER', 0.5, 0.5)
    setTextAlignment('modoption4MODIFIER', 'center')
    setTextBorder('modoption4MODIFIER', 5 * 2, '000000')
    setTextColor('modoption4MODIFIER', 1)
    setTextFont('modoption4MODIFIER', 'Kimberley.ttf')
    addLuaText('modoption4MODIFIER', false)
    setProperty('modoption4MODIFIER.x', modmodifierX - 1150)

    arrowleftOPX = modmodifierX + 200
    arrowrightOPX = modmodifierX + 360
    makeLuaSprite('OPTIONSleft', 'menus/optionsleft', arrowleftOPX, modoption1Y + 15)
    setObjectCamera('OPTIONSleft', 'camHUD')
    addLuaSprite('OPTIONSleft', true)
    setProperty('OPTIONSleft.alpha', 0)
    setProperty('OPTIONSleft.x', arrowleftOPX - 1150)
    makeLuaSprite('OPTIONSright', 'menus/optionsright', arrowrightOPX, modoption1Y + 15)
    setObjectCamera('OPTIONSright', 'camHUD')
    addLuaSprite('OPTIONSright', true)
    setProperty('OPTIONSright.alpha', 0)
    setProperty('OPTIONSright.x', arrowrightOPX - 1150)

    makeLuaSprite('rebindOverlay', nil, 0, 0)
    makeGraphic('rebindOverlay', screenWidth, screenHeight, '696682')
    setObjectCamera('rebindOverlay', 'camHUD')
    addLuaSprite('rebindOverlay', true)
    setBlendMode('rebindOverlay', 'multiply')
    setProperty('rebindOverlay.alpha', 0)

    makeLuaText('rebindTXT', ' Rebinding lol\n ', 800 * 2, 275, 200)
    setTextSize('rebindTXT', 60 * 2)
    scaleObject('rebindTXT', 0.5, 0.5)
    setTextAlignment('rebindTXT', 'center')
    setTextBorder('rebindTXT', 6 * 2, '000000')
    setTextColor('rebindTXT', 'ffffff')
    setTextFont('rebindTXT', 'Kimberley.ttf')
    addLuaText('rebindTXT', false)
    setProperty('rebindTXT.alpha', 0)


    makeLuaText('rebindTXT2', ' Press any key to rebind\n ', 600 * 2, 350, 400)
    setTextSize('rebindTXT2', 45 * 2)
    scaleObject('rebindTXT2', 0.5, 0.5)
    setTextAlignment('rebindTXT2', 'center')
    setTextBorder('rebindTXT2', 4 * 2, 'ffffff')
    setTextColor('rebindTXT2', '000000')
    setTextFont('rebindTXT2', 'Kimberley.ttf')
    addLuaText('rebindTXT2', false)
    setProperty('rebindTXT2.alpha', 0)

    makeAnimatedLuaSprite('BotonOptionsMobile', 'BotonAcceptMobile', 1150, 582)
    addAnimationByPrefix('BotonOptionsMobile', 'idle', 'BotonIdle', 24, true)
    addAnimationByPrefix('BotonOptionsMobile', 'pressed', 'BotonPressed', 24, false)
    setObjectCamera('BotonOptionsMobile', 'other')
    addLuaSprite('BotonOptionsMobile')

    -- open stuff
    optionsState = 'options'
    selectionsmodoptions = 0
    updateOptionPositions()

    setProperty('selectionOptions.alpha', 0.5)
    setProperty('option1.x', option1X)
    setProperty('option2.x', option2X)
    setProperty('option3.x', option3X)
    setProperty('option4.x', option4X)
    setProperty('OPTIONStxt.y', OPTIONStxtY)

    updateControlStrings()
end

function updateControlStrings()
    -- notes
    setTextString('controlsoption1BIND1', ' '..getKeybinds('note_left')[1]..'\n')
    setTextString('controlsoption1BIND2', ' '..getKeybinds('note_left')[2]..'\n')

    setTextString('controlsoption2BIND1', ' '..getKeybinds('note_down')[1]..'\n')
    setTextString('controlsoption2BIND2', ' '..getKeybinds('note_down')[2]..'\n')

    setTextString('controlsoption3BIND1', ' '..getKeybinds('note_up')[1]..'\n')
    setTextString('controlsoption3BIND2', ' '..getKeybinds('note_up')[2]..'\n')

    setTextString('controlsoption4BIND1', ' '..getKeybinds('note_right')[1]..'\n')
    setTextString('controlsoption4BIND2', ' '..getKeybinds('note_right')[2]..'\n')
    
    setTextString('controlsoption5BIND1', ' '..getKeybinds('jump')[1]..'\n')
    setTextString('controlsoption5BIND2', ' '..getKeybinds('jump')[2]..'\n')

    -- ui
    setTextString('controlsoptionA1BIND1', ' '..getKeybinds('ui_left')[1]..'\n')
    setTextString('controlsoptionA1BIND2', ' '..getKeybinds('ui_left')[2]..'\n')

    setTextString('controlsoptionA2BIND1', ' '..getKeybinds('ui_down')[1]..'\n')
    setTextString('controlsoptionA2BIND2', ' '..getKeybinds('ui_down')[2]..'\n')

    setTextString('controlsoptionA3BIND1', ' '..getKeybinds('ui_up')[1]..'\n')
    setTextString('controlsoptionA3BIND2', ' '..getKeybinds('ui_up')[2]..'\n')

    setTextString('controlsoptionA4BIND1', ' '..getKeybinds('ui_right')[1]..'\n')
    setTextString('controlsoptionA4BIND2', ' '..getKeybinds('ui_right')[2]..'\n')

    setTextString('controlsoptionA5BIND1', ' '..getKeybinds('accept')[1]..'\n')
    setTextString('controlsoptionA5BIND2', ' '..getKeybinds('accept')[2]..'\n')

    setTextString('controlsoptionA6BIND1', ' '..getKeybinds('back')[1]..'\n')
    setTextString('controlsoptionA6BIND2', ' '..getKeybinds('back')[2]..'\n')
    
    -- other
    setTextString('controlsoptionB1BIND1', ' '..getKeybinds('pause')[1]..'\n')
    setTextString('controlsoptionB1BIND2', ' '..getKeybinds('pause')[2]..'\n')

    setTextString('controlsoptionB2BIND1', ' '..getKeybinds('togglefps')[1]..'\n')
    setTextString('controlsoptionB2BIND2', ' '..getKeybinds('togglefps')[2]..'\n')
end

keyboardReverse = {}
for name, code in pairs(keyboard) do
    keyboardReverse[code] = name
end

function getKeybinds(id)
    local keys = getPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. id, true)

    if keys == nil or keys == null then
        return { "- - -", "- - -" }
    end

    local first = "- - -"
    local second = "- - -"

    if keys[1] ~= nil and keys[1] ~= null then
        first = keyboardReverse[math.floor(keys[1])] or tostring(keys[1])
    end
    if keys[2] ~= nil and keys[2] ~= null then
        second = keyboardReverse[math.floor(keys[2])] or tostring(keys[2])
    end

    return { first, second }
end

function getKeybindsNum(id)
    getPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. id, true)
end

function setKeybinds(id, value)
    setPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. id, value, true)
end

function onTweenCompleted(tag)
    if tag == 'squaresTopMove' then
        setProperty('squaresTop.x', -10)
        doTweenX('squaresTopMove', 'squaresTop', -77, squaresspeed)
    end
    if tag == 'squaresBottomMove' then
        setProperty('squaresBottom.x', -77)
        doTweenX('squaresBottomMove', 'squaresBottom', -10, squaresspeed)
    end
    if tag == 'optionsbgtween1' then
        setProperty('optionsbg.x', OPbgX)
        setProperty('optionsbg.y', OPbgY)
        doTweenX('optionsbgtween1', 'optionsbg', OPbgX - 300, bgspeed)
        doTweenY('optionsbgtween2', 'optionsbg', OPbgY - 300, bgspeed)
    end
end
function changeFPS(amount, isInitialPress)

    local oldFPS = tonumber(runHaxeCode([[
        return FlxG.drawFramerate;
    ]]))

    local newFPS = oldFPS + amount

    if newFPS > maxfpsallowed then newFPS = maxfpsallowed end
    if newFPS < minfpsallowed then newFPS = minfpsallowed end

    if newFPS ~= oldFPS then
        runHaxeCode([[
            ClientPrefs.data.framerate = ]] .. newFPS .. [[;
            FlxG.updateFramerate = ]] .. newFPS .. [[;
            FlxG.drawFramerate = ]] .. newFPS .. [[;
            ClientPrefs.saveSettings();
        ]])

        setProperty('visualsoption1MODIFIER.y', visualsoption1Y + bindsYoffset - 20)
        doTweenY('visualsoption1MODIFIERY', 'visualsoption1MODIFIER', visualsoption1Y + bindsYoffset, openeaseTime, 'expoOut')

        setTextString('visualsoption1MODIFIER', newFPS)

        playSound('miniscrollMenu', 0.7)

    elseif isInitialPress then
        playSound('errorMenu')
    end
end

function onUpdatePost(elapsed)
        if mouseClicked('left') and caninput then
            if getMouseX('other') > getProperty('backtxtt.x') and getMouseX('other') < getProperty('backtxtt.x') + getProperty('backtxtt.width') 
            and getMouseY('other') > getProperty('backtxtt.y') and getMouseY('other') < getProperty('backtxtt.y') + getProperty('backtxtt.height') then
                
                -- Misma lógica que cuando presionas la tecla BACK
                if optionsState == 'otheroptions' then
                    closeOtherOptions()
                    selectionoptions = 3
                    optionsState = 'options'
                    escTweenAnim()
                    playSound('cancelMenu', 0.8)
                    updateOptionPositions()
                    caninput = false
                    runTimer('resetinput', 0.01)
                    openNewOptions()
                    
                elseif optionsState == 'controlsoptions' then
                    closeControlsOptions()
                    selectionoptions = 1
                    optionsState = 'options'
                    escTweenAnim()
                    playSound('cancelMenu', 0.8)
                    updateOptionPositions()
                    caninput = false
                    runTimer('resetinput', 0.01)
                    openNewOptions()
                    
                elseif optionsState == 'visualsoptions' then
                    closeVisualsOptions()
                    selectionoptions = 2
                    optionsState = 'options'
                    escTweenAnim()
                    playSound('cancelMenu', 0.8)
                    updateOptionPositions()
                    caninput = false
                    runTimer('resetinput', 0.01)
                    openNewOptions()
                    
                elseif optionsState == 'options' then
                    caninput = false
                    soundFadeOut(nil, 0.4, 0) 
                    playSound('cancelMenu', 0.7)
                    setProperty('transInIndicator.x', 1)
                    runTimer('exitoptions', 0.8)
                end
            end
            
            if getMouseX('other') > getProperty('BotonOptionsMobile.x') and getMouseX('other') < getProperty('BotonOptionsMobile.x') + getProperty('BotonOptionsMobile.width') 
            and getMouseY('other') > getProperty('BotonOptionsMobile.y') and getMouseY('other') < getProperty('BotonOptionsMobile.y') + getProperty('BotonOptionsMobile.height') then
                playAnim('BotonOptionsMobile', 'pressed', true)
                runTimer('resetButtonAnim', 0.1)
                
                if optionsState == 'options' then
                    if selectionoptions ~= 4 then
                        playSound('confirmMenu', 0.8)
                        closeOptions()
                    end
                    updateOptionPositions()
                    if selectionoptions == 1 then
                        openControlOptions()
                        optionsState = 'controlsoptions'
                    elseif selectionoptions == 2 then
                        openVisualsOptions()
                        optionsState = 'visualsoptions'
                    elseif selectionoptions == 3 then
                        openOtherOptions()
                        optionsState = 'otheroptions'
                    elseif selectionoptions == 4 then
                        caninput = false
                        rebindKey()
                    end
                elseif optionsState == 'controlsoptions' and caninput then
                    caninput = false
                    rebindKey()
                end
            end
        end

    if controlspage == 3 and selectionscontrolsoptions == 3 then
        hoveringreset = true
    else
        hoveringreset = false
    end
    if getProperty('selectionOptions2.alpha') > 0 then
        setProperty('selectionOptions2.y', getProperty('selectionOptions.y') - 10)
    end
    setProperty('cursor.x', getMouseX('other'))
    setProperty('cursor.y', getMouseY('other'))
    if caninput then
        if keyJustPressed('BACK') and optionsState == 'options' then
            caninput = false
            soundFadeOut(nil, 0.4, 0) 
            playSound('cancelMenu', 0.7)
            setProperty('transInIndicator.x', 1)
            runTimer('exitoptions', 0.8)
        end
        if mouseClicked('left') and caninput then
        if getMouseX('other') > getProperty('backtxtt.x') and getMouseX('other') < getProperty('backtxtt.x') + getProperty('backtxtt.width') 
        and getMouseY('other') > getProperty('backtxtt.y') and getMouseY('other') < getProperty('backtxtt.y') + getProperty('backtxtt.height') then
            
            if optionsState == 'options' then
                caninput = false
                soundFadeOut(nil, 0.4, 0) 
                playSound('cancelMenu', 0.7)
                setProperty('transInIndicator.x', 1)
                runTimer('exitoptions', 0.8)
            end
        end
      end
    end
    --if keyboardJustPressed('R') then
    --    restartSong()
    --end
    if curMenu == 'options' then
        if optionsState == 'visualsoptions' then
            if caninput then
                if keyPressed('right') then
                    setProperty('OPTIONSright.scale.x', 0.6)
                    doTweenX('OPTIONSrightsize', 'OPTIONSright.scale', 1, scrollSpeed, 'expoOut')

                    setProperty('OPTIONSright.scale.y', 0.6)
                    doTweenY('OPTIONSrightsize2', 'OPTIONSright.scale', 1, scrollSpeed, 'expoOut')
                elseif keyPressed('left') then
                    setProperty('OPTIONSleft.scale.x', 0.6)
                    doTweenX('OPTIONSleftsize', 'OPTIONSleft.scale', 1, scrollSpeed, 'expoOut')

                    setProperty('OPTIONSleft.scale.y', 0.6)
                    doTweenY('OPTIONSleftsize2', 'OPTIONSleft.scale', 1, scrollSpeed, 'expoOut')
                end
                if selectionsvisualsoptions == 1 then
                    -- RIGHT
                    if keyPressed('right') then
                        rightHoldTime = rightHoldTime + elapsed
                    
                        if keyJustPressed('right') then
                            changeFPS(1, true)
                    
                        elseif rightHoldTime > repeatDelay and rightHoldTime % repeatRate < elapsed then
                            changeFPS(1, false)
                        end
                    else
                        rightHoldTime = 0
                    end
                    --left
                    if keyPressed('left') then
                        leftHoldTime = leftHoldTime + elapsed
                    
                        if keyJustPressed('left') then
                            changeFPS(-1, true)
                    
                        elseif leftHoldTime > repeatDelay and leftHoldTime % repeatRate < elapsed then
                            changeFPS(-1, false)
                        end
                    else
                        leftHoldTime = 0
                    end
                elseif selectionsvisualsoptions == 3 then
                    if keyJustPressed('left') or keyJustPressed('right') then
                        lowQ = runHaxeCode([[
                            return ClientPrefs.data.lowQuality;
                         ]])
                        if lowQ then
                        setTextString('visualsoption3MODIFIER', 'OFF')
                            playSound('scrollMenu')
                            runHaxeCode([[
                            ClientPrefs.data.lowQuality = false;
                            ClientPrefs.saveSettings();
                        ]])
                        
                        else
                            setTextString('visualsoption3MODIFIER', 'ON')
                            playSound('scrollMenu')
                            runHaxeCode([[
                                ClientPrefs.data.lowQuality = true;
                                ClientPrefs.saveSettings();
                            ]])
                        end
                        setProperty('visualsoption3MODIFIER.y', visualsoption3Y + bindsYoffset - 20)
                        doTweenY('visualsoption3MODIFIERY', 'visualsoption3MODIFIER', visualsoption3Y + bindsYoffset, openeaseTime, 'expoOut')
                    end
                elseif selectionsvisualsoptions == 2 then
                    if keyJustPressed('left') or keyJustPressed('right') then
                        caching = runHaxeCode([[
                            return ClientPrefs.data.cacheOnGPU;
                         ]])
                        if caching then
                        setTextString('visualsoption2MODIFIER', 'OFF')
                            playSound('scrollMenu')
                            runHaxeCode([[
                            ClientPrefs.data.cacheOnGPU = false;
                            ClientPrefs.saveSettings();
                        ]])
                        
                        else
                            setTextString('visualsoption2MODIFIER', 'ON')
                            playSound('scrollMenu')
                            runHaxeCode([[
                                ClientPrefs.data.cacheOnGPU = true;
                                ClientPrefs.saveSettings();
                            ]])
                        end
                        setProperty('visualsoption2MODIFIER.y', visualsoption2Y + bindsYoffset - 20)
                        doTweenY('visualsoption2MODIFIERY', 'visualsoption2MODIFIER', visualsoption2Y + bindsYoffset, openeaseTime, 'expoOut')
                    end
                end
            end
        end
        if optionsState == 'otheroptions' then
            littlebuddyX = getDataFromSave('globalsave', 'littlebuddyX', 800)
            littlebuddyY = getDataFromSave('globalsave', 'littlebuddyY', 380)

            littleopponentX = getDataFromSave('globalsave', 'littleopponentX', 350)
            littleopponentY = getDataFromSave('globalsave', 'littleopponentY', 380)
            -- little buddies dragging
            if not mousePressed('left') then
                dragging = false
                draggingplayer = false
                draggingopponent = false
                PLAYERoffsetX = getMouseX('hud') - littlebuddyX
                PLAYERoffsetY = getMouseY('hud') - littlebuddyY
                OPPONENToffsetX = getMouseX('hud') - littleopponentX
                OPPONENToffsetY = getMouseY('hud') - littleopponentY
                if getDataFromSave('globalsave', 'littlebuddy', 'OFF') == 'ON' then
                end
                if getDataFromSave('globalsave', 'littleopponent', 'OFF') == 'ON' then
                end
            elseif mousePressed('left') then
                dragging = true
                mouseOffsetX = getMouseX('hud')
                mouseOffsetY = getMouseY('hud')
            end
            if dragging then
                setDataFromSave('globalsave', 'littlebuddyX', getProperty('littlebuddy.x'))
                setDataFromSave('globalsave', 'littlebuddyY', getProperty('littlebuddy.y'))
                setDataFromSave('globalsave', 'littleopponentX', getProperty('littleopponent.x'))
                setDataFromSave('globalsave', 'littleopponentY', getProperty('littleopponent.y'))
            else
            end

            if not draggingopponent and
                callMethodFromClass('flixel.FlxG', 'mouse.overlaps', { instanceArg('littlebuddy'), instanceArg('camHUD') }) and
                dragging then
                draggingplayer = true
                setProperty('littlebuddy.x', mouseOffsetX - PLAYERoffsetX)
                setProperty('littlebuddy.y', mouseOffsetY - PLAYERoffsetY)
            end

            if not draggingplayer and
                callMethodFromClass('flixel.FlxG', 'mouse.overlaps',
                    { instanceArg('littleopponent'), instanceArg('camHUD') }) and dragging then
                draggingopponent = true
                setProperty('littleopponent.x', mouseOffsetX - OPPONENToffsetX)
                setProperty('littleopponent.y', mouseOffsetY - OPPONENToffsetY)
            end

            bfUnderlayAlpha = getDataFromSave('globalsave', 'bfUnderlayAlpha', 0) / 100
            dadUnderlayAlpha = getDataFromSave('globalsave', 'dadUnderlayAlpha', 0) / 100
            
            doTweenAlpha('BFNOTESALPHA', 'bfnotesUnderlay', 1 * bfUnderlayAlpha, openeaseTime, 'expoOut')
            doTweenAlpha('DADNOTESALPHA', 'dadnotesUnderlay', 1 * dadUnderlayAlpha, openeaseTime, 'expoOut')
            if caninput then
                if keyJustPressed('right') or keyJustPressed('left') then
                    if selectionsmodoptions == 0 then
                        setProperty('modoption0MODIFIER.y', modoption0Y - 8)
                        doTweenY('modoption0change', 'modoption0MODIFIER', modoption0Y, scrollSpeed, easetype)
                        playSound('scrollMenu', 0.8)
                        if getPropertyFromClass('backend.ClientPrefs', 'data.downScroll') then
                            downscrolldetect = false
                            setTextString('modoption0MODIFIER', 'OFF\n ')
                            local current = getPropertyFromClass('backend.ClientPrefs', 'data.downScroll')
                            setPropertyFromClass('backend.ClientPrefs', 'data.downScroll', not current)
                            runHaxeCode([[
    import backend.ClientPrefs;
    ClientPrefs.saveSettings();
]])
    
                            for i = 1, 8 do
                                doTweenY('NOTEZ' .. i .. 'TWEEN', 'NOTEZ' .. i, upscrollY,openeaseTime, 'expoOut')
                                    
                                doTweenY('NOTEZ' .. i .. 'TWEEN', 'NOTEZ' .. i, upscrollY, openeaseTime, 'expoOut')
                            end
                            doTweenY('MODOPTIONSWITCH', 'MODOPTIONStxt', OPTIONStxtY + 500, openeaseTime, 'expoOut')
                        else
                            downscrolldetect = true
                            setTextString('modoption0MODIFIER', 'ON\n ')
                            local current = getPropertyFromClass('backend.ClientPrefs', 'data.downScroll')
                            setPropertyFromClass('backend.ClientPrefs', 'data.downScroll', not current)
                            runHaxeCode([[
    import backend.ClientPrefs;
    ClientPrefs.saveSettings();
]])
    
                            for i = 1, 8 do
                                doTweenY('NOTEZ' .. i .. 'TWEEN', 'NOTEZ' .. i, dowscrollY,openeaseTime, 'expoOut')
                                    
                                doTweenY('NOTEZ' .. i .. 'TWEEN', 'NOTEZ' .. i, dowscrollY, openeaseTime, 'expoOut')
                            end
                            doTweenY('MODOPTIONSWITCH', 'MODOPTIONStxt', OPTIONStxtY, openeaseTime, 'expoOut')
                        end
                    end
                end
            end
            if caninput then
                if keyPressed('right') then
                    setProperty('OPTIONSright.scale.x', 0.6)
                    doTweenX('OPTIONSrightsize', 'OPTIONSright.scale', 1, scrollSpeed, 'expoOut')

                    setProperty('OPTIONSright.scale.y', 0.6)
                    doTweenY('OPTIONSrightsize2', 'OPTIONSright.scale', 1, scrollSpeed, 'expoOut')
                elseif keyPressed('left') then
                    setProperty('OPTIONSleft.scale.x', 0.6)
                    doTweenX('OPTIONSleftsize', 'OPTIONSleft.scale', 1, scrollSpeed, 'expoOut')

                    setProperty('OPTIONSleft.scale.y', 0.6)
                    doTweenY('OPTIONSleftsize2', 'OPTIONSleft.scale', 1, scrollSpeed, 'expoOut')
                end
            end
            if keyJustPressed('right') and caninput then
                updateOptionPositions()
                if selectionsmodoptions == 1 then
                    if getDataFromSave('globalsave', 'bfUnderlayAlpha') ~= nil then
                        if getDataFromSave('globalsave', 'bfUnderlayAlpha', 0) < 100 then
                            setProperty('modoption1MODIFIER.y', modoption1Y - 8)
                            doTweenY('modoption1change', 'modoption1MODIFIER', modoption1Y, scrollSpeed, easetype)
                            playSound('scrollMenu', 0.8)
                            setDataFromSave('globalsave', 'bfUnderlayAlpha',
                                getDataFromSave('globalsave', 'bfUnderlayAlpha', 0) + 10)
                        else
                            playSound('errorMenu', 0.8)
                        end
                    else
                        setDataFromSave('globalsave', 'bfUnderlayAlpha', 10)
                    end
                elseif selectionsmodoptions == 2 then
                    if getDataFromSave('globalsave', 'dadUnderlayAlpha') ~= nil then
                        if getDataFromSave('globalsave', 'dadUnderlayAlpha', 0) < 100 then
                            setProperty('modoption2MODIFIER.y', modoption2Y - 8)
                            doTweenY('modoption2change', 'modoption2MODIFIER', modoption2Y, scrollSpeed, easetype)
                            playSound('scrollMenu', 0.8)
                            setDataFromSave('globalsave', 'dadUnderlayAlpha',
                                getDataFromSave('globalsave', 'dadUnderlayAlpha', 0) + 10)
                        else
                            playSound('errorMenu', 0.8)
                        end
                    else
                        setDataFromSave('globalsave', 'dadUnderlayAlpha', 10)
                    end
                elseif selectionsmodoptions == 3 then
                    setProperty('modoption3MODIFIER.y', modoption3Y - 8)
                    doTweenY('modoption3change', 'modoption3MODIFIER', modoption3Y, scrollSpeed, easetype)
                    playSound('scrollMenu', 0.8)
                    if getDataFromSave('globalsave', 'littleplayer') ~= nil then
                        if getDataFromSave('globalsave', 'littleplayer', 'OFF') == 'OFF' then
                            setProperty('littlebuddy.alpha', 1)
                            setProperty('littlebuddy.scale.x', 1.1, 1.1)
                            doTweenX('littlebuddySIZE', 'littlebuddy.scale', 1, openeaseTime, 'expoOut')
                            setProperty('littlebuddy.scale.y', 1.1, 1.1)
                            doTweenY('littlebuddySIZE2', 'littlebuddy.scale', 1, openeaseTime, 'expoOut')
                            setDataFromSave('globalsave', 'littleplayer', 'ON')
                        else
                            setProperty('littlebuddy.alpha', 0)
                            setDataFromSave('globalsave', 'littleplayer', 'OFF')

                            setProperty('littlebuddy.x', defaultBUDDYX)
                            setProperty('littlebuddy.y', defaultBUDDYY)
                            setDataFromSave('globalsave', 'littlebuddyX', defaultBUDDYX)
                            setDataFromSave('globalsave', 'littlebuddyY', defaultBUDDYY)
                        end
                    else
                        setProperty('littlebuddy.alpha', 1)
                        setProperty('littlebuddy.scale.x', 1.1, 1.1)
                        doTweenX('littlebuddySIZE', 'littlebuddy.scale', 1, openeaseTime, 'expoOut')
                        setProperty('littlebuddy.scale.y', 1.1, 1.1)
                        doTweenY('littlebuddySIZE2', 'littlebuddy.scale', 1, openeaseTime, 'expoOut')
                        setDataFromSave('globalsave', 'littleplayer', 'ON')
                    end
                elseif selectionsmodoptions == 4 then
                    setProperty('modoption4MODIFIER.y', modoption4Y - 8)
                    doTweenY('modoption4change', 'modoption4MODIFIER', modoption4Y, scrollSpeed, easetype)
                    playSound('scrollMenu', 0.8)
                    if getDataFromSave('globalsave', 'littleopponent') ~= nil then
                        if getDataFromSave('globalsave', 'littleopponent', 'OFF') == 'OFF' then
                            setProperty('littleopponent.alpha', 1)
                            setProperty('littleopponent.scale.x', 1.1, 1.1)
                            doTweenX('littleopponentSIZE', 'littleopponent.scale', 1, openeaseTime, 'expoOut')
                            setProperty('littleopponent.scale.y', 1.1, 1.1)
                            doTweenY('littleopponentSIZE2', 'littleopponent.scale', 1, openeaseTime, 'expoOut')
                            setDataFromSave('globalsave', 'littleopponent', 'ON')
                        else
                            setProperty('littleopponent.alpha', 0)
                            setDataFromSave('globalsave', 'littleopponent', 'OFF')
                            setProperty('littleopponent.x', DEFAULTOPPONENTX)
                            setProperty('littleopponent.y', defaultBUDDYY)
                            setDataFromSave('globalsave', 'littleopponentX', DEFAULTOPPONENTX)
                            setDataFromSave('globalsave', 'littleopponentY', defaultBUDDYY)
                        end
                    else
                        setProperty('littleopponent.alpha', 1)
                        setProperty('littleopponent.scale.x', 1.1, 1.1)
                        doTweenX('littleopponentSIZE', 'littleopponent.scale', 1, openeaseTime, 'expoOut')
                        setProperty('littleopponent.scale.y', 1.1, 1.1)
                        doTweenY('littleopponentSIZE2', 'littleopponent.scale', 1, openeaseTime, 'expoOut')
                        setDataFromSave('globalsave', 'littleopponent', 'ON')
                    end
                end
            elseif keyJustPressed('left') and caninput then
                setProperty('OPTIONSleft.scale.x', 0.6)
                doTweenX('OPTIONSleftsize', 'OPTIONSleft.scale', 1, scrollSpeed, 'expoOut')
                setProperty('OPTIONSleft.scale.y', 0.6)
                doTweenY('OPTIONSleftsize2', 'OPTIONSleft.scale', 1, scrollSpeed, 'expoOut')
                updateOptionPositions()
                if selectionsmodoptions == 1 then
                    if getDataFromSave('globalsave', 'bfUnderlayAlpha') ~= nil then
                        if getDataFromSave('globalsave', 'bfUnderlayAlpha', 0) > 0 then
                            setProperty('modoption1MODIFIER.y', modoption1Y - 8)
                            doTweenY('modoption1change', 'modoption1MODIFIER', modoption1Y, scrollSpeed, easetype)
                            playSound('scrollMenu', 0.8)
                            setDataFromSave('globalsave', 'bfUnderlayAlpha',
                                getDataFromSave('globalsave', 'bfUnderlayAlpha', 0) - 10)
                        else
                            playSound('errorMenu', 0.8)
                        end
                    else
                        setDataFromSave('globalsave', 'bfUnderlayAlpha', 0)
                    end
                elseif selectionsmodoptions == 2 then
                    if getDataFromSave('globalsave', 'dadUnderlayAlpha') ~= nil then
                        if getDataFromSave('globalsave', 'dadUnderlayAlpha', 0) > 0 then
                            setProperty('modoption2MODIFIER.y', modoption2Y - 8)
                            doTweenY('modoption2change', 'modoption2MODIFIER', modoption2Y, scrollSpeed, easetype)
                            playSound('scrollMenu', 0.8)
                            setDataFromSave('globalsave', 'dadUnderlayAlpha',
                                getDataFromSave('globalsave', 'dadUnderlayAlpha', 0) - 10)
                        else
                            playSound('errorMenu', 0.8)
                        end
                    else
                        setDataFromSave('globalsave', 'dadUnderlayAlpha', 0)
                    end
                elseif selectionsmodoptions == 3 then
                    setProperty('modoption3MODIFIER.y', modoption3Y - 8)
                    doTweenY('modoption3change', 'modoption3MODIFIER', modoption3Y, scrollSpeed, easetype)
                    playSound('scrollMenu', 0.8)
                    if getDataFromSave('globalsave', 'littleplayer') ~= nil then
                        if getDataFromSave('globalsave', 'littleplayer', 'OFF') == 'OFF' then
                            setProperty('littlebuddy.alpha', 1)
                            setProperty('littlebuddy.scale.x', 1.1, 1.1)
                            doTweenX('littlebuddySIZE', 'littlebuddy.scale', 1, openeaseTime, 'expoOut')
                            setProperty('littlebuddy.scale.y', 1.1, 1.1)
                            doTweenY('littlebuddySIZE2', 'littlebuddy.scale', 1, openeaseTime, 'expoOut')
                            setDataFromSave('globalsave', 'littleplayer', 'ON')
                        else
                            setProperty('littlebuddy.alpha', 0)
                            setDataFromSave('globalsave', 'littleplayer', 'OFF')
                            setProperty('littlebuddy.x', defaultBUDDYX)
                            setProperty('littlebuddy.y', defaultBUDDYY)
                            setDataFromSave('globalsave', 'littlebuddyX', defaultBUDDYX)
                            setDataFromSave('globalsave', 'littlebuddyY', defaultBUDDYY)
                        end
                    else
                        setProperty('littlebuddy.alpha', 1)
                        setProperty('littlebuddy.scale.x', 1.1, 1.1)
                        doTweenX('littlebuddySIZE', 'littlebuddy.scale', 1, openeaseTime, 'expoOut')
                        setProperty('littlebuddy.scale.y', 1.1, 1.1)
                        doTweenY('littlebuddySIZE2', 'littlebuddy.scale', 1, openeaseTime, 'expoOut')
                        setDataFromSave('globalsave', 'littleplayer', 'ON')
                    end
                elseif selectionsmodoptions == 4 then
                    setProperty('modoption4MODIFIER.y', modoption4Y - 8)
                    doTweenY('modoption4change', 'modoption4MODIFIER', modoption4Y, scrollSpeed, easetype)
                    playSound('scrollMenu', 0.8)
                    if getDataFromSave('globalsave', 'littleopponent') ~= nil then
                        if getDataFromSave('globalsave', 'littleopponent', 'OFF') == 'OFF' then
                            setProperty('littleopponent.alpha', 1)
                            setProperty('littleopponent.scale.x', 1.1, 1.1)
                            doTweenX('littleopponentSIZE', 'littleopponent.scale', 1, openeaseTime, 'expoOut')
                            setProperty('littleopponent.scale.y', 1.1, 1.1)
                            doTweenY('littleopponentSIZE2', 'littleopponent.scale', 1, openeaseTime, 'expoOut')
                            setDataFromSave('globalsave', 'littleopponent', 'ON')
                        else
                            setProperty('littleopponent.alpha', 0)
                            setDataFromSave('globalsave', 'littleopponent', 'OFF')
                            setProperty('littleopponent.x', DEFAULTOPPONENTX)
                            setProperty('littleopponent.y', defaultBUDDYY)
                            setDataFromSave('globalsave', 'littleopponentX', DEFAULTOPPONENTX)
                            setDataFromSave('globalsave', 'littleopponentY', defaultBUDDYY)
                        end
                    else
                        setProperty('littleopponent.alpha', 1)
                        setProperty('littleopponent.scale.x', 1.1, 1.1)
                        doTweenX('littleopponentSIZE', 'littleopponent.scale', 1, openeaseTime, 'expoOut')
                        setProperty('littleopponent.scale.y', 1.1, 1.1)
                        doTweenY('littleopponentSIZE2', 'littleopponent.scale', 1, openeaseTime, 'expoOut')
                        setDataFromSave('globalsave', 'littleopponent', 'ON')
                    end
                end
            end
        elseif optionsState == 'controlsoptions' and caninput then
            if keyJustPressed('ACCEPT') then
                caninput = false
                rebindKey()
            end
        end

        setTextString('modoption1MODIFIER', getDataFromSave('globalsave', 'bfUnderlayAlpha', 0) .. '%\n ')
        setTextString('modoption2MODIFIER', getDataFromSave('globalsave', 'dadUnderlayAlpha', 0) .. '%\n ')

        setTextString('modoption3MODIFIER', getDataFromSave('globalsave', 'littleplayer', 'OFF') .. '\n ')
        setTextString('modoption4MODIFIER', getDataFromSave('globalsave', 'littleopponent', 'OFF') .. '\n ')
        --
        -- debugPrint(selectionscontrolsoptions)
        if keyJustPressed('left') and caninput then
            if optionsState == 'controlsoptions' then
                bindselection = bindselection - 1
                playSound('scrollMenu', 0.8)
                updateOptionPositions()
            end
        end
        if keyJustPressed('right') and caninput then
            if optionsState == 'controlsoptions' then
                bindselection = bindselection + 1
                playSound('scrollMenu', 0.8)
                updateOptionPositions()
            end
        end
        if caninput and optionsState == 'controlsoptions' then
            if keyJustPressed('right') or keyJustPressed('left') then
                if bindselection > 2 then
                    controlspage = controlspage + 1
                    pagechanged = true
                    -- nextpage
                    bindselection = 1
                elseif bindselection < 1 then
                    controlspage = controlspage - 1
                    pagechanged = true
                    -- previouspage
                    bindselection = 2
                end
                if controlspage > 3 then
                    controlspage = 1
                elseif controlspage < 1 then
                    controlspage = 3
                end
                updateOptionPositions()
            end
        end
        --
        if keyJustPressed('down') and caninput then
            if optionsState == 'options' then
                selectionoptions = selectionoptions + 1
            elseif optionsState == 'otheroptions' then
                selectionsmodoptions = selectionsmodoptions + 1
            elseif optionsState == 'controlsoptions' then
                selectionscontrolsoptions = selectionscontrolsoptions + 1
            elseif optionsState == 'visualsoptions' then
                selectionsvisualsoptions = selectionsvisualsoptions + 1
            end
            playSound('scrollMenu', 0.8)
            --
            if selectionoptions > 4 then
                selectionoptions = 1
            elseif selectionoptions < 1 then
                selectionoptions = 4
            end

            
            if selectionsvisualsoptions > 2 then
                selectionsvisualsoptions = 1
            elseif selectionsvisualsoptions < 1 then
                selectionsvisualsoptions = 2
            end
            -- controlsop

            if controlspage == 1 then
                if selectionscontrolsoptions > 5 then
                    selectionscontrolsoptions = 1
                elseif selectionscontrolsoptions < 1 then
                    selectionscontrolsoptions = 5
                end
            elseif controlspage == 2 then
                if selectionscontrolsoptions > 6 then
                    selectionscontrolsoptions = 1
                elseif selectionscontrolsoptions < 1 then
                    selectionscontrolsoptions = 6
                end
            elseif controlspage == 3 then
                if selectionscontrolsoptions > 3 then
                    selectionscontrolsoptions = 1
                elseif selectionscontrolsoptions < 1 then
                    selectionscontrolsoptions = 3
                end
            end
            -- otherop
            if selectionsmodoptions > 4 then
                selectionsmodoptions = 0
            elseif selectionsmodoptions < 0 then
                selectionsmodoptions = 4
            end
            updateOptionPositions()
        elseif keyJustPressed('up') and caninput then
            if optionsState == 'options' then
                selectionoptions = selectionoptions - 1
            elseif optionsState == 'otheroptions' then
                selectionsmodoptions = selectionsmodoptions - 1
            elseif optionsState == 'controlsoptions' then
                selectionscontrolsoptions = selectionscontrolsoptions - 1
            elseif optionsState == 'visualsoptions' then
                selectionsvisualsoptions = selectionsvisualsoptions - 1
            end
            playSound('scrollMenu', 0.8)

            if selectionoptions > 4 then
                selectionoptions = 1
            elseif selectionoptions < 1 then
                selectionoptions = 4
            end

            if selectionsvisualsoptions > 2 then
                selectionsvisualsoptions = 1
            elseif selectionsvisualsoptions < 1 then
                selectionsvisualsoptions = 2
            end
            -- controlsop
            if controlspage == 1 then
                if selectionscontrolsoptions > 5 then
                    selectionscontrolsoptions = 1
                elseif selectionscontrolsoptions < 1 then
                    selectionscontrolsoptions = 5
                end
            elseif controlspage == 2 then
                if selectionscontrolsoptions > 6 then
                    selectionscontrolsoptions = 1
                elseif selectionscontrolsoptions < 1 then
                    selectionscontrolsoptions = 6
                end
            elseif controlspage == 3 then
                if selectionscontrolsoptions > 3 then
                    selectionscontrolsoptions = 1
                elseif selectionscontrolsoptions < 1 then
                    selectionscontrolsoptions = 3
                end
            end
            -- otherop
            if selectionsmodoptions > 4 then
                selectionsmodoptions = 0
            elseif selectionsmodoptions < 0 then
                selectionsmodoptions = 4
            end
            updateOptionPositions()
        elseif keyJustPressed('accept') and caninput then
            if optionsState == 'options' then
                if selectionoptions ~= 4 then
                    playSound('confirmMenu', 0.8)
                    closeOptions()
                end
                updateOptionPositions()
                if selectionoptions == 1 then
                    openControlOptions()
                    optionsState = 'controlsoptions'
                elseif selectionoptions == 2 then
                    openVisualsOptions()
                    optionsState = 'visualsoptions'
                elseif selectionoptions == 3 then
                    openOtherOptions()
                    optionsState = 'otheroptions'
                elseif selectionoptions == 4 then
                    caninput = false
                    rebindKey()
                    --resetGameData()
                end
            end
        elseif keyJustPressed('back') and caninput then
            if optionsState == 'otheroptions' then
                closeOtherOptions()
                selectionoptions = 3
            elseif optionsState == 'controlsoptions' then
                closeControlsOptions()
                selectionoptions = 1
            elseif optionsState == 'visualsoptions' then
                closeVisualsOptions()
                selectionoptions = 2
            end
            if optionsState ~= 'options' then
                escTweenAnim()
                playSound('cancelMenu', 0.8)
                updateOptionPositions()
                caninput = false
                runTimer('resetinput', 0.01)
                openNewOptions()
            end
        end
    end
    if rebinding and not caninput then
        if optionsState == 'controlsoptions' then
            if not hoveringreset then
                keyrebind = callMethodFromClass('flixel.FlxG', 'keys.firstJustPressed', { '' })
                if keyrebind ~= -1 and keyboardReverse[keyrebind] then
                    rebinding = false
                    doTweenAlpha('rebindALPHA', 'rebindOverlay', 0, 0.2, 'linear')
                    doTweenAlpha('rebindTXTALPHA', 'rebindTXT', 0, 0.2, 'linear')
                    doTweenAlpha('rebindTXT2ALPHA', 'rebindTXT2', 0, 0.2, 'linear')
                    playSound('confirmMenu', 0.8)
                    runTimer('resetinput', 0.01)
                    rebindFuck()
                end
            elseif hoveringreset then
                if keyJustPressed('accept') then
                    doTweenAlpha('rebindALPHA', 'rebindOverlay', 0, 0.2, 'linear')
                    doTweenAlpha('rebindTXTALPHA', 'rebindTXT', 0, 0.2, 'linear')
                    doTweenAlpha('rebindTXT2ALPHA', 'rebindTXT2', 0, 0.2, 'linear')
                    playSound('confirmMenu', 0.8)
                    defaultKeybinds()
                    runTimer('resetinput', 0.01)
                end
                if keyJustPressed('BACK') then
                    doTweenAlpha('rebindALPHA', 'rebindOverlay', 0, 0.2, 'linear')
                    doTweenAlpha('rebindTXTALPHA', 'rebindTXT', 0, 0.2, 'linear')
                    doTweenAlpha('rebindTXT2ALPHA', 'rebindTXT2', 0, 0.2, 'linear')
                    playSound('cancelMenu', 0.8)
                    runTimer('resetinput', 0.01)
                end
            end
        elseif optionsState == 'options' then
            if keyJustPressed('accept') then
                resetGameData()
                doTweenAlpha('rebindALPHA', 'rebindOverlay', 0, 0.2, 'linear')
                doTweenAlpha('rebindTXTALPHA', 'rebindTXT', 0, 0.2, 'linear')
                doTweenAlpha('rebindTXT2ALPHA', 'rebindTXT2', 0, 0.2, 'linear')
                playSound('confirmMenu', 0.8)
                runTimer('resetinput', 0.01)
            end
            if keyJustPressed('BACK') then
                doTweenAlpha('rebindALPHA', 'rebindOverlay', 0, 0.2, 'linear')
                doTweenAlpha('rebindTXTALPHA', 'rebindTXT', 0, 0.2, 'linear')
                doTweenAlpha('rebindTXT2ALPHA', 'rebindTXT2', 0, 0.2, 'linear')
                playSound('cancelMenu', 0.8)
                runTimer('resetinput', 0.01)
            end
        end
    end
end



funksongs = {
    "break-down",
    "unbound",
    "rock-solid",
    "ultimatum",
    "blueprint"
}

difficulties = {
    "", -- standard
    "-easy",
    "-encore"
}

function resetGameData()
    for i = 1, #funksongs do
        local songName = funksongs[i]

        for j = 1, #difficulties do
            local difficultylol = difficulties[j]

            local rankgiven = '???'
            local Nscore = '???'
            local acc = '???'
            local crown = false

            setDataFromSave('globalsave', 'rank-' .. songName .. difficultylol, rankgiven)
            setDataFromSave('globalsave', 'score-' .. songName .. difficultylol, Nscore)
            setDataFromSave('globalsave', 'acc-' .. songName .. difficultylol, acc)
            setDataFromSave('globalsave', 'crown-' .. songName .. difficultylol, crown)
        end
    end
end




function escTweenAnim()
    setProperty('back.scale.x', 0.8)
    setProperty('back.scale.y', 0.8)
    doTweenX('backscalex', 'back.scale', 1, 1, 'expoOut')
    doTweenY('backscaley', 'back.scale', 1, 1, 'expoOut')
end

function rebindFuck()
    if controlspage == 1 then
        if selectionscontrolsoptions == 1 then
            local fuckid = 'note_left'
            if bindselection == 1 then
                local lastkeybind = getPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, true)
                setPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, { keyrebind, lastkeybind[2] }, true)
            elseif bindselection == 2 then
                local lastkeybind = getPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, true)
                setPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, { lastkeybind[1], keyrebind }, true)
            end
        elseif selectionscontrolsoptions == 2 then
            local fuckid = 'note_down'
            if bindselection == 1 then
                local lastkeybind = getPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, true)
                setPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, { keyrebind, lastkeybind[2] }, true)
            elseif bindselection == 2 then
                local lastkeybind = getPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, true)
                setPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, { lastkeybind[1], keyrebind }, true)
            end
        elseif selectionscontrolsoptions == 3 then
            local fuckid = 'note_up'
            if bindselection == 1 then
                local lastkeybind = getPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, true)
                setPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, { keyrebind, lastkeybind[2] }, true)
            elseif bindselection == 2 then
                local lastkeybind = getPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, true)
                setPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, { lastkeybind[1], keyrebind }, true)
            end
        elseif selectionscontrolsoptions == 4 then
            local fuckid = 'note_right'
            if bindselection == 1 then
                local lastkeybind = getPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, true)
                setPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, { keyrebind, lastkeybind[2] }, true)
            elseif bindselection == 2 then
                local lastkeybind = getPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, true)
                setPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, { lastkeybind[1], keyrebind }, true)
            end
        elseif selectionscontrolsoptions == 5 then
            local fuckid = 'jump'
            if bindselection == 1 then
                local lastkeybind = getPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, true)
                setPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, { keyrebind, lastkeybind[2] }, true)
            elseif bindselection == 2 then
                local lastkeybind = getPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, true)
                setPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, { lastkeybind[1], keyrebind }, true)
            end
        end
    end
    if controlspage == 2 then
        if selectionscontrolsoptions == 1 then
            local fuckid = 'left'
            if bindselection == 1 then
                local lastkeybind = getPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, true)
                setPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, { keyrebind, lastkeybind[2] }, true)
            elseif bindselection == 2 then
                local lastkeybind = getPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, true)
                setPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, { lastkeybind[1], keyrebind }, true)
            end
        elseif selectionscontrolsoptions == 2 then
            local fuckid = 'down'
            if bindselection == 1 then
                local lastkeybind = getPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, true)
                setPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, { keyrebind, lastkeybind[2] }, true)
            elseif bindselection == 2 then
                local lastkeybind = getPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, true)
                setPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, { lastkeybind[1], keyrebind }, true)
            end
        elseif selectionscontrolsoptions == 3 then
            local fuckid = 'up'
            if bindselection == 1 then
                local lastkeybind = getPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, true)
                setPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, { keyrebind, lastkeybind[2] }, true)
            elseif bindselection == 2 then
                local lastkeybind = getPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, true)
                setPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, { lastkeybind[1], keyrebind }, true)
            end
        elseif selectionscontrolsoptions == 4 then
            local fuckid = 'right'
            if bindselection == 1 then
                local lastkeybind = getPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, true)
                setPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, { keyrebind, lastkeybind[2] }, true)
            elseif bindselection == 2 then
                local lastkeybind = getPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, true)
                setPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, { lastkeybind[1], keyrebind }, true)
            end
        elseif selectionscontrolsoptions == 5 then
            local fuckid = 'accept'
            if bindselection == 1 then
                local lastkeybind = getPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, true)
                setPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, { keyrebind, lastkeybind[2] }, true)
            elseif bindselection == 2 then
                local lastkeybind = getPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, true)
                setPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, { lastkeybind[1], keyrebind }, true)
            end
        elseif selectionscontrolsoptions == 6 then
            local fuckid = 'back'
            if bindselection == 1 then
                local lastkeybind = getPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, true)
                setPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, { keyrebind, lastkeybind[2] }, true)
            elseif bindselection == 2 then
                local lastkeybind = getPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, true)
                setPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, { lastkeybind[1], keyrebind }, true)
            end
        end
    end
    if controlspage == 3 then
        if selectionscontrolsoptions == 1 then
            local fuckid = 'pause'
            if bindselection == 1 then
                local lastkeybind = getPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, true)
                setPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, { keyrebind, lastkeybind[2] }, true)
            elseif bindselection == 2 then
                local lastkeybind = getPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, true)
                setPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, { lastkeybind[1], keyrebind }, true)
            end
        elseif selectionscontrolsoptions == 2 then
            local fuckid = 'togglefps'
            if bindselection == 1 then
                local lastkeybind = getPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, true)
                setPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, { keyrebind, lastkeybind[2] }, true)
            elseif bindselection == 2 then
                local lastkeybind = getPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, true)
                setPropertyFromClass('backend.ClientPrefs', 'keyBinds.' .. fuckid, { lastkeybind[1], keyrebind }, true)
            end
        elseif selectionscontrolsoptions == 3 then
            --
        end
    end
    runHaxeCode([[
    import backend.ClientPrefs;
    ClientPrefs.saveSettings();
    ]])
    updateControlStrings()
end

function defaultKeybinds()
    --UI
    setPropertyFromClass('backend.ClientPrefs', 'keyBinds.left', {65, 37}, true)
    setPropertyFromClass('backend.ClientPrefs', 'keyBinds.ui_down', {83, 40}, true)
    setPropertyFromClass('backend.ClientPrefs', 'keyBinds.ui_up', {87, 38}, true)
    setPropertyFromClass('backend.ClientPrefs', 'keyBinds.right', {68, 39}, true)
    setPropertyFromClass('backend.ClientPrefs', 'keyBinds.accept', {32, 13}, true)
    setPropertyFromClass('backend.ClientPrefs', 'keyBinds.back', {8, 27}, true)
    --NOTES
    setPropertyFromClass('backend.ClientPrefs', 'keyBinds.note_left', {65, 37}, true)
    setPropertyFromClass('backend.ClientPrefs', 'keyBinds.note_down', {83, 40}, true)
    setPropertyFromClass('backend.ClientPrefs', 'keyBinds.note_up', {87, 38}, true)
    setPropertyFromClass('backend.ClientPrefs', 'keyBinds.note_right', {68, 39}, true)
    setPropertyFromClass('backend.ClientPrefs', 'keyBinds.accept', {32, 32}, true)
    --OTHER
    setPropertyFromClass('backend.ClientPrefs', 'keyBinds.pause', {13, 27}, true)
    setPropertyFromClass('backend.ClientPrefs', 'keyBinds.togglefps', {114, 114}, true)

    --update the fuckin strings
    updateControlStrings()
end

-- options functions

function rebindKey()
    if optionsState == 'controlsoptions' then
    for i = 1, 6 do
        if controlspage == 1 then
            setTextString('rebindTXT2', ' Press any key to rebind\n ')
            if selectionscontrolsoptions == i then
                setTextString('rebindTXT', ' Rebinding ' .. getTextString('controlsoption' .. i) .. '\n ')
            end
        elseif controlspage == 2 then
            setTextString('rebindTXT2', ' Press any key to rebind\n ')
            if selectionscontrolsoptions == i then
                setTextString('rebindTXT', ' Rebinding ' .. getTextString('controlsoptionA' .. i) .. '\n ')
            end
        elseif controlspage == 3 then
            if selectionscontrolsoptions == 1 or selectionscontrolsoptions == 2 then
                if selectionscontrolsoptions == 1 then
                    setTextString('rebindTXT', ' Rebinding Pause ')
                elseif selectionscontrolsoptions == 2 then
                    setTextString('rebindTXT', ' Rebinding Toggle FPS Counter ')
                end
                setTextString('rebindTXT2', ' Press any key to rebind\n ')
            elseif selectionscontrolsoptions == 3 then
                setTextString('rebindTXT', ' Reset all keybinds?\n ')
                setTextString('rebindTXT2', ' Press ACCEPT to continue\n Press BACK to cancel\n ')
            end
        end
    end
elseif optionsState == 'options' then
    setTextString('rebindTXT', ' Reset All Game Data?\n ')
                setTextString('rebindTXT2', ' Press ACCEPT to continue\n Press BACK to cancel\n ')
end
    doTweenAlpha('rebindALPHA', 'rebindOverlay', 1, openeaseTime, easetype)
    doTweenAlpha('rebindTXTALPHA', 'rebindTXT', 1, openeaseTime, easetype)
    doTweenAlpha('rebindTXT2ALPHA', 'rebindTXT2', 1, openeaseTime, easetype)
    rebinding = false
    runTimer('rebindtimer', 0.01)
end


function openNewOptions()
    optionsState = 'options'
    selectionsmodoptions = 0
    updateOptionPositions()

    doTweenX('option1IN', 'option1', option1X, openeaseTime, 'expoOut')

    doTweenX('option2IN', 'option2', option2X, openeaseTime, 'expoOut')

    doTweenX('option3IN', 'option3', option3X, openeaseTime, 'expoOut')

    doTweenX('option4IN', 'option4', option4X, openeaseTime, 'expoOut')
    doTweenY('optionstxtIN', 'OPTIONStxt', OPTIONStxtY, openeaseTime, 'expoOut')
end

function closeOptions()
    doTweenX('option1IN', 'option1', option1X + 850, openeaseTime, 'expoOut')
    doTweenX('option2IN', 'option2', option2X + 950, openeaseTime, 'expoOut')
    doTweenX('option3IN', 'option3', option3X + 950, openeaseTime, 'expoOut')
    doTweenX('option4IN', 'option4', option4X + 950, openeaseTime, 'expoOut')
    doTweenY('optionstxtIN', 'OPTIONStxt', OPTIONStxtY - 200, openeaseTime, 'expoOut')
end



function openControlOptions()
    pageselection = true
    bindselection = 1
    optionsState = 'controlsoptions'
    controlspage = 1
    selectionscontrolsoptions = 1
    
    doTweenY('pagecounterNUMTWEEN', 'pagecounterNUM', pagecounterNUMY, openeaseTime, 'expoOut')
    doTweenAlpha('selectionOptions2alpha', 'selectionOptions2', 0.5, openeaseTime, 'expoOut')
    doTweenX('CONTROLSOPTIONStxtTWEEN', 'CONTROLSOPTIONStxt', OPTIONStxtX, openeaseTime, 'expoOut')
    doTweenX('CONTROLSOPTIONSSUBtxtTWEEN', 'controlsoptionsub1', controlsoptionsSUBX, openeaseTime, 'expoOut')
    --
    doTweenX('controlsoption1TWEEN', 'controlsoption1', controlsoptionsX, openeaseTime, 'expoOut')
    doTweenX('controlsoption1BIND1TWEEN', 'controlsoption1BIND1', controlsoptionsX + bind1offset, openeaseTime,
        'expoOut')
    doTweenX('controlsoption1BIND2TWEEN', 'controlsoption1BIND2', controlsoptionsX + bind2offset, openeaseTime,
        'expoOut')
    doTweenX('controlsoption1VISUALTWEEN', 'controlsoption1VISUAL', controlsoptionsX + controlsvisualsoffset,
        openeaseTime, 'expoOut')
    --
    doTweenX('controlsoption2TWEEN', 'controlsoption2', controlsoptionsX, openeaseTime, 'expoOut')
    doTweenX('controlsoption2BIND1TWEEN', 'controlsoption2BIND1', controlsoptionsX + bind1offset, openeaseTime,
        'expoOut')
    doTweenX('controlsoption2BIND2TWEEN', 'controlsoption2BIND2', controlsoptionsX + bind2offset, openeaseTime,
        'expoOut')
    doTweenX('controlsoption2VISUALTWEEN', 'controlsoption2VISUAL', controlsoptionsX + controlsvisualsoffset,
        openeaseTime, 'expoOut')
    --
    doTweenX('controlsoption3TWEEN', 'controlsoption3', controlsoptionsX, openeaseTime, 'expoOut')
    doTweenX('controlsoption3BIND1TWEEN', 'controlsoption3BIND1', controlsoptionsX + bind1offset, openeaseTime,
        'expoOut')
    doTweenX('controlsoption3BIND2TWEEN', 'controlsoption3BIND2', controlsoptionsX + bind2offset, openeaseTime,
        'expoOut')
    doTweenX('controlsoption3VISUALTWEEN', 'controlsoption3VISUAL', controlsoptionsX + controlsvisualsoffset,
        openeaseTime, 'expoOut')
    --
    doTweenX('controlsoption4TWEEN', 'controlsoption4', controlsoptionsX, openeaseTime, 'expoOut')
    doTweenX('controlsoption4BIND1TWEEN', 'controlsoption4BIND1', controlsoptionsX + bind1offset, openeaseTime,
        'expoOut')
    doTweenX('controlsoption4BIND2TWEEN', 'controlsoption4BIND2', controlsoptionsX + bind2offset, openeaseTime,
        'expoOut')
    doTweenX('controlsoption4VISUALTWEEN', 'controlsoption4VISUAL', controlsoptionsX + controlsvisualsoffset,
        openeaseTime, 'expoOut')
    --
    doTweenX('controlsoption5TWEEN', 'controlsoption5', controlsoptionsX, openeaseTime, 'expoOut')
    doTweenX('controlsoption5BIND1TWEEN', 'controlsoption5BIND1', controlsoptionsX + bind1offset, openeaseTime,
        'expoOut')
    doTweenX('controlsoption5BIND2TWEEN', 'controlsoption5BIND2', controlsoptionsX + bind2offset, openeaseTime,
        'expoOut')
    doTweenX('controlsoption5VISUALTWEEN', 'controlsoption5VISUAL', controlsoptionsX + controlsvisualsoffset,
        openeaseTime, 'expoOut')
    --

    doTweenAlpha('selectionOptionsalpha', 'selectionOptions', 0.5, openeaseTime, 'expoOut')
    doTweenAlpha('optionsOverlayIN', 'optionsOverlay', 1, openeaseTime, 'expoOut')
    updateOptionPositions()
end

function closeControlsOptions()
    pageselection = false
    
    doTweenY('pagecounterNUMTWEEN', 'pagecounterNUM', pagecounterNUMY + 200, openeaseTime, 'expoOut')
    doTweenAlpha('selectionOptions2alpha', 'selectionOptions2', 0, openeaseTime, 'expoOut')
        doTweenX('CONTROLSOPTIONStxtTWEEN', 'CONTROLSOPTIONStxt', OPTIONStxtX + distanceop, openeaseTime, 'expoOut')
    if controlspage == 1 then
        local distanceop = 900
        doTweenX('CONTROLSOPTIONSSUBtxtTWEEN', 'controlsoptionsub1', controlsoptionsSUBX + distanceop, openeaseTime,
            'expoOut')
        --
        doTweenX('controlsoption1TWEEN', 'controlsoption1', controlsoptionsX - distanceop, openeaseTime, 'expoOut')
        doTweenX('controlsoption1BIND1TWEEN', 'controlsoption1BIND1', controlsoptionsX - distanceop, openeaseTime,
            'expoOut')
        doTweenX('controlsoption1BIND2TWEEN', 'controlsoption1BIND2', controlsoptionsX - distanceop, openeaseTime,
            'expoOut')
        doTweenX('controlsoption1VISUALTWEEN', 'controlsoption1VISUAL', controlsoptionsX - distanceop, openeaseTime,
            'expoOut')
        --
        doTweenX('controlsoption2TWEEN', 'controlsoption2', controlsoptionsX - distanceop, openeaseTime, 'expoOut')
        doTweenX('controlsoption2BIND1TWEEN', 'controlsoption2BIND1', controlsoptionsX - distanceop, openeaseTime,
            'expoOut')
        doTweenX('controlsoption2BIND2TWEEN', 'controlsoption2BIND2', controlsoptionsX - distanceop, openeaseTime,
            'expoOut')
        doTweenX('controlsoption2VISUALTWEEN', 'controlsoption2VISUAL', controlsoptionsX - distanceop, openeaseTime,
            'expoOut')
        --
        doTweenX('controlsoption3TWEEN', 'controlsoption3', controlsoptionsX - distanceop, openeaseTime, 'expoOut')
        doTweenX('controlsoption3BIND1TWEEN', 'controlsoption3BIND1', controlsoptionsX - distanceop, openeaseTime,
            'expoOut')
        doTweenX('controlsoption3BIND2TWEEN', 'controlsoption3BIND2', controlsoptionsX - distanceop, openeaseTime,
            'expoOut')
        doTweenX('controlsoption3VISUALTWEEN', 'controlsoption3VISUAL', controlsoptionsX - distanceop, openeaseTime,
            'expoOut')
        --
        doTweenX('controlsoption4TWEEN', 'controlsoption4', controlsoptionsX - distanceop, openeaseTime, 'expoOut')
        doTweenX('controlsoption4BIND1TWEEN', 'controlsoption4BIND1', controlsoptionsX - distanceop, openeaseTime,
            'expoOut')
        doTweenX('controlsoption4BIND2TWEEN', 'controlsoption4BIND2', controlsoptionsX - distanceop, openeaseTime,
            'expoOut')
        doTweenX('controlsoption4VISUALTWEEN', 'controlsoption4VISUAL', controlsoptionsX - distanceop, openeaseTime,
            'expoOut')
        --
        doTweenX('controlsoption5TWEEN', 'controlsoption5', controlsoptionsX - distanceop, openeaseTime, 'expoOut')
        doTweenX('controlsoption5BIND1TWEEN', 'controlsoption5BIND1', controlsoptionsX - distanceop, openeaseTime,
            'expoOut')
        doTweenX('controlsoption5BIND2TWEEN', 'controlsoption5BIND2', controlsoptionsX - distanceop, openeaseTime,
            'expoOut')
        doTweenX('controlsoption5VISUALTWEEN', 'controlsoption5VISUAL', controlsoptionsX - distanceop, openeaseTime,
            'expoOut')
        --
    elseif controlspage == 2 then
        local distanceop = 1200
        doTweenX('CONTROLSOPTIONSSUB2txtTWEEN', 'controlsoptionsub2', controlsoptionsSUBX + distanceop, openeaseTime,
            'expoOut')
        doTweenX('controlsoptionA1TWEEN', 'controlsoptionA1', controlsoptionsX - distanceop, openeaseTime, 'expoOut')
        doTweenX('controlsoptionA1BIND1TWEEN', 'controlsoptionA1BIND1', controlsoptionsX + bind1offset - distanceop,
            openeaseTime, 'expoOut')
        doTweenX('controlsoptionA1BIND2TWEEN', 'controlsoptionA1BIND2', controlsoptionsX + bind2offset - distanceop,
            openeaseTime, 'expoOut')
        --
        doTweenX('controlsoptionA2TWEEN', 'controlsoptionA2', controlsoptionsX - distanceop, openeaseTime, 'expoOut')
        doTweenX('controlsoptionA2BIND1TWEEN', 'controlsoptionA2BIND1', controlsoptionsX + bind1offset - distanceop,
            openeaseTime, 'expoOut')
        doTweenX('controlsoptionA2BIND2TWEEN', 'controlsoptionA2BIND2', controlsoptionsX + bind2offset - distanceop,
            openeaseTime, 'expoOut')
        --
        doTweenX('controlsoptionA3TWEEN', 'controlsoptionA3', controlsoptionsX - distanceop, openeaseTime, 'expoOut')
        doTweenX('controlsoptionA3BIND1TWEEN', 'controlsoptionA3BIND1', controlsoptionsX + bind1offset - distanceop,
            openeaseTime, 'expoOut')
        doTweenX('controlsoptionA3BIND2TWEEN', 'controlsoptionA3BIND2', controlsoptionsX + bind2offset - distanceop,
            openeaseTime, 'expoOut')
        --
        doTweenX('controlsoptionA4TWEEN', 'controlsoptionA4', controlsoptionsX - distanceop, openeaseTime, 'expoOut')
        doTweenX('controlsoptionA4BIND1TWEEN', 'controlsoptionA4BIND1', controlsoptionsX + bind1offset - distanceop,
            openeaseTime, 'expoOut')
        doTweenX('controlsoptionA4BIND2TWEEN', 'controlsoptionA4BIND2', controlsoptionsX + bind2offset - distanceop,
            openeaseTime, 'expoOut')
        --
        doTweenX('controlsoptionA5TWEEN', 'controlsoptionA5', controlsoptionsX - distanceop, openeaseTime, 'expoOut')
        doTweenX('controlsoptionA5BIND1TWEEN', 'controlsoptionA5BIND1', controlsoptionsX + bind1offset - distanceop,
            openeaseTime, 'expoOut')
        doTweenX('controlsoptionA5BIND2TWEEN', 'controlsoptionA5BIND2', controlsoptionsX + bind2offset - distanceop,
            openeaseTime, 'expoOut')
        --
        doTweenX('controlsoptionA6TWEEN', 'controlsoptionA6', controlsoptionsX - distanceop, openeaseTime, 'expoOut')
        doTweenX('controlsoptionA6BIND1TWEEN', 'controlsoptionA6BIND1', controlsoptionsX + bind1offset - distanceop,
            openeaseTime, 'expoOut')
        doTweenX('controlsoptionA6BIND2TWEEN', 'controlsoptionA6BIND2', controlsoptionsX + bind2offset - distanceop,
            openeaseTime, 'expoOut')
        --
    elseif controlspage == 3 then
        local distanceop = 1100
        doTweenX('CONTROLSOPTIONSSUB3txtTWEEN', 'controlsoptionsub3', controlsoptionsSUBX + distanceop, openeaseTime,
            'expoOut')
        doTweenX('controlsoptionB1TWEEN', 'controlsoptionB1', controlsoptionsX - distanceop, openeaseTime, 'expoOut')
        doTweenX('controlsoptionB1BIND1TWEEN', 'controlsoptionB1BIND1', controlsoptionsX + bind1offset - distanceop,
            openeaseTime, 'expoOut')
        doTweenX('controlsoptionB1BIND2TWEEN', 'controlsoptionB1BIND2', controlsoptionsX + bind2offset - distanceop,
            openeaseTime, 'expoOut')

        doTweenX('controlsoptionB2TWEEN', 'controlsoptionB2', controlsoptionsX + -distanceop, openeaseTime, 'expoOut')
        doTweenX('controlsoptionB2BIND1TWEEN', 'controlsoptionB2BIND1', controlsoptionsX + bind1offset - distanceop,
            openeaseTime, 'expoOut')
        doTweenX('controlsoptionB2BIND2TWEEN', 'controlsoptionB2BIND2', controlsoptionsX + bind2offset - distanceop,
            openeaseTime, 'expoOut')

        doTweenX('controlsoptionB3TWEEN', 'controlsoptionB3', controlsoptionsX - distanceop, openeaseTime, 'expoOut')
    end

    updateOptionPositions()
end



function openVisualsOptions()
    
    currfps = runHaxeCode([[
    return FlxG.drawFramerate;
]])
    setTextString('visualsoption1MODIFIER', currfps)
                    if caching then
                        setTextString('visualsoption2MODIFIER', 'OFF')
                    else
                        setTextString('visualsoption2MODIFIER', 'ON')
                    end
                    if lowQ then
                        setTextString('visualsoption3MODIFIER', 'OFF')
                    else
                        setTextString('visualsoption3MODIFIER', 'ON')
                    end

    optionsState = 'visualsoptions'
    selectionsvisualsoptions = 1
    
    doTweenY('optionssubtitle1TWEEN', 'optionssubtitle1', optionssubtitle1Y, openeaseTime, 'expoOut')
    doTweenX('VISUALSOPTIONStxtTWEEN', 'VISUALSOPTIONStxt', visualsoptionsTXTX, openeaseTime, 'expoOut')

    doTweenX('visualsoption1TWEEN', 'visualsoption1', visualsoptionsX, openeaseTime, 'expoOut')
    doTweenX('visualsoption1MODIFIERTWEEN', 'visualsoption1MODIFIER', modmodifierX, openeaseTime, 'expoOut')
    doTweenX('visualsoption2TWEEN', 'visualsoption2', visualsoptionsX, openeaseTime, 'expoOut')
    doTweenX('visualsoption2MODIFIERTWEEN', 'visualsoption2MODIFIER', modmodifierX, openeaseTime, 'expoOut')
    --doTweenX('visualsoption3TWEEN', 'visualsoption3', visualsoptionsX, openeaseTime, 'expoOut')
    --doTweenX('visualsoption3MODIFIERTWEEN', 'visualsoption3MODIFIER', modmodifierX, openeaseTime, 'expoOut')
    
    doTweenX('OPTIONSleftTWEEN', 'OPTIONSleft', arrowleftOPX, openeaseTime, 'expoOut')
    doTweenX('OPTIONSrightTWEEN', 'OPTIONSright', arrowrightOPX, openeaseTime, 'expoOut')
    doTweenAlpha('OPTIONSleftalpha', 'OPTIONSleft', 1, openeaseTime, 'expoOut')
    doTweenAlpha('OPTIONSrightalpha', 'OPTIONSright', 1, openeaseTime, 'expoOut')

    updateOptionPositions()
end

function closeVisualsOptions()
    local diffop = 1100
    
    doTweenY('optionssubtitle1TWEEN', 'optionssubtitle1', optionssubtitle1Y + 200, openeaseTime, 'expoOut')
    doTweenX('VISUALSOPTIONStxtTWEEN', 'VISUALSOPTIONStxt', visualsoptionsTXTX - diffop, openeaseTime, 'expoOut')

    doTweenX('visualsoption1TWEEN', 'visualsoption1', visualsoptionsX - diffop, openeaseTime, 'expoOut')
    doTweenX('visualsoption1MODIFIERTWEEN', 'visualsoption1MODIFIER', modmodifierX - diffop, openeaseTime, 'expoOut')
    doTweenX('visualsoption2TWEEN', 'visualsoption2', visualsoptionsX - diffop, openeaseTime, 'expoOut')
    doTweenX('visualsoption2MODIFIERTWEEN', 'visualsoption2MODIFIER', modmodifierX - diffop, openeaseTime, 'expoOut')
    --doTweenX('visualsoption3TWEEN', 'visualsoption3', visualsoptionsX - diffop, openeaseTime, 'expoOut')
    --doTweenX('visualsoption3MODIFIERTWEEN', 'visualsoption3MODIFIER', modmodifierX - diffop, openeaseTime, 'expoOut')
    
    doTweenX('OPTIONSleftTWEEN', 'OPTIONSleft', arrowleftOPX - diffop, openeaseTime, 'expoOut')
    doTweenX('OPTIONSrightTWEEN', 'OPTIONSright', arrowrightOPX - diffop, openeaseTime, 'expoOut')
    doTweenAlpha('OPTIONSleftalpha', 'OPTIONSleft', 1, openeaseTime, 'expoOut')
    doTweenAlpha('OPTIONSrightalpha', 'OPTIONSright', 1, openeaseTime, 'expoOut')

    updateOptionPositions()
end

function openOtherOptions()
    optionsState = 'otheroptions'
    selectionsmodoptions = 0
    doTweenX('littlebuddyIN', 'littlebuddy', littlebuddyX, openeaseTime, 'expoOut')
    doTweenAlpha('littlebuddyALPHA', 'littlebuddy', buddyalpha * 1, openeaseTime, 'expoOut')
    doTweenX('littleopponentIN', 'littleopponent', littleopponentX, openeaseTime, 'expoOut')
    doTweenAlpha('littleopponentALPHA', 'littleopponent', oppalpha * 1, openeaseTime, 'expoOut')
    for i = 1, 8 do
        if downscrolldetect then
            doTweenY('NOTEZ' .. i .. 'TWEEN', 'NOTEZ' .. i, dowscrollY,
                openeaseTime, 'expoOut')
        else
            doTweenY('NOTEZ' .. i .. 'TWEEN', 'NOTEZ' .. i, upscrollY,
                openeaseTime, 'expoOut')
        end
    end
    doTweenAlpha('BFNOTESALPHA', 'bfnotesUnderlay', 1 * bfUnderlayAlpha, openeaseTime, 'expoOut')
    doTweenAlpha('DADNOTESALPHA', 'dadnotesUnderlay', 1 * dadUnderlayAlpha, openeaseTime, 'expoOut')
    doTweenX('MODOPTIONStxtTWEEN', 'MODOPTIONStxt', OPTIONStxtX, openeaseTime, 'expoOut')
    doTweenX('modoption0TWEEN', 'modoption0', modoptionsX, openeaseTime, 'expoOut')
    doTweenX('modoption0MODIFIERTWEEN', 'modoption0MODIFIER', modmodifierX, openeaseTime, 'expoOut')
    doTweenX('modoption1TWEEN', 'modoption1', modoptionsX, openeaseTime, 'expoOut')
    doTweenX('modoption1MODIFIERTWEEN', 'modoption1MODIFIER', modmodifierX, openeaseTime, 'expoOut')
    doTweenX('modoption2TWEEN', 'modoption2', modoptionsX, openeaseTime, 'expoOut')
    doTweenX('modoption2MODIFIERTWEEN', 'modoption2MODIFIER', modmodifierX, openeaseTime, 'expoOut')
    doTweenX('modoption3TWEEN', 'modoption3', modoptionsX, openeaseTime, 'expoOut')
    doTweenX('modoption3MODIFIERTWEEN', 'modoption3MODIFIER', modmodifierX, openeaseTime, 'expoOut')
    doTweenX('modoption4TWEEN', 'modoption4', modoptionsX, openeaseTime, 'expoOut')
    doTweenX('modoption4MODIFIERTWEEN', 'modoption4MODIFIER', modmodifierX, openeaseTime, 'expoOut')
    doTweenX('OPTIONSleftTWEEN', 'OPTIONSleft', arrowleftOPX, openeaseTime, 'expoOut')
    doTweenX('OPTIONSrightTWEEN', 'OPTIONSright', arrowrightOPX, openeaseTime, 'expoOut')
    doTweenAlpha('OPTIONSleftalpha', 'OPTIONSleft', 1, openeaseTime, 'expoOut')
    doTweenAlpha('OPTIONSrightalpha', 'OPTIONSright', 1, openeaseTime, 'expoOut')
    doTweenAlpha('selectionOptionsalpha', 'selectionOptions', 0.5, openeaseTime, 'expoOut')
    doTweenAlpha('optionsOverlayIN', 'optionsOverlay', 1, openeaseTime, 'expoOut')
    updateOptionPositions()
end

function closeOtherOptions()
    selectionoptions = 3
    updateOptionPositions()
    doTweenX('littlebuddyIN', 'littlebuddy', littlebuddyX + 500, openeaseTime, 'expoOut')
    doTweenAlpha('littlebuddyALPHA', 'littlebuddy', buddyalpha * 0, openeaseTime / 2, 'expoOut')
    doTweenX('littleopponentIN', 'littleopponent', littleopponentX - 500, openeaseTime, 'expoOut')
    doTweenAlpha('littleopponentALPHA', 'littleopponent', oppalpha * 0, openeaseTime / 2, 'expoOut')
    for i = 1, 8 do
        if downscrolldetect then
            doTweenY('NOTEZ' .. i .. 'TWEEN', 'NOTEZ' .. i, dowscrollY + 200,
                openeaseTime, 'expoOut')
        else
            doTweenY('NOTEZ' .. i .. 'TWEEN', 'NOTEZ' .. i, upscrollY - 200,
                openeaseTime, 'expoOut')
        end
    end
    doTweenAlpha('BFNOTESALPHA', 'bfnotesUnderlay', 0 * bfUnderlayAlpha, openeaseTime, 'expoOut')
    doTweenAlpha('DADNOTESALPHA', 'dadnotesUnderlay', 0 * dadUnderlayAlpha, openeaseTime, 'expoOut')

    doTweenX('MODOPTIONStxtTWEEN', 'MODOPTIONStxt', OPTIONStxtX - 1000, openeaseTime, 'expoOut')
    doTweenX('modoption0TWEEN', 'modoption0', modoptionsX - 1150, openeaseTime, 'expoOut')
    doTweenX('modoption0MODIFIERTWEEN', 'modoption0MODIFIER', modmodifierX - 1150, openeaseTime, 'expoOut')
    doTweenX('modoption1TWEEN', 'modoption1', modoptionsX - 1150, openeaseTime, 'expoOut')
    doTweenX('modoption1MODIFIERTWEEN', 'modoption1MODIFIER', modmodifierX - 1150, openeaseTime, 'expoOut')
    doTweenX('modoption2TWEEN', 'modoption2', modoptionsX - 1150, openeaseTime, 'expoOut')
    doTweenX('modoption2MODIFIERTWEEN', 'modoption2MODIFIER', modmodifierX - 1150, openeaseTime, 'expoOut')
    doTweenX('modoption3TWEEN', 'modoption3', modoptionsX - 1150, openeaseTime, 'expoOut')
    doTweenX('modoption3MODIFIERTWEEN', 'modoption3MODIFIER', modmodifierX - 1150, openeaseTime, 'expoOut')
    doTweenX('modoption4TWEEN', 'modoption4', modoptionsX - 1150, openeaseTime, 'expoOut')
    doTweenX('modoption4MODIFIERTWEEN', 'modoption4MODIFIER', modmodifierX - 1150, openeaseTime, 'expoOut')
    doTweenX('OPTIONSleftTWEEN', 'OPTIONSleft', arrowleftOPX - 1150, openeaseTime, 'expoOut')
    doTweenX('OPTIONSrightTWEEN', 'OPTIONSright', arrowrightOPX - 1150, openeaseTime, 'expoOut')
    doTweenAlpha('OPTIONSleftalpha', 'OPTIONSleft', 0, openeaseTime, 'expoOut')
    doTweenAlpha('OPTIONSrightalpha', 'OPTIONSright', 0, openeaseTime, 'expoOut')
end

function updateOptionPositions()
    if optionsState == 'options' then
        if selectionoptions == 1 then
            doTweenY('moveoptionsshadow', 'selectionOptions', option1Y + 5, scrollSpeed, easetype)
            doTweenX('option1size', 'option1.scale', 0.5, scrollSpeed, easetype)
            doTweenY('option1size2', 'option1.scale', 0.5, scrollSpeed, easetype)
            doTweenAlpha('option1color', 'option1', 1, scrollSpeed, easetype)
            doTweenX('option2size', 'option2.scale', 0.3, scrollSpeed, easetype)
            doTweenY('option2size2', 'option2.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('option2color', 'option2', 0.5, scrollSpeed, easetype)
            doTweenX('option3size', 'option3.scale', 0.3, scrollSpeed, easetype)
            doTweenY('option3size2', 'option3.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('option3color', 'option3', 0.5, scrollSpeed, easetype)
            doTweenX('option4size', 'option4.scale', 0.3, scrollSpeed, easetype)
            doTweenY('option4size2', 'option4.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('option4color', 'option4', 0.5, scrollSpeed, easetype)
        elseif selectionoptions == 2 then
            doTweenY('moveoptionsshadow', 'selectionOptions', option2Y + 5, scrollSpeed, easetype)
            doTweenX('option2size', 'option2.scale', 0.5, scrollSpeed, easetype)
            doTweenY('option2size2', 'option2.scale', 0.5, scrollSpeed, easetype)
            doTweenAlpha('option2color', 'option2', 1, scrollSpeed, easetype)
            doTweenX('option1size', 'option1.scale', 0.3, scrollSpeed, easetype)
            doTweenY('option1size2', 'option1.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('option1color', 'option1', 0.5, scrollSpeed, easetype)
            doTweenX('option3size', 'option3.scale', 0.3, scrollSpeed, easetype)
            doTweenY('option3size2', 'option3.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('option3color', 'option3', 0.5, scrollSpeed, easetype)
            doTweenX('option4size', 'option4.scale', 0.3, scrollSpeed, easetype)
            doTweenY('option4size2', 'option4.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('option4color', 'option4', 0.5, scrollSpeed, easetype)
        elseif selectionoptions == 3 then
            doTweenY('moveoptionsshadow', 'selectionOptions', option3Y + 5, scrollSpeed, easetype)
            doTweenX('option3size', 'option3.scale', 0.5, scrollSpeed, easetype)
            doTweenY('option3size2', 'option3.scale', 0.5, scrollSpeed, easetype)
            doTweenAlpha('option3color', 'option3', 1, scrollSpeed, easetype)
            doTweenX('option1size', 'option1.scale', 0.3, scrollSpeed, easetype)
            doTweenY('option1size2', 'option1.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('option1color', 'option1', 0.5, scrollSpeed, easetype)
            doTweenX('option2size', 'option2.scale', 0.3, scrollSpeed, easetype)
            doTweenY('option2size2', 'option2.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('option2color', 'option2', 0.5, scrollSpeed, easetype)
            doTweenX('option4size', 'option4.scale', 0.3, scrollSpeed, easetype)
            doTweenY('option4size2', 'option4.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('option4color', 'option4', 0.5, scrollSpeed, easetype)
        elseif selectionoptions == 4 then
            doTweenY('moveoptionsshadow', 'selectionOptions', option4Y + 5, scrollSpeed, easetype)
            doTweenX('option4size', 'option4.scale', 0.5, scrollSpeed, easetype)
            doTweenY('option4size2', 'option4.scale', 0.5, scrollSpeed, easetype)
            doTweenAlpha('option4color', 'option4', 1, scrollSpeed, easetype)
            doTweenX('option1size', 'option1.scale', 0.3, scrollSpeed, easetype)
            doTweenY('option1size2', 'option1.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('option1color', 'option1', 0.5, scrollSpeed, easetype)
            doTweenX('option2size', 'option2.scale', 0.3, scrollSpeed, easetype)
            doTweenY('option2size2', 'option2.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('option2color', 'option2', 0.5, scrollSpeed, easetype)
            doTweenX('option3size', 'option3.scale', 0.3, scrollSpeed, easetype)
            doTweenY('option3size2', 'option3.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('option3color', 'option3', 0.5, scrollSpeed, easetype)
        end
    elseif optionsState == 'otheroptions' then
        if selectionsmodoptions == 0 then
            doTweenY('moveoptionsshadow', 'selectionOptions', modoption0Y + 5, scrollSpeed, easetype)
            doTweenY('movearrow1', 'OPTIONSleft', modoption0Y + 15, scrollSpeed, easetype)
            doTweenY('movearrow2', 'OPTIONSright', modoption0Y + 15, scrollSpeed, easetype)

            doTweenX('modoption0size', 'modoption0.scale', 0.5, scrollSpeed, easetype)
            doTweenY('modoption0size2', 'modoption0.scale', 0.5, scrollSpeed, easetype)
            doTweenAlpha('modoption0color', 'modoption0', 1, scrollSpeed, easetype)
            doTweenX('modoption0MODIFIERsize', 'modoption0MODIFIER.scale', 0.5, scrollSpeed, easetype)
            doTweenY('modoption0MODIFIERsize2', 'modoption0MODIFIER.scale', 0.5, scrollSpeed, easetype)
            doTweenAlpha('modoption0MODIFIERcolor', 'modoption0MODIFIER', 1, scrollSpeed, easetype)

            doTweenX('modoption1size', 'modoption1.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption1size2', 'modoption1.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption1color', 'modoption1', 0.5, scrollSpeed, easetype)
            doTweenX('modoption1MODIFIERsize', 'modoption1MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption1MODIFIERsize2', 'modoption1MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption1MODIFIERcolor', 'modoption1MODIFIER', 0.5, scrollSpeed, easetype)

            doTweenX('modoption2size', 'modoption2.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption2size2', 'modoption2.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption2color', 'modoption2', 0.5, scrollSpeed, easetype)
            doTweenX('modoption2MODIFIERsize', 'modoption2MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption2MODIFIERsize2', 'modoption2MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption2MODIFIERcolor', 'modoption2MODIFIER', 0.5, scrollSpeed, easetype)

            doTweenX('modoption3size', 'modoption3.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption3size2', 'modoption3.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption3color', 'modoption3', 0.5, scrollSpeed, easetype)
            doTweenX('modoption3MODIFIERsize', 'modoption3MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption3MODIFIERsize2', 'modoption3MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption3MODIFIERcolor', 'modoption3MODIFIER', 0.5, scrollSpeed, easetype)

            doTweenX('modoption4size', 'modoption4.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption4size2', 'modoption4.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption4color', 'modoption4', 0.5, scrollSpeed, easetype)
            doTweenX('modoption4MODIFIERsize', 'modoption4MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption4MODIFIERsize2', 'modoption4MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption4MODIFIERcolor', 'modoption4MODIFIER', 0.5, scrollSpeed, easetype)
        elseif selectionsmodoptions == 1 then
            doTweenY('moveoptionsshadow', 'selectionOptions', modoption1Y + 5, scrollSpeed, easetype)
            doTweenY('movearrow1', 'OPTIONSleft', modoption1Y + 15, scrollSpeed, easetype)
            doTweenY('movearrow2', 'OPTIONSright', modoption1Y + 15, scrollSpeed, easetype)

            doTweenX('modoption1size', 'modoption1.scale', 0.5, scrollSpeed, easetype)
            doTweenY('modoption1size2', 'modoption1.scale', 0.5, scrollSpeed, easetype)
            doTweenAlpha('modoption1color', 'modoption1', 1, scrollSpeed, easetype)
            doTweenX('modoption1MODIFIERsize', 'modoption1MODIFIER.scale', 0.5, scrollSpeed, easetype)
            doTweenY('modoption1MODIFIERsize2', 'modoption1MODIFIER.scale', 0.5, scrollSpeed, easetype)
            doTweenAlpha('modoption1MODIFIERcolor', 'modoption1MODIFIER', 1, scrollSpeed, easetype)

            doTweenX('modoption0size', 'modoption0.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption0size2', 'modoption0.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption0color', 'modoption0', 0.5, scrollSpeed, easetype)
            doTweenX('modoption0MODIFIERsize', 'modoption0MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption0MODIFIERsize2', 'modoption0MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption0MODIFIERcolor', 'modoption0MODIFIER', 0.5, scrollSpeed, easetype)

            doTweenX('modoption2size', 'modoption2.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption2size2', 'modoption2.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption2color', 'modoption2', 0.5, scrollSpeed, easetype)
            doTweenX('modoption2MODIFIERsize', 'modoption2MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption2MODIFIERsize2', 'modoption2MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption2MODIFIERcolor', 'modoption2MODIFIER', 0.5, scrollSpeed, easetype)

            doTweenX('modoption3size', 'modoption3.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption3size2', 'modoption3.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption3color', 'modoption3', 0.5, scrollSpeed, easetype)
            doTweenX('modoption3MODIFIERsize', 'modoption3MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption3MODIFIERsize2', 'modoption3MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption3MODIFIERcolor', 'modoption3MODIFIER', 0.5, scrollSpeed, easetype)

            doTweenX('modoption4size', 'modoption4.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption4size2', 'modoption4.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption4color', 'modoption4', 0.5, scrollSpeed, easetype)
            doTweenX('modoption4MODIFIERsize', 'modoption4MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption4MODIFIERsize2', 'modoption4MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption4MODIFIERcolor', 'modoption4MODIFIER', 0.5, scrollSpeed, easetype)
        elseif selectionsmodoptions == 2 then
            doTweenY('moveoptionsshadow', 'selectionOptions', modoption2Y + 5, scrollSpeed, easetype)
            doTweenY('movearrow1', 'OPTIONSleft', modoption2Y + 15, scrollSpeed, easetype)
            doTweenY('movearrow2', 'OPTIONSright', modoption2Y + 15, scrollSpeed, easetype)

            doTweenX('modoption0size', 'modoption0.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption0size2', 'modoption0.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption0color', 'modoption0', 0.5, scrollSpeed, easetype)
            doTweenX('modoption0MODIFIERsize', 'modoption0MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption0MODIFIERsize2', 'modoption0MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption0MODIFIERcolor', 'modoption0MODIFIER', 0.5, scrollSpeed, easetype)

            doTweenX('modoption1size', 'modoption1.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption1size2', 'modoption1.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption1color', 'modoption1', 0.5, scrollSpeed, easetype)
            doTweenX('modoption1MODIFIERsize', 'modoption1MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption1MODIFIERsize2', 'modoption1MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption1MODIFIERcolor', 'modoption1MODIFIER', 0.5, scrollSpeed, easetype)

            doTweenX('modoption2size', 'modoption2.scale', 0.5, scrollSpeed, easetype)
            doTweenY('modoption2size2', 'modoption2.scale', 0.5, scrollSpeed, easetype)
            doTweenColor('modoption2color', 'modoption2', 1, scrollSpeed, easetype)
            doTweenX('modoption2MODIFIERsize', 'modoption2MODIFIER.scale', 0.5, scrollSpeed, easetype)
            doTweenY('modoption2MODIFIERsize2', 'modoption2MODIFIER.scale', 0.5, scrollSpeed, easetype)
            doTweenAlpha('modoption2MODIFIERcolor', 'modoption2MODIFIER', 1, scrollSpeed, easetype)

            doTweenX('modoption3size', 'modoption3.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption3size2', 'modoption3.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption3color', 'modoption3', 0.5, scrollSpeed, easetype)
            doTweenX('modoption3MODIFIERsize', 'modoption3MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption3MODIFIERsize2', 'modoption3MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption3MODIFIERcolor', 'modoption3MODIFIER', 0.5, scrollSpeed, easetype)

            doTweenX('modoption4size', 'modoption4.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption4size2', 'modoption4.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption4color', 'modoption4', 0.5, scrollSpeed, easetype)
            doTweenX('modoption4MODIFIERsize', 'modoption4MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption4MODIFIERsize2', 'modoption4MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption4MODIFIERcolor', 'modoption4MODIFIER', 0.5, scrollSpeed, easetype)
        elseif selectionsmodoptions == 3 then
            doTweenY('moveoptionsshadow', 'selectionOptions', modoption3Y + 5, scrollSpeed, easetype)
            doTweenY('movearrow1', 'OPTIONSleft', modoption3Y + 15, scrollSpeed, easetype)
            doTweenY('movearrow2', 'OPTIONSright', modoption3Y + 15, scrollSpeed, easetype)

            doTweenX('modoption0size', 'modoption0.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption0size2', 'modoption0.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption0color', 'modoption0', 0.5, scrollSpeed, easetype)
            doTweenX('modoption0MODIFIERsize', 'modoption0MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption0MODIFIERsize2', 'modoption0MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption0MODIFIERcolor', 'modoption0MODIFIER', 0.5, scrollSpeed, easetype)

            doTweenX('modoption1size', 'modoption1.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption1size2', 'modoption1.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption1color', 'modoption1', 0.5, scrollSpeed, easetype)
            doTweenX('modoption1MODIFIERsize', 'modoption1MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption1MODIFIERsize2', 'modoption1MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption1MODIFIERcolor', 'modoption1MODIFIER', 0.5, scrollSpeed, easetype)

            doTweenX('modoption2size', 'modoption2.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption2size2', 'modoption2.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption2color', 'modoption2', 0.5, scrollSpeed, easetype)
            doTweenX('modoption2MODIFIERsize', 'modoption2MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption2MODIFIERsize2', 'modoption2MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption2MODIFIERcolor', 'modoption2MODIFIER', 0.5, scrollSpeed, easetype)

            doTweenX('modoption3size', 'modoption3.scale', 0.5, scrollSpeed, easetype)
            doTweenY('modoption3size2', 'modoption3.scale', 0.5, scrollSpeed, easetype)
            doTweenAlpha('modoption3color', 'modoption3', 1, scrollSpeed, easetype)
            doTweenX('modoption3MODIFIERsize', 'modoption3MODIFIER.scale', 0.5, scrollSpeed, easetype)
            doTweenY('modoption3MODIFIERsize2', 'modoption3MODIFIER.scale', 0.5, scrollSpeed, easetype)
            doTweenAlpha('modoption3MODIFIERcolor', 'modoption3MODIFIER', 1, scrollSpeed, easetype)

            doTweenX('modoption4size', 'modoption4.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption4size2', 'modoption4.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption4color', 'modoption4', 0.5, scrollSpeed, easetype)
            doTweenX('modoption4MODIFIERsize', 'modoption4MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption4MODIFIERsize2', 'modoption4MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption4MODIFIERcolor', 'modoption4MODIFIER', 0.5, scrollSpeed, easetype)
        elseif selectionsmodoptions == 4 then
            doTweenY('moveoptionsshadow', 'selectionOptions', modoption4Y + 5, scrollSpeed, easetype)
            doTweenY('movearrow1', 'OPTIONSleft', modoption4Y + 15, scrollSpeed, easetype)
            doTweenY('movearrow2', 'OPTIONSright', modoption4Y + 15, scrollSpeed, easetype)
            doTweenX('modoption1size', 'modoption1.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption1size2', 'modoption1.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption1color', 'modoption1', 0.5, scrollSpeed, easetype)
            doTweenX('modoption1MODIFIERsize', 'modoption1MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption1MODIFIERsize2', 'modoption1MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption1MODIFIERcolor', 'modoption1MODIFIER', 0.5, scrollSpeed, easetype)

            doTweenX('modoption0size', 'modoption0.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption0size2', 'modoption0.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption0color', 'modoption0', 0.5, scrollSpeed, easetype)
            doTweenX('modoption0MODIFIERsize', 'modoption0MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption0MODIFIERsize2', 'modoption0MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption0MODIFIERcolor', 'modoption0MODIFIER', 0.5, scrollSpeed, easetype)

            doTweenX('modoption2size', 'modoption2.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption2size2', 'modoption2.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption2color', 'modoption2', 0.5, scrollSpeed, easetype)
            doTweenX('modoption2MODIFIERsize', 'modoption2MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption2MODIFIERsize2', 'modoption2MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption2MODIFIERcolor', 'modoption2MODIFIER', 0.5, scrollSpeed, easetype)

            doTweenX('modoption3size', 'modoption3.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption3size2', 'modoption3.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption3color', 'modoption3', 0.5, scrollSpeed, easetype)
            doTweenX('modoption3MODIFIERsize', 'modoption3MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenY('modoption3MODIFIERsize2', 'modoption3MODIFIER.scale', 0.3, scrollSpeed, easetype)
            doTweenAlpha('modoption3MODIFIERcolor', 'modoption3MODIFIER', 0.5, scrollSpeed, easetype)

            doTweenX('modoption4size', 'modoption4.scale', 0.5, scrollSpeed, easetype)
            doTweenY('modoption4size2', 'modoption4.scale', 0.5, scrollSpeed, easetype)
            doTweenAlpha('modoption4color', 'modoption4', 1, scrollSpeed, easetype)
            doTweenX('modoption4MODIFIERsize', 'modoption4MODIFIER.scale', 0.5, scrollSpeed, easetype)
            doTweenY('modoption4MODIFIERsize2', 'modoption4MODIFIER.scale', 0.5, scrollSpeed, easetype)
            doTweenAlpha('modoption4MODIFIERcolor', 'modoption4MODIFIER', 1, scrollSpeed, easetype)
        end
    elseif optionsState == 'controlsoptions' then
        --
        if bindselection == 1 then
            doTweenX('moveoptionsshadow2', 'selectionOptions2', controlsoptionsX + bind1offset + 225, scrollSpeed,
                easetype)
        elseif bindselection == 2 then
            doTweenX('moveoptionsshadow2', 'selectionOptions2', controlsoptionsX + bind2offset + 225, scrollSpeed,
                easetype)
        end
        if pageselection then
            if controlspage == 1 then -- dingdong
                if selectionscontrolsoptions > 5 then
                    selectionscontrolsoptions = 5
                end
                distanceop = 1100
                
                setTextString('pagecounterNUM', ' Page 1/3\n ')
                if pagechanged then
                    if keyJustPressed('left') then
                        setProperty('pagecounterNUM.x', pagecounterNUMX + 18)
                        doTweenX('pagecounterNUMmove', 'pagecounterNUM', pagecounterNUMX, openeaseTime, 'expoOut')
                        
                        -- ui SLIDES OUT
                        doTweenX('CONTROLSOPTIONSSUB2txtTWEEN', 'controlsoptionsub2', controlsoptionsSUBX + distanceop,
                            openeaseTime, 'expoOut')
                        doTweenX('controlsoptionA1TWEEN', 'controlsoptionA1', controlsoptionsX + distanceop,
                            openeaseTime, 'expoOut')
                        doTweenX('controlsoptionA1BIND1TWEEN', 'controlsoptionA1BIND1',
                            controlsoptionsX + bind1offset + distanceop, openeaseTime, 'expoOut')
                        doTweenX('controlsoptionA1BIND2TWEEN', 'controlsoptionA1BIND2',
                            controlsoptionsX + bind2offset + distanceop, openeaseTime, 'expoOut')
                        --
                        doTweenX('controlsoptionA2TWEEN', 'controlsoptionA2', controlsoptionsX + distanceop,
                            openeaseTime, 'expoOut')
                        doTweenX('controlsoptionA2BIND1TWEEN', 'controlsoptionA2BIND1',
                            controlsoptionsX + bind1offset + distanceop, openeaseTime, 'expoOut')
                        doTweenX('controlsoptionA2BIND2TWEEN', 'controlsoptionA2BIND2',
                            controlsoptionsX + bind2offset + distanceop, openeaseTime, 'expoOut')
                        --
                        doTweenX('controlsoptionA3TWEEN', 'controlsoptionA3', controlsoptionsX + distanceop,
                            openeaseTime, 'expoOut')
                        doTweenX('controlsoptionA3BIND1TWEEN', 'controlsoptionA3BIND1',
                            controlsoptionsX + bind1offset + distanceop, openeaseTime, 'expoOut')
                        doTweenX('controlsoptionA3BIND2TWEEN', 'controlsoptionA3BIND2',
                            controlsoptionsX + bind2offset + distanceop, openeaseTime, 'expoOut')
                        --
                        doTweenX('controlsoptionA4TWEEN', 'controlsoptionA4', controlsoptionsX + distanceop,
                            openeaseTime, 'expoOut')
                        doTweenX('controlsoptionA4BIND1TWEEN', 'controlsoptionA4BIND1',
                            controlsoptionsX + bind1offset + distanceop, openeaseTime, 'expoOut')
                        doTweenX('controlsoptionA4BIND2TWEEN', 'controlsoptionA4BIND2',
                            controlsoptionsX + bind2offset + distanceop, openeaseTime, 'expoOut')
                        --
                        doTweenX('controlsoptionA5TWEEN', 'controlsoptionA5', controlsoptionsX + distanceop,
                            openeaseTime, 'expoOut')
                        doTweenX('controlsoptionA5BIND1TWEEN', 'controlsoptionA5BIND1',
                            controlsoptionsX + bind1offset + distanceop, openeaseTime, 'expoOut')
                        doTweenX('controlsoptionA5BIND2TWEEN', 'controlsoptionA5BIND2',
                            controlsoptionsX + bind2offset + distanceop, openeaseTime, 'expoOut')
                        --
                        doTweenX('controlsoptionA6TWEEN', 'controlsoptionA6', controlsoptionsX + distanceop,
                            openeaseTime, 'expoOut')
                        doTweenX('controlsoptionA6BIND1TWEEN', 'controlsoptionA6BIND1',
                            controlsoptionsX + bind1offset + distanceop, openeaseTime, 'expoOut')
                        doTweenX('controlsoptionA6BIND2TWEEN', 'controlsoptionA6BIND2',
                            controlsoptionsX + bind2offset + distanceop, openeaseTime, 'expoOut')
                        -- set positions for NOTES
                        setProperty('controlsoptionsub1.x', controlsoptionsSUBX - distanceop)
                        setProperty('controlsoption1.x', controlsoptionsX - distanceop)
                        setProperty('controlsoption1BIND1.x', controlsoptionsX + bind1offset - distanceop)
                        setProperty('controlsoption1BIND2.x', controlsoptionsX + bind2offset - distanceop)
                        setProperty('controlsoption1VISUAL.x', controlsoptionsX + controlsvisualsoffset - distanceop)

                        setProperty('controlsoption2.x', controlsoptionsX - distanceop)
                        setProperty('controlsoption2BIND1.x', controlsoptionsX + bind1offset - distanceop)
                        setProperty('controlsoption2BIND2.x', controlsoptionsX + bind2offset - distanceop)
                        setProperty('controlsoption2VISUAL.x', controlsoptionsX + controlsvisualsoffset - distanceop)

                        setProperty('controlsoption3.x', controlsoptionsX - distanceop)
                        setProperty('controlsoption3BIND1.x', controlsoptionsX + bind1offset - distanceop)
                        setProperty('controlsoption3BIND2.x', controlsoptionsX + bind2offset - distanceop)
                        setProperty('controlsoption3VISUAL.x', controlsoptionsX + controlsvisualsoffset - distanceop)

                        setProperty('controlsoption4.x', controlsoptionsX - distanceop)
                        setProperty('controlsoption4BIND1.x', controlsoptionsX + bind1offset - distanceop)
                        setProperty('controlsoption4BIND2.x', controlsoptionsX + bind2offset - distanceop)
                        setProperty('controlsoption4VISUAL.x', controlsoptionsX + controlsvisualsoffset - distanceop)

                        setProperty('controlsoption5.x', controlsoptionsX - distanceop)
                        setProperty('controlsoption5BIND1.x', controlsoptionsX + bind1offset - distanceop)
                        setProperty('controlsoption5BIND2.x', controlsoptionsX + bind2offset - distanceop)
                        setProperty('controlsoption5VISUAL.x', controlsoptionsX + controlsvisualsoffset - distanceop)
                    elseif keyJustPressed('right') then
                        setProperty('pagecounterNUM.x', pagecounterNUMX - 18)
                        doTweenX('pagecounterNUMmove', 'pagecounterNUM', pagecounterNUMX, openeaseTime, 'expoOut')
                        doTweenX('CONTROLSOPTIONSSUB3txtTWEEN', 'controlsoptionsub3', controlsoptionsSUBX - distanceop,
                            openeaseTime, 'expoOut')
                        doTweenX('controlsoptionB1TWEEN', 'controlsoptionB1', controlsoptionsX - distanceop,
                            openeaseTime, 'expoOut')
                        doTweenX('controlsoptionB1BIND1TWEEN', 'controlsoptionB1BIND1',
                            controlsoptionsX + bind1offset - distanceop, openeaseTime, 'expoOut')
                        doTweenX('controlsoptionB1BIND2TWEEN', 'controlsoptionB1BIND2',
                            controlsoptionsX + bind2offset - distanceop, openeaseTime, 'expoOut')

                        doTweenX('controlsoptionB2TWEEN', 'controlsoptionB2', controlsoptionsX + -distanceop,
                            openeaseTime, 'expoOut')
                        doTweenX('controlsoptionB2BIND1TWEEN', 'controlsoptionB2BIND1',
                            controlsoptionsX + bind1offset - distanceop, openeaseTime, 'expoOut')
                        doTweenX('controlsoptionB2BIND2TWEEN', 'controlsoptionB2BIND2',
                            controlsoptionsX + bind2offset - distanceop, openeaseTime, 'expoOut')

                        doTweenX('controlsoptionB3TWEEN', 'controlsoptionB3', controlsoptionsX - distanceop,
                            openeaseTime, 'expoOut')

                        setProperty('controlsoptionsub1.x', controlsoptionsSUBX + distanceop)
                        setProperty('controlsoption1.x', controlsoptionsX + distanceop)
                        setProperty('controlsoption1BIND1.x', controlsoptionsX + bind1offset + distanceop)
                        setProperty('controlsoption1BIND2.x', controlsoptionsX + bind2offset + distanceop)
                        setProperty('controlsoption1VISUAL.x', controlsoptionsX + controlsvisualsoffset + distanceop)

                        setProperty('controlsoption2.x', controlsoptionsX + distanceop)
                        setProperty('controlsoption2BIND1.x', controlsoptionsX + bind1offset + distanceop)
                        setProperty('controlsoption2BIND2.x', controlsoptionsX + bind2offset + distanceop)
                        setProperty('controlsoption2VISUAL.x', controlsoptionsX + controlsvisualsoffset + distanceop)

                        setProperty('controlsoption3.x', controlsoptionsX + distanceop)
                        setProperty('controlsoption3BIND1.x', controlsoptionsX + bind1offset + distanceop)
                        setProperty('controlsoption3BIND2.x', controlsoptionsX + bind2offset + distanceop)
                        setProperty('controlsoption3VISUAL.x', controlsoptionsX + controlsvisualsoffset + distanceop)

                        setProperty('controlsoption4.x', controlsoptionsX + distanceop)
                        setProperty('controlsoption4BIND1.x', controlsoptionsX + bind1offset + distanceop)
                        setProperty('controlsoption4BIND2.x', controlsoptionsX + bind2offset + distanceop)
                        setProperty('controlsoption4VISUAL.x', controlsoptionsX + controlsvisualsoffset + distanceop)

                        setProperty('controlsoption5.x', controlsoptionsX + distanceop)
                        setProperty('controlsoption5BIND1.x', controlsoptionsX + bind1offset + distanceop)
                        setProperty('controlsoption5BIND2.x', controlsoptionsX + bind2offset + distanceop)
                        setProperty('controlsoption5VISUAL.x', controlsoptionsX + controlsvisualsoffset + distanceop)
                    end
                    pagechanged = false
                end
                doTweenX('CONTROLSOPTIONSSUBtxtTWEEN', 'controlsoptionsub1', controlsoptionsSUBX, openeaseTime,
                    'expoOut')
                --
                doTweenX('controlsoption1TWEEN', 'controlsoption1', controlsoptionsX, openeaseTime, 'expoOut')
                doTweenX('controlsoption1BIND1TWEEN', 'controlsoption1BIND1', controlsoptionsX + bind1offset,
                    openeaseTime, 'expoOut')
                doTweenX('controlsoption1BIND2TWEEN', 'controlsoption1BIND2', controlsoptionsX + bind2offset,
                    openeaseTime, 'expoOut')
                doTweenX('controlsoption1VISUALTWEEN', 'controlsoption1VISUAL',
                    controlsoptionsX + controlsvisualsoffset, openeaseTime, 'expoOut')
                --
                doTweenX('controlsoption2TWEEN', 'controlsoption2', controlsoptionsX, openeaseTime, 'expoOut')
                doTweenX('controlsoption2BIND1TWEEN', 'controlsoption2BIND1', controlsoptionsX + bind1offset,
                    openeaseTime, 'expoOut')
                doTweenX('controlsoption2BIND2TWEEN', 'controlsoption2BIND2', controlsoptionsX + bind2offset,
                    openeaseTime, 'expoOut')
                doTweenX('controlsoption2VISUALTWEEN', 'controlsoption2VISUAL',
                    controlsoptionsX + controlsvisualsoffset, openeaseTime, 'expoOut')
                --
                doTweenX('controlsoption3TWEEN', 'controlsoption3', controlsoptionsX, openeaseTime, 'expoOut')
                doTweenX('controlsoption3BIND1TWEEN', 'controlsoption3BIND1', controlsoptionsX + bind1offset,
                    openeaseTime, 'expoOut')
                doTweenX('controlsoption3BIND2TWEEN', 'controlsoption3BIND2', controlsoptionsX + bind2offset,
                    openeaseTime, 'expoOut')
                doTweenX('controlsoption3VISUALTWEEN', 'controlsoption3VISUAL',
                    controlsoptionsX + controlsvisualsoffset, openeaseTime, 'expoOut')
                --
                doTweenX('controlsoption4TWEEN', 'controlsoption4', controlsoptionsX, openeaseTime, 'expoOut')
                doTweenX('controlsoption4BIND1TWEEN', 'controlsoption4BIND1', controlsoptionsX + bind1offset,
                    openeaseTime, 'expoOut')
                doTweenX('controlsoption4BIND2TWEEN', 'controlsoption4BIND2', controlsoptionsX + bind2offset,
                    openeaseTime, 'expoOut')
                doTweenX('controlsoption4VISUALTWEEN', 'controlsoption4VISUAL',
                    controlsoptionsX + controlsvisualsoffset, openeaseTime, 'expoOut')
                --
                doTweenX('controlsoption5TWEEN', 'controlsoption5', controlsoptionsX, openeaseTime, 'expoOut')
                doTweenX('controlsoption5BIND1TWEEN', 'controlsoption5BIND1', controlsoptionsX + bind1offset,
                    openeaseTime, 'expoOut')
                doTweenX('controlsoption5BIND2TWEEN', 'controlsoption5BIND2', controlsoptionsX + bind2offset,
                    openeaseTime, 'expoOut')
                doTweenX('controlsoption5VISUALTWEEN', 'controlsoption5VISUAL',
                    controlsoptionsX + controlsvisualsoffset, openeaseTime, 'expoOut')
                --
                if selectionscontrolsoptions == 1 then
                    doTweenY('moveoptionsshadow', 'selectionOptions', controlsoption1Y + 5, scrollSpeed, easetype)
                elseif selectionscontrolsoptions == 2 then
                    doTweenY('moveoptionsshadow', 'selectionOptions', controlsoption2Y + 5, scrollSpeed, easetype)
                elseif selectionscontrolsoptions == 3 then
                    doTweenY('moveoptionsshadow', 'selectionOptions', controlsoption3Y + 5, scrollSpeed, easetype)
                elseif selectionscontrolsoptions == 4 then
                    doTweenY('moveoptionsshadow', 'selectionOptions', controlsoption4Y + 5, scrollSpeed, easetype)
                elseif selectionscontrolsoptions == 5 then
                    doTweenY('moveoptionsshadow', 'selectionOptions', controlsoption5Y + 5, scrollSpeed, easetype)
                end
                local scalefuck = 0.3
                for i = 1, 5 do
                    if selectionscontrolsoptions == i and bindselection == 1 then
                        doTweenAlpha('controlsoption' .. i .. 'BIND1ALPHA', 'controlsoption' .. i .. 'BIND1', 1,
                            openeaseTime, easetype)
                        doTweenX('controlsoption' .. i .. 'BIND1SIZEX', 'controlsoption' .. i .. 'BIND1.scale', 0.5,
                            openeaseTime, easetype)
                        doTweenY('controlsoption' .. i .. 'BIND1SIZEY', 'controlsoption' .. i .. 'BIND1.scale', 0.5,
                            openeaseTime, easetype)
                    else
                        doTweenAlpha('controlsoption' .. i .. 'BIND1ALPHA', 'controlsoption' .. i .. 'BIND1', scalefuck,
                            openeaseTime, easetype)
                        doTweenX('controlsoption' .. i .. 'BIND1SIZEX', 'controlsoption' .. i .. 'BIND1.scale',
                            scalefuck, openeaseTime, easetype)
                        doTweenY('controlsoption' .. i .. 'BIND1SIZEY', 'controlsoption' .. i .. 'BIND1.scale',
                            scalefuck, openeaseTime, easetype)
                    end
                    for i = 1, 5 do
                        if selectionscontrolsoptions == i and bindselection == 2 then
                            doTweenAlpha('controlsoption' .. i .. 'BIND2ALPHA', 'controlsoption' .. i .. 'BIND2', 1,
                                openeaseTime, easetype)
                            doTweenX('controlsoption' .. i .. 'BIND2SIZEX', 'controlsoption' .. i .. 'BIND2.scale', 0.5,
                                openeaseTime, easetype)
                            doTweenY('controlsoption' .. i .. 'BIND2SIZEY', 'controlsoption' .. i .. 'BIND2.scale', 0.5,
                                openeaseTime, easetype)
                        else
                            doTweenAlpha('controlsoption' .. i .. 'BIND2ALPHA', 'controlsoption' .. i .. 'BIND2',
                                scalefuck, openeaseTime, easetype)
                            doTweenX('controlsoption' .. i .. 'BIND2SIZEX', 'controlsoption' .. i .. 'BIND2.scale',
                                scalefuck, openeaseTime, easetype)
                            doTweenY('controlsoption' .. i .. 'BIND2SIZEY', 'controlsoption' .. i .. 'BIND2.scale',
                                scalefuck, openeaseTime, easetype)
                        end
                    end
                end
            elseif controlspage == 2 then
                if getProperty('selectionOptions2.alpha') < 0.5 then
                    doTweenAlpha('selectionOptions2alpha', 'selectionOptions2', 0.5, openeaseTime, 'expoOut')
                end
                if pagechanged then
                    setTextString('pagecounterNUM', ' Page 2/3\n ')
                    if keyJustPressed('left') then
                        setProperty('pagecounterNUM.x', pagecounterNUMX + 18)
                        doTweenX('pagecounterNUMmove', 'pagecounterNUM', pagecounterNUMX, openeaseTime, 'expoOut')
                        doTweenX('CONTROLSOPTIONSSUB3txtTWEEN', 'controlsoptionsub3', controlsoptionsSUBX + distanceop,
                            openeaseTime, 'expoOut')
                        doTweenX('controlsoptionB1TWEEN', 'controlsoptionB1', controlsoptionsX + distanceop,
                            openeaseTime, 'expoOut')
                        doTweenX('controlsoptionB1BIND1TWEEN', 'controlsoptionB1BIND1',
                            controlsoptionsX + bind1offset + distanceop, openeaseTime, 'expoOut')
                        doTweenX('controlsoptionB1BIND2TWEEN', 'controlsoptionB1BIND2',
                            controlsoptionsX + bind2offset + distanceop, openeaseTime, 'expoOut')

                        doTweenX('controlsoptionB2TWEEN', 'controlsoptionB2', controlsoptionsX + distanceop,
                            openeaseTime, 'expoOut')
                        doTweenX('controlsoptionB2BIND1TWEEN', 'controlsoptionB2BIND1',
                            controlsoptionsX + bind1offset + distanceop, openeaseTime, 'expoOut')
                        doTweenX('controlsoptionB2BIND2TWEEN', 'controlsoptionB2BIND2',
                            controlsoptionsX + bind2offset + distanceop, openeaseTime, 'expoOut')

                        doTweenX('controlsoptionB3TWEEN', 'controlsoptionB3', controlsoptionsX + distanceop,
                            openeaseTime, 'expoOut')

                        setProperty('controlsoptionA1.x', controlsoptionsX - distanceop)
                        setProperty('controlsoptionA1BIND1.x', controlsoptionsX + bind1offset - distanceop)
                        setProperty('controlsoptionA1BIND2.x', controlsoptionsX + bind2offset - distanceop)

                        setProperty('controlsoptionA2.x', controlsoptionsX - distanceop)
                        setProperty('controlsoptionA2BIND1.x', controlsoptionsX + bind1offset - distanceop)
                        setProperty('controlsoptionA2BIND2.x', controlsoptionsX + bind2offset - distanceop)

                        setProperty('controlsoptionA3.x', controlsoptionsX - distanceop)
                        setProperty('controlsoptionA3BIND1.x', controlsoptionsX + bind1offset - distanceop)
                        setProperty('controlsoptionA3BIND2.x', controlsoptionsX + bind2offset - distanceop)

                        setProperty('controlsoptionA4.x', controlsoptionsX - distanceop)
                        setProperty('controlsoptionA4BIND1.x', controlsoptionsX + bind1offset - distanceop)
                        setProperty('controlsoptionA4BIND2.x', controlsoptionsX + bind2offset - distanceop)

                        setProperty('controlsoptionA5.x', controlsoptionsX - distanceop)
                        setProperty('controlsoptionA5BIND1.x', controlsoptionsX + bind1offset - distanceop)
                        setProperty('controlsoptionA5BIND2.x', controlsoptionsX + bind2offset - distanceop)

                        setProperty('controlsoptionA6.x', controlsoptionsX - distanceop)
                        setProperty('controlsoptionA6BIND1.x', controlsoptionsX + bind1offset - distanceop)
                        setProperty('controlsoptionA6BIND2.x', controlsoptionsX + bind2offset - distanceop)
                        setProperty('controlsoptionsub2.x', controlsoptionsSUBX - distanceop)
                    elseif keyJustPressed('right') then
                        setProperty('pagecounterNUM.x', pagecounterNUMX - 18)
                        doTweenX('pagecounterNUMmove', 'pagecounterNUM', pagecounterNUMX, openeaseTime, 'expoOut')
                        doTweenX('CONTROLSOPTIONSSUBtxtTWEEN', 'controlsoptionsub1', controlsoptionsSUBX - distanceop,
                            openeaseTime, 'expoOut')

                        setProperty('controlsoptionA1.x', controlsoptionsX + distanceop)
                        setProperty('controlsoptionA1BIND1.x', controlsoptionsX + bind1offset + distanceop)
                        setProperty('controlsoptionA1BIND2.x', controlsoptionsX + bind2offset + distanceop)

                        setProperty('controlsoptionA2.x', controlsoptionsX + distanceop)
                        setProperty('controlsoptionA2BIND1.x', controlsoptionsX + bind1offset + distanceop)
                        setProperty('controlsoptionA2BIND2.x', controlsoptionsX + bind2offset + distanceop)

                        setProperty('controlsoptionA3.x', controlsoptionsX + distanceop)
                        setProperty('controlsoptionA3BIND1.x', controlsoptionsX + bind1offset + distanceop)
                        setProperty('controlsoptionA3BIND2.x', controlsoptionsX + bind2offset + distanceop)

                        setProperty('controlsoptionA4.x', controlsoptionsX + distanceop)
                        setProperty('controlsoptionA4BIND1.x', controlsoptionsX + bind1offset + distanceop)
                        setProperty('controlsoptionA4BIND2.x', controlsoptionsX + bind2offset + distanceop)

                        setProperty('controlsoptionA5.x', controlsoptionsX + distanceop)
                        setProperty('controlsoptionA5BIND1.x', controlsoptionsX + bind1offset + distanceop)
                        setProperty('controlsoptionA5BIND2.x', controlsoptionsX + bind2offset + distanceop)

                        setProperty('controlsoptionA6.x', controlsoptionsX + distanceop)
                        setProperty('controlsoptionA6BIND1.x', controlsoptionsX + bind1offset + distanceop)
                        setProperty('controlsoptionA6BIND2.x', controlsoptionsX + bind2offset + distanceop)
                        --
                        --
                        doTweenX('controlsoption1TWEEN', 'controlsoption1', controlsoptionsX - distanceop, openeaseTime,
                            'expoOut')
                        doTweenX('controlsoption1BIND1TWEEN', 'controlsoption1BIND1',
                            controlsoptionsX + bind1offset - distanceop, openeaseTime, 'expoOut')
                        doTweenX('controlsoption1BIND2TWEEN', 'controlsoption1BIND2',
                            controlsoptionsX + bind2offset - distanceop, openeaseTime, 'expoOut')
                        doTweenX('controlsoption1VISUALTWEEN', 'controlsoption1VISUAL',
                            controlsoptionsX + controlsvisualsoffset - distanceop, openeaseTime, 'expoOut')
                        --
                        doTweenX('controlsoption2TWEEN', 'controlsoption2', controlsoptionsX - distanceop, openeaseTime,
                            'expoOut')
                        doTweenX('controlsoption2BIND1TWEEN', 'controlsoption2BIND1',
                            controlsoptionsX + bind1offset - distanceop, openeaseTime, 'expoOut')
                        doTweenX('controlsoption2BIND2TWEEN', 'controlsoption2BIND2',
                            controlsoptionsX + bind2offset - distanceop, openeaseTime, 'expoOut')
                        doTweenX('controlsoption2VISUALTWEEN', 'controlsoption2VISUAL',
                            controlsoptionsX + controlsvisualsoffset - distanceop, openeaseTime, 'expoOut')
                        --

                        doTweenX('controlsoption3TWEEN', 'controlsoption3', controlsoptionsX - distanceop, openeaseTime,
                            'expoOut')
                        doTweenX('controlsoption3BIND1TWEEN', 'controlsoption3BIND1',
                            controlsoptionsX + bind1offset - distanceop, openeaseTime, 'expoOut')
                        doTweenX('controlsoption3BIND2TWEEN', 'controlsoption3BIND2',
                            controlsoptionsX + bind2offset - distanceop, openeaseTime, 'expoOut')
                        doTweenX('controlsoption3VISUALTWEEN', 'controlsoption3VISUAL',
                            controlsoptionsX + controlsvisualsoffset - distanceop, openeaseTime, 'expoOut')
                        --
                        doTweenX('controlsoption4TWEEN', 'controlsoption4', controlsoptionsX - distanceop, openeaseTime,
                            'expoOut')
                        doTweenX('controlsoption4BIND1TWEEN', 'controlsoption4BIND1',
                            controlsoptionsX + bind1offset - distanceop, openeaseTime, 'expoOut')
                        doTweenX('controlsoption4BIND2TWEEN', 'controlsoption4BIND2',
                            controlsoptionsX + bind2offset - distanceop, openeaseTime, 'expoOut')
                        doTweenX('controlsoption4VISUALTWEEN', 'controlsoption4VISUAL',
                            controlsoptionsX + controlsvisualsoffset - distanceop, openeaseTime, 'expoOut')
                        --
                        doTweenX('controlsoption5TWEEN', 'controlsoption5', controlsoptionsX - distanceop, openeaseTime,
                            'expoOut')
                        doTweenX('controlsoption5BIND1TWEEN', 'controlsoption5BIND1',
                            controlsoptionsX + bind1offset - distanceop, openeaseTime, 'expoOut')
                        doTweenX('controlsoption5BIND2TWEEN', 'controlsoption5BIND2',
                            controlsoptionsX + bind2offset - distanceop, openeaseTime, 'expoOut')
                        doTweenX('controlsoption5VISUALTWEEN', 'controlsoption5VISUAL',
                            controlsoptionsX + controlsvisualsoffset - distanceop, openeaseTime, 'expoOut')
                        setProperty('controlsoptionsub2.x', controlsoptionsSUBX + distanceop)
                    end
                    pagechanged = false
                end
                doTweenX('CONTROLSOPTIONSSUB2txtTWEEN', 'controlsoptionsub2', controlsoptionsSUBX, openeaseTime,
                    'expoOut')
                --

                doTweenX('controlsoptionA1TWEEN', 'controlsoptionA1', controlsoptionsX, openeaseTime, 'expoOut')
                doTweenX('controlsoptionA1BIND1TWEEN', 'controlsoptionA1BIND1', controlsoptionsX + bind1offset,
                    openeaseTime, 'expoOut')
                doTweenX('controlsoptionA1BIND2TWEEN', 'controlsoptionA1BIND2', controlsoptionsX + bind2offset,
                    openeaseTime, 'expoOut')
                --
                doTweenX('controlsoptionA2TWEEN', 'controlsoptionA2', controlsoptionsX, openeaseTime, 'expoOut')
                doTweenX('controlsoptionA2BIND1TWEEN', 'controlsoptionA2BIND1', controlsoptionsX + bind1offset,
                    openeaseTime, 'expoOut')
                doTweenX('controlsoptionA2BIND2TWEEN', 'controlsoptionA2BIND2', controlsoptionsX + bind2offset,
                    openeaseTime, 'expoOut')
                --
                doTweenX('controlsoptionA3TWEEN', 'controlsoptionA3', controlsoptionsX, openeaseTime, 'expoOut')
                doTweenX('controlsoptionA3BIND1TWEEN', 'controlsoptionA3BIND1', controlsoptionsX + bind1offset,
                    openeaseTime, 'expoOut')
                doTweenX('controlsoptionA3BIND2TWEEN', 'controlsoptionA3BIND2', controlsoptionsX + bind2offset,
                    openeaseTime, 'expoOut')
                --
                doTweenX('controlsoptionA4TWEEN', 'controlsoptionA4', controlsoptionsX, openeaseTime, 'expoOut')
                doTweenX('controlsoptionA4BIND1TWEEN', 'controlsoptionA4BIND1', controlsoptionsX + bind1offset,
                    openeaseTime, 'expoOut')
                doTweenX('controlsoptionA4BIND2TWEEN', 'controlsoptionA4BIND2', controlsoptionsX + bind2offset,
                    openeaseTime, 'expoOut')
                --
                doTweenX('controlsoptionA5TWEEN', 'controlsoptionA5', controlsoptionsX, openeaseTime, 'expoOut')
                doTweenX('controlsoptionA5BIND1TWEEN', 'controlsoptionA5BIND1', controlsoptionsX + bind1offset,
                    openeaseTime, 'expoOut')
                doTweenX('controlsoptionA5BIND2TWEEN', 'controlsoptionA5BIND2', controlsoptionsX + bind2offset,
                    openeaseTime, 'expoOut')
                --
                doTweenX('controlsoptionA6TWEEN', 'controlsoptionA6', controlsoptionsX, openeaseTime, 'expoOut')
                doTweenX('controlsoptionA6BIND1TWEEN', 'controlsoptionA6BIND1', controlsoptionsX + bind1offset,
                    openeaseTime, 'expoOut')
                doTweenX('controlsoptionA6BIND2TWEEN', 'controlsoptionA6BIND2', controlsoptionsX + bind2offset,
                    openeaseTime, 'expoOut')
                --
                if selectionscontrolsoptions == 1 then
                    doTweenY('moveoptionsshadow', 'selectionOptions', controlsoptionA1Y + 5, scrollSpeed, easetype)
                elseif selectionscontrolsoptions == 2 then
                    doTweenY('moveoptionsshadow', 'selectionOptions', controlsoptionA2Y + 5, scrollSpeed, easetype)
                elseif selectionscontrolsoptions == 3 then
                    doTweenY('moveoptionsshadow', 'selectionOptions', controlsoptionA3Y + 5, scrollSpeed, easetype)
                elseif selectionscontrolsoptions == 4 then
                    doTweenY('moveoptionsshadow', 'selectionOptions', controlsoptionA4Y + 5, scrollSpeed, easetype)
                elseif selectionscontrolsoptions == 5 then
                    doTweenY('moveoptionsshadow', 'selectionOptions', controlsoptionA5Y + 5, scrollSpeed, easetype)
                elseif selectionscontrolsoptions == 6 then
                    doTweenY('moveoptionsshadow', 'selectionOptions', controlsoptionA6Y + 5, scrollSpeed, easetype)
                end
                local scalefuck = 0.3
                for i = 1, 6 do
                    if selectionscontrolsoptions == i and bindselection == 1 then
                        doTweenAlpha('controlsoptionA' .. i .. 'BIND1ALPHA', 'controlsoptionA' .. i .. 'BIND1', 1,
                            openeaseTime, easetype)
                        doTweenX('controlsoptionA' .. i .. 'BIND1SIZEX', 'controlsoptionA' .. i .. 'BIND1.scale', 0.5,
                            openeaseTime, easetype)
                        doTweenY('controlsoptionA' .. i .. 'BIND1SIZEY', 'controlsoptionA' .. i .. 'BIND1.scale', 0.5,
                            openeaseTime, easetype)
                    else
                        doTweenAlpha('controlsoptionA' .. i .. 'BIND1ALPHA', 'controlsoptionA' .. i .. 'BIND1',
                            scalefuck, openeaseTime, easetype)
                        doTweenX('controlsoptionA' .. i .. 'BIND1SIZEX', 'controlsoptionA' .. i .. 'BIND1.scale',
                            scalefuck, openeaseTime, easetype)
                        doTweenY('controlsoptionA' .. i .. 'BIND1SIZEY', 'controlsoptionA' .. i .. 'BIND1.scale',
                            scalefuck, openeaseTime, easetype)
                    end
                    if selectionscontrolsoptions == i and bindselection == 2 then
                        doTweenAlpha('controlsoptionA' .. i .. 'BIND2ALPHA', 'controlsoptionA' .. i .. 'BIND2', 1,
                            openeaseTime, easetype)
                        doTweenX('controlsoptionA' .. i .. 'BIND2SIZEX', 'controlsoptionA' .. i .. 'BIND2.scale',
                            0.5, openeaseTime, easetype)
                        doTweenY('controlsoptionA' .. i .. 'BIND2SIZEY', 'controlsoptionA' .. i .. 'BIND2.scale',
                            0.5, openeaseTime, easetype)
                    else
                        doTweenAlpha('controlsoptionA' .. i .. 'BIND2ALPHA', 'controlsoptionA' .. i .. 'BIND2',
                            scalefuck, openeaseTime, easetype)
                        doTweenX('controlsoptionA' .. i .. 'BIND2SIZEX', 'controlsoptionA' .. i .. 'BIND2.scale',
                            scalefuck, openeaseTime, easetype)
                        doTweenY('controlsoptionA' .. i .. 'BIND2SIZEY', 'controlsoptionA' .. i .. 'BIND2.scale',
                            scalefuck, openeaseTime, easetype)
                    end
                end
            elseif controlspage == 3 then
                if getProperty('selectionOptions2.alpha') < 0.5 then
                    doTweenAlpha('selectionOptions2alpha', 'selectionOptions2', 0.5, openeaseTime, 'expoOut')
                end
                if selectionscontrolsoptions > 3 then
                    selectionscontrolsoptions = 3
                end
                if pagechanged then
                    setTextString('pagecounterNUM', ' Page 3/3\n ')
                    if keyJustPressed('left') then
                        setProperty('pagecounterNUM.x', pagecounterNUMX + 18)
                        doTweenX('pagecounterNUMmove', 'pagecounterNUM', pagecounterNUMX, openeaseTime, 'expoOut')
                        doTweenX('CONTROLSOPTIONSSUBtxtTWEEN', 'controlsoptionsub1', controlsoptionsSUBX + distanceop,
                            openeaseTime, 'expoOut')
                        doTweenX('controlsoption1TWEEN', 'controlsoption1', controlsoptionsX + distanceop, openeaseTime,
                            'expoOut')
                        doTweenX('controlsoption1BIND1TWEEN', 'controlsoption1BIND1',
                            controlsoptionsX + bind1offset + distanceop, openeaseTime, 'expoOut')
                        doTweenX('controlsoption1BIND2TWEEN', 'controlsoption1BIND2',
                            controlsoptionsX + bind2offset + distanceop, openeaseTime, 'expoOut')
                        doTweenX('controlsoption1VISUALTWEEN', 'controlsoption1VISUAL',
                            controlsoptionsX + controlsvisualsoffset + distanceop, openeaseTime, 'expoOut')
                        --
                        doTweenX('controlsoption2TWEEN', 'controlsoption2', controlsoptionsX + distanceop, openeaseTime,
                            'expoOut')
                        doTweenX('controlsoption2BIND1TWEEN', 'controlsoption2BIND1',
                            controlsoptionsX + bind1offset + distanceop, openeaseTime, 'expoOut')
                        doTweenX('controlsoption2BIND2TWEEN', 'controlsoption2BIND2',
                            controlsoptionsX + bind2offset + distanceop, openeaseTime, 'expoOut')
                        doTweenX('controlsoption2VISUALTWEEN', 'controlsoption2VISUAL',
                            controlsoptionsX + controlsvisualsoffset + distanceop, openeaseTime, 'expoOut')
                        --
                        doTweenX('controlsoption3TWEEN', 'controlsoption3', controlsoptionsX + distanceop, openeaseTime,
                            'expoOut')
                        doTweenX('controlsoption3BIND1TWEEN', 'controlsoption3BIND1',
                            controlsoptionsX + bind1offset + distanceop, openeaseTime, 'expoOut')
                        doTweenX('controlsoption3BIND2TWEEN', 'controlsoption3BIND2',
                            controlsoptionsX + bind2offset + distanceop, openeaseTime, 'expoOut')
                        doTweenX('controlsoption3VISUALTWEEN', 'controlsoption3VISUAL',
                            controlsoptionsX + controlsvisualsoffset + distanceop, openeaseTime, 'expoOut')
                        --
                        doTweenX('controlsoption4TWEEN', 'controlsoption4', controlsoptionsX + distanceop, openeaseTime,
                            'expoOut')
                        doTweenX('controlsoption4BIND1TWEEN', 'controlsoption4BIND1',
                            controlsoptionsX + bind1offset + distanceop, openeaseTime, 'expoOut')
                        doTweenX('controlsoption4BIND2TWEEN', 'controlsoption4BIND2',
                            controlsoptionsX + bind2offset + distanceop, openeaseTime, 'expoOut')
                        doTweenX('controlsoption4VISUALTWEEN', 'controlsoption4VISUAL',
                            controlsoptionsX + controlsvisualsoffset + distanceop, openeaseTime, 'expoOut')
                        --
                        doTweenX('controlsoption5TWEEN', 'controlsoption5', controlsoptionsX + distanceop, openeaseTime,
                            'expoOut')
                        doTweenX('controlsoption5BIND1TWEEN', 'controlsoption5BIND1',
                            controlsoptionsX + bind1offset + distanceop, openeaseTime, 'expoOut')
                        doTweenX('controlsoption5BIND2TWEEN', 'controlsoption5BIND2',
                            controlsoptionsX + bind2offset + distanceop, openeaseTime, 'expoOut')
                        doTweenX('controlsoption5VISUALTWEEN', 'controlsoption5VISUAL',
                            controlsoptionsX + controlsvisualsoffset + distanceop, openeaseTime, 'expoOut')
                        setProperty('controlsoptionsub2.x', controlsoptionsSUBX + distanceop)
                        setProperty('controlsoptionsub3.x', controlsoptionsSUBX - distanceop)

                        setProperty('controlsoptionsub3.x', controlsoptionsSUBX - distanceop)
                        setProperty('controlsoptionB1.x', controlsoptionsSUBX - distanceop)
                        setProperty('controlsoptionB1BIND1.x', controlsoptionsSUBX + bind1offset - distanceop)
                        setProperty('controlsoptionB1BIND2.x', controlsoptionsSUBX + bind1offset - distanceop)
                        setProperty('controlsoptionB2.x', controlsoptionsSUBX - distanceop)
                        setProperty('controlsoptionB2BIND1.x', controlsoptionsSUBX + bind1offset - distanceop)
                        setProperty('controlsoptionB2BIND2.x', controlsoptionsSUBX + bind1offset - distanceop)
                        setProperty('controlsoptionB3.x', controlsoptionsSUBX - distanceop)
                    elseif keyJustPressed('right') then
                        setProperty('pagecounterNUM.x', pagecounterNUMX - 18)
                        doTweenX('pagecounterNUMmove', 'pagecounterNUM', pagecounterNUMX, openeaseTime, 'expoOut')
                        doTweenX('CONTROLSOPTIONSSUB2txtTWEEN', 'controlsoptionsub2', controlsoptionsSUBX - distanceop,
                            openeaseTime, 'expoOut')
                        doTweenX('controlsoptionA1TWEEN', 'controlsoptionA1', controlsoptionsX - distanceop,
                            openeaseTime, 'expoOut')
                        doTweenX('controlsoptionA1BIND1TWEEN', 'controlsoptionA1BIND1',
                            controlsoptionsX + bind1offset - distanceop, openeaseTime, 'expoOut')
                        doTweenX('controlsoptionA1BIND2TWEEN', 'controlsoptionA1BIND2',
                            controlsoptionsX + bind2offset - distanceop, openeaseTime, 'expoOut')
                        --
                        doTweenX('controlsoptionA2TWEEN', 'controlsoptionA2', controlsoptionsX - distanceop,
                            openeaseTime, 'expoOut')
                        doTweenX('controlsoptionA2BIND1TWEEN', 'controlsoptionA2BIND1',
                            controlsoptionsX + bind1offset - distanceop, openeaseTime, 'expoOut')
                        doTweenX('controlsoptionA2BIND2TWEEN', 'controlsoptionA2BIND2',
                            controlsoptionsX + bind2offset - distanceop, openeaseTime, 'expoOut')
                        --
                        doTweenX('controlsoptionA3TWEEN', 'controlsoptionA3', controlsoptionsX - distanceop,
                            openeaseTime, 'expoOut')
                        doTweenX('controlsoptionA3BIND1TWEEN', 'controlsoptionA3BIND1',
                            controlsoptionsX + bind1offset - distanceop, openeaseTime, 'expoOut')
                        doTweenX('controlsoptionA3BIND2TWEEN', 'controlsoptionA3BIND2',
                            controlsoptionsX + bind2offset - distanceop, openeaseTime, 'expoOut')
                        --
                        doTweenX('controlsoptionA4TWEEN', 'controlsoptionA4', controlsoptionsX - distanceop,
                            openeaseTime, 'expoOut')
                        doTweenX('controlsoptionA4BIND1TWEEN', 'controlsoptionA4BIND1',
                            controlsoptionsX + bind1offset - distanceop, openeaseTime, 'expoOut')
                        doTweenX('controlsoptionA4BIND2TWEEN', 'controlsoptionA4BIND2',
                            controlsoptionsX + bind2offset - distanceop, openeaseTime, 'expoOut')
                        --
                        doTweenX('controlsoptionA5TWEEN', 'controlsoptionA5', controlsoptionsX - distanceop,
                            openeaseTime, 'expoOut')
                        doTweenX('controlsoptionA5BIND1TWEEN', 'controlsoptionA5BIND1',
                            controlsoptionsX + bind1offset - distanceop, openeaseTime, 'expoOut')
                        doTweenX('controlsoptionA5BIND2TWEEN', 'controlsoptionA5BIND2',
                            controlsoptionsX + bind2offset - distanceop, openeaseTime, 'expoOut')
                        --
                        doTweenX('controlsoptionA6TWEEN', 'controlsoptionA6', controlsoptionsX - distanceop,
                            openeaseTime, 'expoOut')
                        doTweenX('controlsoptionA6BIND1TWEEN', 'controlsoptionA6BIND1',
                            controlsoptionsX + bind1offset - distanceop, openeaseTime, 'expoOut')
                        doTweenX('controlsoptionA6BIND2TWEEN', 'controlsoptionA6BIND2',
                            controlsoptionsX + bind2offset - distanceop, openeaseTime, 'expoOut')
                        --
                        setProperty('controlsoptionsub3.x', controlsoptionsSUBX + distanceop)
                        setProperty('controlsoptionB1.x', controlsoptionsSUBX + distanceop)
                        setProperty('controlsoptionB1BIND1.x', controlsoptionsSUBX + bind1offset + distanceop)
                        setProperty('controlsoptionB1BIND2.x', controlsoptionsSUBX + bind1offset + distanceop)
                        setProperty('controlsoptionB2.x', controlsoptionsSUBX + distanceop)
                        setProperty('controlsoptionB2BIND1.x', controlsoptionsSUBX + bind1offset + distanceop)
                        setProperty('controlsoptionB2BIND2.x', controlsoptionsSUBX + bind1offset + distanceop)
                        setProperty('controlsoptionB3.x', controlsoptionsSUBX + distanceop)
                    end
                    pagechanged = false
                end

                doTweenX('controlsoptionB1TWEEN', 'controlsoptionB1', controlsoptionsX, openeaseTime, 'expoOut')
                doTweenX('controlsoptionB1BIND1TWEEN', 'controlsoptionB1BIND1', controlsoptionsX + bind1offset,
                    openeaseTime, 'expoOut')
                doTweenX('controlsoptionB1BIND2TWEEN', 'controlsoptionB1BIND2', controlsoptionsX + bind2offset,
                    openeaseTime, 'expoOut')

                doTweenX('controlsoptionB2TWEEN', 'controlsoptionB2', controlsoptionsX, openeaseTime, 'expoOut')
                doTweenX('controlsoptionB2BIND1TWEEN', 'controlsoptionB2BIND1', controlsoptionsX + bind1offset,
                    openeaseTime, 'expoOut')
                doTweenX('controlsoptionB2BIND2TWEEN', 'controlsoptionB2BIND2', controlsoptionsX + bind2offset,
                    openeaseTime, 'expoOut')

                doTweenX('controlsoptionB3TWEEN', 'controlsoptionB3', controlsoptionsX, openeaseTime, 'expoOut')

                doTweenX('CONTROLSOPTIONSSUB3txtTWEEN', 'controlsoptionsub3', controlsoptionsSUBX, openeaseTime,
                    'expoOut')
                    if selectionscontrolsoptions == 1 then
                    doTweenY('moveoptionsshadow', 'selectionOptions', controlsoptionB1Y + 5, scrollSpeed, easetype)
                elseif selectionscontrolsoptions == 2 then
                    doTweenY('moveoptionsshadow', 'selectionOptions', controlsoptionB2Y + 5, scrollSpeed, easetype)
                elseif selectionscontrolsoptions == 3 then
                    doTweenY('moveoptionsshadow', 'selectionOptions', controlsoptionB3Y + 5, scrollSpeed, easetype)
                end
                local scalefuck = 0.3
                if selectionscontrolsoptions == 3 then
                    if getProperty('selectionOptions2.alpha') > 0 then
                        doTweenAlpha('selectionOptions2alpha', 'selectionOptions2', 0, openeaseTime, 'expoOut')
                    end
                    if keyJustPressed('right') then
                        bindselection = bindselection + 1
                    elseif keyJustPressed('left') then
                        bindselection = bindselection - 1
                    end
                    doTweenAlpha('controlsoptionB3ALPHA', 'controlsoptionB3', 1, openeaseTime, easetype)
                    doTweenX('controlsoptionB3SIZEX', 'controlsoptionB3.scale', 0.5, openeaseTime, easetype)
                    doTweenY('controlsoptionB3SIZEY', 'controlsoptionB3.scale', 0.5, openeaseTime, easetype)
                else
                    if getProperty('selectionOptions2.alpha') < 0.5 then
                        doTweenAlpha('selectionOptions2alpha', 'selectionOptions2', 0.5, openeaseTime, 'expoOut')
                    end
                    doTweenAlpha('controlsoptionB3ALPHA', 'controlsoptionB3', scalefuck, openeaseTime, easetype)
                    doTweenX('controlsoptionB3SIZEX', 'controlsoptionB3.scale', scalefuck, openeaseTime, easetype)
                    doTweenY('controlsoptionB3SIZEY', 'controlsoptionB3.scale', scalefuck, openeaseTime, easetype)
                end
                for i = 1, 2 do
                    if selectionscontrolsoptions == i and bindselection == 1 then
                        doTweenAlpha('controlsoptionB' .. i .. 'BIND1ALPHA', 'controlsoptionB' .. i .. 'BIND1', 1,
                            openeaseTime, easetype)
                        doTweenX('controlsoptionB' .. i .. 'BIND1SIZEX', 'controlsoptionB' .. i .. 'BIND1.scale', 0.5,
                            openeaseTime, easetype)
                        doTweenY('controlsoptionB' .. i .. 'BIND1SIZEY', 'controlsoptionB' .. i .. 'BIND1.scale', 0.5,
                            openeaseTime, easetype)
                    else
                        doTweenAlpha('controlsoptionB' .. i .. 'BIND1ALPHA', 'controlsoptionB' .. i .. 'BIND1',
                            scalefuck, openeaseTime, easetype)
                        doTweenX('controlsoptionB' .. i .. 'BIND1SIZEX', 'controlsoptionB' .. i .. 'BIND1.scale',
                            scalefuck, openeaseTime, easetype)
                        doTweenY('controlsoptionB' .. i .. 'BIND1SIZEY', 'controlsoptionB' .. i .. 'BIND1.scale',scalefuck, openeaseTime, easetype)
                    end
                    if selectionscontrolsoptions == i and bindselection == 2 then
                        doTweenAlpha('controlsoptionB' .. i .. 'BIND2ALPHA', 'controlsoptionB' .. i .. 'BIND2', 1,
                            openeaseTime, easetype)
                        doTweenX('controlsoptionB' .. i .. 'BIND2SIZEX', 'controlsoptionB' .. i .. 'BIND2.scale',
                            0.5, openeaseTime, easetype)
                        doTweenY('controlsoptionB' .. i .. 'BIND2SIZEY', 'controlsoptionB' .. i .. 'BIND2.scale',
                            0.5, openeaseTime, easetype)
                    else
                        doTweenAlpha('controlsoptionB' .. i .. 'BIND2ALPHA', 'controlsoptionB' .. i .. 'BIND2',
                            scalefuck, openeaseTime, easetype)
                        doTweenX('controlsoptionB' .. i .. 'BIND2SIZEX', 'controlsoptionB' .. i .. 'BIND2.scale',
                            scalefuck, openeaseTime, easetype)
                        doTweenY('controlsoptionB' .. i .. 'BIND2SIZEY', 'controlsoptionB' .. i .. 'BIND2.scale',
                            scalefuck, openeaseTime, easetype)
                    end
                end
            end
        end
    elseif optionsState == 'visualsoptions' then

        
        if selectionsvisualsoptions == 1 then
            doTweenY('movearrow1', 'OPTIONSleft', visualsoption1Y + 15, scrollSpeed, easetype)
            doTweenY('movearrow2', 'OPTIONSright', visualsoption1Y + 15, scrollSpeed, easetype)
        elseif selectionsvisualsoptions == 2 then
            doTweenY('movearrow1', 'OPTIONSleft', visualsoption2Y + 15, scrollSpeed, easetype)
            doTweenY('movearrow2', 'OPTIONSright', visualsoption2Y + 15, scrollSpeed, easetype)
        elseif selectionsvisualsoptions == 3 then
            doTweenY('movearrow1', 'OPTIONSleft', visualsoption3Y + 15, scrollSpeed, easetype)
            doTweenY('movearrow2', 'OPTIONSright', visualsoption3Y + 15, scrollSpeed, easetype)
        end
        
                local scalefuck = 0.3
        for i = 1, 4 do
            if selectionsvisualsoptions == i then
                doTweenAlpha('visualsoption' .. i .. 'ALPHA', 'visualsoption' .. i , 1,
                    openeaseTime, easetype)
                doTweenX('visualsoption' .. i .. 'SIZEX', 'visualsoption' .. i .. '.scale', 0.5,
                    openeaseTime, easetype)
                doTweenY('visualsoption' .. i .. 'SIZEY', 'visualsoption' .. i .. '.scale', 0.5,
                    openeaseTime, easetype)
                    
                doTweenAlpha('visualsoption' .. i .. 'MODIFIERALPHA', 'visualsoption' .. i .. 'MODIFIER', 1,
                    openeaseTime, easetype)
                doTweenX('visualsoption' .. i .. 'MODIFIERSIZEX', 'visualsoption' .. i .. 'MODIFIER.scale', 0.5,
                    openeaseTime, easetype)
                doTweenY('visualsoption' .. i .. 'MODIFIERSIZEY', 'visualsoption' .. i .. 'MODIFIER.scale', 0.5,
                    openeaseTime, easetype)
            else
                doTweenAlpha('visualsoption' .. i .. 'ALPHA', 'visualsoption' .. i , scalefuck,
                    openeaseTime, easetype)
                doTweenX('visualsoption' .. i .. 'SIZEX', 'visualsoption' .. i .. '.scale', scalefuck,
                    openeaseTime, easetype)
                doTweenY('visualsoption' .. i .. 'SIZEY', 'visualsoption' .. i .. '.scale', scalefuck,
                    openeaseTime, easetype)

                doTweenAlpha('visualsoption' .. i .. 'MODIFIERALPHA', 'visualsoption' .. i .. 'MODIFIER', scalefuck,
                    openeaseTime, easetype)
                doTweenX('visualsoption' .. i .. 'MODIFIERSIZEX', 'visualsoption' .. i .. 'MODIFIER.scale', scalefuck,
                    openeaseTime, easetype)
                doTweenY('visualsoption' .. i .. 'MODIFIERSIZEY', 'visualsoption' .. i .. 'MODIFIER.scale', scalefuck,
                    openeaseTime, easetype)
            end
        end

            setProperty('optionssubtitle1.x', optionssubtitle1X - 50)
            doTweenX('optionssubtitle1move', 'optionssubtitle1', optionssubtitle1X, scrollSpeed, easetype)
        if selectionsvisualsoptions == 1 then
            doTweenY('moveoptionsshadow', 'selectionOptions', visualsoption1Y + 5, scrollSpeed, easetype)
            setTextString('optionssubtitle1', " HIGHLY recommended to leave at 60 if you don't want slow-downs\n ")
        elseif selectionsvisualsoptions == 2 then
            doTweenY('moveoptionsshadow', 'selectionOptions', visualsoption2Y + 5, scrollSpeed, easetype)
            setTextString('optionssubtitle1', ' HIGHLY Recommended to turn on if you have a decent GPU\n ')
        elseif selectionsvisualsoptions == 3 then
            doTweenY('moveoptionsshadow', 'selectionOptions', visualsoption3Y + 5, scrollSpeed, easetype)
            setTextString('optionssubtitle1', ' Removes some assets and flashy effects so the game can run better\n ')
        end
    end
end
