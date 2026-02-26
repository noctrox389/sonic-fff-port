function onCreate()
    
    makeLuaSprite('cursor', 'cursor', 0, 0) 
    setObjectCamera('cursor', 'other')
    addLuaSprite('cursor', true)
    
    precacheMusic('breakfast')
    removeLuaScript('scripts/titlecard')
    removeLuaScript('scripts/noteUnderlays')
    removeLuaScript('scripts/pauseMenu')
    removeLuaScript('scripts/homing attack')
    removeLuaScript('scripts/sonic UI')
    removeLuaScript('scripts/results')
    removeLuaScript('scripts/customCountdown')
    setProperty('skipCountdown', true)

    initSaveData('globalsave')
    prevsong = getDataFromSave('globalsave', 'lastSong')
    setDataFromSave('globalsave', 'lastSong', nil)
end

function onCreatePost()
    imgTweenType = 'expoOut'
    imgTweenSpeed = 2
    caninput = true
    songbpm = 125
    stopDancing = false
    musicplayingsoundtest = false
    musicplaying = true
    gallselected = true
    boppinz2 = false
    mainmenu = true
    gallery = false
    soundtest = false
    credits = false
    specialthanks = false
    firstimg = 1
    lastimg = 25
    songplaying = 'breakfast'
    stopSound()
    runTimer('song1', 0.1)
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

    makeLuaSprite('extrasbgtemp')
    makeGraphic('extrasbgtemp', 1920, 1080, 'ffffff') --0000ff
    setProperty('extrasbgtemp.alpha', 1)
    addLuaSprite('extrasbgtemp', false)
    setObjectCamera('extrasbgtemp', 'hud')

    makeAnimatedLuaSprite('bgretro','extras/bg retro', -80, -80)
    addAnimationByPrefix('bgretro', 'scroll', 'reverse checkerboard', 30, true)
    setObjectCamera('bgretro', 'hud')
    addLuaSprite('bgretro')
    playAnim('bgretro', 'scroll', true)
    setProperty('bgretro.color', getColorFromHex('93a9ba'))

    makeAnimatedLuaSprite('bgsquares','extras/bgsquares', -80, 550)
    addAnimationByPrefix('bgsquares', 'scroll', 'squares2', 30, true)
    setObjectCamera('bgsquares', 'hud')
    addLuaSprite('bgsquares')
    setProperty('bgsquares.angle', 352)
    playAnim('bgsquares', 'scroll', true)

    makeAnimatedLuaSprite('bgsquares2','extras/bgsquares', -100, -200)
    addAnimationByPrefix('bgsquares2', 'scroll', 'squares2', 30, true)
    setObjectCamera('bgsquares2', 'hud')
    addLuaSprite('bgsquares2')
    setProperty('bgsquares2.angle', 170)
    playAnim('bgsquares2', 'scroll', true)

    --credits stuff
    makeLuaSprite('creditsbg')
    makeGraphic('creditsbg', 1920, 1080, '000000') --0000ff
    setProperty('creditsbg.alpha', 0.7)
    addLuaSprite('creditsbg', false)
    setObjectCamera('creditsbg', 'hud')


    makeAnimatedLuaSprite('joncredits','extras/credits/jonspeedarts', 300, 300)
    addAnimationByPrefix('joncredits', 'idle', 'jon', 24, false)
    addOffset('joncredits', 'idle', 30, 30)
    setObjectCamera('joncredits', 'hud')
    addLuaSprite('joncredits')
    playAnim('joncredits', 'idle', true)

    makeAnimatedLuaSprite('bazcredits','extras/credits/megabaz', 650, 300)
    addAnimationByPrefix('bazcredits', 'idle', 'baz', 24, false)
    setObjectCamera('bazcredits', 'hud')
    addLuaSprite('bazcredits')
    playAnim('bazcredits', 'idle', true)

    makeLuaSprite('totem1','extras/credits/totem', -20, 280)
    addAnimationByPrefix('totem1', 'idle', 'baz', 24, true)
    setObjectCamera('totem1', 'hud')
    addLuaSprite('totem1')

    makeLuaSprite('totem2','extras/credits/totem', 1020, 280)
    addAnimationByPrefix('totem2', 'idle', 'baz', 24, true)
    setObjectCamera('totem2', 'hud')
    addLuaSprite('totem2')
    setProperty('totem2.flipX', true)

    makeAnimatedLuaSprite('bubblejon','extras/creditslinks', 0, 0)
    addAnimationByPrefix('bubblejon', 'bubble', 'bubble', 24, false)
    setObjectCamera('bubblejon', 'hud')
    addLuaSprite('bubblejon')
    scaleObject('bubblejon', 0.8, 0.8)
    playAnim('bubblejon', 'bubble', true)
    setProperty('bubblejon.alpha', 0)
    bubblecredit1 = false

    makeAnimatedLuaSprite('YTjon','extras/creditslinks', 0, 0)
    addAnimationByPrefix('YTjon', 'YT', 'yt', 24, false)
    addAnimationByPrefix('YTjon', 'YTSELECTED', 'ytselected', 24, false)
    setObjectCamera('YTjon', 'hud')
    addLuaSprite('YTjon')
    scaleObject('YTjon', 0.7, 0.7)
    playAnim('YTjon', 'YT', true)
    setProperty('YTjon.alpha', 0)

    makeAnimatedLuaSprite('TWTjon','extras/creditslinks', 0, 0)
    addAnimationByPrefix('TWTjon', 'TWT', 'twt', 24, false)
    addAnimationByPrefix('TWTjon', 'TWTSELECTED', 'twtselected', 24, false)
    setObjectCamera('TWTjon', 'hud')
    addLuaSprite('TWTjon')
    scaleObject('TWTjon', 0.7, 0.7)
    playAnim('TWTjon', 'TWT', true)
    setProperty('TWTjon.alpha', 0)

    makeAnimatedLuaSprite('bubblebaz','extras/creditslinks', 0, 0)
    addAnimationByPrefix('bubblebaz', 'bubble', 'bubble', 24, false)
    setProperty('bubblebaz.flipX', true)
    setObjectCamera('bubblebaz', 'hud')
    addLuaSprite('bubblebaz')
    scaleObject('bubblebaz', 0.8, 0.8)
    playAnim('bubblebaz', 'bubble', true)
    setProperty('bubblebaz.alpha', 0)
    bubblecredit2 = false
    
    makeAnimatedLuaSprite('YTbaz','extras/creditslinks', 0, 0)
    addAnimationByPrefix('YTbaz', 'YT', 'yt', 24, false)
    addAnimationByPrefix('YTbaz', 'YTSELECTED', 'ytselected', 24, false)
    setObjectCamera('YTbaz', 'hud')
    addLuaSprite('YTbaz')
    scaleObject('YTbaz', 0.7, 0.7)
    playAnim('YTbaz', 'YT', true)
    setProperty('YTbaz.alpha', 0)
    
    makeAnimatedLuaSprite('TWTbaz','extras/creditslinks', 0, 0)
    addAnimationByPrefix('TWTbaz', 'TWT', 'twt', 24, false)
    addAnimationByPrefix('TWTbaz', 'TWTSELECTED', 'twtselected', 24, false)
    setObjectCamera('TWTbaz', 'hud')
    addLuaSprite('TWTbaz')
    scaleObject('TWTbaz', 0.7, 0.7)
    playAnim('TWTbaz', 'TWT', true)
    setProperty('TWTbaz.alpha', 0)


    makeLuaText('creditsTXT2', 'CREDITS', 1270, 0, 80)
    setTextSize('creditsTXT2', 55)
    setTextBorder('creditsTXT2', 5, '000000')
    setTextColor('creditsTXT2', 'ffffff')
    setTextFont('creditsTXT2', 'Kimberley.ttf')
    addLuaText('creditsTXT2', true)
    creditsTXT2y = getProperty('creditsTXT2.y')

    makeLuaText('actualcredits', 'Music, art and coding by Jon SpeedArts \n \nBreak Down, Blueprint and the Game Over Music by MegaBaz', 1270, 0, 150)
    setTextSize('actualcredits', 30)
    setTextBorder('actualcredits', 4, '000000')
    setTextColor('actualcredits', 'ffffff')
    setTextFont('actualcredits', 'Kimberley.ttf')
    addLuaText('actualcredits', true)
    actualcreditsy = getProperty('actualcredits.y')

        makeLuaText('specialthanksind', ' Press TAB for \n Special Thanks', 1270, 500, 40)
    setTextSize('specialthanksind', 25)
    setTextBorder('specialthanksind', 3, '000000')
    setTextColor('specialthanksind', 'ffffff')
    setTextFont('specialthanksind', 'Kimberley.ttf')
    addLuaText('specialthanksind', true)

        makeLuaSprite('overlayspecial', nil, 0, 0)
    makeGraphic('overlayspecial', screenWidth, screenHeight, '696682')
    setObjectCamera('overlayspecial', 'camHUD')
    addLuaSprite('overlayspecial', true)
    setBlendMode('overlayspecial', 'multiply')
    setProperty('overlayspecial.alpha', 0)
    
        makeLuaSprite('overlayspecial', nil, 0, 0)
    makeGraphic('overlayspecial', screenWidth, screenHeight, '696682')
    setObjectCamera('overlayspecial', 'camHUD')
    addLuaSprite('overlayspecial', true)
    setBlendMode('overlayspecial', 'multiply')
    setProperty('overlayspecial.alpha', 0)

    makeLuaText('specialthankstitle', 'Special Thanks!', 1270, 0, 80)
    setTextSize('specialthankstitle', 55)
    setTextBorder('specialthankstitle', 4, '000000')
    setTextColor('specialthankstitle', 'ffffff')
    setTextFont('specialthankstitle', 'Kimberley.ttf')
    addLuaText('specialthankstitle', true)
    specialthanksy = getProperty('specialthankstitle.y')
    setProperty('specialthankstitle.alpha', 0)

    specialcreditssize = 24
    specialcreditsY = 200
    makeLuaText('specialthankscredits1', 'Rofel132_ \n DingusCola \n CommandoDev \n KaiGrasoso \n Trafalgar \n paigeypaper \n justisaac \n Slushy_Anime \n FireVeryHot', 1270, 200, specialcreditsY)
    setTextSize('specialthankscredits1', specialcreditssize)
    setTextBorder('specialthankscredits1', 4, '000000')
    setTextColor('specialthankscredits1', 'ffffff')
    setTextFont('specialthankscredits1', 'Kimberley.ttf')
    addLuaText('specialthankscredits1', true)
    setProperty('specialthankscredits1.alpha', 0)

    makeLuaText('specialthankscredits2', 'blue_kyt (helped a TON with optimizing) \n Mariote780 \n fl0pd00dle \n meatku \n Soihan \n smoothdedede_ \n iwontbeforgotten  \n Estrogen_Storm \n Andree1x', 1270, -200, specialcreditsY)
    setTextSize('specialthankscredits2', specialcreditssize)
    setTextBorder('specialthankscredits2', 4, '000000')
    setTextColor('specialthankscredits2', 'ffffff')
    setTextFont('specialthankscredits2', 'Kimberley.ttf')
    addLuaText('specialthankscredits2', true)
    setProperty('specialthankscredits2.alpha', 0)

    speciallogosize = 1.2
    makeLuaSprite('specialthanks3', 'menus/title/sega logo', 360, 540)
    setObjectCamera('specialthanks3', 'hud')
    setProperty('specialthanks3.scale.x', speciallogosize + 0.15)
    setProperty('specialthanks3.scale.y', speciallogosize + 0.15)
    addLuaSprite('specialthanks3', true)
    setProperty('specialthanks3.alpha', 0)
    
    makeLuaSprite('specialthanks4', 'menus/title/sonic team logo', 700, 520)
    setObjectCamera('specialthanks4', 'hud')
    setProperty('specialthanks4.scale.x', speciallogosize)
    setProperty('specialthanks4.scale.y', speciallogosize)
    addLuaSprite('specialthanks4', true)
    setProperty('specialthanks4.alpha', 0)

    -----------------------------------
    --soundtest stuff

    makeAnimatedLuaSprite('bgsquareswhite1','extras/bgsquareswhite', 100, 50)
    addAnimationByPrefix('bgsquareswhite1', 'scroll', 'squares2 white', 30, true)
    setObjectCamera('bgsquareswhite1', 'hud')
    addLuaSprite('bgsquareswhite1')
    setProperty('bgsquareswhite1.angle', 315)
    playAnim('bgsquareswhite1', 'scroll', true)
    setProperty('bgsquareswhite1.color', getColorFromHex('4550ed'))

    makeAnimatedLuaSprite('bgsquareswhite2','extras/bgsquareswhite', 200, 50)
    addAnimationByPrefix('bgsquareswhite2', 'scroll', 'squares2 white', 30, true)
    setObjectCamera('bgsquareswhite2', 'hud')
    addLuaSprite('bgsquareswhite2')
    setProperty('bgsquareswhite2.flipX', true)
    setProperty('bgsquareswhite2.angle', 315)
    playAnim('bgsquareswhite2', 'scroll', true)
    setProperty('bgsquareswhite2.color', getColorFromHex('372f83'))

    makeAnimatedLuaSprite('sonicsoundtest', 'extras/soundtest/sonicsoundtest', 700, 80, true)
    addAnimationByPrefix('sonicsoundtest', 'idle', 'sonicnew idle', 24, false)
    addAnimationByIndices('sonicsoundtest', 'danceLeft', 'sonicnew dance', '0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12', 24, false)
	addAnimationByIndices('sonicsoundtest', 'danceRight', 'sonicnew dance', '13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27', 24, false)
    setObjectCamera('sonicsoundtest', 'hud')
    scaleObject('sonicsoundtest', 2, 2)
    playAnim('sonicsoundtest', 'idle', true)
    addLuaSprite('sonicsoundtest')

    makeLuaSprite('circlesountest', 'extras/soundtest/soundtestbg', 245, 290, true)
    setObjectCamera('circlesountest', 'hud')
    addLuaSprite('circlesountest')

    makeAnimatedLuaSprite('sountestarrowleft', 'extras/soundtest/arrow soundtest', 200, 350, true)
    addAnimationByPrefix('sountestarrowleft', 'press', 'arrow soundtest', 24, false)
    setObjectCamera('sountestarrowleft', 'hud')
    playAnim('sountestarrowleft', 'press', true)
    addLuaSprite('sountestarrowleft')
    setProperty('sountestarrowleft.flipX', true)

    makeAnimatedLuaSprite('sountestarrowright', 'extras/soundtest/arrow soundtest', 455, 350, true)
    addAnimationByPrefix('sountestarrowright', 'press', 'arrow soundtest', 24, false)
    setObjectCamera('sountestarrowright', 'hud')
    playAnim('sountestarrowright', 'press', true)
    addLuaSprite('sountestarrowright')

    soundtestpick = '00'
    soundtestNUM = 0
    makeLuaText('soundtestpicker', soundtestpick, 250, 230, 350) 
    setTextSize('soundtestpicker', 80)
    setTextBorder('soundtestpicker', 6, '000000')
    setTextColor('soundtestpicker', 'ffffff')
    setTextFont('soundtestpicker', 'Kimberley.ttf')
    addLuaText('soundtestpicker', true)

    soundtestname = 'test'
    makeLuaText('soundtestname', soundtestname, 500, 105, 450)
    setTextSize('soundtestname', 45)
    setTextBorder('soundtestname', 5, '6f2c47')
    setTextColor('soundtestname', 'fec010')
    setTextFont('soundtestname', 'Kimberley.ttf')
    addLuaText('soundtestname', true)

    makeLuaText('soundtesttxt2dec', 'SOUND TEST', 500, 390, 630)
    setTextSize('soundtesttxt2dec', 65)
    setTextBorder('soundtesttxt2dec', 7, '000000')
    setTextColor('soundtesttxt2dec', 'ffffff')
    setTextFont('soundtesttxt2dec', 'Kimberley.ttf')
    addLuaText('soundtesttxt2dec', true)



    --hud
    makeLuaSprite('back','extras/back', 20, 20)
    setObjectCamera('back', 'hud')
    addLuaSprite('back')
    makeLuaText('backtxtt', 'ESC', 100, 90, 30)
    setTextSize('backtxtt', 45)
    setTextBorder('backtxtt', 5, '000000')
    setTextColor('backtxtt', 'ffffff')
    setTextFont('backtxtt', 'Kimberley.ttf')
    addLuaText('backtxtt', true)
    setObjectOrder('back', getObjectOrder('backtxtt') + 1)

    makeLuaText('extrastxt', 'EXTRAS', 250, 1000, 630)
    setTextSize('extrastxt', 65)
    setTextBorder('extrastxt', 7, '000000')
    setTextColor('extrastxt', 'ffffff')
    setTextFont('extrastxt', 'Kimberley.ttf')
    addLuaText('extrastxt', true)

        --image1
        img1Scale = 1.4
        makeLuaSprite('img1','extras/gallery/extras1', 200, 110)
        setObjectCamera('img1', 'hud')
        addLuaSprite('img1')
        scaleObject('img1', img1Scale, img1Scale)
        img1X = getProperty('img1.x')
        img1Y = 110
        --image2
        img2Scale = 1.4
        makeLuaSprite('img2','extras/gallery/extras2', 200, 110)
        setObjectCamera('img2', 'hud')
        addLuaSprite('img2')
        scaleObject('img2', img2Scale, img2Scale)
        img2X = getProperty('img2.x')
        img2Y = 110
        setProperty('img2.visible', false)
        --image3
        img3Scale = 1.4
        makeLuaSprite('img3','extras/gallery/extras3', 200, 110)
        setObjectCamera('img3', 'hud')
        addLuaSprite('img3')
        scaleObject('img3', img3Scale, img3Scale)
        img3X = getProperty('img3.x')
        img3Y = 110
        setProperty('img3.visible', false)
        --image4
        img4Scale = 1.4
        makeLuaSprite('img4','extras/gallery/extras4', 200, 110)
        setObjectCamera('img4', 'hud')
        addLuaSprite('img4')
        scaleObject('img4', img4Scale, img4Scale)
        img4X = getProperty('img4.x')
        img4Y = 110
        setProperty('img4.visible', false)
        --image5
        img5Scale = 1.4
        makeLuaSprite('img5','extras/gallery/extras5', 200, 110)
        setObjectCamera('img5', 'hud')
        addLuaSprite('img5')
        scaleObject('img5', img5Scale, img5Scale)
        img5X = getProperty('img5.x')
        img5Y = 110
        setProperty('img5.visible', false)
        --image6
        img6Scale = 1.4
        makeLuaSprite('img6','extras/gallery/extras6', 200, 110)
        setObjectCamera('img6', 'hud')
        addLuaSprite('img6')
        scaleObject('img6', img6Scale, img6Scale)
        img6X = getProperty('img6.x')
        img6Y = 110
        setProperty('img6.visible', false)
        --image7
        img7Scale = 1.4
        makeLuaSprite('img7','extras/gallery/extras7', 200, 110)
        setObjectCamera('img7', 'hud')
        addLuaSprite('img7')
        scaleObject('img7', img7Scale, img7Scale)
        img7X = getProperty('img7.x')
        img7Y = 110
        setProperty('img7.visible', false)
        --image8
        img8Scale = 1.4
        makeLuaSprite('img8','extras/gallery/extras8', 200, 110)
        setObjectCamera('img8', 'hud')
        addLuaSprite('img8')
        scaleObject('img8', img8Scale, img8Scale)
        img8X = getProperty('img8.x')
        img8Y = 110
        setProperty('img8.visible', false)
        --image9
        img9Scale = 1.4
        makeLuaSprite('img9','extras/gallery/extras9', 200, 110)
        setObjectCamera('img9', 'hud')
        addLuaSprite('img9')
        scaleObject('img9', img9Scale, img9Scale)
        img9X = getProperty('img9.x')
        img9Y = 110
        setProperty('img9.visible', false)
        --image10
        img10Scale = 1
        makeLuaSprite('img10','extras/gallery/extras10', 200, 0)
        setObjectCamera('img10', 'hud')
        addLuaSprite('img10')
        scaleObject('img10', img10Scale, img10Scale)
        img10X = getProperty('img10.x') + 220
        img10Y = 170
        setProperty('img10.visible', false)
        --image11
        img11Scale = 1.4
        makeLuaSprite('img11','extras/gallery/extras11', 200, 110)
        setObjectCamera('img11', 'hud')
        addLuaSprite('img11')
        scaleObject('img11', img11Scale, img11Scale)
        img11X = getProperty('img11.x')
        img11Y = 130
        setProperty('img11.visible', false)
        --image12
        img12Scale = 2.6
        makeLuaSprite('img12','extras/gallery/extras12', 200, 110)
        setObjectCamera('img12', 'hud')
        addLuaSprite('img12')
        setProperty('img12.antialiasing', false)
        scaleObject('img12', img12Scale, img12Scale)
        img12X = getProperty('img12.x')
        img12Y = 130
        setProperty('img12.visible', false)
        --image13
        img13Scale = 1.4
        makeLuaSprite('img13','extras/gallery/extras13', 200, 110)
        setObjectCamera('img13', 'hud')
        addLuaSprite('img13')
        scaleObject('img13', img13Scale, img13Scale)
        img13X = getProperty('img13.x')
        img13Y = 110
        setProperty('img13.visible', false)
        --image14
        img14Scale = 1.8
        makeLuaSprite('img14','extras/gallery/extras14', 200, 110)
        setObjectCamera('img14', 'hud')
        addLuaSprite('img14')
        scaleObject('img14', img14Scale, img14Scale)
        img14X = getProperty('img14.x') + 100
        img14Y = 135
        setProperty('img14.visible', false)
        --image15
        img15Scale = 1.7
        makeLuaSprite('img15','extras/gallery/extras15', 200, 110)
        setObjectCamera('img15', 'hud')
        addLuaSprite('img15')
        scaleObject('img15', img15Scale, img15Scale)
        img15X = getProperty('img15.x') + 60
        img15Y = 135
        setProperty('img15.visible', false)
                --image16
        img16Scale = 3.2
        makeLuaSprite('img16','extras/gallery/extras16', 200, 110)
        setObjectCamera('img16', 'hud')
        addLuaSprite('img16')
        scaleObject('img16', img16Scale, img16Scale)
        img16X = getProperty('img16.x') - 20
        img16Y = 135
        setProperty('img16.visible', false)

        --image17
        img17Scale = 2.6
        makeLuaSprite('img17','extras/gallery/extras17', 200, 110)
        setObjectCamera('img17', 'hud')
        addLuaSprite('img17')
        scaleObject('img17', img17Scale, img17Scale)
        img17X = getProperty('img17.x') + 70
        img17Y = 150
        setProperty('img17.visible', false)

        --image18
        img18Scale = 1.4
        makeLuaSprite('img18','extras/gallery/extras18', 200, 110)
        setObjectCamera('img18', 'hud')
        addLuaSprite('img18')
        scaleObject('img18', img18Scale, img18Scale)
        img18X = getProperty('img18.x')
        img18Y = 110
        setProperty('img18.visible', false)

        --image19
        img19Scale = 2
        makeLuaSprite('img19','extras/gallery/extras19', 200, 110)
        setObjectCamera('img19', 'hud')
        addLuaSprite('img19')
        scaleObject('img19', img19Scale, img19Scale)
        img19X = getProperty('img19.x') + 60
        img19Y = 135
        setProperty('img19.visible', false)

        --image20
        img20Scale = 0.6
        makeLuaSprite('img20','extras/gallery/extras20', 200, 110)
        setObjectCamera('img20', 'hud')
        addLuaSprite('img20')
        scaleObject('img20', img20Scale, img20Scale)
        img20X = getProperty('img20.x') + 10
        img20Y = 110
        setProperty('img20.visible', false)

        --image21
        img21Scale = 1.4
        makeLuaSprite('img21','extras/gallery/extras21', 200, 110)
        setObjectCamera('img21', 'hud')
        addLuaSprite('img21')
        scaleObject('img21', img21Scale, img21Scale)
        img21X = getProperty('img21.x')
        img21Y = 110
        setProperty('img21.visible', false)

        --image22
        img22Scale = 1.7
        makeLuaSprite('img22','extras/gallery/extras22', 200, 110)
        setObjectCamera('img22', 'hud')
        addLuaSprite('img22')
        scaleObject('img22', img22Scale, img22Scale)
        img22X = getProperty('img22.x') + 180
        img22Y = 135
        setProperty('img22.visible', false)
        --image23
        img23Scale = 1.1
        makeLuaSprite('img23','extras/gallery/extras23', 200, 110)
        setObjectCamera('img23', 'hud')
        addLuaSprite('img23')
        scaleObject('img23', img23Scale, img23Scale)
        img23X = getProperty('img23.x') - 10
        img23Y = 180
        setProperty('img23.visible', false)
        --image24
        img24Scale = 0.8
        makeLuaSprite('img24','extras/gallery/extras24', 200, 110)
        setObjectCamera('img24', 'hud')
        addLuaSprite('img24')
        scaleObject('img24', img24Scale, img24Scale)
        img24X = getProperty('img24.x') + 180
        img24Y = 135
        setProperty('img24.visible', false)
        --image25
        img25Scale = 1.2
        makeLuaSprite('img25','extras/gallery/extras25', 200, 110)
        setObjectCamera('img25', 'hud')
        addLuaSprite('img25')
        scaleObject('img25', img25Scale, img25Scale)
        img25X = getProperty('img25.x') + 180
        img25Y = 135
        setProperty('img25.visible', false)


    
