
local songs = {
    {name = "Break Down", icon = "tails", player = "sonic", opponent = "tails", description = "LET ME BREAK IT DOWN FOR YOU"},
    {name = "Unbound", icon = "sonic", player = "bf", opponent = "sonic", description = "JUST A GUY THAT LOVES ADVENTURE!"},
    {name = "Rock Solid", icon = "knuckles", player = "sonic", opponent = "knuckles", description = "UNLIKE SONIC HE DON'T CHUCKLE"},
    {name = "Ultimatum", icon = "shadow", player = "sonic", opponent = "shadow", description = "THE ULTIMATE LIFE FORM"},
    {name = "Blueprint", icon = "metalsonic", player = "sonic", opponent = "metalsonic", description = "STRANGE, ISN'T IT?"}
}
local colors = {
    sonic = "1e6feb",
    tails = "FFB124",
    shadow = "4c3753",
    knuckles = "f61f7a",
    bf = "24E7EE",
    metalsonic = "4240d4"
}
local opponentrenderOffsetsX = {
    sonic = -40,
    tails = -80,
    shadow = 0,
    knuckles = -30,
    metalsonic = -20,
}
local opponentrenderOffsetsY = {
    sonic = 30,
    tails = 40,
    shadow = -50,
    knuckles = 20,
    metalsonic = 20,
}

local playerrenderOffsetsX = {
    sonic = -20,
    bf = 20,
}
local playerrenderOffsetsY = {
    sonic = 30,
    bf = 30,
}
vinylspin = false
vinylmultiplier = 1
local menuselected = 1 --1 adventure, 2 extras, 3 options
local menubgspeed1 = 0
local menubgspeed2 = 0.3
openeaseTime = 1
menuselection = 0 -- 0 none, 1 load song, 2 options, 3 extras
textSprites = {}
iconSprites = {}
playerRenders = {}
opponentRenders = {}
selectedIndex = 1
curMenu = 'title'
local lastPlayer = nil
local lastOpponent = nil
lastdirection = nil
local vinylDirection = 'right'
local lastdirectionPressed = 'right'
local minAngleSpeed = 0.4
local maxAngleSpeed = -0.4
local lastdirection = 'right'
local caninput = true
local inscene = false

diffselection = ''



local txtCenter = 500
local txtLeft = 100
local txtRight = 900
local txtHiddenLEFT = -300
local txtHiddenRIGHT = 1400 --increments of 400
local scrollSpeed = 0.8
local easetype = 'expoOut'
local maxIndex = #songs
local minIndex = 1
local renderCenter = 100

local lastTime = 0
local beatLength = 60 / 125
local lastBeat = -1
local beatallowed = false
local beathit = false
function onCreate()
            --cursor
    makeLuaSprite('cursor', 'cursor', 0, 0) 
    setObjectCamera('cursor', 'other')
    addLuaSprite('cursor', true)

    precacheMusic('freakyMenu')
    removeLuaScript('scripts/titlecard')
    removeLuaScript('scripts/noteUnderlays')
    removeLuaScript('scripts/pauseMenu')
    removeLuaScript('scripts/homing attack')
    removeLuaScript('scripts/sonic UI')
    removeLuaScript('scripts/results')
    removeLuaScript('scripts/customCountdown')
    setProperty('skipCountdown', true)
    initSaveData('globalsave')

    if getDataFromSave('globalsave', 'lastSong') ~= nil then
        prevsong = getDataFromSave('globalsave', 'lastSong')
    else
        prevsong = 'none'
    end
    diffselection = getDataFromSave('globalsave', 'lastDifficulty')
    
    setDataFromSave('globalsave', 'lastSong', nil)

    if prevsong == 'rock solid' then
        prevsong = 'Rock Solid'
    elseif prevsong == 'break down' then
        prevsong = 'Break Down'
    end


    if prevsong == 'none' or prevsong == "" then
        menuIntroDone = false
        curMenu = 'intro'
    elseif prevsong:lower() == 'extras' then
        menuIntroDone = true
        menuselected = 2
        curMenu = 'main'
    elseif prevsong:lower() == 'options' then
        menuIntroDone = true
        menuselected = 3
        curMenu = 'main'
    else
        menuIntroDone = true
        curMenu = 'main'
    end

    
    makeLuaSprite('menuIntroindicator')
    makeGraphic('menuIntroindicator', 1, 1, 'ffffff')
    setProperty('menuIntroindicator.alpha', 0)
    addLuaSprite('menuIntroindicator', false)
    setObjectCamera('menuIntroindicator', 'hud')
    if menuIntroDone then
        setProperty('menuIntroindicator.x', 1) -- 1= intro done, 0= intro not done
    else
        setProperty('menuIntroindicator.x', 0)
    end

    --menu intro
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

        --hide HUD
    setProperty('scoreTxt.visible', false)
    setProperty('timeBar.visible', false)
    setProperty('timeTxt.visible', false)
    --setObjectCamera('timeTxt', 'hud')
    setProperty('timeBarBG.visible', false)
    setProperty('iconP1.visible', false)
    setProperty('healthBar.visible', false)
    setProperty('healthBarBG.visible', false)
    setProperty('iconP2.visible', false)

    --hide NOTES
    for i = 0,7 do
        noteTweenAlpha('notessAlpha'..i, i, 0, 0.01, 'quadInOut')
    end

    makeLuaSprite('bgtemp')
    makeGraphic('bgtemp', 1920, 1080, 'ffffff') --0000ff
    setProperty('bgtemp.alpha', 1)
    addLuaSprite('bgtemp', false)
    setObjectCamera('bgtemp', 'hud')


    makeSprites()
    if prevsong == 'none' or prevsong == nil then
        if menuIntroDone == false then
            makeIntroShit()
        end
    else
        menuIntroDone = true
    end
if prevsong ~= nil then
    for i, song in ipairs(songs) do
        if song.name == prevsong then
            updateMainMenu()
            
            curMenu = 'adventure'
            closeMainMenu()
            openAdventure()
            selectedIndex = i
            scrollSpeed = 0.01
            openeaseTime = 0.01
            runTimer('resetscrollspeed', 0.01)
            break
        end
    end
end
updateFreeplayPositions()
if curMenu == 'main' then
    updateMainMenu()
end
end

local textsize = 45

function makeIntroShit()
    caninput = false

    makeLuaSprite('introOverlay2', nil, 0, 0) --hide in beat 32
    makeGraphic('introOverlay2', screenWidth, screenHeight, '4C216A')
    setObjectCamera('introOverlay2', 'hud')
    addLuaSprite('introOverlay2', true)

    makeLuaSprite('introbg', 'menus/title/introbg', -10, 0)
    setObjectCamera('introbg', 'camHUD')
    scaleObject('introbg', 2,2)
    addLuaSprite('introbg', true)

    makeLuaSprite('introOverlay1', nil, 0, 0) --hide in beat 32
    makeGraphic('introOverlay1', screenWidth, screenHeight, '000000')
    setObjectCamera('introOverlay1', 'hud')
    addLuaSprite('introOverlay1', true)

    makeLuaSprite()
    makeAnimatedLuaSprite('silhouette', 'menus/title/silhouette', 0, 50)
    addAnimationByPrefix('silhouette', 'anim1', 'introanim1MASK', 24, false)
    addAnimationByPrefix('silhouette', 'anim2', 'introanim2mask', 24, false)
    addAnimationByPrefix('silhouette', 'anim3', 'introanim3mask', 24, false)
    addAnimationByPrefix('silhouette', 'anim4', 'introanim4mask', 24, false)
    addAnimationByPrefix('silhouette', 'anim5', 'introanim5mask', 24, false)
    setObjectCamera('silhouette', 'camHUD')
    scaleObject('silhouette', 2,2)
    addLuaSprite('silhouette', true)
    playAnim('silhouette', 'anim1', false)
    setProperty('silhouette.visible', false)


    makeLuaSprite('segalogo', 'menus/title/sega logo', 480, 380)
    setObjectCamera('segalogo', 'camHUD')
    scaleObject('segalogo', 2,2)
    addLuaSprite('segalogo', true)
    setProperty('segalogo.visible', false)
    
    makeLuaSprite('jonlogo', 'menus/title/jon logo', 445, 200)
    setObjectCamera('jonlogo', 'camHUD')
    scaleObject('jonlogo', 2,2)
    addLuaSprite('jonlogo', true)

    introtxtfont = 'Kimberley.ttf'
    introtxt1X = 130
    makeLuaText('INTROtxt1', 'Jon SpeedArts', 1000 * 2, 330, 250)
    setTextSize('INTROtxt1', 60 * 2)
    scaleObject('INTROtxt1', 0.5, 0.5)
    setTextAlignment('INTROtxt1', 'center')
    setTextColor('INTROtxt1', 'ffffff')
    setTextBorder('INTROtxt1', 0, 'ffffff')
    setTextFont('INTROtxt1', introtxtfont)
    addLuaText('INTROtxt1', true)
    setProperty('INTROtxt1.visible', false)


    introtxt2X = 130
    makeLuaText('INTROtxt2', 'Presents', 1000 * 2, 330, 380)
    setTextSize('INTROtxt2', 60 * 2)
    scaleObject('INTROtxt2', 0.5, 0.5)
    setTextAlignment('INTROtxt2', 'center')
    setTextColor('INTROtxt2', 'ffffff')
    setTextBorder('INTROtxt2', 0, 'ffffff')
    setTextFont('INTROtxt2', introtxtfont)
    addLuaText('INTROtxt2', true)
    setProperty('INTROtxt2.visible', false)

    -- FLAVOR TEXT
    introflavortext = -- green hill's looking a lot more like funk hill
    {
    {line1 = "WELCOME TO", line2 = "THE NEXT LEVEL"}, --1
    {line1 = "Sonic had a rough", line2 = "Transition to FNF"}, --2
    {line1 = "Play", line2 = "Sonic Jam"}, --3
    {line1 = "AMERICAN", line2 = "FUNKY ACTION"}, --4
    {line1 = "Sega Does", line2 = "What Nintendon't"}, --5
    {line1 = "Today's a day", line2 = "Today's a new day"}, --6
    {line1 = "Friday Night Rush", line2 = "Coming Tomorrow"}, --7
    {line1 = "FUN IS INFINITE", line2 = "WITH SEGA ENTERPRISES"}, --8
    {line1 = "Sonic", line2 = "The Fuck"}, --9
    {line1 = "I'VE COME", line2 = "TO MAKE AN ANNOUNCEMENT"}, --10
    {line1 = "Blast", line2 = "Processing"}, --11
    {line1 = "Sonic's The Name", line2 = "Speed's My Game"}, --12
    {line1 = "Secretly", line2 = "An EXE Mod"}, --13
    {line1 = "Everything", line2 = "By Everyone"}, --14
    {line1 = "By The Fans", line2 = "For The Fans"}, --15
    {line1 = "Hahaha", line2 = "One"}, --16
    {line1 = "The Most Famous", line2 = "Hedgehog In The World"}, --17
    {line1 = "Featuring", line2 = "Michael Jackson?"}, --18
    {line1 = "Blue Streak", line2 = "Speeds By"}, --19
    {line1 = "Triplets Born", line2 = "The Throne Awaits"}, --20
    {line1 = "Release The", line2 = "2019 Cut"}, --21
    {line1 = "Dance Dance Revolution", line2 = "Sonic Mix"}, --22
    {line1 = "Established", line2 = "1991"}, --23
    {line1 = "Fans Do", line2 = "What Sega Don't"}, --24
    {line1 = "Dreams", line2 = "Don't Come True"}, --25
    {line1 = "Includes", line2 = "Muzzle curve"}, --26
    {line1 = "Is This Some Kind Of...", line2 = "Sonic Paradox?"}, --27
    {line1 = "Sonic Shorts:", line2 = "Volume 100"} --28
    }
end