------------------------------------------------------------------------
--arrows
    makeAnimatedLuaSprite('arrowLEFT','NOTE_assets-sonic', 60, 200)
    addAnimationByPrefix('arrowLEFT', 'idle', 'arrowLEFT', 20, true)
    addAnimationByPrefix('arrowLEFT', 'press', 'left press', 20, false)
    setObjectCamera('arrowLEFT', 'hud')
    addLuaSprite('arrowLEFT')
    playAnim('arrowLEFT', 'idle', false)
    scaleObject('arrowLEFT', 0.7, 0.7)

    makeAnimatedLuaSprite('arrowRIGHT','NOTE_assets-sonic', 1125, 200)
    addAnimationByPrefix('arrowRIGHT', 'idle', 'arrowRIGHT', 20, true)
    addAnimationByPrefix('arrowRIGHT', 'press', 'right press', 20, false)
    setObjectCamera('arrowRIGHT', 'hud')
    addLuaSprite('arrowRIGHT')
    playAnim('arrowRIGHT', 'idle', false)
    scaleObject('arrowRIGHT', 0.7, 0.7)

    imageselected = 1
    makeLuaText('imgcounter', imageselected..' / '..lastimg, 1270, 0, 50)
    setTextSize('imgcounter', 45)
    setTextBorder('imgcounter', 5, '000000')
    setTextColor('imgcounter', 'ffffff')
    setTextFont('imgcounter', 'Kimberley.ttf')
    addLuaText('imgcounter', true)

    imagedescription = 'peepeepoopoo'
    makeLuaText('imgdesc', imagedescription, 1270, 0, 620)
    imgdescsize = 45 --DEFAULT
    setTextSize('imgdesc', imgdescsize)
    setTextBorder('imgdesc', 5, '000000')
    setTextColor('imgdesc', 'ffffff')
    setTextFont('imgdesc', 'Kimberley.ttf')
    addLuaText('imgdesc', true)
    imgdescY = getProperty('imgdesc.y')

    makeLuaText('galleryTXT', 'GALLERY', 1270, 0, 120)
    setTextSize('galleryTXT', 100)
    setTextBorder('galleryTXT', 7, '000000')
    setTextColor('galleryTXT', 'ffffff')
    setTextFont('galleryTXT', 'Kimberley.ttf')
    addLuaText('galleryTXT', true)
    galleryTXTy = getProperty('galleryTXT.y')

    makeLuaText('soundtestTXT', 'SOUND TEST', 1270, 0, 270)
    setTextSize('soundtestTXT', 100)
    setTextBorder('soundtestTXT', 7, '000000')
    setTextColor('soundtestTXT', 'ffffff')
    setTextFont('soundtestTXT', 'Kimberley.ttf')
    addLuaText('soundtestTXT', true)
    soundtestTXTy = getProperty('soundtestTXT.y')

    makeLuaText('creditsTXT', 'CREDITS', 1270, 0, 420)
    setTextSize('creditsTXT', 100)
    setTextBorder('creditsTXT', 7, '000000')
    setTextColor('creditsTXT', 'ffffff')
    setTextFont('creditsTXT', 'Kimberley.ttf')
    addLuaText('creditsTXT', true)
    creditsTXTy = getProperty('creditsTXT.y')

    makeLuaText('soundcredit', 'Unwind\n- Jon SpeedArts', 1100, 120, 100)
    setTextSize('soundcredit', 40)
    setTextBorder('soundcredit', 5, '000000')
    setTextColor('soundcredit', 'ffffff')
    setTextFont('soundcredit', 'Kimberley.ttf')
    setTextAlignment('soundcredit', 'left')
    addLuaText('soundcredit', true) --
    setProperty('soundcredit.alpha', 0)


    makeLuaSprite('musicicon', 'extras/musicicon', 20, 100)
    setObjectCamera('musicicon', 'hud')
    addLuaSprite('musicicon', true)
    setProperty('musicicon.alpha', 0)

    musicCredit()



    setProperty('img1.visible', false)
    setProperty('img2.visible', false)
    setProperty('img3.visible', false)
    setProperty('img4.visible', false)
    setProperty('img5.visible', false)
    setProperty('img6.visible', false)
    setProperty('img7.visible', false)
    setProperty('img8.visible', false)
    setProperty('img9.visible', false)
    setProperty('img10.visible', false)
    setProperty('img11.visible', false)
    setProperty('img12.visible', false)
    setProperty('img13.visible', false)
    setProperty('img14.visible', false)
    setProperty('imgdesc.visible', false)
    setProperty('imgcounter.visible', false)
    setProperty('arrowLEFT.visible', false)
    setProperty('arrowRIGHT.visible', false)
    setProperty('soundtestTXT.visible', false)
    setProperty('galleryTXT.visible', false)
    setProperty('creditsTXT.visible', false)

    setProperty('joncredits.visible', false)
    setProperty('bazcredits.visible', false)
    --setProperty('totem1.visible', false)
    --setProperty('totem2.visible', false)
    setProperty('creditsbg.visible', false)
    setProperty('creditsTXT2.visible', false)
    setProperty('actualcredits.visible', false)
    setProperty('specialthanksind.visible', false)

    setProperty('bgsquareswhite1.visible', false)
    setProperty('bgsquareswhite2.visible', false)
    setProperty('sonicsoundtest.visible', false)
    setProperty('circlesountest.visible', false)
    setProperty('sountestarrowleft.visible', false)
    setProperty('sountestarrowright.visible', false)
    setProperty('soundtestpicker.visible', false)
    setProperty('soundtestname.visible', false)
    setProperty('soundtesttxt2dec.visible', false)


    extrasMenu()

    makeAnimatedLuaSprite('BotonExtraMobile', 'BotonAcceptMobile', 1150, 582)
    addAnimationByPrefix('BotonExtraMobile', 'idle', 'BotonIdle', 24, true)
    addAnimationByPrefix('BotonExtraMobile', 'pressed', 'BotonPressed', 24, false)
    setObjectCamera('BotonExtraMobile', 'other')
    addLuaSprite('BotonExtraMobile')
end

function musicCredit()
    setProperty('soundcredit.x', -500)
    setProperty('soundcredit.alpha', 0)
    doTweenAlpha('soundcreditInAl', 'soundcredit', 1, 1.5)
    doTweenX('soundcreditIn', 'soundcredit', 120, 1.5, 'quadOut')
    setProperty('musicicon.x', -600)
    setProperty('musicicon.alpha', 0)
    doTweenAlpha('musiciconAl', 'musicicon', 1, 1.5)
    doTweenX('musiciconIn', 'musicicon', 20, 1.5, 'quadOut')
    runTimer('musiciconIn', 2)--poop
    
        if soundtestNUM == 51 then
            setTextString('soundcredit', 'Unwind\n- Jon SpeedArts')
        end
        if soundtestNUM == 52 then
            setTextString('soundcredit', 'WORLD FAMOUS HEDGEHOG\n- Jon SpeedArts')
        end
        if soundtestNUM == 53 then
            setTextString('soundcredit', 'Not Enough Rings\n- MegaBaz')
        end
        if soundtestNUM == 54 then
            setTextString('soundcredit', 'Assembly\n- Jon SpeedArts')
        end
        if soundtestNUM == 55 then
            setTextString('soundcredit', 'Downwind\n- Jon SpeedArts')
        end
        if soundtestNUM == 56 then
            setTextString('soundcredit', 'Rewind\n- Jon SpeedArts')
        end
        if soundtestNUM == 57 then
            setTextString('soundcredit', 'Break Down\n- MegaBaz')
        end
        if soundtestNUM == 59 then
            setTextString('soundcredit', 'Rock Solid\n- Jon SpeedArts')
        end
        if soundtestNUM == 60 then
            setTextString('soundcredit', 'Ultimatum\n- Jon SpeedArts')
        end
        if soundtestNUM == 61 then
            setTextString('soundcredit', 'Unbound\n- Jon SpeedArts')
            bpm = 132
        end
        if soundtestNUM == 62 then
            setTextString('soundcredit', 'Smashprint\n- MegaBaz (ft. Smash Mouth)')
        end