function pickFlavorText()
    if #introflavortext == 0 then
        return nil
    end

    local index = getRandomInt(1, #introflavortext)
    local chosenline = introflavortext[index]

    -- blacklist chosen
    table.remove(introflavortext, index)

    return chosenline
end

function introText1Appear()
            setProperty('INTROtxt1.scale.x', 0.55)
            setProperty('INTROtxt1.scale.y', 0.45)
            doTweenX('INTROtxt1size1', 'INTROtxt1.scale', 0.5, 0.6, 'expoOut')
            doTweenY('INTROtxt1size2', 'INTROtxt1.scale', 0.5, 0.6, 'expoOut')
end
function introText2Appear()
            setProperty('INTROtxt2.scale.x', 0.55)
            setProperty('INTROtxt2.scale.y', 0.45)
            doTweenX('INTROtxt2size1', 'INTROtxt2.scale', 0.5, 0.6, 'expoOut')
            doTweenY('INTROtxt2size2', 'INTROtxt2.scale', 0.5, 0.6, 'expoOut')
end

function onBeatHit()
    if startflash then
        playAnim('titlestart', 'flash2', false)
        startflash = false
    elseif not startflash or startflash == nil then
        playAnim('titlestart', 'flash1', false)
        startflash = true
    end
    logoscale = 2.1
    if menuIntroDone == false then
        if curBeat < 31 then
            setProperty('camHUD.zoom', 1.03)
            doTweenZoom('introbopzoom', 'camHUD', 1, 1, 'expoOut')
        end
        if curBeat == 1 then
            setProperty('INTROtxt1.x', introtxt1X)
            setProperty('INTROtxt1.y', 250)
            setProperty('INTROtxt2.x', introtxt2X)
            setProperty('INTROtxt2.y', 380)
            setTextString('INTROtxt1', 'Jon SpeedArts')
            setTextString('INTROtxt2', 'Presents')
            setProperty('jonlogo.visible', true)
        end
        if curBeat == 3 then
            introText2Appear()
            setProperty('INTROtxt2.visible', true)
        end
        if curBeat == 4 then
            setProperty('jonlogo.visible', false)
            setProperty('INTROtxt1.visible', false)
            setProperty('INTROtxt2.visible', false)
        end
        if curBeat == 5 then
            introText1Appear()
            setTextString('INTROtxt1', 'Not associated with')
            setProperty('INTROtxt1.visible', true)
        end
        if curBeat == 7 then
            introText2Appear()
            setProperty('segalogo.visible', true)
            setProperty('segalogo.scale.x', 0.01)
            setProperty('segalogo.scale.y', 0.01)
            doTweenX('segalogosize1', 'segalogo.scale', 2, 0.6, 'expoOut')
            doTweenY('segalogosize2', 'segalogo.scale', 2, 0.6, 'expoOut')
        end
        if curBeat == 8 then
            setProperty('INTROtxt1.visible', false)
            setProperty('segalogo.visible', false)
        end
        if curBeat == 9 then
            flavor = pickFlavorText()
            pickFlavorText()
            setTextString('INTROtxt1', flavor.line1)
            introText1Appear()
            setProperty('INTROtxt1.visible', true)
        end
        if curBeat == 11 then
            setTextString('INTROtxt2', flavor.line2)
            introText2Appear()
            setProperty('INTROtxt2.visible', true)
        end
        if curBeat == 12 then
            setProperty('INTROtxt1.visible', false)
            setProperty('INTROtxt2.visible', false)
        end
        if curBeat == 13 then
            flavor = pickFlavorText()
            pickFlavorText()
            setTextString('INTROtxt1', flavor.line1)
            introText1Appear()
            setProperty('INTROtxt1.visible', true)
        end
        if curBeat == 15 then
            setTextString('INTROtxt2', flavor.line2)
            introText2Appear()
            setProperty('INTROtxt2.visible', true)
        end
        if curBeat == 16 then
            setProperty('introOverlay1.visible', false)
            setProperty('INTROtxt1.visible', false)
            setProperty('INTROtxt2.visible', false)
            setProperty('silhouette.visible', true)
            playAnim('silhouette', 'anim1', false)
            setProperty('silhouette.y', 0)
            setProperty('silhouette.x', -100)
            doTweenX('silhouettetween', 'silhouette', -300, 1.92)
        end
        if curBeat == 17 then
            flavor = pickFlavorText()
            pickFlavorText()
            setTextString('INTROtxt1', flavor.line1)
            introText1Appear()
            setProperty('INTROtxt1.visible', true)
        end
        if curBeat == 19 then
            setTextString('INTROtxt2', flavor.line2)
            introText2Appear()
            setProperty('INTROtxt2.visible', true)
        end
        if curBeat == 20 then
            setProperty('INTROtxt1.visible', false)
            setProperty('INTROtxt2.visible', false)
        end
        if curBeat == 21 then
            flavor = pickFlavorText()
            pickFlavorText()
            setTextString('INTROtxt1', flavor.line1)
            introText1Appear()
            setProperty('INTROtxt1.visible', true)
        end
        if curBeat == 23 then
            setTextString('INTROtxt2', flavor.line2)
            introText2Appear()
            setProperty('INTROtxt2.visible', true)
        end
        if curBeat == 24 then
            setProperty('INTROtxt1.visible', false)
            setProperty('INTROtxt2.visible', false)
        end
        if curBeat == 25 then
            flavor = pickFlavorText()
            pickFlavorText()
            setTextString('INTROtxt1', flavor.line1)
            introText1Appear()
            setProperty('INTROtxt1.visible', true)
        end
        if curBeat == 27 then
            setTextString('INTROtxt2', flavor.line2)
            introText2Appear()
            setProperty('INTROtxt2.visible', true)
        end
        if curBeat == 28 then
            setProperty('INTROtxt1.visible', false)
            setProperty('INTROtxt2.visible', false)
        end
        if curBeat == 20 then
            playAnim('silhouette', 'anim2', false)
            setProperty('silhouette.x', -200)
            doTweenX('silhouettetween', 'silhouette', getProperty('silhouette.x') + 200, 1.92)
        end
        if curBeat == 24 then
            playAnim('silhouette', 'anim3', false)
            setProperty('silhouette.x', -100)
            doTweenX('silhouettetween', 'silhouette', getProperty('silhouette.x') - 200, 1.92)
        end
        if curBeat == 25 or curBeat == 26 then
            playAnim('silhouette', 'anim3', false)
        end
        if curBeat == 28 then
            playAnim('silhouette', 'anim4', false)
            setProperty('silhouette.x', 0)
            setProperty('silhouette.y', 0)
            cancelTween('silhouettetween')
        end
        if curBeat == 29 or curBeat == 30 then
            playAnim('silhouette', 'anim4', false)
        end
        if curBeat == 30 then
        end
        if curBeat == 31 then
            doTweenAlpha('introbg0', 'introbg', 0, 0.48, 'expoIn')
            doTweenX('silhouettesize1', 'silhouette.scale', 4, 0.48, 'expoIn')
            doTweenY('silhouettesize2', 'silhouette.scale', 4, 0.48, 'expoIn')
        end
        if curBeat == 32 then
            hideIntro()
        end
    end
end


function hideIntro()    
    openTitleScreen()
    runTimer('resetinput', 0.01)
    setProperty('titlesquares.visible', true)
    setProperty('titletotems.visible', true)
    setProperty('titlepalmtrees.visible', true)
    setProperty('LogoTitle.visible', true)
    setProperty('logojon.visible', true)
    setProperty('logojonNUM.visible', true)
    setProperty('titlestart.visible', true)

    setProperty('squaresBottom.y', squaresBottomY + 130)
    setProperty('squaresTop.y', squaresTopY - 130)
    setProperty('backtxtt.y', backTXTY - 110)
    setProperty('back.y', backICONY - 110)
    setProperty('bgcircle1.x', bgcircle1X - 400)
        setProperty('bgcircle2.x', bgcircle2X - 400)
        setProperty('portraitBackgroundAdventure.x', adventureBGPortraitX + 680)
        setProperty('portraitForegroundAdventure.x', adventureFGPortraitX + 680)
        setProperty('portraitBackgroundExtras.x', extrasBGPortraitX + 680)
        setProperty('portraitForegroundExtras.x', extrasFGPortraitX + 680)
        setProperty('portraitBackgroundOptions.x', optionsBGPortraitX + 680)
        setProperty('portraitForegroundOptions.x', optionsFGPortraitX + 680)
        setProperty('border.x', borderX + 680)
        setProperty('borderbg.x', borderX + 680)
        setProperty('selectionShadow.alpha', 0)
        setProperty('adventureBUTTON.x', adventureBUTTONX - 650)
        setProperty('extrasBUTTON.x', extrasBUTTONX - 520)
        setProperty('optionsBUTTON.x', optionsBUTTONX - 600)
        
    setProperty('backtxtt.visible', true)
    setProperty('back.visible', true)
    setProperty('introbg.visible', false)
    setProperty('jonlogo.visible', false)
    setProperty('segalogo.visible', false)
    setProperty('squaresTop.visible', false)
    setProperty('squaresBottom.visible', false)
    setProperty('bgcircle1.visible', false)
    setProperty('bgcircle2.visible', false)
    setProperty('portraitBackgroundAdventure.visible', false)
    setProperty('portraitForeAdventure.visible', false)
    setProperty('portraitBackgroundExtras.visible', false)
    setProperty('portraitForegroundExtras.visible', false)
    setProperty('portraitBackgroundOptions.visible', false)
    setProperty('portraitForegroundOptions.visible', false)
    setProperty('border.visible', false)
    setProperty('borderbg.visible', false)
    setProperty('selectionShadow.visible', false)
    setProperty('adventureBUTTON.visible', false)
    setProperty('extrasBUTTON.visible', false)
    setProperty('optionsBUTTON.visible', false)
    menuIntroDone = true
    curMenu = 'title'
    setProperty('INTROtxt1.visible', false)
    setProperty('INTROtxt2.visible', false)
    cancelTween('introbopzoom')
    setProperty('camHUD.zoom', 1)
    setProperty('introOverlay1.visible', false)
    setProperty('introOverlay2.visible', false)
    setProperty('silhouette.visible', false)
end

function makeSprites()
    makeLuaSprite('checkerboard','menus/bg checkerboard', 0, 20)
    setObjectCamera('checkerboard', 'hud')
    scaleObject('checkerboard', 2,2)
    addLuaSprite('checkerboard', false) 

    --titlescreen

    titlesquaresX = -20
    titlesquaresY = -650
    makeLuaSprite('titlesquares', 'menus/title/checkerboardtitle', titlesquaresX, titlesquaresY)
    setObjectCamera('titlesquares', 'hud')
    scaleObject('titlesquares', 2,2)
    addLuaSprite('titlesquares', false)
    setProperty('titlesquares.visible', false)
    titlesquarespeed = 1
    doTweenX('titlesquaresMove', 'titlesquares', -143, titlesquarespeed)

    titlepalmtreesX = 20
    titlepalmtreesY = 260
    makeLuaSprite('titlepalmtrees', 'menus/title/palmtrees', titlepalmtreesX, titlepalmtreesY)
    setObjectCamera('titlepalmtrees', 'hud')
    scaleObject('titlepalmtrees', 2,2)
    addLuaSprite('titlepalmtrees', false)
    setProperty('titlepalmtrees.visible', false)
    titletotemsX = 950
    titletotemsY = 310
    makeLuaSprite('titletotems', 'menus/title/totems', titletotemsX, titletotemsY)
    setObjectCamera('titletotems', 'hud')
    scaleObject('titletotems', 2,2)
    addLuaSprite('titletotems', false)
    setProperty('titletotems.visible', false)

    LogoTitleX = 300
    LogoTitleY = 50
    makeLuaSprite('LogoTitle', 'menus/title/SonicTheFunkLogo', LogoTitleX, LogoTitleY)
    setObjectCamera('LogoTitle', 'hud')
    scaleObject('LogoTitle', 2,2)
    addLuaSprite('LogoTitle', false)
    setProperty('LogoTitle.visible', false)

    jonlogoX = 10
    jonlogoY = 630
    makeLuaSprite('logojon', 'menus/title/jonspeedartslogo', jonlogoX, jonlogoY)
    setObjectCamera('logojon', 'hud')
    scaleObject('logojon', 2,2)
    addLuaSprite('logojon', false)
    setProperty('logojon.visible', false)
    setProperty('logojon.y', jonlogoY + 100)

    offsetlogoNUMX = 170
    offsetlogoNUMY = 22
    makeLuaText('logojonNUM', ' 2026', 200 * 2, getProperty('logojon.x') + 400, getProperty('logojon.y') + 10)
    setTextSize('logojonNUM', 22 * 2)
    scaleObject('logojonNUM', 0.5, 0.5)
    setTextBorder('logojonNUM', 5 * 2, '4D3282')
    setTextAlignment('logojonNUM', 'left')
    setTextColor('logojonNUM', 'ffffff')
    setTextFont('logojonNUM', 'Kimberley.ttf')
    addLuaText('logojonNUM', false)
    setObjectOrder('logojonNUM', getObjectOrder('logojon') - 1)
    setProperty('logojonNUM.visible', false)

    titlestartX = 440
    titlestartY = 550
    makeAnimatedLuaSprite('titlestart', 'menus/title/pressstart', titlestartX, titlestartY)
    addAnimationByPrefix('titlestart', 'flash1', 'press start', 24, false)
    addAnimationByPrefix('titlestart', 'flash2', 'press starT2', 24, false)
    setObjectCamera('titlestart', 'hud')
    addLuaSprite('titlestart', false)
    setProperty('titlestart.visible', false)
    playAnim('titlestart', 'flash2')
    startflash = true


    bgcircle1X = -80
    makeLuaSprite('bgcircle1','menus/bgcircle1', bgcircle1X, 400)
    setObjectCamera('bgcircle1', 'hud')
    scaleObject('bgcircle1', 2,2)
    addLuaSprite('bgcircle1', false)

    bgcircle2X = -170
    makeLuaSprite('bgcircle2','menus/bgcircle2', -170, 300)
    setObjectCamera('bgcircle2', 'hud')
    scaleObject('bgcircle2', 2,2)
    addLuaSprite('bgcircle2', false)

    setProperty('titlesquares.y', titlesquaresY - 200)
        setProperty('LogoTitle.y', -300)
        setProperty('titlestart.y', 730)
        setProperty('titletotems.y', titletotemsY + 350)
        setProperty('titletotems.x', titletotemsX + 350)
        setProperty('titlepalmtrees.y', titlepalmtreesY + 350)
        setProperty('titlepalmtrees.x', titlepalmtreesX - 350)
    --selection shadow
    selectionYadventure = 140
    selectionYextras = 300
    selectionYoptions = 470
    makeLuaSprite('selectionShadow',nil, 0, selectionYadventure)
    makeGraphic('selectionShadow', screenWidth, 120, '000000')
    setObjectCamera('selectionShadow', 'hud')
    addLuaSprite('selectionShadow', false)
    setProperty('selectionShadow.alpha', 0.5)

    --portraits

    
    borderX = 600
    makeLuaSprite('borderbg','menus/portraits/border background', borderX +10, 20)
    setObjectCamera('borderbg', 'hud')
    scaleObject('borderbg', 2,2)
    addLuaSprite('borderbg', false)

    optionsBGPortraitY = 80
    optionsBGPortraitX = 580
    makeLuaSprite('portraitBackgroundOptions','menus/portraits/options background', optionsBGPortraitX, optionsBGPortraitY)
    setObjectCamera('portraitBackgroundOptions', 'hud')
    scaleObject('portraitBackgroundOptions', 2,2)
    addLuaSprite('portraitBackgroundOptions', false)
    setProperty('portraitBackgroundOptions.alpha', 0)

    optionsFGPortraitX = 760
    makeLuaSprite('portraitForegroundOptions','menus/portraits/options foreground', optionsFGPortraitX, 150)
    setObjectCamera('portraitForegroundOptions', 'hud')
    scaleObject('portraitForegroundOptions', 2,2)
    addLuaSprite('portraitForegroundOptions', false)
    setProperty('portraitForegroundOptions.alpha', 0)

    extrasBGPortraitY = 230
    extrasBGPortraitX = 580
    makeLuaSprite('portraitBackgroundExtras','menus/portraits/extras background', extrasBGPortraitX, extrasBGPortraitY)
    setObjectCamera('portraitBackgroundExtras', 'hud')
    scaleObject('portraitBackgroundExtras', 2,2)
    addLuaSprite('portraitBackgroundExtras', false)
    setProperty('portraitBackgroundExtras.alpha', 0)

    extrasFGPortraitX = 780
    makeLuaSprite('portraitForegroundExtras','menus/portraits/extras foreground', extrasFGPortraitX, 100)
    setObjectCamera('portraitForegroundExtras', 'hud')
    scaleObject('portraitForegroundExtras', 2,2)
    addLuaSprite('portraitForegroundExtras', false)
    setProperty('portraitForegroundExtras.alpha', 0)

    adventureBGPortraitY = 350
    adventureBGPortraitX = 600
    makeLuaSprite('portraitBackgroundAdventure','menus/portraits/adventure background', adventureBGPortraitX, adventureBGPortraitY)
    setObjectCamera('portraitBackgroundAdventure', 'hud')
    scaleObject('portraitBackgroundAdventure', 2,2)
    addLuaSprite('portraitBackgroundAdventure', false)
    setProperty('portraitBackgroundAdventure.alpha', 0)

    adventureFGPortraitX = 850
    makeLuaSprite('portraitForegroundAdventure','menus/portraits/adventure foreground', adventureFGPortraitX, 150)
    setObjectCamera('portraitForegroundAdventure', 'hud')
    scaleObject('portraitForegroundAdventure', 2,2)
    addLuaSprite('portraitForegroundAdventure', false)
    setProperty('portraitForegroundAdventure.alpha', 0)


    makeLuaSprite('border','menus/portraits/border', borderX, 20)
    setObjectCamera('border', 'hud')
    scaleObject('border', 2,2)
    addLuaSprite('border', false)



    --buttons
    
    adventureBUTTONX = 30
    makeLuaSprite('adventureBUTTON','menus/adventure', adventureBUTTONX, 140)
    setObjectCamera('adventureBUTTON', 'hud')
    scaleObject('adventureBUTTON', 2,2)
    addLuaSprite('adventureBUTTON', false)
    
    extrasBUTTONX = 150
    makeLuaSprite('extrasBUTTON','menus/extras', extrasBUTTONX, 300)
    setObjectCamera('extrasBUTTON', 'hud')
    scaleObject('extrasBUTTON', 2,2)
    addLuaSprite('extrasBUTTON', false)

    optionsBUTTONX = 100
    makeLuaSprite('optionsBUTTON','menus/options', optionsBUTTONX, 470)
    setObjectCamera('optionsBUTTON', 'hud')
    scaleObject('optionsBUTTON', 2,2)
    addLuaSprite('optionsBUTTON', false) -- 


    squares1X = 910
    makeLuaSprite('squares1', 'menus/squares1', squares1X, -100)
    setObjectCamera('squares1', 'hud')
    scaleObject('squares1', 2,2)
    addLuaSprite('squares1', false)
    setProperty('squares1.color', getColorFromHex('000000'))
    
    makeLuaSprite('squares1highlights', 'menus/squares2', squares1X, -100)
    setObjectCamera('squares1highlights', 'hud')
    scaleObject('squares1highlights', 2,2)
    addLuaSprite('squares1highlights', false)

    squares2X = -160
    makeLuaSprite('squares2', 'menus/squares1', squares2X, -100)
    setObjectCamera('squares2', 'hud')
    scaleObject('squares2', 2,2)
    addLuaSprite('squares2', false)
    setProperty('squares2.flipX', true)
    setProperty('squares2.color', getColorFromHex('000000'))

    makeLuaSprite('squares2highlights', 'menus/squares2', squares2X - 40, -100)
    setObjectCamera('squares2highlights', 'hud')
    scaleObject('squares2highlights', 2,2)
    addLuaSprite('squares2highlights', false)
    setProperty('squares2highlights.flipX', true)

    

    vinylY = 450
    makeLuaSprite('vinyl1', 'menus/vinyl', 270, vinylY)
    setObjectCamera('vinyl1', 'hud')
    scaleObject('vinyl1', 2,2)
    addLuaSprite('vinyl1', false)
    makeLuaSprite('vinyl2', 'menus/vinylColor', 270, vinylY)
    setObjectCamera('vinyl2', 'hud')
    scaleObject('vinyl2', 2,2)
    addLuaSprite('vinyl2', false)

    diffOffsetX = 0
    diffOffsetY = 0
    
    stats1Y = 120
    statsX = 30

    statsRIGHTX = 970

    makeLuaText('composersub1', '\n Composed By: \n\n', 300 * 2, statsRIGHTX, stats1Y - 10)
    setTextSize('composersub1', 18 * 2)
    scaleObject('composersub1', 0.5, 0.5)
    setTextBorder('composersub1', 4 * 2, '000000')
    setTextAlignment('composersub1', 'right')
    setTextColor('composersub1', 'ffffff')
    setTextFont('composersub1', 'Kimberley.ttf')
    addLuaText('composersub1', false)
    setProperty('composersub1.x', statsRIGHTX + 300)

    makeLuaText('composersub2', '\n Jon SpeedArts \n\n', 300 * 2, statsRIGHTX, stats1Y + 5)
    setTextSize('composersub2', 30 * 2)
    scaleObject('composersub2', 0.5, 0.5)
    setTextBorder('composersub2', 4 * 2, '000000')
    setTextAlignment('composersub2', 'right')
    setTextColor('composersub2', 'ffffff')
    setTextFont('composersub2', 'Kimberley.ttf')
    addLuaText('composersub2', false)
    setProperty('composersub2.x', statsRIGHTX + 300)
    

    
    makeLuaText('diffTXT', '\n DIFFICULTY: \n\n', 350 * 2, statsRIGHTX, stats1Y + 170)
    setTextSize('diffTXT', 26 * 2)
    scaleObject('diffTXT', 0.5, 0.5)
    setTextBorder('diffTXT', 4 * 2, '000000')
    setTextAlignment('diffTXT', 'center')
    setTextColor('diffTXT', 'ffffff')
    setTextFont('diffTXT', 'Kimberley.ttf')
    addLuaText('diffTXT', false)
    setProperty('diffTXT.x', statsRIGHTX + 300)


    monitorX = 1006
    monitorY = 421
    makeLuaSprite('difficultymonitor', 'menus/difficultymonitor', monitorX, monitorY)
    scaleObject('difficultymonitor', 1.6,1.6)
    setObjectCamera('difficultymonitor', 'hud')
    addLuaSprite('difficultymonitor', false)

    difficultyX = 1000
    difficultyY = 450
    makeAnimatedLuaSprite('difficulty', 'menus/difficulties', difficultyX + diffOffsetX, difficultyY + diffOffsetY)
    addAnimationByPrefix('difficulty', 'standard', 'diff standard', 24, false)
    addOffset('difficulty', 'standard', 0, 0)
    addAnimationByPrefix('difficulty', 'easy', 'diff easy', 24, false)
    addOffset('difficulty', 'easy', -50, 0)
    addAnimationByPrefix('difficulty', 'encore', 'diff encore', 24, false)
    addOffset('difficulty', 'encore', -20, 0)
    if diffselection == '' then
        playAnim('difficulty', 'standard', true)
    elseif diffselection == '-easy' then
        playAnim('difficulty', 'easy', true)
    elseif diffselection == '-encore' then
        playAnim('difficulty', 'encore', true)
    end
    diffscale = 0.65
    setProperty('difficulty.scale.x', diffscale)
    setProperty('difficulty.scale.y', diffscale)
    setObjectCamera('difficulty', 'hud')
    addLuaSprite('difficulty', false)

    diffarrowsX = 1115
    makeLuaSprite('diffarrowtop', 'menus/diff arrow', diffarrowsX + diffOffsetX, 380 + diffOffsetY)
    setObjectCamera('diffarrowtop', 'hud')
    addLuaSprite('diffarrowtop', false)
    makeLuaSprite('diffarrowbottom', 'menus/diff arrow', diffarrowsX + diffOffsetX, 550 + diffOffsetY)
    setObjectCamera('diffarrowbottom', 'hud')
    addLuaSprite('diffarrowbottom', false)
    setProperty('diffarrowbottom.flipY', true)

    
    difflockX = 1115
    difflockY = 450 + diffOffsetY
    makeLuaSprite('difflock', 'menus/diff lock', difflockX + diffOffsetX, difflockY)
    locksize = 0.7
    setProperty('difflock.scale.x', locksize)
    setProperty('difflock.scale.y', locksize)
    setObjectCamera('difflock', 'hud')
    addLuaSprite('difflock', false)



    songdescY = 20
        makeLuaText('songdesc', 'Song Description', 1280, 620, songdescY)
        setTextAlignment('songdesc', 'right')
        setTextSize('songdesc', 30 * 2)
        scaleObject('songdesc', 0.5, 0.5)
        setTextColor('songdesc', 'ffffff')
        setTextFont('songdesc', 'Kimberley.ttf')
        setObjectCamera('songdesc', 'hud')
        addLuaText('songdesc', false)
        
    
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

        
    logoY = 650
    makeLuaSprite('logosonic', 'logonormal', -80, squaresBottomY + 50)
    addLuaSprite('logosonic', false)
    setObjectCamera('logosonic', 'hud')
    logosize = 0.6
    setProperty('logosonic.scale.x', logosize)
    setProperty('logosonic.scale.y', logosize)


    makeLuaText('versionnumber', 'v1.0', 200 * 2, getProperty('logosonic.x') + 400, getProperty('logosonic.y') + 10)
    setTextSize('versionnumber', 28 * 2)
    scaleObject('versionnumber', 0.5, 0.5)
    setTextBorder('versionnumber', 5 * 2, '000000')
    setTextAlignment('versionnumber', 'left')
    setTextColor('versionnumber', 'ffffff')
    setTextFont('versionnumber', 'Kimberley.ttf')
    addLuaText('versionnumber', false)


    

    statsTXT = ' SCORE:\n\n\n ACCURACY:\n\n\n RANK:\n\n'
    makeLuaText('songstats1', statsTXT, 200 * 2, statsX, stats1Y)
    setTextSize('songstats1', 22 * 2)
    scaleObject('songstats1', 0.5, 0.5)
    setTextBorder('songstats1', 5 * 2, '000000')
    setTextAlignment('songstats1', 'left')
    setTextColor('songstats1', 'ffffff')
    setTextFont('songstats1', 'Kimberley.ttf')
    addLuaText('songstats1', false)

    stats2Y = 150
    makeLuaText('songstats2', statsTXT, 200 * 2, statsX, stats2Y)
    setTextSize('songstats2', 34 * 2)
    scaleObject('songstats2', 0.5, 0.5)
    setTextBorder('songstats2', 5 * 2, '000000')
    setTextAlignment('songstats2', 'left')
    setTextColor('songstats2', 'ffffff')
    setTextFont('songstats2', 'Kimberley.ttf')
    addLuaText('songstats2', false)

    local ranksize = 0.5
    rankoffsetX = - 20
    rankoffsetY = 160
    makeAnimatedLuaSprite('ranklol', 'results/ranks', statsX + rankoffsetX, stats2Y + rankoffsetY)
    addAnimationByPrefix('ranklol', 'SS', 'ranK SS', 24, false)
    addAnimationByPrefix('ranklol', 'S', 'rank s', 24, false)
    addAnimationByPrefix('ranklol', 'A', 'rank a', 24, false)
    addAnimationByPrefix('ranklol', 'B', 'rank b', 24, false)
    addAnimationByPrefix('ranklol', 'C', 'rank c', 24, false)
    addAnimationByPrefix('ranklol', 'L', 'rank l', 24, false)
    addAnimationByPrefix('ranklol', '???', 'rank ???', 24, false)
    addLuaSprite('ranklol', true)
    setObjectCamera('ranklol', 'camHUD')
    setProperty('ranklol.scale.x', ranksize)
    setProperty('ranklol.scale.y', ranksize)
    setProperty('ranklol.x', statsX + rankoffsetX - 300)
    setProperty('ranklol.y', statsX + rankoffsetX - 300)

    crownoffsetX = 95
    crownoffsetY = 20
    crownsize = 0.7
    makeAnimatedLuaSprite('crownrank', 'results/crown', statsX + rankoffsetX + crownoffsetX, stats2Y + rankoffsetY + crownoffsetY)
    addAnimationByPrefix('crownrank', 'crown', 'crown', 24, false)
    addLuaSprite('crownrank', true)
    setObjectCamera('crownrank', 'camHUD')
    setProperty('crownrank.scale.x', crownsize)
    setProperty('crownrank.scale.y', crownsize)
    setProperty('crownrank.visible', false)
    setProperty('crownrank.x', statsX + rankoffsetX + crownoffsetX - 300)
    setProperty('crownrank.y', statsX + rankoffsetX + crownoffsetX - 300)
    
            songscore = '94749'
            songaccuracy = '98.7%'
            reformattedaccuracy = '98.7%'
            songrank = 'S'
            setTextString('songstats2', '\n  '..songscore..'\n\n  '..reformattedaccuracy..'\n\n  ')


    for _, song in ipairs(songs) do
        local spriteName = song.player .. 'RenderPlayer'
        if not playerRenders[spriteName] then
            renderplayerX = 620
            makeLuaSprite(spriteName, 'renders/' .. song.player, renderplayerX, 100)
            scaleObject(spriteName, 1.4, 1.4)
            setObjectCamera(spriteName, 'hud')
            addLuaSprite(spriteName, false)
            setProperty(spriteName..'.alpha', 0)
            
            playerRenders[spriteName] = true
        end
    end
    for _, song in ipairs(songs) do
        local spriteName = song.opponent .. 'RenderOpponent'
        if not opponentRenders[spriteName] then
            renderopponentX = 300
            makeLuaSprite(spriteName, 'renders/' .. song.opponent, renderopponentX, 100)
            scaleObject(spriteName, 1.4, 1.4)
            setObjectCamera(spriteName, 'hud')
            addLuaSprite(spriteName, false)
            setProperty(spriteName..'.alpha', 0)

            if song.opponent == 'sonic' then
                setProperty(spriteName .. '.flipX', true)
            end

            opponentRenders[spriteName] = true
        end
    end
        makeLuaSprite('songBar', '', 0, 450)
        makeGraphic('songBar', screenWidth, 80, '000000')
        setObjectCamera('songBar', 'hud')
        addLuaSprite('songBar', false)
        setProperty('songBar.alpha', 0)
    for i, song in ipairs(songs) do
        local textName = 'textSprite'..i
        local iconName = 'iconSprite'..i
        local renderPlayerName = 'renderPlayerSprite'..i
        local renderOpponentName = 'renderOpponentSprite'..i
        songtextY =  600
        

        makeLuaText(textName, song.name, 600, 500, songtextY)
        setTextSize(textName, textsize * 2)
        scaleObject(textName, 0.5, 0.5)
        setTextColor(textName, 'ffffff')
        setTextBorder(textName, 10, '2d2b53')
        setTextFont(textName, 'Kimberley.ttf')
        setTextAlignment(textName, 'center')
        addLuaText(textName)
        table.insert(textSprites, textName)
        setProperty(textName..'.alpha', 0)
        setProperty(textName..'.y', songtextY)

        --icons
        makeAnimatedLuaSprite(iconName, 'icons/icon-'..song.icon, 0, 450)
        addAnimationByPrefix(iconName, 'normal', 'normal', 24, true)
        addAnimationByPrefix(iconName, 'losing', 'losing', 24, true)
        playAnim(iconName, 'normal')
        scaleObject(iconName, 0.7, 0.7)
        setObjectCamera(iconName, 'hud')
        addLuaSprite(iconName, false)

        setProperty(iconName..'.origin.y', 120)

        setProperty(iconName..'.x', 500 - 160)
        setProperty(iconName..'.y', 500 - 25) 
        table.insert(iconSprites, iconName)
    end


    arrowsY = 550
    makeAnimatedLuaSprite('sountestarrowleft', 'extras/soundtest/arrow soundtest', 430, arrowsY, true)
    addAnimationByPrefix('sountestarrowleft', 'press', 'arrow soundtest', 24, false)
    setObjectCamera('sountestarrowleft', 'hud')
    playAnim('sountestarrowleft', 'press', true)
    addLuaSprite('sountestarrowleft')
    setProperty('sountestarrowleft.flipX', true)
        doTweenX('sountestarrowleftSIZEX', 'sountestarrowleft.scale', 0.7, 0.01)
        doTweenY('sountestarrowleftSIZEY', 'sountestarrowleft.scale', 0.7, 0.01)

    makeAnimatedLuaSprite('sountestarrowright', 'extras/soundtest/arrow soundtest', 810, arrowsY, true)
    addAnimationByPrefix('sountestarrowright', 'press', 'arrow soundtest', 24, false)
    setObjectCamera('sountestarrowright', 'hud')
    playAnim('sountestarrowright', 'press', true)
    addLuaSprite('sountestarrowright')
        doTweenX('sountestarrowrightSIZEX', 'sountestarrowright.scale', 0.7, 0.01)
        doTweenY('sountestarrowrightSIZEY', 'sountestarrowright.scale', 0.7, 0.01)

    backTXTY = 30
    backTXTX = 90

    backICONY = 20
    backICONX = 20
    makeLuaSprite('back','extras/back', backICONX, backICONY)
    setObjectCamera('back', 'hud')
    addLuaSprite('back', false)
    makeLuaText('backtxtt', 'ESC', 100 * 2, backTXTX, backTXTY)
    setTextSize('backtxtt', 45 * 2)
    scaleObject('backtxtt', 0.5, 0.5)
    setTextBorder('backtxtt', 5 * 2, '000000')
    setTextColor('backtxtt', 'ffffff')
    setTextFont('backtxtt', 'Kimberley.ttf')
    addLuaText('backtxtt', false)
    
    --hide shit
    setProperty('sountestarrowleft.y', arrowsY + 170)
    setProperty('sountestarrowright.y', arrowsY + 170)
    for i, name in ipairs(textSprites) do
        setProperty(name..'.y', songtextY + 300)
    end
    for spriteName, _ in pairs(playerRenders) do
        setProperty(spriteName..'.x', renderplayerX + 760)
    end
    for spriteName, _ in pairs(opponentRenders) do
        setProperty(spriteName..'.x', renderopponentX - 760)
    end
        
        --diff stuff
        setProperty('difficultymonitor.x', monitorX + 300)
        setProperty('difficulty.x', difficultyX + 300)
        setProperty('diffarrowtop.x', diffarrowsX + 300)
        setProperty('diffarrowbottom.x', diffarrowsX + 300)
        setProperty('difflock.x', difflockX + 300)
        
        setProperty('vinyl1.y', vinylY + 400)
        setProperty('vinyl2.y', vinylY + 400)
        
        setProperty('squares1.x', squares1X + 400)
        setProperty('squares1highlights.x', squares1X + 400)
        setProperty('squares2.x', squares2X - 400)
        setProperty('squares2highlights.x', squares2X - 40 - 400)
        setProperty('songdesc.y', songdescY - 60)
        setProperty('songdesc.alpha', 0)

    setProperty('songstats1.x', statsX - 300)
    setProperty('songstats2.x', statsX - 300)
end

function titleToMain()
    doTweenY('escIN2', 'backtxtt',  backTXTY, scrollSpeed, easetype)
    doTweenY('escIN3', 'back',  backICONY, scrollSpeed, easetype)
        setProperty('portraitBackgroundAdventure.alpha', 1)
        setProperty('portraitForegroundAdventure.alpha', 1)

        setProperty('portraitBackgroundExtras.alpha', 0)
        setProperty('portraitForegroundExtras.alpha', 0)
        setProperty('portraitBackgroundOptions.alpha', 0)
        setProperty('portraitForegroundOptions.alpha', 0)

        
        doTweenX('portrait1tweenAdventureX', 'portraitBackgroundAdventure', adventureBGPortraitX, scrollSpeed, easetype)
        doTweenX('portrait2tweenAdventure', 'portraitForegroundAdventure', adventureFGPortraitX, scrollSpeed, easetype)

        doTweenY('selectionshadowtween', 'selectionShadow', selectionYadventure, scrollSpeed, easetype)
        doTweenX('adventuresize', 'adventureBUTTON.scale', 2, scrollSpeed, easetype)
        doTweenY('adventuresize2', 'adventureBUTTON.scale', 2, scrollSpeed, easetype)
        doTweenColor('adventurecolor', 'adventureBUTTON', 'ffffff', scrollSpeed, easetype)

        doTweenX('extrassize', 'extrasBUTTON.scale', 1.6, scrollSpeed, easetype)
        doTweenY('extrassize2', 'extrasBUTTON.scale', 1.6, scrollSpeed, easetype)
        doTweenColor('extrascolor', 'extrasBUTTON', '8f8f8f', scrollSpeed, easetype)

        doTweenX('optionssize', 'optionsBUTTON.scale', 1.6, scrollSpeed, easetype)
        doTweenY('optionssize2', 'optionsBUTTON.scale', 1.6, scrollSpeed, easetype)
        doTweenColor('optionscolor', 'optionsBUTTON', '8f8f8f', scrollSpeed, easetype)
end
function updateFreeplayPositions()
    --TEXT
    setProperty('songdesc.y', songdescY - 20)
    doTweenY('songdescupdate', 'songdesc', songdescY, scrollSpeed, easetype)
        setProperty('composersub2.y', stats1Y + 5 - 8)
        doTweenY('composersub2bounce', 'composersub2', stats1Y + 5, scrollSpeed, easetype)
        setProperty('songstats2.y', stats2Y - 8)
        doTweenY('songstats2bounce', 'songstats2', stats2Y, scrollSpeed, easetype)
        setProperty('ranklol.y', stats2Y + rankoffsetY - 8)
        doTweenY('ranklolbounce', 'ranklol', stats2Y + rankoffsetY, scrollSpeed, easetype)
        setProperty('crownrank.y', stats2Y + rankoffsetY + crownoffsetY - 8)
        doTweenY('crownrankbounce', 'crownrank', stats2Y + rankoffsetY + crownoffsetY , scrollSpeed, easetype)
    for i, iconName in ipairs(iconSprites) do
        if i ~= selectedIndex then
            doTweenX(iconName..'twewenx', iconName..'.scale', 0.35, scrollSpeed, easetype)
            doTweenY(iconName..'tweweny', iconName..'.scale', 0.35, scrollSpeed, easetype)
            doTweenAlpha(iconName..'Color', iconName, 0.5, 0.4)
        else
            doTweenX(iconName..'twewenx', iconName..'.scale', 0.7, scrollSpeed, easetype)
            doTweenY(iconName..'tweweny', iconName..'.scale', 0.7, scrollSpeed, easetype)
            doTweenAlpha(iconName..'Color', iconName, 1, 0.4)
        end
    end
    for i, name in ipairs(textSprites) do
        if i ~= selectedIndex then
            doTweenX(name..'twewenx', name..'.scale', 0.25, scrollSpeed, easetype)
            doTweenY(name..'tweweny', name..'.scale', 0.25, scrollSpeed, easetype)
            doTweenAlpha(name..'Color', name, 0.5, 0.4)
        else
            doTweenX(name..'twewenx', name..'.scale', 0.5, scrollSpeed, easetype)
            doTweenY(name..'tweweny', name..'.scale', 0.5, scrollSpeed, easetype)
            doTweenAlpha(name..'Color', name, 1, 0.4)
        end
        if i == selectedIndex then -- center
            cancelTween(name..'hiddenalpha')
            setProperty(name..'.alpha', 1)
            if keyJustPressed('ui_left') then
                setProperty(name..'.x', txtLeft)
                doTweenX(name..'tween', name, txtCenter, scrollSpeed, easetype)
            elseif keyJustPressed('ui_right') then
                setProperty(name..'.x', txtRight)
                doTweenX(name..'tween', name, txtCenter, scrollSpeed, easetype)
            else
                doTweenX(name..'tween', name, txtCenter, scrollSpeed, easetype)
            end
        elseif i == selectedIndex - 1 then -- left
            cancelTween(name..'hiddenalpha')
            setProperty(name..'.alpha', 1)
            if keyJustPressed('ui_left') then
                setProperty(name..'.x', txtHiddenLEFT)
                doTweenX(name..'tween', name, txtLeft, scrollSpeed, easetype)
            elseif keyJustPressed('ui_right') then
                setProperty(name..'.x', txtCenter)
                doTweenX(name..'tween', name, txtLeft, scrollSpeed, easetype)
            else
                doTweenX(name..'tween', name, txtLeft, scrollSpeed, easetype)
            end
        elseif i == selectedIndex + 1 then -- right
            cancelTween(name..'hiddenalpha')
            setProperty(name..'.alpha', 1)
            if keyJustPressed('ui_left') then
                setProperty(name..'.x', txtCenter)
                doTweenX(name..'tween', name, txtRight, scrollSpeed, easetype)
            elseif keyJustPressed('ui_right') then
                setProperty(name..'.x', txtHiddenRIGHT)
                doTweenX(name..'tween', name, txtRight, scrollSpeed, easetype)
            else
                doTweenX(name..'tween', name, txtRight, scrollSpeed, easetype)
            end
        elseif i == selectedIndex - 2 then -- hidden left
            doTweenAlpha(name..'hiddenalpha', name, 0, scrollSpeed, easetype)
            if keyJustPressed('ui_left') then
                setProperty(name..'.x', txtHiddenLEFT - 400)
                doTweenX(name..'tween', name, txtHiddenLEFT, scrollSpeed, easetype)
            elseif keyJustPressed('ui_right') then
                setProperty(name..'.x', txtLeft)
                doTweenX(name..'tween', name, txtHiddenLEFT, scrollSpeed, easetype)
            else
                doTweenX(name..'tween', name, txtHiddenLEFT, scrollSpeed, easetype)
            end
        elseif i == selectedIndex + 2 then -- hidden right
            doTweenAlpha(name..'hiddenalpha', name, 0, scrollSpeed, easetype)
            if keyJustPressed('ui_left') then
                setProperty(name..'.x', txtRight)
                doTweenX(name..'tween', name, txtHiddenRIGHT, scrollSpeed, easetype)
            elseif keyJustPressed('ui_right') then
                setProperty(name..'.x', txtHiddenRIGHT + 400)
                doTweenX(name..'tween', name, txtHiddenRIGHT, scrollSpeed, easetype)
            else
                doTweenX(name..'tween', name, txtHiddenRIGHT, scrollSpeed, easetype)
            end
        elseif selectedIndex == maxIndex and i == 1 then
            cancelTween(name..'hiddenalpha')
            setProperty(name..'.alpha', 1)
            if keyJustPressed('ui_left') then
                setProperty(name..'.x', txtCenter)
                doTweenX(name..'tween', name, txtRight, scrollSpeed, easetype)
            elseif keyJustPressed('ui_right') then
                setProperty(name..'.x', txtHiddenRIGHT)
                doTweenX(name..'tween', name, txtRight, scrollSpeed, easetype)
            else
                doTweenX(name..'tween', name, txtRight, scrollSpeed, easetype)
            end
        elseif selectedIndex == 1 and i == maxIndex then
            cancelTween(name..'hiddenalpha')
            setProperty(name..'.alpha', 1)
            if keyJustPressed('ui_left') then
                setProperty(name..'.x', txtHiddenLEFT)
                doTweenX(name..'tween', name, txtLeft, scrollSpeed, easetype)
            elseif keyJustPressed('ui_right') then
                setProperty(name..'.x', txtCenter)
                doTweenX(name..'tween', name, txtLeft, scrollSpeed, easetype)
            else
                doTweenX(name..'tween', name, txtLeft, scrollSpeed, easetype)
            end
        elseif selectedIndex == 1 and i == maxIndex then
        else
            doTweenAlpha(name..'hiddenalpha', name, 0, scrollSpeed, easetype)
            if keyJustPressed('ui_left') then
                setProperty(name..'.x', txtRight)
                doTweenX(name..'tween', name, txtHiddenRIGHT, scrollSpeed, easetype)
            elseif keyJustPressed('ui_right') then
                setProperty(name..'.x', txtLeft)
                doTweenX(name..'tween', name, txtHiddenLEFT, scrollSpeed, easetype)
            else
                doTweenX(name..'tween', name, txtHiddenLEFT, scrollSpeed, easetype)
            end
        end
    end


    --player renders

    local currentPlayer = songs[selectedIndex].player

    if currentPlayer ~= lastPlayer then
        local currentSprite = currentPlayer .. 'RenderPlayer'
        local lastSprite = lastPlayer and lastPlayer .. 'RenderPlayer' or nil

        if playerRenders[currentSprite] then
            setProperty(currentSprite .. '.alpha', 0)
            doTweenAlpha(currentPlayer .. 'RENDEROPalpha', currentSprite, 1, scrollSpeed, easetype)
            if lastdirection == 'right' then
                setProperty(currentSprite .. '.y', renderCenter - 200)
                doTweenY(currentPlayer .. 'RENDEROPtween', currentSprite, renderCenter + playerrenderOffsetsY[currentPlayer], scrollSpeed, easetype)
            elseif lastdirection == 'left' then
                setProperty(currentSprite .. '.y', renderCenter + 200)
                doTweenY(currentPlayer .. 'RENDEROPtween', currentSprite, renderCenter + playerrenderOffsetsY[currentPlayer], scrollSpeed, easetype)
            end
            if lastSprite and playerRenders[lastSprite] then
                if lastdirection == 'right' then
                    doTweenAlpha(lastPlayer .. 'RENDEROPalpha', lastSprite, 0, scrollSpeed, easetype)
                    doTweenY(lastPlayer .. 'RENDEROPtween', lastSprite, renderCenter + playerrenderOffsetsY[currentPlayer] + 200, scrollSpeed, easetype)
                elseif lastdirection == 'left' then
                    doTweenAlpha(lastPlayer .. 'RENDEROPalpha', lastSprite, 0, scrollSpeed, easetype)
                    doTweenY(lastPlayer .. 'RENDEROPtween', lastSprite, renderCenter + playerrenderOffsetsY[currentPlayer] - 200, scrollSpeed, easetype)
                end
            end
        end

        lastPlayer = currentPlayer
    end


    --opponent renders

    local currentOpponent = songs[selectedIndex].opponent

    if currentOpponent ~= lastOpponent then
        local currentSprite = currentOpponent .. 'RenderOpponent'
        local lastSprite = lastOpponent and lastOpponent .. 'RenderOpponent' or nil
    
        if opponentRenders[currentSprite] then
    
            setProperty(currentSprite .. '.alpha', 0)
            doTweenAlpha(currentOpponent .. 'RENDERalpha', currentSprite, 1, scrollSpeed, easetype)
    
            if lastdirection == 'right' then
                setProperty(currentSprite .. '.y', renderCenter + 200)
                doTweenY(currentOpponent .. 'RENDERtween', currentSprite, renderCenter + opponentrenderOffsetsY[currentOpponent], scrollSpeed, easetype)
            elseif lastdirection == 'left' then
                setProperty(currentSprite .. '.y', renderCenter - 200)
                doTweenY(currentOpponent .. 'RENDERtween', currentSprite, renderCenter + opponentrenderOffsetsY[currentOpponent], scrollSpeed, easetype)
            end
    
            if lastSprite and opponentRenders[lastSprite] then
                if lastdirection == 'right' then
                    doTweenAlpha(lastOpponent .. 'RENDERalpha', lastSprite, 0, scrollSpeed, easetype)
                    doTweenY(lastOpponent .. 'RENDERtween', lastSprite, renderCenter + opponentrenderOffsetsY[currentOpponent] - 200, scrollSpeed, easetype)
                elseif lastdirection == 'left' then
                    doTweenAlpha(lastOpponent .. 'RENDERalpha', lastSprite, 0, scrollSpeed, easetype)
                    doTweenY(lastOpponent .. 'RENDERtween', lastSprite, renderCenter + opponentrenderOffsetsY[currentOpponent] + 200, scrollSpeed, easetype)
                end
            end
        end

        lastOpponent = currentOpponent
    end

     if vinylDirection ~= lastdirectionPressed then
                    minAngleSpeed = 2
                    maxAngleSpeed = -2
            end

            currentOpponentColor = colors[currentOpponent]
            currentPlayerColor = colors[currentPlayer]
            doTweenColor('vinylColor', 'vinyl2', currentOpponentColor, 0.4)
            
            doTweenColor('squaresColor', 'squares1', currentPlayerColor, scrollSpeed / 2)
            doTweenColor('squares2Color', 'squares2', currentOpponentColor, scrollSpeed / 2)

    for i, song in ipairs(songs) do
        if i == selectedIndex then
            songdescription = song.description
            break
        end
    end
        setTextString('songdesc', songdescription)

end

function openTitleScreen()
    if curMenu == 'intro' then
        setProperty('titlesquares.y', 20)
        setProperty('LogoTitle.y', -300)
        setProperty('titlestart.y', 730)
        setProperty('titletotems.y', titletotemsY + 350)
        setProperty('titletotems.x', titletotemsX + 350)
        setProperty('titlepalmtrees.y', titlepalmtreesY + 350)
        setProperty('titlepalmtrees.x', titlepalmtreesX - 350)
    end
    doTweenY('titlesquaresIN', 'titlesquares', titlesquaresY, scrollSpeed, 'expoOut')
    doTweenY('LogoTitleIN', 'LogoTitle', LogoTitleY, scrollSpeed, 'expoOut')
    doTweenY('logojonIN', 'logojon', jonlogoY, scrollSpeed, 'expoOut')
    doTweenY('titlestartIN', 'titlestart', titlestartY, scrollSpeed, 'expoOut')
    doTweenX('titlepalmtreesIN1', 'titlepalmtrees', titlepalmtreesX, scrollSpeed, 'expoOut')
    doTweenY('titlepalmtreesIN2', 'titlepalmtrees', titlepalmtreesY, scrollSpeed, 'expoOut')
    doTweenX('titletotemsIN1', 'titletotems', titletotemsX, scrollSpeed, 'expoOut')
    doTweenY('titletotemsIN2', 'titletotems', titletotemsY, scrollSpeed, 'expoOut')
    setProperty('titlesquares.visible', true)
    setProperty('titlepalmtrees.visible', true)
    setProperty('titletotems.visible', true)
    setProperty('LogoTitle.visible', true)
    setProperty('logojon.visible', true)
    setProperty('logojonNUM.visible', true)
    setProperty('titlestart.visible', true)
end

function closeTitleScreen()
    doTweenY('titlesquaresIN', 'titlesquares', titlesquaresY - 200, scrollSpeed, 'expoOut')
    doTweenY('LogoTitleIN', 'LogoTitle', -300, scrollSpeed, 'expoOut')
    doTweenY('logojonIN', 'logojon', jonlogoY + 100, scrollSpeed, 'expoOut')
    doTweenY('titlestartIN', 'titlestart', 730, scrollSpeed, 'expoOut')
    doTweenX('titlepalmtreesIN1', 'titlepalmtrees', titlepalmtreesX - 350, scrollSpeed, 'expoOut')
    doTweenY('titlepalmtreesIN2', 'titlepalmtrees', titlepalmtreesY + 350, scrollSpeed, 'expoOut')
    doTweenX('titletotemsIN1', 'titletotems', titletotemsX + 350, scrollSpeed, 'expoOut')
    doTweenY('titletotemsIN2', 'titletotems', titletotemsY + 350, scrollSpeed, 'expoOut')
    playSound('confirmMenu')
end

function closeMainMenu()
    if curMenu == 'title' then
    doTweenY('escIN2', 'backtxtt',  backTXTY - 110, scrollSpeed, easetype)
    doTweenY('escIN3', 'back',  backICONY - 110, scrollSpeed, easetype)
    end
        doTweenX('bgcircle1out', 'bgcircle1', bgcircle1X - 400, scrollSpeed, easetype)
        doTweenX('bgcircle2out', 'bgcircle2', bgcircle2X - 400, scrollSpeed, easetype)
        doTweenX('portrait1tweenAdventureX', 'portraitBackgroundAdventure', adventureBGPortraitX + 680, scrollSpeed, easetype)
        doTweenX('portrait2tweenAdventure', 'portraitForegroundAdventure', adventureFGPortraitX + 680, scrollSpeed, easetype)

        doTweenX('portrait1tweenExtrasX', 'portraitBackgroundExtras', extrasBGPortraitX + 680, scrollSpeed, easetype)
        doTweenX('portrait2tweenExtras', 'portraitForegroundExtras', extrasFGPortraitX + 680, scrollSpeed, easetype)

        doTweenX('portrait1tweenOptionsX', 'portraitBackgroundOptions', optionsBGPortraitX + 680, scrollSpeed, easetype)
        doTweenX('portrait2tweenOptions', 'portraitForegroundOptions', optionsFGPortraitX + 680, scrollSpeed, easetype)
        
        doTweenX('border1tween', 'border', borderX + 680, scrollSpeed, easetype)
        doTweenX('border2tween', 'borderbg', borderX + 680, scrollSpeed, easetype)

        
    doTweenAlpha('selectionShadowOut', 'selectionShadow', 0, openeaseTime, 'expoOut')
    doTweenX('adventureout', 'adventureBUTTON', adventureBUTTONX - 650, openeaseTime, 'expoOut')
    doTweenX('extrasout', 'extrasBUTTON', extrasBUTTONX - 520, openeaseTime, 'expoOut')
    doTweenX('optionsout', 'optionsBUTTON', optionsBUTTONX - 600, openeaseTime, 'expoOut')
end

function openMainMenu()
    if getProperty('squaresTop.y') ~= squarestopY then
        doTweenY('squarestopOut', 'squaresTop', squaresTopY, openeaseTime, 'expoOut')
    end
    if getProperty('squaresTop.y') ~= squarestopY then
        doTweenY('squaresbottomOut', 'squaresBottom', squaresBottomY, openeaseTime, 'expoOut')
    end
    setProperty('backtxtt.visible', true)
    setProperty('back.visible', true)
    setProperty('squaresTop.visible', true)
    setProperty('squaresBottom.visible', true)
    setProperty('bgcircle1.visible', true)
    setProperty('bgcircle2.visible', true)
    setProperty('portraitBackgroundAdventure.visible', true)
    setProperty('portraitForeAdventure.visible', true)
    setProperty('portraitBackgroundExtras.visible', true)
    setProperty('portraitForegroundExtras.visible', true)
    setProperty('portraitBackgroundOptions.visible', true)
    setProperty('portraitForegroundOptions.visible', true)
    setProperty('border.visible', true)
    setProperty('borderbg.visible', true)
    setProperty('selectionShadow.visible', true)
    setProperty('adventureBUTTON.visible', true)
    setProperty('extrasBUTTON.visible', true)
    setProperty('optionsBUTTON.visible', true)
    --
    doTweenX('bgcircle1out', 'bgcircle1', bgcircle1X, scrollSpeed, easetype)
    doTweenX('bgcircle2out', 'bgcircle2', bgcircle2X, scrollSpeed, easetype)
        doTweenX('portrait1tweenAdventureX', 'portraitBackgroundAdventure', adventureBGPortraitX, scrollSpeed, easetype)
        doTweenX('portrait2tweenAdventure', 'portraitForegroundAdventure', adventureFGPortraitX, scrollSpeed, easetype)

        doTweenX('portrait1tweenExtrasX', 'portraitBackgroundExtras', extrasBGPortraitX, scrollSpeed, easetype)
        doTweenX('portrait2tweenExtras', 'portraitForegroundExtras', extrasFGPortraitX, scrollSpeed, easetype)

        doTweenX('portrait1tweenOptionsX', 'portraitBackgroundOptions', optionsBGPortraitX, scrollSpeed, easetype)
        doTweenX('portrait2tweenOptions', 'portraitForegroundOptions', optionsFGPortraitX, scrollSpeed, easetype)
        
        doTweenX('border1tween', 'border', borderX, scrollSpeed, easetype)
        doTweenX('border2tween', 'borderbg', borderX, scrollSpeed, easetype)

    doTweenAlpha('selectionShadowOut', 'selectionShadow', 0.5, openeaseTime, 'expoOut')
    doTweenX('adventureout', 'adventureBUTTON', adventureBUTTONX, openeaseTime, 'expoOut')
    doTweenX('extrasout', 'extrasBUTTON', extrasBUTTONX, openeaseTime, 'expoOut')
    doTweenX('optionsout', 'optionsBUTTON', optionsBUTTONX, openeaseTime, 'expoOut')
end

function updateMainMenu()
    
    if menuselected > 3 then
        menuselected = 1
    elseif menuselected < 1 then
        menuselected = 3
    end
    cancelTween('portrait1tweenAdventureX')
    cancelTween('portrait1tweenExtrasX')
    cancelTween('portrait1tweenOptionsX')
    setProperty('portraitBackgroundAdventure.x', adventureBGPortraitX)
    setProperty('portraitBackgroundExtras.x', extrasBGPortraitX)
    setProperty('portraitBackgroundOptions.x', optionsBGPortraitX)
    if menuselected == 1 then --adventure
        setProperty('portraitBackgroundAdventure.alpha', 1)
        setProperty('portraitForegroundAdventure.alpha', 1)

        setProperty('portraitBackgroundExtras.alpha', 0)
        setProperty('portraitForegroundExtras.alpha', 0)
        setProperty('portraitBackgroundOptions.alpha', 0)
        setProperty('portraitForegroundOptions.alpha', 0)

        setProperty('portraitBackgroundAdventure.y', adventureBGPortraitY + 200)
        doTweenY('portrait1tweenAdventure', 'portraitBackgroundAdventure', adventureBGPortraitY, scrollSpeed, easetype)
        setProperty('portraitForegroundAdventure.x', adventureFGPortraitX + 200)
        doTweenX('portrait2tweenAdventure', 'portraitForegroundAdventure', adventureFGPortraitX, scrollSpeed, easetype)

        doTweenY('selectionshadowtween', 'selectionShadow', selectionYadventure, scrollSpeed, easetype)
        doTweenX('adventuresize', 'adventureBUTTON.scale', 2, scrollSpeed, easetype)
        doTweenY('adventuresize2', 'adventureBUTTON.scale', 2, scrollSpeed, easetype)
        doTweenColor('adventurecolor', 'adventureBUTTON', 'ffffff', scrollSpeed, easetype)

        doTweenX('extrassize', 'extrasBUTTON.scale', 1.6, scrollSpeed, easetype)
        doTweenY('extrassize2', 'extrasBUTTON.scale', 1.6, scrollSpeed, easetype)
        doTweenColor('extrascolor', 'extrasBUTTON', '8f8f8f', scrollSpeed, easetype)

        doTweenX('optionssize', 'optionsBUTTON.scale', 1.6, scrollSpeed, easetype)
        doTweenY('optionssize2', 'optionsBUTTON.scale', 1.6, scrollSpeed, easetype)
        doTweenColor('optionscolor', 'optionsBUTTON', '8f8f8f', scrollSpeed, easetype)
    elseif menuselected == 2 then --extras
        setProperty('portraitBackgroundExtras.alpha', 1)
        setProperty('portraitForegroundExtras.alpha', 1)

        setProperty('portraitBackgroundAdventure.alpha', 0)
        setProperty('portraitForegroundAdventure.alpha', 0)
        setProperty('portraitBackgroundOptions.alpha', 0)
        setProperty('portraitForegroundOptions.alpha', 0)

        setProperty('portraitBackgroundExtras.y', extrasBGPortraitY + 200)
        doTweenY('portrait1tweenExtras', 'portraitBackgroundExtras', extrasBGPortraitY, scrollSpeed, easetype)
        setProperty('portraitForegroundExtras.x', extrasFGPortraitX + 200)
        doTweenX('portrait2tweenExtras', 'portraitForegroundExtras', extrasFGPortraitX, scrollSpeed, easetype)

        doTweenY('selectionshadowtween', 'selectionShadow', selectionYextras, scrollSpeed, easetype)
        doTweenX('extrassize', 'extrasBUTTON.scale', 2, scrollSpeed, easetype)
        doTweenY('extrassize2', 'extrasBUTTON.scale', 2, scrollSpeed, easetype)
        doTweenColor('extrascolor', 'extrasBUTTON', 'ffffff', scrollSpeed, easetype)

        doTweenX('adventuresize', 'adventureBUTTON.scale', 1.6, scrollSpeed, easetype)
        doTweenY('adventuresize2', 'adventureBUTTON.scale', 1.6, scrollSpeed, easetype)
        doTweenColor('adventurecolor', 'adventureBUTTON', '8f8f8f', scrollSpeed, easetype)

        doTweenX('optionssize', 'optionsBUTTON.scale', 1.6, scrollSpeed, easetype)
        doTweenY('optionssize2', 'optionsBUTTON.scale', 1.6, scrollSpeed, easetype)
        doTweenColor('optionscolor', 'optionsBUTTON', '8f8f8f', scrollSpeed, easetype)
    elseif menuselected == 3 then --options
        setProperty('portraitBackgroundOptions.alpha', 1)
        setProperty('portraitForegroundOptions.alpha', 1)

        setProperty('portraitBackgroundExtras.alpha', 0)
        setProperty('portraitForegroundExtras.alpha', 0)
        setProperty('portraitBackgroundAdventure.alpha', 0)
        setProperty('portraitForegroundAdventure.alpha', 0)
        
        setProperty('portraitBackgroundOptions.y', optionsBGPortraitY + 200)
        doTweenY('portrait1tweenOptions', 'portraitBackgroundOptions', optionsBGPortraitY, scrollSpeed, easetype)
        setProperty('portraitForegroundOptions.x', optionsFGPortraitX + 200)
        doTweenX('portrait2tweenOptions', 'portraitForegroundOptions', optionsFGPortraitX, scrollSpeed, easetype)

        doTweenY('selectionshadowtween', 'selectionShadow', selectionYoptions, scrollSpeed, easetype)
        doTweenX('optionssize', 'optionsBUTTON.scale', 2, scrollSpeed, easetype)
        doTweenY('optionssize2', 'optionsBUTTON.scale', 2, scrollSpeed, easetype)
        doTweenColor('optionscolor', 'optionsBUTTON', 'ffffff', scrollSpeed, easetype)

        doTweenX('extrassize', 'extrasBUTTON.scale', 1.6, scrollSpeed, easetype)
        doTweenY('extrassize2', 'extrasBUTTON.scale', 1.6, scrollSpeed, easetype)
        doTweenColor('extrascolor', 'extrasBUTTON', '8f8f8f', scrollSpeed, easetype)

        doTweenX('adventuresize', 'adventureBUTTON.scale', 1.6, scrollSpeed, easetype)
        doTweenY('adventuresize2', 'adventureBUTTON.scale', 1.6, scrollSpeed, easetype)
        doTweenColor('adventurecolor', 'adventureBUTTON', '8f8f8f', scrollSpeed, easetype)
    end
end

function openAdventure()
    doTweenY('squaresbottomOut', 'squaresBottom', squaresBottomY + 130, openeaseTime, 'expoOut')
    doTweenX('songstats1IN', 'songstats1', statsX, openeaseTime, 'expoOut')
    doTweenX('songstats2IN', 'songstats2', statsX, openeaseTime, 'expoOut')
    doTweenX('composersub1IN', 'composersub1', statsRIGHTX, openeaseTime, easetype)
    doTweenX('composersub2IN', 'composersub2', statsRIGHTX, openeaseTime, easetype)
    doTweenX('diffTXTIN', 'diffTXT', statsRIGHTX, openeaseTime, easetype)
    doTweenX('ranklolIN', 'ranklol', statsX + rankoffsetX, openeaseTime, easetype)
    doTweenX('crownrankIN', 'crownrank', statsX + rankoffsetX + crownoffsetX, openeaseTime, easetype)
    if getProperty('songdesc.alpha') ~= 1 then
        doTweenAlpha('songdescAlpha', 'songdesc', 1, openeaseTime, 'expoOut')
    end
    setProperty('sountestarrowleft.y', arrowsY + 170)
    setProperty('sountestarrowright.y', arrowsY + 170)
    doTweenY('sountestarrowleftIN', 'sountestarrowleft', arrowsY, openeaseTime, 'expoOut')
    doTweenY('sountestarrowrightIN', 'sountestarrowright', arrowsY, openeaseTime, 'expoOut')
    selectedIndex = 1
    scrollSpeed = 0.01
    runTimer('resetscrollspeed', 0.01)
    updateFreeplayPositions()
    if vinylDirection == 'right' then
        minAngleSpeed = 2
    elseif vinylDirection == 'left' then
        maxAngleSpeed = -2
    end
    --diff stuff
            
        setProperty('difficultymonitor.x', monitorX + 300)
        doTweenX('difficultymonitorinTween', 'difficultymonitor', monitorX, openeaseTime, 'expoOut')

        setProperty('difficulty.x', difficultyX + 300)
        doTweenX('difficultyinTween', 'difficulty', difficultyX, openeaseTime, 'expoOut')

        setProperty('diffarrowtop.x', diffarrowsX + 300)
        doTweenX('diffarrowtopinTween', 'diffarrowtop', diffarrowsX, openeaseTime, 'expoOut')

        setProperty('diffarrowbottom.x', diffarrowsX + 300)
        doTweenX('diffarrowbottominTween', 'diffarrowbottom', diffarrowsX, openeaseTime, 'expoOut')

        setProperty('difflock.x', difflockX + 300)
        doTweenX('difflockinTween', 'difflock', difflockX, openeaseTime, 'expoOut')

        --vinyl
        setProperty('vinyl1.y', vinylY + 300)
        doTweenY('vinylinTween', 'vinyl1', vinylY, openeaseTime, 'expoOut')
        setProperty('vinyl2.y', vinylY + 300)
        doTweenY('vinyl2inTween', 'vinyl2', vinylY, openeaseTime, 'expoOut')

    for i, name in ipairs(textSprites) do
        setProperty(name .. '.y', songtextY + 300)
        doTweenY(name..'inTween', name, songtextY, openeaseTime, 'expoOut')
    end
    for _, song in ipairs(songs) do
        local renderoffsetX = playerrenderOffsetsX[song.player]
        setProperty(song.player .. 'RenderPlayer.x', renderplayerX - 750)
        doTweenX(song.player .. 'RenderPlayerinTween', song.player .. 'RenderPlayer', renderplayerX + renderoffsetX, openeaseTime, 'expoOut')
    end
    for _, song in ipairs(songs) do
        local renderoffsetX = opponentrenderOffsetsX[song.opponent]
        setProperty(song.opponent .. 'RenderOpponent.x', renderopponentX + 750)
        doTweenX(song.opponent .. 'RenderOpponentinTween', song.opponent .. 'RenderOpponent', renderopponentX + renderoffsetX, openeaseTime, 'expoOut')
    end
        setProperty('squares1.x', squares1X + 400)
        doTweenX('squares1inTween', 'squares1', squares1X, openeaseTime, 'expoOut')
        setProperty('squares1highlights.x', squares1X + 400)
        doTweenX('squares1highlightsinTween', 'squares1highlights', squares1X, openeaseTime, 'expoOut')
        setProperty('squares2.x', squares2X - 400)
        doTweenX('squares2inTween', 'squares2', squares2X, openeaseTime, 'expoOut')
        setProperty('squares2highlights.x', squares2X - 40 - 400)
        doTweenX('squares2highlightsinTween', 'squares2highlights', squares2X - 40, openeaseTime, 'expoOut')
end

function closeAdventure()
    doTweenY('squaresbottomOut', 'squaresBottom', squaresBottomY, openeaseTime, 'expoOut')
    doTweenX('songstats1IN', 'songstats1', statsX - 300, openeaseTime, 'expoOut')
    doTweenX('songstats2IN', 'songstats2', statsX - 300, openeaseTime, 'expoOut')
    doTweenX('composersub1IN', 'composersub1', statsRIGHTX + 300, openeaseTime, easetype)
    doTweenX('composersub2IN', 'composersub2', statsRIGHTX + 300, openeaseTime, easetype)
    doTweenX('diffTXTIN', 'diffTXT', statsRIGHTX + 300, openeaseTime, easetype)
    doTweenX('ranklolIN', 'ranklol', statsX + rankoffsetX - 300, openeaseTime, easetype)
    doTweenX('crownrankIN', 'crownrank', statsX + rankoffsetX + crownoffsetX - 300, openeaseTime, easetype)
    doTweenAlpha('songdescAlpha', 'songdesc', 0,1, 'expoOut')
    doTweenY('songdescupdate', 'songdesc', songdescY - 60, scrollSpeed, easetype)
    doTweenY('sountestarrowleftIN', 'sountestarrowleft', arrowsY + 170, openeaseTime, 'expoOut')
    doTweenY('sountestarrowrightIN', 'sountestarrowright', arrowsY + 170, openeaseTime, 'expoOut')
    for i, name in ipairs(textSprites) do
        doTweenY(name..'inTween', name, songtextY + 300, openeaseTime, 'expoOut')
    end
    for spriteName, _ in pairs(playerRenders) do
        doTweenX(spriteName..'inTween', spriteName, renderplayerX + 760, openeaseTime, 'expoOut')
    end
    for spriteName, _ in pairs(opponentRenders) do
        doTweenX(spriteName..'inTween', spriteName, renderopponentX - 760, openeaseTime, 'expoOut')
    end
--diff stuff

        doTweenX('difficultymonitorinTween', 'difficultymonitor', monitorX + 300, openeaseTime, 'expoOut')

        doTweenX('difficultyinTween', 'difficulty', difficultyX+ 300, openeaseTime, 'expoOut')

        doTweenX('diffarrowtopinTween', 'diffarrowtop', diffarrowsX+ 300, openeaseTime, 'expoOut')

        doTweenX('diffarrowbottominTween', 'diffarrowbottom', diffarrowsX+ 300, openeaseTime, 'expoOut')

        doTweenX('difflockinTween', 'difflock', difflockX+ 300, openeaseTime, 'expoOut')

        --vinyl stuff
        doTweenY('vinylinTween', 'vinyl1', vinylY - 1250, openeaseTime, 'expoOut')
        doTweenY('vinyl2inTween', 'vinyl2', vinylY - 1250, openeaseTime, 'expoOut')

        doTweenX('squares1inTween', 'squares1', squares1X + 400, openeaseTime, 'expoOut')
        doTweenX('squares1highlightsinTween', 'squares1highlights', squares1X + 400, openeaseTime, 'expoOut')
        doTweenX('squares2inTween', 'squares2', squares2X - 400, openeaseTime, 'expoOut')
        doTweenX('squares2highlightsinTween', 'squares2highlights', squares2X - 40 - 400, openeaseTime, 'expoOut')
    
end


function openNewOptions()
    loadSong('options', -1)
end





function onTimerCompleted(tag)
    if tag == 'closemain' then
        closeMainMenu()
        doTweenY('squarestopOut', 'squaresTop', squaresTopY - 130, openeaseTime, 'expoOut')
        doTweenY('squaresbottomOut', 'squaresBottom', squaresBottomY + 130, openeaseTime, 'expoOut')
    end
    if tag == 'resetinput' then
        caninput = true
    end
    if tag == 'resetTITLE' then
        caninput = true
        menuselected = 1
        titleToMain()
    end
    if tag == 'musictimer' then
        playMusic('freakyMenu', 0.8, true, 'menuMusic')
        beatallowed = true
    end
    if tag == 'resetscrollspeed' then
        scrollSpeed = 0.8
        openeaseTime = 1
    end
    if tag == 'transitionOutLoad' then
        setProperty('transInIndicator.x', 1)
        runTimer('loadsong', 0.8)
    end
    if tag == 'loadsong' then
        if not caninput then
                setDataFromSave('globalsave', 'lastSong', songName)
                setDataFromSave('globalsave', 'lastDifficulty', diffselection)
                --
                if diffselection == '-easy' then
                    setPropertyFromClass('backend.Difficulty', 'list', {'easy'})
                    loadSong(songToLoad, 0)
                elseif diffselection == '' then
                    setPropertyFromClass('backend.Difficulty', 'list', {'normal'})
                    loadSong(songToLoad, 0)
                elseif diffselection == '-encore' then
                    setPropertyFromClass('backend.Difficulty', 'list', {'encore'})
                    loadSong(songToLoad, 0)
                end
        end
    end
    if tag == 'loadextras' then
        setDataFromSave('globalsave', 'lastSong', songName)
        setPropertyFromClass('backend.Difficulty', 'list', {'normal'})
        loadSong('extras', 0)
    end
    if tag == 'loadoptions' then
        openNewOptions()
    end
end

function onTweenCompleted(t, l, ll)
    if t == 'titlesquaresMove' then
        setProperty('titlesquares.x', -20)
        doTweenX('titlesquaresMove', 'titlesquares', -143, titlesquarespeed)
    end
    if t == 'squaresTopMove' then
        setProperty('squaresTop.x', -10)
        doTweenX('squaresTopMove', 'squaresTop', -77, squaresspeed)
    end
    if t == 'squaresBottomMove' then
        setProperty('squaresBottom.x', -77)
        doTweenX('squaresBottomMove', 'squaresBottom', -10, squaresspeed)
    end
end

function onUpdate(elapsed)
        setProperty('bgcircle1.angle', getProperty('bgcircle1.angle') + menubgspeed2 * elapsed * 60)
        setProperty('bgcircle2.angle', getProperty('bgcircle2.angle') + -menubgspeed2 / 1.5 * elapsed * 60)
        if menubgspeed2 > 0.3 then
            menubgspeed2 = menubgspeed2 - 0.05 * elapsed * 60
        elseif menubgspeed2 < 0.3 then
            menubgspeed2 = menubgspeed2 + 0.05 * elapsed * 60
        end
    if not inscene then
        scaledMinSpeed = minAngleSpeed * elapsed * 60
        scaledMaxSpeed = maxAngleSpeed * elapsed * 60
    end


        if vinylspin then
            vinylmultiplier = vinylmultiplier + 11 * elapsed
        end
    if vinylDirection == 'right' then
        if not inscene then
            delta = scaledMinSpeed * 2
        end
        setProperty('vinyl1.angle', getProperty('vinyl1.angle') + delta / 2 * vinylmultiplier)

        setProperty('squares1.y', getProperty('squares1.y') + delta)
        setProperty('squares1highlights.y', getProperty('squares1highlights.y') + delta)
        setProperty('squares2.y', getProperty('squares2.y') - delta)
        setProperty('squares2highlights.y', getProperty('squares2highlights.y') - delta)

        if minAngleSpeed > 0.4 then
            minAngleSpeed = minAngleSpeed - 0.05 * elapsed * 60
        end

    elseif vinylDirection == 'left' then
        if not inscene then
            delta = scaledMaxSpeed * 2
        end
        setProperty('vinyl1.angle', getProperty('vinyl1.angle') + delta / 2 * vinylmultiplier)

        setProperty('squares1.y', getProperty('squares1.y') + delta)
        setProperty('squares1highlights.y', getProperty('squares1highlights.y') + delta)
        setProperty('squares2.y', getProperty('squares2.y') - delta)
        setProperty('squares2highlights.y', getProperty('squares2highlights.y') - delta)

        if maxAngleSpeed < -0.4 then
            maxAngleSpeed = maxAngleSpeed + 0.05 * elapsed * 60
        end
    end

    -- looping reset
    if getProperty('squares1.y') < -163 or getProperty('squares1.y') > -37 then
        setProperty('squares1.y', -100)
        setProperty('squares1highlights.y', -100)
    end

    if getProperty('squares2.y') < -163 or getProperty('squares2.y') > -37 then
        setProperty('squares2.y', -100)
        setProperty('squares2highlights.y', -100)
    end
end

function enterSong()
    soundFadeOut(nil, 0.4, 0) 
    playSound('confirmMenu', 0.7)
    doTweenZoom('camhudzooom', 'camhud', 1.3, 2, 'expoOut')
    doTweenY('squarestopY', 'squaresTop', getProperty('squaresTop.y') + 60, 2, 'expoOut')
    doTweenY('squaresbottomOut', 'squaresBottom', squaresBottomY - 60, openeaseTime, 'expoOut')
    
    for _, song in ipairs(songs) do --player render
        cancelTween(song.player .. 'RenderPlayerRENDERtween')
        cancelTween(song.player .. 'RenderPlayerRENDEROPtween')
        cancelTween(song.player .. 'RenderPlayerinTween')
        cancelTween(song.player..'RENDERtween')

        doTweenX(song.player .. 'RenderPlayerinTween', song.player .. 'RenderPlayer', renderplayerX + playerrenderOffsetsX[song.player] + 70, 1, 'expoOut')
        doTweenY(song.player .. 'RenderPlayerinTween2', song.player .. 'RenderPlayer', renderCenter + playerrenderOffsetsY[song.player] + 30, 2, 'expoOut')
    end
    for _, song in ipairs(songs) do --opponent render
        cancelTween(song.opponent .. 'RenderOpponentRENDERtween')
        cancelTween(song.opponent .. 'RenderOpponentRENDEROPtween')
        cancelTween(song.opponent .. 'RenderOpponentinTween')
        cancelTween(song.opponent..'RENDEROPtween')

        --local renderopponentX = opponentrenderOffsetsY[song.opponent] + renderCenter
        
        doTweenX(song.opponent .. 'RenderOpponentinTween', song.opponent .. 'RenderOpponent', renderopponentX + opponentrenderOffsetsX[song.opponent] - 70, 1, 'expoOut')
        doTweenY(song.opponent .. 'RenderOpponentinTween2', song.opponent .. 'RenderOpponent', renderCenter + opponentrenderOffsetsY[song.opponent] + 30, 2, 'expoOut')
    end

    --doTweenX('')
    --diff stuff
    cancelTween('difficultyinTween')
    cancelTween('diffarrowtopinTween')
    cancelTween('diffarrowbottominTween')
    cancelTween('difflockinTween')
    doTweenX('difficultymonitorinTween', 'difficultymonitor', monitorX+ 300, 2, 'expoOut')
    doTweenX('difficultyOut', 'difficulty', difficultyX+ 300, 2, 'expoOut')
    doTweenX('diffarrowtopOut', 'diffarrowtop', diffarrowsX+ 300, 2, 'expoOut')
    doTweenX('diffarrowbottomOut', 'diffarrowbottom', diffarrowsX+ 300, 2, 'expoOut')
    doTweenX('difflockOut', 'difflock', difflockX+ 300, 2, 'expoOut')

    cancelTween('vinylinTween')
    cancelTween('vinyl2inTween')
    doTweenY('vinyl1Out', 'vinyl1', getProperty('vinyl1.y') - 450, 2, 'expoOut')
    doTweenY('vinyl2Out', 'vinyl2', getProperty('vinyl2.y') - 450, 2, 'expoOut')
    doTweenX('vinyl1size1', 'vinyl1.scale', 0.5, 2, 'expoOut')
    doTweenY('vinyl1size2', 'vinyl1.scale', 0.5, 2, 'expoOut')
    doTweenX('vinyl2size1', 'vinyl2.scale', 0.5, 2, 'expoOut')
    doTweenY('vinyl2size2', 'vinyl2.scale', 0.5, 2, 'expoOut')

    doTweenY('sountestarrowleftIN', 'sountestarrowleft', arrowsY + 100, 1, 'expoOut')
    doTweenY('sountestarrowrightIN', 'sountestarrowright', arrowsY + 100, 1, 'expoOut')
    inscene = true
    delta = delta * 2 
    vinylspin = true
    runTimer('transitionOutLoad', 0.6)
    caninput = false
    beatallowed = false
    --
    for i, name in ipairs(textSprites) do
        if i ~= selectedIndex then
            
            doTweenY(name..'inTween', name, songtextY + 100, 2, 'expoOut')
        else
            doTweenY(name..'inTween', name, songtextY - 150, 2, 'expoOut')
        end
    end
    setProperty('songBar.y', getProperty('songBar.y') + 100)
    doTweenY('songBarIN2', 'songBar', getProperty('songBar.y') - 100, 2, 'expoOut')
    doTweenAlpha('songBarIN', 'songBar', 0.6, 2, 'expoOut')
    
    doTweenX('songstats1IN', 'songstats1', statsX - 300, openeaseTime, 'expoOut')
    doTweenX('songstats2IN', 'songstats2', statsX - 300, openeaseTime, 'expoOut')
    doTweenX('composersub1IN', 'composersub1', statsRIGHTX + 300, openeaseTime, easetype)
    doTweenX('composersub2IN', 'composersub2', statsRIGHTX + 300, openeaseTime, easetype)
    doTweenX('diffTXTIN', 'diffTXT', statsRIGHTX + 300, openeaseTime, easetype)
    doTweenX('ranklolIN', 'ranklol', statsX + rankoffsetX - 300, openeaseTime, 'expoOut')
    doTweenX('crownrankIN', 'crownrank', statsX + rankoffsetX + crownoffsetX - 300, openeaseTime, 'expoOut')
    
    doTweenX('escIN', 'backtxtt', getProperty('backtxtt.x') - 100, openeaseTime, 'expoOut')
    doTweenX('backIN', 'back', getProperty('back.x') - 100, openeaseTime, 'expoOut')
    for i, iconName in ipairs(iconSprites) do
        if i == selectedIndex then
            doTweenX(iconName..'twewenx', iconName..'.scale', 1, 2, 'expoOut')
            doTweenY(iconName..'tweweny', iconName..'.scale', 1, 2, 'expoOut')
        end
    end
end

function onStepHit()
    if curStep == 123 and menuIntroDone == false then
        playAnim('silhouette', 'anim5', false)
    end
    if curStep % 4 == 0 then
    setProperty('LogoTitle.scale.x', logoscale)
    doTweenX('LogoTitlesize1', 'LogoTitle.scale', 2, 0.8, 'expoOut')
    setProperty('LogoTitle.scale.y', logoscale)
    doTweenY('LogoTitlesize2', 'LogoTitle.scale', 2, 0.8, 'expoOut')
    end
end

function onBeatHitCustom(beat)
    beattweentime = 1.6
    beatscale = 2.1
    if beathit then
        beathit = false
        setProperty('bgcircle1.scale.x', beatscale)
        doTweenX('circle1BOP1', 'bgcircle1.scale', 2, beattweentime, 'expoOut')
        setProperty('bgcircle1.scale.y', beatscale)
        doTweenY('circle1BOP2', 'bgcircle1.scale', 2, beattweentime, 'expoOut')
    else
        beathit = true
        setProperty('bgcircle2.scale.x', beatscale)
        doTweenX('circle2BOP1', 'bgcircle2.scale', 2, beattweentime, 'expoOut')
        setProperty('bgcircle2.scale.y', beatscale)
        doTweenY('circle2BOP2', 'bgcircle2.scale', 2, beattweentime, 'expoOut')
    end
end

function escTweenAnim()
    setProperty('back.scale.x', 0.8)
    setProperty('back.scale.y', 0.8)
    doTweenX('backscalex', 'back.scale', 1, 1, 'expoOut')
    doTweenY('backscaley', 'back.scale', 1, 1, 'expoOut')
end

function onUpdatePost()
    if caninput then
    setProperty('logojonNUM.x', getProperty('logojon.x') + offsetlogoNUMX)
    setProperty('logojonNUM.y', getProperty('logojon.y') + offsetlogoNUMY)
    setProperty('logosonic.y', getProperty('squaresBottom.y') + 50)
    setProperty('versionnumber.y', getProperty('logosonic.y') + 10)
    end
    if menuIntroDone and getProperty('menuIntroindicator.x') == 0 then
        setProperty('menuIntroindicator.x', 1)-- 1= intro done, 0= intro not done
    end
    if not menuIntroDone and getProperty('menuIntroindicator.x') == 1 then
        setProperty('menuIntroindicator.x', 0)
    end
    setProperty('cursor.x', getMouseX('other'))
	setProperty('cursor.y', getMouseY('other'))
    --setDataFromSave('globalsave', 'dadUnderlayAlpha', 0)
        if beatallowed then
    local currentTime = getSongPosition() / 1000
    local currentBeat = math.floor(currentTime / beatLength)

    if currentTime < lastTime then
        lastBeat = -1
    end
    lastTime = currentTime

    if currentBeat > lastBeat then
        lastBeat = currentBeat
        onBeatHitCustom(currentBeat)
    end
    end
    --if keyboardJustPressed('R') then
    --    restartSong()
    --end
        if curMenu == 'intro' then
            if (keyJustPressed('accept') or mouseClicked()) or keyJustPressed('back') then
                caninput = false
                runTimer('resetinput', 0.01)
                hideIntro()
                curMenu = 'title'
            end
        end
    if caninput then
        if keyJustPressed('back') and curMenu == 'main' then
            playSound('cancelMenu', 0.8)
                    openTitleScreen()
                    curMenu = 'title'
                    runTimer('closemain', 0.01)
                    
        end
        if (keyJustPressed('accept') or mouseClicked()) and curMenu == 'title' then
            caninput = false
            runTimer('resetTITLE', 0.01)
            menuselected = 0
            closeTitleScreen()
            openMainMenu()
            curMenu = 'main'
        end
        if keyJustPressed('back') then
            if curMenu ~= 'main' and curMenu ~= 'title' and curMenu ~= 'intro' then
                        openMainMenu()
                        escTweenAnim()
            end
        end
        if curMenu == 'main' then
            if keyJustPressed('ui_down') then
                playSound('scrollMenu', 0.8)
                menuselected = menuselected + 1
                updateMainMenu()
            elseif keyJustPressed('ui_up') then
                playSound('scrollMenu', 0.8)
                menuselected = menuselected - 1
                updateMainMenu()
            end
            if keyJustPressed('accept') then
                if menuselected == 1 then
                    caninput = false
                    runTimer('resetinput', 0.01)
                    closeMainMenu()
                    playSound('confirmMenu', 0.7)
                    curMenu = 'adventure'
                    openAdventure()
                    diffselection = ''
                    playAnim('difficulty', 'standard', true)
                elseif menuselected == 2 then
                    caninput = false
                    beatallowed = false
                    soundFadeOut(nil, 0.4, 0) 
                    playSound('confirmMenu', 0.7)
                    setProperty('transInIndicator.x', 1)
                    runTimer('loadextras', 0.8)
                elseif menuselected == 3 then
                    caninput = false
                    beatallowed = false
                    soundFadeOut(nil, 0.4, 0) 
                    playSound('confirmMenu', 0.7)
                    setProperty('transInIndicator.x', 1)
                    runTimer('loadoptions', 0.8)

                    
                end
            end
            if not confirmed and keyJustPressed('back') and curMenu == 'title' and caninput then
               confirmed = true
                endSong()
            end
        end
        
    
        if curMenu == 'adventure' then
            local songzName = songs[selectedIndex].name
            local namereformat = songzName:gsub("%s+", "-"):lower()

            songrank = getDataFromSave('globalsave', 'rank-' .. namereformat .. diffselection, '???')
            songcrown = getDataFromSave('globalsave', 'crown-' .. namereformat .. diffselection, false)
            local songscore = getDataFromSave('globalsave', 'score-' .. namereformat .. diffselection, '???')
            local songaccuracy = getDataFromSave('globalsave', 'acc-' .. namereformat .. diffselection, '???')
            if songaccuracy ~= '???' then
                reformattedaccuracy = songaccuracy..'%'
            else
                reformattedaccuracy = '???'
            end
            setTextString('songstats2', '\n  '..songscore..'\n\n  '..reformattedaccuracy..'\n\n  ')
            playAnim('ranklol', songrank, true)
            if keyJustPressed('back') then
                curMenu = 'main'
                closeAdventure()
                playSound('cancelMenu', 0.7)
            end
            if songcrown then
                setProperty('crownrank.visible', true)
            else
                setProperty('crownrank.visible', false)
            end
        end
            if curMenu == 'adventure' then

            songToLoad = songs[selectedIndex].name
            songsimplifiedname = string.gsub(string.lower(songToLoad), " ", "-")
        if keyJustPressed('accept') and caninput then
            
            if checkFileExists('data/'..songsimplifiedname..'/'..songsimplifiedname..diffselection..'.json') then
                menuselection = 1
            
                enterSong()
            else
                playSound('errorMenu')
            end
        end
        if songsimplifiedname == 'blueprint' or songsimplifiedname == 'break-down' then
            setTextString('composersub2', '\n MegaBaz \n\n')
        else
            setTextString('composersub2', '\n Jon SpeedArts \n\n')
        end
        --debugPrint('data/'..songsimplifiedname..'/'..songsimplifiedname..diffselection..'.json')
           if checkFileExists('data/'..songsimplifiedname..'/'..songsimplifiedname..diffselection..'.json') then
                if getProperty('difflock.visible') then
                    setProperty('difflock.visible', false)
                end
            else
                if not getProperty('difflock.visible') then
                    setProperty('difflock.visible', true)
                    setProperty('difflock.y', difflockY - 10)
                    doTweenY('difflockappear', 'difflock', difflockY, scrollSpeed, easetype)
                end
            end
        if keyJustPressed('ui_up') then
            playSound('scrollMenu', 0.8)
        setProperty('songstats2.y', stats2Y - 8)
        doTweenY('songstats2bounce', 'songstats2', stats2Y, scrollSpeed, easetype)
        setProperty('ranklol.y', stats2Y + rankoffsetY - 8)
        doTweenY('ranklolbounce', 'ranklol', stats2Y + rankoffsetY, scrollSpeed, easetype)
        setProperty('crownrank.y', stats2Y + rankoffsetY + crownoffsetY - 8)
        doTweenY('crownrankbounce', 'crownrank', stats2Y + rankoffsetY + crownoffsetY , scrollSpeed, easetype)

            setProperty('diffarrowtop.scale.x', 0.8)
            setProperty('diffarrowtop.scale.y', 0.8)
            doTweenX('diffarrowtopscaletweenx', 'diffarrowtop.scale', 1, 0.8, 'expoOut')
            doTweenY('diffarrowtopscaletweeny', 'diffarrowtop.scale', 1, 0.8, 'expoOut')

            setProperty('difficulty.y', difficultyY + 10)
            doTweenY('difftweeny', 'difficulty', difficultyY, 0.8, 'expoOut')
            if diffselection == '-easy' then
                diffselection = '-encore'
                playAnim('difficulty', 'encore', true)
            elseif diffselection == '' then
                diffselection = '-easy'
                playAnim('difficulty', 'easy', true)
            elseif diffselection == '-encore' then
                diffselection = ''
                playAnim('difficulty', 'standard', true)
            end
        elseif keyJustPressed('ui_down') then
            playSound('scrollMenu', 0.8)
        setProperty('songstats2.y', stats2Y - 8)
        doTweenY('songstats2bounce', 'songstats2', stats2Y, scrollSpeed, easetype)
        setProperty('ranklol.y', stats2Y + rankoffsetY - 8)
        doTweenY('ranklolbounce', 'ranklol', stats2Y + rankoffsetY, scrollSpeed, easetype)
        setProperty('crownrank.y', stats2Y + rankoffsetY + crownoffsetY - 8)
        doTweenY('crownrankbounce', 'crownrank', stats2Y + rankoffsetY + crownoffsetY , scrollSpeed, easetype)

            setProperty('diffarrowbottom.scale.x', 0.8)
            setProperty('diffarrowbottom.scale.y', 0.8)
            doTweenX('diffarrowbottomscaletweenx', 'diffarrowbottom.scale', 1, 0.8, 'expoOut')
            doTweenY('diffarrowbottomscaletweeny', 'diffarrowbottom.scale', 1, 0.8, 'expoOut')

            setProperty('difficulty.y', difficultyY - 10)
            doTweenY('difftweeny', 'difficulty', difficultyY, 0.8, 'expoOut')
            if diffselection == '-easy' then
                playAnim('difficulty', 'standard', true)
                diffselection = ''
            elseif diffselection == '' then
                playAnim('difficulty', 'encore', true)
                diffselection = '-encore'
            elseif diffselection == '-encore' then
                playAnim('difficulty', 'easy', true)
                diffselection = '-easy'
            end
        end
        if keyJustPressed('ui_left') then
            playSound('scrollMenu', 0.8)
            playAnim('sountestarrowleft', 'press', true)
            lastdirectionPressed = vinylDirection
            vinylDirection = 'left'
            lastdirection = 'left'
            selectedIndex = selectedIndex - 1
            if selectedIndex < 1 then
                selectedIndex = maxIndex
            end
            updateFreeplayPositions()
            elseif keyJustPressed('ui_right') then
            playSound('scrollMenu', 0.8)
            playAnim('sountestarrowright', 'press', true)
                lastdirectionPressed = vinylDirection
                vinylDirection = 'right'
                lastdirection = 'right'
                selectedIndex = selectedIndex + 1
                if selectedIndex > maxIndex then
                    selectedIndex = 1
                end
                updateFreeplayPositions()
            end
        end
    end
    for i, iconName in ipairs(iconSprites) do
        textName = textSprites[i]
        iconXOffset = 95
        iconYOffset = -90

        setProperty(iconName..'.x', getProperty(textName..'.x') + iconXOffset)
        setProperty(iconName..'.y', getProperty(textName..'.y') + iconYOffset)
        setProperty(iconName..'.alpha', getProperty(textName..'.alpha'))
    end

        -- CLIC EN BACKTXT (ESC) - Funciona como la tecla BACK
    if caninput and mouseClicked('left') then
        if getMouseX('other') > getProperty('backtxtt.x') and getMouseX('other') < getProperty('backtxtt.x') + getProperty('backtxtt.width') 
        and getMouseY('other') > getProperty('backtxtt.y') and getMouseY('other') < getProperty('backtxtt.y') + getProperty('backtxtt.height') then
            
            -- Animación del botón back
            setProperty('back.scale.x', 0.8)
            setProperty('back.scale.y', 0.8)
            doTweenX('backscalex', 'back.scale', 1, 1, 'expoOut')
            doTweenY('backscaley', 'back.scale', 1, 1, 'expoOut')
            
            -- Reproducir sonido de cancelar
            playSound('cancelMenu', 0.8)
            
            -- Comportamiento según el menú actual
            if curMenu == 'main' then
                -- En menú principal, volver a title
                openTitleScreen()
                curMenu = 'title'
                runTimer('closemain', 0.01)
                
            elseif curMenu == 'adventure' then
                -- En adventure, volver al menú principal
                curMenu = 'main'
                closeAdventure()
                -- Asegurar que el menú principal se abre correctamente
                openMainMenu()
                updateMainMenu()
                
            elseif curMenu == 'title' then
                -- En title, salir del juego si es posible
                if prevsong == 'Menu' then
                    soundFadeOut(nil, 0.4, 0) 
                    setProperty('transInIndicator.x', 1)
                    runTimer('loadmenu', 0.8)
                else
                    confirmed = true
                    endSong()
                end
                
            elseif curMenu == 'intro' then
                -- En intro, saltar la intro
                caninput = false
                runTimer('resetinput', 0.01)
                hideIntro()
                curMenu = 'title'
            end
            
            return
        end
    end
        -- HOVER PARA SELECCIONAR EN MENÚ PRINCIPAL
    if caninput and curMenu == 'main' then
        local mouseX = getMouseX('other')
        local mouseY = getMouseY('other')
        
        -- Detectar hover sobre adventureBUTTON
        if mouseX > getProperty('adventureBUTTON.x') and mouseX < getProperty('adventureBUTTON.x') + getProperty('adventureBUTTON.width') 
        and mouseY > getProperty('adventureBUTTON.y') and mouseY < getProperty('adventureBUTTON.y') + getProperty('adventureBUTTON.height') then
            if menuselected ~= 1 then
                menuselected = 1
                playSound('scrollMenu', 0.8)
                updateMainMenu()
            end
        end
        
        -- Detectar hover sobre extrasBUTTON
        if mouseX > getProperty('extrasBUTTON.x') and mouseX < getProperty('extrasBUTTON.x') + getProperty('extrasBUTTON.width') 
        and mouseY > getProperty('extrasBUTTON.y') and mouseY < getProperty('extrasBUTTON.y') + getProperty('extrasBUTTON.height') then
            if menuselected ~= 2 then
                menuselected = 2
                playSound('scrollMenu', 0.8)
                updateMainMenu()
            end
        end
        
        -- Detectar hover sobre optionsBUTTON
        if mouseX > getProperty('optionsBUTTON.x') and mouseX < getProperty('optionsBUTTON.x') + getProperty('optionsBUTTON.width') 
        and mouseY > getProperty('optionsBUTTON.y') and mouseY < getProperty('optionsBUTTON.y') + getProperty('optionsBUTTON.height') then
            if menuselected ~= 3 then
                menuselected = 3
                playSound('scrollMenu', 0.8)
                updateMainMenu()
            end
        end
    end
        -- Manejar clics del mouse en el menú principal
    if caninput and mouseClicked('left') then
        
        -- CLIC EN ADVENTURE BUTTON
        if curMenu == 'main' then
            if getMouseX('other') > getProperty('adventureBUTTON.x') and getMouseX('other') < getProperty('adventureBUTTON.x') + getProperty('adventureBUTTON.width') 
            and getMouseY('other') > getProperty('adventureBUTTON.y') and getMouseY('other') < getProperty('adventureBUTTON.y') + getProperty('adventureBUTTON.height') then
                caninput = false
                runTimer('resetinput', 0.01)
                closeMainMenu()
                playSound('confirmMenu', 0.7)
                curMenu = 'adventure'
                openAdventure()
                diffselection = ''
                playAnim('difficulty', 'standard', true)
                return
            end
            
            -- CLIC EN EXTRAS BUTTON
            if getMouseX('other') > getProperty('extrasBUTTON.x') and getMouseX('other') < getProperty('extrasBUTTON.x') + getProperty('extrasBUTTON.width') 
            and getMouseY('other') > getProperty('extrasBUTTON.y') and getMouseY('other') < getProperty('extrasBUTTON.y') + getProperty('extrasBUTTON.height') then
                caninput = false
                beatallowed = false
                soundFadeOut(nil, 0.4, 0) 
                playSound('confirmMenu', 0.7)
                setProperty('transInIndicator.x', 1)
                runTimer('loadextras', 0.8)
                return
            end
            
            -- CLIC EN OPTIONS BUTTON
            if getMouseX('other') > getProperty('optionsBUTTON.x') and getMouseX('other') < getProperty('optionsBUTTON.x') + getProperty('optionsBUTTON.width') 
            and getMouseY('other') > getProperty('optionsBUTTON.y') and getMouseY('other') < getProperty('optionsBUTTON.y') + getProperty('optionsBUTTON.height') then
                caninput = false
                beatallowed = false
                soundFadeOut(nil, 0.4, 0) 
                playSound('confirmMenu', 0.7)
                setProperty('transInIndicator.x', 1)
                runTimer('loadoptions', 0.8)
                return
            end
        end
        
        -- CLIC EN DIFICULTAD (arriba/abajo) en Adventure
        if curMenu == 'adventure' then
            -- Flecha arriba de dificultad
            if getMouseX('other') > getProperty('diffarrowtop.x') and getMouseX('other') < getProperty('diffarrowtop.x') + getProperty('diffarrowtop.width') 
            and getMouseY('other') > getProperty('diffarrowtop.y') and getMouseY('other') < getProperty('diffarrowtop.y') + getProperty('diffarrowtop.height') then
                playSound('scrollMenu', 0.8)
                setProperty('songstats2.y', stats2Y - 8)
                doTweenY('songstats2bounce', 'songstats2', stats2Y, scrollSpeed, easetype)
                setProperty('ranklol.y', stats2Y + rankoffsetY - 8)
                doTweenY('ranklolbounce', 'ranklol', stats2Y + rankoffsetY, scrollSpeed, easetype)
                setProperty('crownrank.y', stats2Y + rankoffsetY + crownoffsetY - 8)
                doTweenY('crownrankbounce', 'crownrank', stats2Y + rankoffsetY + crownoffsetY , scrollSpeed, easetype)

                setProperty('diffarrowtop.scale.x', 0.8)
                setProperty('diffarrowtop.scale.y', 0.8)
                doTweenX('diffarrowtopscaletweenx', 'diffarrowtop.scale', 1, 0.8, 'expoOut')
                doTweenY('diffarrowtopscaletweeny', 'diffarrowtop.scale', 1, 0.8, 'expoOut')

                setProperty('difficulty.y', difficultyY + 10)
                doTweenY('difftweeny', 'difficulty', difficultyY, 0.8, 'expoOut')
                
                if diffselection == '-easy' then
                    diffselection = '-encore'
                    playAnim('difficulty', 'encore', true)
                elseif diffselection == '' then
                    diffselection = '-easy'
                    playAnim('difficulty', 'easy', true)
                elseif diffselection == '-encore' then
                    diffselection = ''
                    playAnim('difficulty', 'standard', true)
                end
                return
            end
            
            -- Flecha abajo de dificultad
            if getMouseX('other') > getProperty('diffarrowbottom.x') and getMouseX('other') < getProperty('diffarrowbottom.x') + getProperty('diffarrowbottom.width') 
            and getMouseY('other') > getProperty('diffarrowbottom.y') and getMouseY('other') < getProperty('diffarrowbottom.y') + getProperty('diffarrowbottom.height') then
                playSound('scrollMenu', 0.8)
                setProperty('songstats2.y', stats2Y - 8)
                doTweenY('songstats2bounce', 'songstats2', stats2Y, scrollSpeed, easetype)
                setProperty('ranklol.y', stats2Y + rankoffsetY - 8)
                doTweenY('ranklolbounce', 'ranklol', stats2Y + rankoffsetY, scrollSpeed, easetype)
                setProperty('crownrank.y', stats2Y + rankoffsetY + crownoffsetY - 8)
                doTweenY('crownrankbounce', 'crownrank', stats2Y + rankoffsetY + crownoffsetY , scrollSpeed, easetype)

                setProperty('diffarrowbottom.scale.x', 0.8)
                setProperty('diffarrowbottom.scale.y', 0.8)
                doTweenX('diffarrowbottomscaletweenx', 'diffarrowbottom.scale', 1, 0.8, 'expoOut')
                doTweenY('diffarrowbottomscaletweeny', 'diffarrowbottom.scale', 1, 0.8, 'expoOut')

                setProperty('difficulty.y', difficultyY - 10)
                doTweenY('difftweeny', 'difficulty', difficultyY, 0.8, 'expoOut')
                
                if diffselection == '-easy' then
                    playAnim('difficulty', 'standard', true)
                    diffselection = ''
                elseif diffselection == '' then
                    playAnim('difficulty', 'encore', true)
                    diffselection = '-encore'
                elseif diffselection == '-encore' then
                    playAnim('difficulty', 'easy', true)
                    diffselection = '-easy'
                end
                return
            end
            
            -- FLECHAS DE CANCIÓN (izquierda/derecha) - sountestarrowleft y sountestarrowright
            if getMouseX('other') > getProperty('sountestarrowleft.x') and getMouseX('other') < getProperty('sountestarrowleft.x') + getProperty('sountestarrowleft.width') 
            and getMouseY('other') > getProperty('sountestarrowleft.y') and getMouseY('other') < getProperty('sountestarrowleft.y') + getProperty('sountestarrowleft.height') then
                playSound('scrollMenu', 0.8)
                playAnim('sountestarrowleft', 'press', true)
                lastdirectionPressed = vinylDirection
                vinylDirection = 'left'
                lastdirection = 'left'
                selectedIndex = selectedIndex - 1
                if selectedIndex < 1 then
                    selectedIndex = maxIndex
                end
                updateFreeplayPositions()
                return
            end
            
            if getMouseX('other') > getProperty('sountestarrowright.x') and getMouseX('other') < getProperty('sountestarrowright.x') + getProperty('sountestarrowright.width') 
            and getMouseY('other') > getProperty('sountestarrowright.y') and getMouseY('other') < getProperty('sountestarrowright.y') + getProperty('sountestarrowright.height') then
                playSound('scrollMenu', 0.8)
                playAnim('sountestarrowright', 'press', true)
                lastdirectionPressed = vinylDirection
                vinylDirection = 'right'
                lastdirection = 'right'
                selectedIndex = selectedIndex + 1
                if selectedIndex > maxIndex then
                    selectedIndex = 1
                end
                updateFreeplayPositions()
                return
            end
            
            -- CLIC EN EL TEXTO DE LA CANCIÓN SELECCIONADA (para iniciar)
            local selectedTextName = textSprites[selectedIndex]
            if getMouseX('other') > getProperty(selectedTextName..'.x') and getMouseX('other') < getProperty(selectedTextName..'.x') + getProperty(selectedTextName..'.width') 
            and getMouseY('other') > getProperty(selectedTextName..'.y') and getMouseY('other') < getProperty(selectedTextName..'.y') + getProperty(selectedTextName..'.height') then
                
                songToLoad = songs[selectedIndex].name
                songsimplifiedname = string.gsub(string.lower(songToLoad), " ", "-")
                
                if checkFileExists('data/'..songsimplifiedname..'/'..songsimplifiedname..diffselection..'.json') then
                    menuselection = 1
                    enterSong()
                else
                    playSound('errorMenu')
                end
                return
            end
        end
    end
end

function onEndSong()
    if not confirmed then
        return Function_Stop
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