end

function extrasGallery()
    gallery = true
    mainmenu = false
    soundtest = false
    credits = false
    hideMainMenu()
    hideCredits()
    --hideSoundTest()
    --hideCredits()

    imageselected = 1
    setProperty('imgdesc.visible', true)
    setProperty('imgcounter.visible', true)
    setProperty('arrowLEFT.visible', true)
    setProperty('arrowRIGHT.visible', true)
    cancelTimer('hidegallerystuff')


    for i = 1, lastimg do
        setProperty('img'..i..'.y', 720)
        doTweenY('img'..i..'IN', 'img'..i,  _G['img'..i..'Y'], 1, 'expoOut')
        cancelTween('img'..i..'Xtween')
    end
    setProperty('img1.visible', true)
    setProperty('img1.x', img1X)
    for i = 2, lastimg do
        setProperty('img'..i..'.visible', false)
    end

    setProperty('arrowLEFT.x', -110) --60
    doTweenX('arrowLEFTIN', 'arrowLEFT', 60, 0.6, 'quadOut')

    setProperty('arrowRIGHT.x', 1300) --1125
    doTweenX('arrowRIGHTIN', 'arrowRIGHT', 1125, 0.6, 'quadOut')

    setProperty('imgcounter.alpha', 0)
    doTweenAlpha('imgcounterIN', 'imgcounter', 1, 0.6)

    setProperty('imgdesc.alpha', 0)
    doTweenAlpha('imgdescIN', 'imgdesc', 1, 0.6)
end

function extrasMenu()
    if gallery == true then
        hideGallery()
    end
    if credits == true then
        hideCredits()
    end
    if soundtest == true then
        hideSoundTest()
    end
    mainmenu = true
    gallery = false
    soundtest = false
    credits = false
    musicplaying = true

    setProperty('soundtestTXT.visible', true)
    setProperty('galleryTXT.visible', true)
    setProperty('creditsTXT.visible', true)
    cancelTween('galleryTXTOUT')
    cancelTween('creditsTXTOUT')
    cancelTween('soundtestTXTOUT')
    setProperty('galleryTXT.alpha', 1)
    setProperty('creditsTXT.alpha', 1)
    setProperty('soundtestTXT.alpha', 1)

    setProperty('galleryTXT.y', -120)
    doTweenY('galleryTXTin', 'galleryTXT', galleryTXTy, 0.8, 'bounceOut')
    setProperty('soundtestTXT.y', -120)
    doTweenY('soundtestTXTin', 'soundtestTXT', soundtestTXTy, 1, 'bounceOut')
    setProperty('creditsTXT.y', -120)
    doTweenY('creditsTXTin', 'creditsTXT', creditsTXTy, 1.2, 'bounceOut')

    if songplaying ~= 'breakfast' then

        ---

    end

end

function extrasCredits()
    credits = true
    mainmenu = false
    gallery = false
    soundtest = false
    hideMainMenu()
    cancelTimer('hidecreditsstuff')

    setProperty('joncredits.visible', true)
    setProperty('bazcredits.visible', true)
    setProperty('totem1.visible', true)
    setProperty('totem2.visible', true)
    setProperty('creditsbg.visible', true)
    setProperty('creditsTXT2.visible', true)
    setProperty('actualcredits.visible', true)
    setProperty('specialthanksind.visible', true)

    setProperty('creditsTXT2.y', -60)
    doTweenY('creditsTXT2in', 'creditsTXT2', creditsTXT2y, 0.5, 'quadOut')
    
    setProperty('specialthanksind.y', -115)
    doTweenY('specialthanksindin', 'specialthanksind', 40, 0.5, 'quadOut')

    setProperty('actualcredits.y', -115)
    doTweenY('actualcreditsin', 'actualcredits', actualcreditsy, 0.5, 'quadOut')

    setProperty('creditsbg.alpha', 0)
    doTweenAlpha('creditsbgALPHA', 'creditsbg', 0.7, 0.5)
    doTweenAlpha('bgsqALPHA1', 'bgsquares', 0.6, 0.5)
    doTweenAlpha('bgsqALPHA2', 'bgsquares2', 0.6, 0.5)

    setProperty('joncredits.y', 800)
    doTweenY('joncreditsin', 'joncredits', 300, 0.7, 'cubeOut') --x300

    setProperty('bazcredits.y', 800)
    doTweenY('bazcreditsin', 'bazcredits', 300, 0.7, 'cubeOut') --x650
end

function extrasSoundTest()
    musicplaying = false
    soundtest = true
    mainmenu = false
    gallery = false
    credits = false
    soundtestpick = 'null'
    runTimer('soundtestpicktimer', 0.01)
    hideMainMenu()

    setProperty('bgsquareswhite1.visible', true)
    setProperty('bgsquareswhite2.visible', true)
    setProperty('sonicsoundtest.visible', true)
    setProperty('circlesountest.visible', true)
    setProperty('sountestarrowleft.visible', true)
    setProperty('sountestarrowright.visible', true)
    setProperty('soundtestpicker.visible', true)
    setProperty('soundtestname.visible', true)
    setProperty('soundtesttxt2dec.visible', true)
    cancelTimer('hidesoundteststuff')

    playAnim('sonicsoundtest', 'idle', true)
    setProperty('sonicsoundtest.x', 1300) -- 700
    doTweenX('sonicsoundtestIN', 'sonicsoundtest', 700, 0.7, 'cubeOut')
    setProperty('bgsquareswhite1.x', 1000) --100
    doTweenX('bgsquareswhite1IN', 'bgsquareswhite1', 100, 0.7, 'cubeOut')
    
    setProperty('bgsquareswhite2.x', 1000) --200
    doTweenX('bgsquareswhite2IN', 'bgsquareswhite2', 200, 0.7, 'cubeOut')
    
    setProperty('circlesountest.scale.x', 0.01)
    doTweenX('circlesountestIN', 'circlesountest.scale', 1, 0.7, 'cubeOut')
    setProperty('circlesountest.scale.y', 0.01)
    doTweenY('circlesountestIN2', 'circlesountest.scale', 1, 0.7, 'cubeOut')

    setProperty('sountestarrowright.y', -100)
    doTweenY('sountestarrowrightIN', 'sountestarrowright', 350, 0.7, 'cubeOut')

    setProperty('sountestarrowleft.y', -100)
    doTweenY('sountestarrowleftIN', 'sountestarrowleft', 350, 0.7, 'cubeOut')

    setProperty('soundtestpicker.y', -80) --350, 450
    doTweenY('soundtestpickerIN', 'soundtestpicker', 350, 0.7, 'cubeOut')
    
    setProperty('soundtestname.y', 720) --350, 450
    doTweenY('soundtestnameIN', 'soundtestname', 450, 0.7, 'cubeOut')

    setProperty('soundtesttxt2dec.y', 720) --630
    doTweenY('soundtesttxt2decIN', 'soundtesttxt2dec', 630, 0.7, 'cubeOut')

    doTweenY('totem1IN', 'totem1', 720, 0.7, 'quadOut')
    doTweenY('totem2IN', 'totem2', 720, 0.7, 'quadOut')

    
    soundFadeOut(nil, 1, 0) 
end

function hideGallery()
    gallery = false

    runTimer('hidegallerystuff', 0.6)
    for i = 1, lastimg do
        doTweenY('img'..i..'IN', 'img'..i, 720, 1, 'expoOut')
    end

    doTweenX('arrowLEFTIN', 'arrowLEFT', -110, 0.6, 'quadOut')

    doTweenX('arrowRIGHTIN', 'arrowRIGHT', 1300, 0.6, 'quadOut')

    doTweenAlpha('imgcounterIN', 'imgcounter', 0, 0.6)
    
    doTweenAlpha('imgdescIN', 'imgdesc', 0, 0.6)
end

function hideMainMenu()
    mainmenu = false
    
    doTweenX('soundtestTXTsize', 'soundtestTXT.scale', 0.1, 0.3, 'quadIn')
    doTweenY('soundtestTXTsize2', 'soundtestTXT.scale', 0.1, 0.3, 'quadIn')
    doTweenAlpha('soundtestTXTOUT', 'soundtestTXT', 0, 0.3)
    doTweenX('galleryTXTsize', 'galleryTXT.scale', 0.1, 0.3, 'quadIn')
    doTweenY('galleryTXTsize2', 'galleryTXT.scale', 0.1, 0.3, 'quadIn')
    doTweenAlpha('galleryTXTOUT', 'galleryTXT', 0, 0.3)
    doTweenX('creditsTXTsize', 'creditsTXT.scale', 0.1, 0.3, 'quadIn')
    doTweenY('creditsTXTsize2', 'creditsTXT.scale', 0.1, 0.3, 'quadIn')
    doTweenAlpha('creditsTXTOUT', 'creditsTXT', 0, 0.3)
end

function hideCredits()
    credits = false

    doTweenAlpha('bubblejonIN', 'bubblejon', 0, 0.5)
    doTweenAlpha('YTjonIN', 'YTjon', 0, 0.2)
    doTweenAlpha('TWTjonIN', 'TWTjon', 0, 0.2)
    doTweenAlpha('bubblebazIN', 'bubblebaz', 0, 0.5)
    doTweenAlpha('YTbazIN', 'YTbaz', 0, 0.2)
    doTweenAlpha('TWTbazIN', 'TWTbaz', 0, 0.2)
    runTimer('hidecreditsstuff', 0.7)
    doTweenY('creditsTXT2in', 'creditsTXT2', -65, 0.5, 'quadOut')
    
    doTweenY('actualcreditsin', 'actualcredits', -115, 0.5, 'quadOut')
    doTweenY('specialthanksindin', 'specialthanksind', -115, 0.5, 'quadOut')

    doTweenAlpha('creditsbgALPHA', 'creditsbg', 0, 0.5)
    doTweenAlpha('bgsqALPHA1', 'bgsquares', 1, 0.5)
    doTweenAlpha('bgsqALPHA2', 'bgsquares2', 1, 0.5)

    doTweenY('joncreditsin', 'joncredits', 800, 0.7, 'quadOut') --x300

    doTweenY('bazcreditsin', 'bazcredits', 800, 0.7, 'quadOut') --x650
end

function hideSoundTest()
    musicplayingsoundtest = false
    runTimer('hidesoundteststuff', 0.7)

    doTweenX('sonicsoundtestIN', 'sonicsoundtest', 1300, 0.7, 'cubeOut')
    doTweenX('bgsquareswhite1IN', 'bgsquareswhite1', 1000, 0.7, 'cubeOut')
    
    doTweenX('bgsquareswhite2IN', 'bgsquareswhite2', 1000, 0.7, 'cubeOut')
    
    doTweenX('circlesountestIN', 'circlesountest.scale', 0.01, 0.7, 'cubeOut')
    doTweenY('circlesountestIN2', 'circlesountest.scale', 0.01, 0.7, 'cubeOut')

    doTweenY('sountestarrowrightIN', 'sountestarrowright', -100, 0.7, 'cubeOut')

    doTweenY('sountestarrowleftIN', 'sountestarrowleft', -100, 0.7, 'cubeOut')

    doTweenY('soundtestpickerIN', 'soundtestpicker', -80, 0.7, 'cubeOut')
    
    doTweenY('soundtestnameIN', 'soundtestname', 720, 0.7, 'cubeOut')

    doTweenY('soundtesttxt2decIN', 'soundtesttxt2dec', 720, 0.7, 'cubeOut')

    doTweenY('totem1IN', 'totem1', 280, 0.7, 'quadOut')
    doTweenY('totem2IN', 'totem2', 280, 0.7, 'quadOut')

    if musicplaying == false then
        musicCredit()
        soundFadeIn(nil, 1, 0, 0.6)
    end
end
imgdistance = 1200
imgspeedtween = 1
function updateGallery()
    for i = 1, lastimg do
        if i == imageselected then
            if keyJustPressed('right') then
                setProperty('img'..i..'.x', _G['img'..i..'X'] + imgdistance)
                doTweenX('img'..i..'Xtween', 'img'..i, _G['img'..i..'X'], imgspeedtween, 'expoOut')
                setProperty('img'..(i-1)..'.x', _G['img'..(i-1)..'X'])
                doTweenX('img'..(i-1)..'Xtween', 'img'..(i-1), _G['img'..(i-1)..'X'] - imgdistance, imgspeedtween, 'expoOut')
            elseif keyJustPressed('left') then
                setProperty('img'..i..'.x', _G['img'..i..'X'] - imgdistance)
                doTweenX('img'..i..'Xtween', 'img'..i, _G['img'..i..'X'], imgspeedtween, 'expoOut')
                setProperty('img'..(i+1)..'.x', _G['img'..(i+1)..'X'])
                doTweenX('img'..(i+1)..'Xtween', 'img'..(i+1), _G['img'..(i+1)..'X'] + imgdistance, imgspeedtween, 'expoOut')
            end
            setProperty('img'..i..'.y', _G['img'..i..'Y'])
            setProperty('img'..i..'.alpha', 1)
            setProperty('img'..i..'.visible', true)
        end
    end
end

function onTweenCompleted(tag)
end

function onTimerCompleted(tag)
    if tag == 'turnonspecial' then
        
            specialthanks = true
    end
    if tag == 'resetspecial' then
        
            specialthanks = false
    end
    if tag == 'loadmenu' then
        setDataFromSave('globalsave', 'lastSong', songName)
        loadSong('menu', -1)
    end
    if tag == 'soundtestpicktimer' then
        soundtestpick = '00'
    end
    if tag == 'song1' then
        playMusic('breakfast', 0.9, true)
    end
    if tag == 'scrollTexty' then
        setProperty('imgdesc.y', imgdescY - 15)
        doTweenY('imagedescytween', 'imgdesc', imgdescY, 0.3, 'quadOut')
    end
    if tag == 'hidegallerystuff' then        
        setProperty('img1.visible', false)
        setProperty('img2.visible', false)
        setProperty('img3.visible', false)
        setProperty('img4.visible', false)
        setProperty('img5.visible', false)
        setProperty('img6.visible', false)
        setProperty('img7.visible', false)
        setProperty('img8.visible', false)
        setProperty('img9.visible', false)
        setProperty('img10.visible', false)
        setProperty('img11.visible', false)
        setProperty('img12.visible', false)
        setProperty('img13.visible', false)
        setProperty('img14.visible', false)
        setProperty('imgdesc.visible', false)
        setProperty('imgcounter.visible', false)
        setProperty('arrowLEFT.visible', false)
        setProperty('arrowRIGHT.visible', false)
    end
    if tag == 'hidecreditsstuff' then        
        setProperty('joncredits.visible', false)
        setProperty('bazcredits.visible', false)
        setProperty('bgsquares.alpha', 1)
        setProperty('bgsquares2.alpha', 1)
        setProperty('creditsbg.visible', false)
        setProperty('creditsTXT2.visible', false)
        setProperty('actualcredits.visible', false)
        setProperty('specialthanksind.visible', false)
        cancelTween('bgsqALPHA1')
        cancelTween('bgsqALPHA2')
        setProperty('bgsquares.alpha', 1)
        setProperty('bgsquares2.alpha', 1)
    end
    if tag == 'hidesoundteststuff' then        
        setProperty('bgsquareswhite1.visible', false)
        setProperty('bgsquareswhite2.visible', false)
        setProperty('sonicsoundtest.visible', false)
        setProperty('circlesountest.visible', false)
        setProperty('sountestarrowleft.visible', false)
        setProperty('sountestarrowright.visible', false)
        setProperty('soundtestpicker.visible', false)
        setProperty('soundtestname.visible', false)
        setProperty('soundtesttxt2dec.visible', false)
    end
    if tag == 'stopdancing' then
        stopDancing = false
    end
    if tag == 'musiciconIn' then
        doTweenAlpha('soundcreditInAl', 'soundcredit', 0, 1.5)
        doTweenX('soundcreditIn', 'soundcredit', 620, 1.5, 'quadIn')
        doTweenAlpha('musiciconAl', 'musicicon', 0, 1.5)
        doTweenX('musiciconIn', 'musicicon', 520, 1.5, 'quadIn')
    end
    if tag == 'dancetimer' then
        if musicplaying == true then
            setProperty('extrastxt.scale.x', 1.1)
            doTweenX('extrasBOP', 'extrastxt.scale', 1, 0.48, 'quadOut')
            setProperty('extrastxt.scale.y', 1.1)
            doTweenY('extrasBOP2', 'extrastxt.scale', 1, 0.48, 'quadOut')
    
           if boppinz2 then
                boppinz2 = false
                playAnim('joncredits', 'idle', true)
                playAnim('bazcredits', 'idle', true)
                if soundtest == true and musicplayingsoundtest == true then
                    playAnim('sonicsoundtest', 'danceLeft', true)
                end
            else
                boppinz2 = true
                if soundtest == true and musicplayingsoundtest == true then
                    playAnim('sonicsoundtest', 'danceRight', true)
                end
            end
        end
    end
        if tag == 'resetButtonExtraAnim' then
        playAnim('BotonExtraMobile', 'idle', true)
    end
end

function onEndSong()
    if not confirmed then
        return Function_Stop
    end
end

function onBeatHit()

end

function onStepHit()
    if curStep % 4 == 0 then
        if songbpm == 125 then
            runTimer('dancetimer', 0.45)
        end
        if songbpm == 87 then
            runTimer('dancetimer', 0.13)
        end
        if songbpm == 132 then
            runTimer('dancetimer', 0.225)
        end
        if songbpm == 170 then
            runTimer('dancetimer', 0.15)
        end
        if songbpm == 180 then
            runTimer('dancetimer', 0.15)
        end
        if songbpm == 105 then
            runTimer('dancetimer', 0.15)
        end
        if songbpm == 116 then
            runTimer('dancetimer', 0.35)
        end
        if songbpm == 121 then
            runTimer('dancetimer', 0.12)
        end
        if songbpm == 112 then
            runTimer('dancetimer', 0.35)
        end
        if songbpm == 97 then
            runTimer('dancetimer', 0.1)
        end
    end
end

function onUpdatePost()
    --if keyboardJustPressed('R') then --DELETE BEFORE RELEASE
    --    restartSong()
    --end
    if credits and not specialthanks then
        if keyboardJustPressed('TAB') then
            runTimer('turnonspecial', 0.01)
            doTweenAlpha('overlayspecialalpha', 'overlayspecial', 1, 0.7)
            doTweenAlpha('specialthankstitlealpha', 'specialthankstitle', 1, 0.7)
            doTweenAlpha('specialthankscredits1alpha', 'specialthankscredits1', 1, 0.7)
            doTweenAlpha('specialthankscredits2alpha', 'specialthankscredits2', 1, 0.7)
            doTweenAlpha('specialthanks3alpha', 'specialthanks3', 1, 0.7)
            doTweenAlpha('specialthanks4alpha', 'specialthanks4', 1, 0.7)
            --hide other stuff
            doTweenAlpha('creditsTXT2alpha', 'creditsTXT2', 0, 0.7)
            doTweenAlpha('actualcreditsalpha', 'actualcredits', 0, 0.7)
            doTweenAlpha('specialthanksindalpha', 'specialthanksind', 0, 0.7)

            
        end
    end
    if specialthanks then
        if getProperty('bubblebaz.alpha') ~= 0 then
                doTweenAlpha('bubblebazIN', 'bubblebaz', 0, 0.2)
                doTweenAlpha('YTbazIN', 'YTbaz', 0, 0.2)
                playAnim('YTbaz', 'YT', true)
                doTweenAlpha('TWTbazIN', 'TWTbaz', 0, 0.2)
                playAnim('TWTbaz', 'TWT', true)
            end
            if getProperty('bubblejon.alpha') ~= 0 then
                doTweenAlpha('bubblejonIN', 'bubblejon', 0, 0.2)
                doTweenAlpha('YTjonIN', 'YTjon', 0, 0.2)
                playAnim('YTjon', 'YT', true)
                doTweenAlpha('TWTjonIN', 'TWTjon', 0, 0.2)
                playAnim('TWTjon', 'TWT', true)
            end
        if keyJustPressed('BACK') or keyboardJustPressed('TAB') then
            runTimer('resetspecial', 0.01)
            doTweenAlpha('overlayspecialalpha', 'overlayspecial', 0, 0.7)
            doTweenAlpha('specialthankstitlealpha', 'specialthankstitle', 0, 0.7)
            doTweenAlpha('specialthankscredits1alpha', 'specialthankscredits1', 0, 0.7)
            doTweenAlpha('specialthankscredits2alpha', 'specialthankscredits2', 0, 0.7)
            doTweenAlpha('specialthanks3alpha', 'specialthanks3', 0, 0.7)
            doTweenAlpha('specialthanks4alpha', 'specialthanks4', 0, 0.7)
            --unhide other stuff
            doTweenAlpha('creditsTXT2alpha', 'creditsTXT2', 1, 0.7)
            doTweenAlpha('actualcreditsalpha', 'actualcredits', 1, 0.7)
            doTweenAlpha('specialthanksindalpha', 'specialthanksind', 1, 0.7)
        end
    end

    setProperty('cursor.x', getMouseX('other'))
	setProperty('cursor.y', getMouseY('other'))
	setProperty('selection.x', getProperty('cursor.x'))
	setProperty('selection.y', getProperty('cursor.y'))
    
    setProperty('bubblejon.x', getProperty('joncredits.x') - 250)
    setProperty('bubblejon.y', getProperty('joncredits.y') + 10)
    setProperty('YTjon.x', getProperty('bubblejon.x') + 10)
    setProperty('YTjon.y', getProperty('bubblejon.y') + 20)
    setProperty('TWTjon.x', getProperty('bubblejon.x') + 10)
    setProperty('TWTjon.y', getProperty('bubblejon.y') + 110)
    setProperty('bubblebaz.x', getProperty('bazcredits.x') + 300)
    setProperty('bubblebaz.y', getProperty('bazcredits.y') + 10)
    setProperty('YTbaz.x', getProperty('bubblebaz.x') + 35)
    setProperty('YTbaz.y', getProperty('bubblebaz.y') + 20)
    setProperty('TWTbaz.x', getProperty('bubblebaz.x') + 35)
    setProperty('TWTbaz.y', getProperty('bubblebaz.y') + 110)
    if credits and not specialthanks then
        if callMethodFromClass('flixel.FlxG', 'mouse.overlaps', {instanceArg('joncredits'), instanceArg('camHUD')}) or callMethodFromClass('flixel.FlxG', 'mouse.overlaps', {instanceArg('bubblejon'), instanceArg('camHUD')}) and bubblecredit1 then
            if getProperty('bubblejon.alpha') ~= 1 then
                bubblecredit1 = true
                doTweenAlpha('bubblejonIN', 'bubblejon', 1, 0.5)
                doTweenAlpha('YTjonIN', 'YTjon', 1, 0.5)
                doTweenAlpha('TWTjonIN', 'TWTjon', 1, 0.5)
            end
            if callMethodFromClass('flixel.FlxG', 'mouse.overlaps', {instanceArg('YTjon'), instanceArg('camHUD')}) and bubblecredit1 then
                playAnim('YTjon', 'YTSELECTED', true)
                if mouseClicked() then
                    os.execute("start https://www.youtube.com/@JonSpeedArts")
                end
            else
                playAnim('YTjon', 'YT', true)
            end
            if callMethodFromClass('flixel.FlxG', 'mouse.overlaps', {instanceArg('TWTjon'), instanceArg('camHUD')}) and bubblecredit1 then
                playAnim('TWTjon', 'TWTSELECTED', true)
                if mouseClicked() then
                    os.execute("start https://twitter.com/Jon_SpeedArts")
                end
            else
                playAnim('TWTjon', 'TWT', true)
            end
        else
            bubblecredit1 = false
            doTweenAlpha('bubblejonIN', 'bubblejon', 0, 0.2)
            doTweenAlpha('YTjonIN', 'YTjon', 0, 0.2)
            playAnim('YTjon', 'YT', true)
            doTweenAlpha('TWTjonIN', 'TWTjon', 0, 0.2)
            playAnim('TWTjon', 'TWT', true)
        end
        --BAZ
        if callMethodFromClass('flixel.FlxG', 'mouse.overlaps', {instanceArg('bazcredits'), instanceArg('camHUD')}) or callMethodFromClass('flixel.FlxG', 'mouse.overlaps', {instanceArg('bubblebaz'), instanceArg('camHUD')}) and bubblecredit2 then
            if getProperty('bubblebaz.alpha') ~= 1 then
                bubblecredit2 = true
                doTweenAlpha('bubblebazIN', 'bubblebaz', 1, 0.5)
                doTweenAlpha('YTbazIN', 'YTbaz', 1, 0.5)
                doTweenAlpha('TWTbazIN', 'TWTbaz', 1, 0.5)
            end
            if callMethodFromClass('flixel.FlxG', 'mouse.overlaps', {instanceArg('YTbaz'), instanceArg('camHUD')}) and bubblecredit2 then
                playAnim('YTbaz', 'YTSELECTED', true)
                if mouseClicked() then
                    os.execute("start https://www.youtube.com/@megabaz9")
                end
            else
                playAnim('YTbaz', 'YT', true)
            end
            if callMethodFromClass('flixel.FlxG', 'mouse.overlaps', {instanceArg('TWTbaz'), instanceArg('camHUD')}) and bubblecredit2 then
                playAnim('TWTbaz', 'TWTSELECTED', true)
                if mouseClicked() then
                    os.execute("start https://twitter.com/MegaBaZ")
                end
            else
                playAnim('TWTbaz', 'TWT', true)
            end
        else
            bubblecredit2 = false
            doTweenAlpha('bubblebazIN', 'bubblebaz', 0, 0.2)
            doTweenAlpha('YTbazIN', 'YTbaz', 0, 0.2)
            playAnim('YTbaz', 'YT', true)
            doTweenAlpha('TWTbazIN', 'TWTbaz', 0, 0.2)
            playAnim('TWTbaz', 'TWT', true)
        end        
    end
if caninput then
    if not confirmed and keyJustPressed('back') and mainmenu == true then
        caninput = false
        if prevsong == 'Menu' then
                    soundFadeOut(nil, 0.4, 0) 
                    playSound('cancelMenu', 0.8)
                    setProperty('transInIndicator.x', 1)
                    runTimer('loadmenu', 0.8)
        else
        confirmed = true
        endSong()
        end
    end
    if keyJustPressed('back') and mainmenu ~= true and not specialthanks then
        setProperty('back.scale.x', 0.8)
        setProperty('back.scale.y', 0.8)
        doTweenX('backscalex', 'back.scale', 1, 0.3, 'quadOut')
        doTweenY('backscaley', 'back.scale', 1, 0.3, 'quadOut')
        playSound('cancelMenu', 0.8)
        extrasMenu()
        if gallery == true then
            gallselected = true
            credselected = false
            soundselected = false
        end
        if soundtest == true then
            soundselected = true
            credselected = false
            gallselected = false
        end
        if credits == true then
            credselected = true
            soundselected = false
            gallselected = false
        end
    end
end
if caninput then
    if gallselected == true and gallery == false then
        if keyJustPressed('accept') then
            playSound('confirmMenu', 0.8)
            extrasGallery()
        end
    end
    if credselected == true and credits == false then
        if keyJustPressed('accept') then
            playSound('confirmMenu', 0.8)
            extrasCredits()
        end
    end
    if soundselected == true and soundtest == false then
        if keyJustPressed('accept') then
            playSound('confirmMenu', 0.8)
            extrasSoundTest()
        end
    end
    
    if mainmenu == true then
        if keyJustPressed('down') then
            playSound('scrollMenu', 0.8)
            if gallselected == true then
                gallselected = false
                soundselected = true
                credselected = false
            elseif soundselected == true then
                soundselected = false
                gallselected = false
                credselected = true
            elseif credselected == true then
                credselected = false
                soundselected = false
                gallselected = true
            end
        end
        if keyJustPressed('up') then
            playSound('scrollMenu', 0.8)
            if gallselected == true then
                gallselected = false
                soundselected = false
                credselected = true
            elseif credselected == true then
                credselected = false
                soundselected = true
                gallselected = false
            elseif soundselected == true then
                soundselected = false
                gallselected = true
                credselected = false
            end
        end
        if gallselected == true then
            setTextBorder('galleryTXT', 10, '6f2c47')
            setTextColor('galleryTXT', 'fec010')
            doTweenX('galleryTXTsize', 'galleryTXT.scale', 1.2, 0.3, 'quadOut')
            doTweenY('galleryTXTsize2', 'galleryTXT.scale', 1.2, 0.3, 'quadOut')
        else
            setTextBorder('galleryTXT', 10, '000000')
            setTextColor('galleryTXT', 'ffffff')
            doTweenX('galleryTXTsize', 'galleryTXT.scale', 1, 0.3, 'quadOut')
            doTweenY('galleryTXTsize2', 'galleryTXT.scale', 1, 0.3, 'quadOut')
        end
        if soundselected == true then
            setTextBorder('soundtestTXT', 10, '6f2c47')
            setTextColor('soundtestTXT', 'fec010')
            doTweenX('soundtestTXTsize', 'soundtestTXT.scale', 1.2, 0.3, 'quadOut')
            doTweenY('soundtestTXTsize2', 'soundtestTXT.scale', 1.2, 0.3, 'quadOut')
        else
            setTextBorder('soundtestTXT', 10, '000000')
            setTextColor('soundtestTXT', 'ffffff')
            doTweenX('soundtestTXTsize', 'soundtestTXT.scale', 1, 0.3, 'quadOut')
            doTweenY('soundtestTXTsize2', 'soundtestTXT.scale', 1, 0.3, 'quadOut')
        end
        if credselected == true then
            setTextBorder('creditsTXT', 10, '6f2c47')
            setTextColor('creditsTXT', 'fec010')
            doTweenX('creditsTXTsize', 'creditsTXT.scale', 1.2, 0.3, 'quadOut')
            doTweenY('creditsTXTsize2', 'creditsTXT.scale', 1.2, 0.3, 'quadOut')
        else
            setTextBorder('creditsTXT', 10, '000000')
            setTextColor('creditsTXT', 'ffffff')
            doTweenX('creditsTXTsize', 'creditsTXT.scale', 1, 0.3, 'quadOut')
            doTweenY('creditsTXTsize2', 'creditsTXT.scale', 1, 0.3, 'quadOut')
        end
        --gallselected = true
        --soundselected = false
        --credselected = false
    end
end


    if soundtest == true then
        if keyJustPressed('right') then
            playAnim('sountestarrowright', 'press', true)
            --soundtestpicker 230, soundtestname 105
            setProperty('soundtestpicker.x', 240)
            doTweenX('soundtestpickerScroll', 'soundtestpicker', 230, 0.3, 'quadOut')
            setProperty('soundtestname.x', 115)
            doTweenX('soundtestnameScroll', 'soundtestname', 105, 0.3, 'quadOut')
            if soundtestNUM < 63 then
                soundtestNUM = soundtestNUM + 1
            else
                soundtestNUM = 1
            end
            soundtestpick = string.format("%02X", soundtestNUM)
            
        end
        if keyJustPressed('left') then
            playAnim('sountestarrowleft', 'press', true)
            setProperty('soundtestpicker.x', 220)
            doTweenX('soundtestpickerScroll', 'soundtestpicker', 230, 0.3, 'quadOut')
            setProperty('soundtestname.x', 95)
            doTweenX('soundtestnameScroll', 'soundtestname', 105, 0.3, 'quadOut')
            
            if soundtestNUM > 0 then
                soundtestNUM = soundtestNUM - 1
            else
                soundtestNUM = 63
            end
            soundtestpick = string.format("%02X", soundtestNUM)
        end

        setTextString('soundtestpicker', soundtestpick)
        setTextString('soundtestname', soundtestname)
        if soundtestNUM == null then
            soundtestmusic = false
            soundtestname = 'null'
        end
        if soundtestNUM == 0 then
            soundtestmusic = false
            soundtestname = '10rings'
            soundfilename = '10rings'
        end
        if soundtestNUM == 1 then
            soundtestmusic = false
            soundtestname = 'bfyeah'
            soundfilename = soundtestname
        end
        if soundtestNUM == 2 then
            soundtestmusic = false
            soundtestname = 'bumper'
            soundfilename = soundtestname
        end
        if soundtestNUM == 3 then
            soundtestmusic = false
            soundtestname = 'cancelMenu'
            soundfilename = soundtestname
        end
        if soundtestNUM == 4 then
            soundtestmusic = false
            soundtestname = 'confirmMenu'
            soundfilename = soundtestname
        end
        if soundtestNUM == 5 then
            soundtestmusic = false
            soundtestname = 'continue'
            soundfilename = soundtestname
        end
        if soundtestNUM == 6 then
            soundtestmusic = false
            soundtestname = 'coolHit'
            soundfilename = soundtestname
        end
        if soundtestNUM == 7 then
            soundtestmusic = false
            soundtestname = 'damage'
            soundfilename = soundtestname
        end
        if soundtestNUM == 8 then
            soundtestmusic = false
            soundtestname = 'errorMenu'
            soundfilename = soundtestname
        end
        if soundtestNUM == 9 then
            soundtestmusic = false
            soundtestname = 'fireworkexplode'
            soundfilename = soundtestname
        end
        if soundtestNUM == 10 then
            soundtestmusic = false
            soundtestname = 'fireworklaunch'
            soundfilename = soundtestname
        end
        if soundtestNUM == 11 then
            soundtestmusic = false
            soundtestname = 'giveup'
            soundfilename = soundtestname
        end
        if soundtestNUM == 12 then
            soundtestmusic = false
            soundtestname = 'gunshot'
            soundfilename = soundtestname
        end
        if soundtestNUM == 13 then
            soundtestmusic = false
            soundtestname = 'hit1'
            soundfilename = soundtestname
        end
        if soundtestNUM == 14 then
            soundtestmusic = false
            soundtestname = 'hitit'
            soundfilename = soundtestname
        end
        if soundtestNUM == 15 then
            soundtestmusic = false
            soundtestname = 'hitsketchhog'
            soundfilename = soundtestname
        end
        if soundtestNUM == 16 then
            soundtestmusic = false
            soundtestname = 'hitsonic'
            soundfilename = soundtestname
        end
        if soundtestNUM == 17 then
            soundtestmusic = false
            soundtestname = 'homing'
            soundfilename = soundtestname
        end
        if soundtestNUM == 18 then
            soundtestmusic = false
            soundtestname = 'homingsketchhog'
            soundfilename = soundtestname
        end
        if soundtestNUM == 19 then
            soundtestmusic = false
            soundtestname = 'honk'
            soundfilename = soundtestname
        end
        if soundtestNUM == 20 then
            soundtestmusic = false
            soundtestname = 'hurt'
            soundfilename = soundtestname
        end
        if soundtestNUM == 21 then
            soundtestmusic = false
            soundtestname = 'intro1'
            soundfilename = soundtestname
        end
        if soundtestNUM == 22 then
            soundtestmusic = false
            soundtestname = 'intro2'
            soundfilename = soundtestname
        end
        if soundtestNUM == 23 then
            soundtestmusic = false
            soundtestname = 'intro3'
            soundfilename = soundtestname
        end
        if soundtestNUM == 24 then
            soundtestmusic = false
            soundtestname = 'introGo'
            soundfilename = soundtestname
        end
        if soundtestNUM == 25 then
            soundtestmusic = false
            soundtestname = 'jump'
            soundfilename = soundtestname
        end
        if soundtestNUM == 26 then
            soundtestmusic = false
            soundtestname = 'jumpsketchhog'
            soundfilename = soundtestname
        end
        if soundtestNUM == 27 then
            soundtestmusic = false
            soundtestname = 'land'
            soundfilename = soundtestname
        end
        if soundtestNUM == 28 then
            soundtestmusic = false
            soundtestname = 'loserings'
            soundfilename = soundtestname
        end
        if soundtestNUM == 29 then
            soundtestmusic = false
            soundtestname = 'loseringssketchhog'
            soundfilename = soundtestname
        end
        if soundtestNUM == 29 then
            soundtestmusic = false
            soundtestname = 'metalBlock'
            soundfilename = soundtestname
        end
        if soundtestNUM == 30 then
            soundtestmusic = false
            soundtestname = 'metalexplosion'
            soundfilename = soundtestname
        end
        if soundtestNUM == 31 then
            soundtestmusic = false
            soundtestname = 'miniscrollMenu'
            soundfilename = soundtestname
        end
        if soundtestNUM == 32 then
            soundtestmusic = false
            soundtestname = 'monitor'
            soundfilename = soundtestname
        end
        if soundtestNUM == 33 then
            soundtestmusic = false
            soundtestname = 'OSUhit'
            soundfilename = soundtestname
        end
        if soundtestNUM == 34 then
            soundtestmusic = false
            soundtestname = 'OSUpunch'
            soundfilename = soundtestname
        end
        if soundtestNUM == 35 then
            soundtestmusic = false
            soundtestname = 'quicktimeBad'
            soundfilename = soundtestname
        end
        if soundtestNUM == 36 then
            soundtestmusic = false
            soundtestname = 'quicktimeGood'
            soundfilename = soundtestname
        end
        if soundtestNUM == 37 then
            soundtestmusic = false
            soundtestname = 'quicktimeHit'
            soundfilename = soundtestname
        end
        if soundtestNUM == 38 then
            soundtestmusic = false
            soundtestname = 'rank'
            soundfilename = soundtestname
        end
        if soundtestNUM == 39 then
            soundtestmusic = false
            soundtestname = 'ring'
            soundfilename = soundtestname
        end
        if soundtestNUM == 40 then
            soundtestmusic = false
            soundtestname = 'ringleft'
            soundfilename = soundtestname
        end
        if soundtestNUM == 41 then
            soundtestmusic = false
            soundtestname = 'ringright'
            soundfilename = soundtestname
        end
        if soundtestNUM == 42 then
            soundtestmusic = false
            soundtestname = 'ringsketchhog'
            soundfilename = soundtestname
        end
        if soundtestNUM == 43 then
            soundtestmusic = false
            soundtestname = 'ringsketchhogleft'
            soundfilename = soundtestname
        end
        if soundtestNUM == 44 then
            soundtestmusic = false
            soundtestname = 'ringsketchhogright'
            soundfilename = soundtestname
        end
        if soundtestNUM == 45 then
            soundtestmusic = false
            soundtestname = 'scrollMenu'
            soundfilename = soundtestname
        end
        if soundtestNUM == 46 then
            soundtestmusic = false
            soundtestname = 'slide'
            soundfilename = soundtestname
        end
        if soundtestNUM == 47 then
            soundtestmusic = false
            soundtestname = 'thud'
            soundfilename = soundtestname
        end
        if soundtestNUM == 48 then
            soundtestmusic = false
            soundtestname = 'warning'
            soundfilename = soundtestname
        end
        if soundtestNUM == 49 then
            soundtestmusic = false
            soundtestname = 'warning1'
            soundfilename = soundtestname
        end
        if soundtestNUM == 50 then
            soundtestmusic = false
            soundtestname = 'warning2'
            soundfilename = soundtestname
        end
        if soundtestNUM == 51 then
            soundtestmusic = true
            soundtestname = 'Unwind\n(Pause Menu)'
            soundfilename = 'breakfast'
            bpm = 125
        end
        if soundtestNUM == 52 then
            soundtestmusic = true
            soundtestname = 'WORLD FAMOUS HEDGEHOG\n(Main Menu)'
            soundfilename = 'freakyMenu'
            bpm = 125
        end
        if soundtestNUM == 53 then
            soundtestmusic = true
            soundtestname = 'Not Enough Rings\n(Game Over)'
            soundfilename = 'gameOver'
            bpm = 87
        end
        if soundtestNUM == 54 then
            soundtestmusic = true
            soundtestname = 'Assembly\n(Options)'
            soundfilename = 'options'
            bpm = 121
        end
        if soundtestNUM == 55 then
            soundtestmusic = true
            soundtestname = 'Downwind\n- Results (Bad)'
            soundfilename = 'resultsBad'
            bpm = 97
        end
        if soundtestNUM == 56 then
            soundtestmusic = true
            soundtestname = 'Rewind\n- Results (Good)'
            soundfilename = 'resultsGood'
            bpm = 116
        end
        if soundtestNUM == 57 then
            soundtestmusic = true
            soundtestname = 'Blueprint (Instrumental)'
            soundfilename = '../songs/blueprint/Inst'
            bpm = 170
        end
        if soundtestNUM == 58 then
            soundtestmusic = true
            soundtestname = 'Break Down (Instrumental)'
            soundfilename = '../songs/break-down/Inst'
            bpm = 112
        end
        if soundtestNUM == 59 then
            soundtestmusic = true
            soundtestname = 'Rock Solid (Instrumental)'
            soundfilename = '../songs/rock-solid/Inst'
            bpm = 105
        end
        if soundtestNUM == 60 then
            soundtestmusic = true
            soundtestname = 'Ultimatum (Instrumental)'
            soundfilename = '../songs/ultimatum/Inst'
            bpm = 180
        end
        if soundtestNUM == 61 then
            soundtestmusic = true
            soundtestname = 'Unbound (Instrumental)'
            soundfilename = '../songs/unbound/Inst'
            bpm = 132
        end
        if soundtestNUM == 62 then
            soundtestmusic = true
            soundtestname = 'Smashprint'
            soundfilename = '../music/smashprint'
            bpm = 170
        end
        if soundtestNUM == 63 then
            soundtestmusic = false
            soundtestname = 'iMissYou.'
            soundfilename = 'iMissYou'
        end
        --
        
        if keyJustPressed('accept') then
            if soundtestpick ~= 'null' then
                if soundtestmusic == false then
                    playSound(soundfilename, 0.8)
                    if musicplayingsoundtest == true then
                        musicplaying = false
                        musicplayingsoundtest = false
                        soundFadeIn(breakfast, 0.5, 0.6, 0)
                        playAnim('sonicsoundtest', 'idle', true)
                    end
                elseif soundtestmusic == true then
                    songbpm = bpm
                    musicplaying = true
                    musicplayingsoundtest = true
                    playMusic(soundfilename, 0.9, true)
                    soundFadeIn(nil, 0.01, 0, 0.6)
                    songplaying = soundtestname
                    musicCredit()
                    setPropertyFromClass('backend.Conductor', 'bpm', bpm)
                    stopDancing = true
                    runTimer('stopdancing', 0.8)
                end
            end
        end
    end

    if gallery == true then

    for i = 1, lastimg do
        if getProperty('img'..i..'.x') == _G['img'..i..'X'] + imgdistance or getProperty('img'..i..'.x') == _G['img'..i..'X'] - imgdistance then
            setProperty('img'..i..'.visible', false)
        end
    end
        if getProperty('arrowLEFT.animation.curAnim.finished') and getProperty('arrowLEFT.animation.name') ~= 'idle' then
            playAnim('arrowLEFT', 'idle', false)
        end
    
        if getProperty('arrowRIGHT.animation.curAnim.finished') and getProperty('arrowRIGHT.animation.name') ~= 'idle' then
            playAnim('arrowRIGHT', 'idle', false)
        end
    
        setTextString('imgcounter', imageselected..' / '..lastimg)
        setTextString('imgdesc', imagedescription)
        setTextSize('imgdesc', imgdescsize)
    
        if keyJustPressed('right') then
            if imageselected < lastimg then
                imageselected = imageselected + 1
                playSound('scrollMenu', 0.8)
                runTimer('scrollTexty', 0.001)
            updateGallery()
                --nextImage()
                playAnim('arrowRIGHT', 'press', false)
            elseif  imageselected == lastimg then
                playSound('errorMenu', 0.8, false)
            end
        end
        if keyJustPressed('left') then
            if imageselected > firstimg then
                imageselected = imageselected - 1
                playSound('scrollMenu', 0.8)
                runTimer('scrollTexty', 0.001)
            updateGallery()
                --prevImage()
                playAnim('arrowLEFT', 'press', false)
            elseif  imageselected == firstimg then
                playSound('errorMenu', 0.8, false)
            end
        end
        if keyJustPressed('left') or keyJustPressed('right') then
        end
    
        -- IMAGE DESCRIPTIONS
        if imageselected == 1 then
            imagedescription = 'Arrow Skin Concepts'
            imgdescsize = 45
        end
        if imageselected == 2 then
            imagedescription = 'Shadow Sprite Concept'
            imgdescsize = 45
        end
        if imageselected == 3 then
            imagedescription = 'Sonic Scrapped Poses'
            imgdescsize = 45
        end
        if imageselected == 4 then
            imagedescription = 'Shadow Concepts'
            imgdescsize = 45
        end
        if imageselected == 5 then
            imagedescription = 'Knuckles Concepts'
            imgdescsize = 45
        end
        if imageselected == 6 then
            imagedescription = '"Rock Solid" Ending\nCutscene Concept Sketch'
            imgdescsize = 30
        end
        if imageselected == 7 then
            imagedescription = 'Sonic Background Sketch'
            imgdescsize = 45
        end
        if imageselected == 8 then
            imagedescription = 'Sonic Rail Grinding Section\nScrapped Concept'
            imgdescsize = 30
        end
        if imageselected == 9 then
            imagedescription = 'Results Screen\nEarly Concept'
            imgdescsize = 30
        end
        if imageselected == 10 then
            imagedescription = 'SONIC.EXE???\n(he will never be in the actual mod)'
            imgdescsize = 30
        end
        if imageselected == 11 then
            imagedescription = 'First Sonic vs Knuckles Sketch'
            imgdescsize = 45
        end
        if imageselected == 12 then
            imagedescription = 'Youtube Thumbnail Concept'
            imgdescsize = 45
        end
        if imageselected == 13 then
            imagedescription = 'Sound Test Sonic sketch\n(And a Shadow Variant)'
            imgdescsize = 30
        end
        if imageselected == 14 then
            imagedescription = 'Early Concept for "Breakdown"\nSketchHog Sprites'
            imgdescsize = 30
        end
        if imageselected == 15 then
            imagedescription = 'Hue hue hue'
            imgdescsize = 45
        end
        if imageselected == 16 then
            imagedescription = '"Adventure" Menu Concept'
            imgdescsize = 45
        end
        if imageselected == 17 then
            imagedescription = 'Pause Menu Concept'
            imgdescsize = 45
        end
        if imageselected == 18 then
            imagedescription = 'Scrapped Sonic and Shadow\nRenders'
            imgdescsize = 30
        end
        if imageselected == 19 then
            imagedescription = 'Scrapped Sonic Poses'
            imgdescsize = 45
        end
        if imageselected == 20 then
            imagedescription = "Knuckles' Background\n(Rough Sketch)"
            imgdescsize = 30
        end
        if imageselected == 21 then
            imagedescription = '"Sonic The Funk"\nLogo Concepts'
            imgdescsize = 30
        end
        if imageselected == 22 then
            imagedescription = 'Promo Concept Art'
            imgdescsize = 45
        end
        if imageselected == 23 then
            imagedescription = 'Game Over Concept Art'
            imgdescsize = 45
        end
        if imageselected == 24 then
            imagedescription = 'Metal Sonic Shooting Mechanic\nConcept by MegaBaz'
            imgdescsize = 30
        end
        if imageselected == 25 then
            imagedescription = 'Awesome doodle by fl0pd00dle'
            imgdescsize = 45
        end
    end
        -- Manejar clics del mouse
    if mouseClicked('left') and caninput then
        -- Botón BACK (ESC)
                -- Botón BACK (ESC)
        if getMouseX('other') > getProperty('backtxtt.x') and getMouseX('other') < getProperty('backtxtt.x') + getProperty('backtxtt.width') 
        and getMouseY('other') > getProperty('backtxtt.y') and getMouseY('other') < getProperty('backtxtt.y') + getProperty('backtxtt.height') then
            
            -- Misma lógica que la tecla BACK
            setProperty('back.scale.x', 0.8)
            setProperty('back.scale.y', 0.8)
            doTweenX('backscalex', 'back.scale', 1, 0.3, 'quadOut')
            doTweenY('backscaley', 'back.scale', 1, 0.3, 'quadOut')
            playSound('cancelMenu', 0.8)
            
            -- Si Special Thanks está activo, solo cerrarlo
            if specialthanks then
                specialthanks = false
                runTimer('resetspecial', 0.01)
                doTweenAlpha('overlayspecialalpha', 'overlayspecial', 0, 0.7)
                doTweenAlpha('specialthankstitlealpha', 'specialthankstitle', 0, 0.7)
                doTweenAlpha('specialthankscredits1alpha', 'specialthankscredits1', 0, 0.7)
                doTweenAlpha('specialthankscredits2alpha', 'specialthankscredits2', 0, 0.7)
                doTweenAlpha('specialthanks3alpha', 'specialthanks3', 0, 0.7)
                doTweenAlpha('specialthanks4alpha', 'specialthanks4', 0, 0.7)
                --unhide other stuff
                doTweenAlpha('creditsTXT2alpha', 'creditsTXT2', 1, 0.7)
                doTweenAlpha('actualcreditsalpha', 'actualcredits', 1, 0.7)
                doTweenAlpha('specialthanksindalpha', 'specialthanksind', 1, 0.7)
            
            -- Si no, comportamiento normal de BACK según el contexto
            elseif mainmenu == true then
                if prevsong == 'Menu' then
                    caninput = false
                    soundFadeOut(nil, 0.4, 0) 
                    setProperty('transInIndicator.x', 1)
                    runTimer('loadmenu', 0.8)
                else
                    confirmed = true
                    endSong()
                end
            else
                extrasMenu()
                if gallery == true then
                    gallselected = true
                    credselected = false
                    soundselected = false
                end
                if soundtest == true then
                    soundselected = true
                    credselected = false
                    gallselected = false
                end
                if credits == true then
                    credselected = true
                    soundselected = false
                    gallselected = false
                end
            end
        end
        
        -- Botón ACCEPT (BotonExtraMobile)
        if getMouseX('other') > getProperty('BotonExtraMobile.x') and getMouseX('other') < getProperty('BotonExtraMobile.x') + getProperty('BotonExtraMobile.width') 
        and getMouseY('other') > getProperty('BotonExtraMobile.y') and getMouseY('other') < getProperty('BotonExtraMobile.y') + getProperty('BotonExtraMobile.height') then
            
            -- Reproducir animación de presionado
            playAnim('BotonExtraMobile', 'pressed', true)
            runTimer('resetButtonExtraAnim', 0.1)
            
            -- Misma lógica que la tecla ACCEPT
            if mainmenu == true then
                if gallselected == true and gallery == false then
                    playSound('confirmMenu', 0.8)
                    extrasGallery()
                end
                if credselected == true and credits == false then
                    playSound('confirmMenu', 0.8)
                    extrasCredits()
                end
                if soundselected == true and soundtest == false then
                    playSound('confirmMenu', 0.8)
                    extrasSoundTest()
                end
            elseif soundtest == true then
                -- Reproducir sonido seleccionado en Sound Test
                if soundtestpick ~= 'null' then
                    if soundtestmusic == false then
                        playSound(soundfilename, 0.8)
                        if musicplayingsoundtest == true then
                            musicplaying = false
                            musicplayingsoundtest = false
                            soundFadeIn(breakfast, 0.5, 0.6, 0)
                            playAnim('sonicsoundtest', 'idle', true)
                        end
                    elseif soundtestmusic == true then
                        songbpm = bpm
                        musicplaying = true
                        musicplayingsoundtest = true
                        playMusic(soundfilename, 0.9, true)
                        soundFadeIn(nil, 0.01, 0, 0.6)
                        songplaying = soundtestname
                        musicCredit()
                        setPropertyFromClass('backend.Conductor', 'bpm', bpm)
                        stopDancing = true
                        runTimer('stopdancing', 0.8)
                    end
                end
            end
        end
        if credits and not specialthanks then
            if getMouseX('other') > getProperty('specialthanksind.x') and getMouseX('other') < getProperty('specialthanksind.x') + getProperty('specialthanksind.width') 
            and getMouseY('other') > getProperty('specialthanksind.y') and getMouseY('other') < getProperty('specialthanksind.y') + getProperty('specialthanksind.height') then
                
                -- Activar Special Thanks
                specialthanks = true
                runTimer('turnonspecial', 0.01)
                doTweenAlpha('overlayspecialalpha', 'overlayspecial', 1, 0.7)
                doTweenAlpha('specialthankstitlealpha', 'specialthankstitle', 1, 0.7)
                doTweenAlpha('specialthankscredits1alpha', 'specialthankscredits1', 1, 0.7)
                doTweenAlpha('specialthankscredits2alpha', 'specialthankscredits2', 1, 0.7)
                doTweenAlpha('specialthanks3alpha', 'specialthanks3', 1, 0.7)
                doTweenAlpha('specialthanks4alpha', 'specialthanks4', 1, 0.7)
                --hide other stuff
                doTweenAlpha('creditsTXT2alpha', 'creditsTXT2', 0, 0.7)
                doTweenAlpha('actualcreditsalpha', 'actualcredits', 0, 0.7)
                doTweenAlpha('specialthanksindalpha', 'specialthanksind', 0, 0.7)
                
                -- Salir para evitar que el mismo clic también ejecute el cierre
                return
            end
        end
    end
end


