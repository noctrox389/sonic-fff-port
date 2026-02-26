spotlightspeed = 2
spotlightspeedvariable = 1.1
bgscrolling = false
timetravelscrollspeed = 1

sparkleIndex = 0
sonicsparkling = false
sparkleTimer = 0

local fireflyIndex = 0
local fireflySpawnX = 1700
local fireflyDespawnX = -900
local fireflyMinY = -120
local fireflyMaxY = 800
local fireflyMinScale = 1.3
local fireflyMaxScale = 1.7
local fireflySpawnCooldown = 0.1
local fireflySpeeds = {}
local fireflySpawnTimer = 0

stopscrolling = false
local badendingoffset = 0

function onCreate()
    makeLuaSprite('scrollingspeedway') --
    makeGraphic('scrollingspeedway', 1, 1, 'ffffff') --0000ff
    setProperty('scrollingspeedway.alpha', 0)
    addLuaSprite('scrollingspeedway', false)
    setObjectCamera('scrollingspeedway', 'hud') 
    setProperty('scrollingspeedway.x', 0) --0=not scrolling 1=scrolling

    makeLuaSprite('bgscene') --
    makeGraphic('bgscene', 1, 1, 'ffffff') --0000ff
    setProperty('bgscene.alpha', 0)
    addLuaSprite('bgscene', false)
    setObjectCamera('bgscene', 'hud') 
    setProperty('bgscene.x', 0) --0=present 1=time traveling 2=past 3=good future 4= bad future

    setProperty('gf.visible', false)
    
    --present
    makeLuaSprite('PRESENTbg5', 'bgs/stardust speedway/assets/presentbglayer5', -600, -510)
    setScrollFactor('PRESENTbg5', 0.1, 0.2)
    addLuaSprite('PRESENTbg5', false)
    setProperty('PRESENTbg5.visible', false)

    makeLuaSprite('PRESENTbg4', 'bgs/stardust speedway/assets/presentbglayer4', -800, 230)
    setScrollFactor('PRESENTbg4', 0.25, 0.5)
    addLuaSprite('PRESENTbg4', false)
    setProperty('PRESENTbg4.visible', false)

    makeLuaSprite('PRESENTbg3', 'bgs/stardust speedway/assets/presentbglayer3', -800, 80)
    setScrollFactor('PRESENTbg3', 0.4, 0.7)
    addLuaSprite('PRESENTbg3', false)
    setProperty('PRESENTbg3.visible', false)

    -- Elementos que antes dependían de lowQuality ahora se incluyen siempre
    makeLuaSprite('PRESENTbg2', 'bgs/stardust speedway/assets/presentbglayer2', -1200, 430)
    setScrollFactor('PRESENTbg2', 0.7, 0.8)
    addLuaSprite('PRESENTbg2', false)
    setProperty('PRESENTbg2.visible', false)

    makeLuaSprite('PRESENTbg1', 'bgs/stardust speedway/assets/presentbglayer1', -1200, 646)
    setScrollFactor('PRESENTbg1', 0.7, 0.8)
    addLuaSprite('PRESENTbg1', false)
    setProperty('PRESENTbg1.visible', false)

    PRESENTspotlight4X = 0
    makeLuaSprite('PRESENTspotlight4', 'bgs/stardust speedway/assets/presentspotlight2', PRESENTspotlight4X, 500)
    setScrollFactor('PRESENTspotlight4', 1, 1)
    addLuaSprite('PRESENTspotlight4', false)
    setProperty('PRESENTspotlight4.visible', false)
    setProperty('PRESENTspotlight4.scale.x', 1.6)
    setProperty('PRESENTspotlight4.scale.y', 1.6)
    setBlendMode('PRESENTspotlight4', 'add')
    setProperty('PRESENTspotlight4.origin.y', 1700)
    doTweenAngle('PRESENTspotlight4move2', 'PRESENTspotlight4', -60, spotlightspeed/spotlightspeedvariable, 'sineInOut')

    PRESENTspotlight3X = 800
    makeLuaSprite('PRESENTspotlight3', 'bgs/stardust speedway/assets/presentspotlight1', PRESENTspotlight3X, 500)
    setScrollFactor('PRESENTspotlight3', 1, 1)
    addLuaSprite('PRESENTspotlight3', false)
    setProperty('PRESENTspotlight3.visible', false)
    setProperty('PRESENTspotlight3.scale.x', 1.6)
    setProperty('PRESENTspotlight3.scale.y', 1.6)
    setBlendMode('PRESENTspotlight3', 'add')
    setProperty('PRESENTspotlight3.origin.y', 1700)
    doTweenAngle('PRESENTspotlight3move1', 'PRESENTspotlight3', 70, spotlightspeed, 'sineInOut')

    makeLuaSprite('PRESENTfloorback', 'bgs/stardust speedway/assets/presentfloorback', -1200, 450)
    setScrollFactor('PRESENTfloorback', 1, 1)
    addLuaSprite('PRESENTfloorback', false)
    setProperty('PRESENTfloorback.visible', false)

    makeLuaSprite('PRESENTfloorfront', 'bgs/stardust speedway/assets/presentfloorfront', -1600, 670)
    setScrollFactor('PRESENTfloorfront', 1, 1)
    addLuaSprite('PRESENTfloorfront', true)
    setProperty('PRESENTfloorfront.visible', false)

    PRESENTspotlight1X = -700
    makeLuaSprite('PRESENTspotlight1', 'bgs/stardust speedway/assets/presentspotlight1', -700, 1400)
    setScrollFactor('PRESENTspotlight1', 1, 1)
    addLuaSprite('PRESENTspotlight1', true)
    setProperty('PRESENTspotlight1.visible', false)
    setBlendMode('PRESENTspotlight1', 'add')
	scaleObject('PRESENTspotlight1', 2.3,2.3)
    setProperty('PRESENTspotlight1.origin.y', 1900)
    doTweenAngle('PRESENTspotlight1move1', 'PRESENTspotlight1', 70, spotlightspeed, 'sineInOut')

    PRESENTspotlight2X = 1100
    makeLuaSprite('PRESENTspotlight2', 'bgs/stardust speedway/assets/presentspotlight2', 1100, 1400)
    setScrollFactor('PRESENTspotlight2', 1, 1)
    addLuaSprite('PRESENTspotlight2', true)
    setProperty('PRESENTspotlight2.visible', false)
    setBlendMode('PRESENTspotlight2', 'add')
	scaleObject('PRESENTspotlight2', 2.3,2.3)
    setProperty('PRESENTspotlight2.origin.y', 1900)
    doTweenAngle('PRESENTspotlight2move2', 'PRESENTspotlight2', -60, spotlightspeed * spotlightspeedvariable, 'sineInOut')
    
    if lowQuality then
        setProperty('PRESENTspotlight1.alpha', 0)
        setProperty('PRESENTspotlight2.alpha', 0)
        setProperty('PRESENTspotlight3.alpha', 0)
        setProperty('PRESENTspotlight4.alpha', 0)
    end
    -- time travel graphics
    makeLuaSprite('timetravelbg', 'bgs/stardust speedway/timetravelbg', -750, -340)
    setProperty('timetravelbg.scale.x', 2.6)
    setProperty('timetravelbg.scale.y', 2.6)
    setObjectCamera('timetravelbg', 'camGame')
    addLuaSprite('timetravelbg', false)
    setProperty('timetravelbg.visible', false)

    makeLuaSprite('timetravelray1', 'bgs/stardust speedway/timetravelray', 1900, -140)
    setObjectCamera('timetravelray1', 'camGame')
    addLuaSprite('timetravelray1', false)
	scaleObject('timetravelray1', 2,2)
    setProperty('timetravelray1.visible', false)
    doTweenX('timetravelray1scroll', 'timetravelray1', -1900, timetravelscrollspeed / 0.5)

    makeLuaSprite('timetravelray2', 'bgs/stardust speedway/timetravelray', 1900, 140)
    setObjectCamera('timetravelray2', 'camGame')
    addLuaSprite('timetravelray2', false)
	scaleObject('timetravelray2', 2,2)
    setProperty('timetravelray2.visible', false)
    doTweenX('timetravelray2scroll', 'timetravelray2', -1900, timetravelscrollspeed / 0.4)

    makeLuaSprite('timetravelray3', 'bgs/stardust speedway/timetravelray', 1900, 380)
    setObjectCamera('timetravelray3', 'camGame')
    addLuaSprite('timetravelray3', true)
	scaleObject('timetravelray3', 2,2)
    setProperty('timetravelray3.visible', false)
    doTweenX('timetravelray3scroll', 'timetravelray3', -1900, timetravelscrollspeed / 0.6)

    makeLuaSprite('timetravelray4', 'bgs/stardust speedway/timetravelray', 1900, 590)
    setObjectCamera('timetravelray4', 'camGame')
    addLuaSprite('timetravelray4', true)
	scaleObject('timetravelray4', 2,2)
    setProperty('timetravelray4.visible', false)
    doTweenX('timetravelray4scroll', 'timetravelray4', -1900, timetravelscrollspeed / 0.3)
    
    --past
    makeLuaSprite('PASTbg4', 'bgs/stardust speedway/assets/pastbglayer4', -600, -660)
    setScrollFactor('PASTbg4', 0.1, 0.2)
    addLuaSprite('PASTbg4', false)
    setProperty('PASTbg4.visible', false)

    runTimer('createpast2', 0.2)

    makeLuaSprite('PASTbg3', 'bgs/stardust speedway/assets/pastbglayer3', -800, 70)
    setScrollFactor('PASTbg3', 0.25, 0.5)
    addLuaSprite('PASTbg3', false)
    setProperty('PASTbg3.visible', false)

    pastbg1spacing = 2267
    makeLuaSprite('PASTbg11', 'bgs/stardust speedway/pastbglayer1', -800, 400)
    setScrollFactor('PASTbg11', 0.4, 0.7)
    addLuaSprite('PASTbg11', false)
    setProperty('PASTbg11.visible', false)

    makeLuaSprite('PASTbg12', 'bgs/stardust speedway/pastbglayer1', -800 + pastbg1spacing, 400)
    setScrollFactor('PASTbg12', 0.4, 0.7)
    addLuaSprite('PASTbg12', false)
    setProperty('PASTbg12.visible', false)

    makeLuaSprite('PASTbg13', 'bgs/stardust speedway/pastbglayer1', -800 + pastbg1spacing *2, 400)
    setScrollFactor('PASTbg13', 0.4, 0.7)
    addLuaSprite('PASTbg13', false)
    setProperty('PASTbg13.visible', false)

    makeLuaSprite('PASTbg21', 'bgs/stardust speedway/assets/pastbglayer2', -800, -150)
    setScrollFactor('PASTbg21', 0.4, 0.7)
    addLuaSprite('PASTbg21', false)
    setProperty('PASTbg21.visible', false)

    makeLuaSprite('PASTbg22', 'bgs/stardust speedway/assets/pastbglayer2', -800 + pastbg1spacing, -150)
    setScrollFactor('PASTbg22', 0.4, 0.7)
    addLuaSprite('PASTbg22', false)
    setProperty('PASTbg22.visible', false)

    makeLuaSprite('PASTbg23', 'bgs/stardust speedway/assets/pastbglayer2', -800 + pastbg1spacing *2, -150)
    setScrollFactor('PASTbg23', 0.4, 0.7)
    addLuaSprite('PASTbg23', false)
    setProperty('PASTbg23.visible', false)
    
    makeLuaSprite('PASTfloorback', 'bgs/stardust speedway/assets/pastfloorback', -1200, 485)
    setScrollFactor('PASTfloorback', 1, 1)
    addLuaSprite('PASTfloorback', false)
    setProperty('PASTfloorback.visible', false)

    makeAnimatedLuaSprite('PASTbgelements', 'bgs/stardust speedway/assets/pastbgelements', 200, 455)
    addAnimationByPrefix('PASTbgelements', '1', 'PASTBGELEMENTjar', 24, false)
    addOffset('PASTbgelements', '1', 0, 0)
    addAnimationByPrefix('PASTbgelements', '2', 'PASTBGELEMENTjaRplant', 24, false)
    addOffset('PASTbgelements', '2', 0, 30)
    addAnimationByPrefix('PASTbgelements', '3', 'PASTBGELEMENTpillar', 24, false)
    addOffset('PASTbgelements', '3', 0, 470)
    addAnimationByPrefix('PASTbgelements', '4', 'PASTBGELEMENTstatue', 24, false)
    addOffset('PASTbgelements', '4', 0, 310)
    setScrollFactor('PASTbgelements', 1, 1)
    addLuaSprite('PASTbgelements', false)
    setProperty('PASTbgelements.visible', false)
    playAnim('PASTbgelements', '2', false)

    makeLuaSprite('PASTfloorfront', 'bgs/stardust speedway/assets/pastfloorfront', -1600, 740)
    setScrollFactor('PASTfloorfront', 1, 1)
    addLuaSprite('PASTfloorfront', true)
    setProperty('PASTfloorfront.visible', false)
    
    --bad future
    makeLuaSprite('BADbg5', 'bgs/stardust speedway/assets/badfuturebglayer5', -600, -480)
    setScrollFactor('BADbg5', 0.1, 0.2)
    addLuaSprite('BADbg5', false)
    setProperty('BADbg5.visible', false)

    makeLuaSprite('BADbg4', 'bgs/stardust speedway/assets/badfuturebglayer4', -600, -480)
    setScrollFactor('BADbg4', 0.1, 0.2)
    addLuaSprite('BADbg4', false)
    setProperty('BADbg4.visible', false)

    makeLuaSprite('BADbg3', 'bgs/stardust speedway/assets/badfuturebglayer3', -800, 140)
    setScrollFactor('BADbg3', 0.25, 0.5)
    addLuaSprite('BADbg3', false)
    setProperty('BADbg3.visible', false)

    signpostX = 2000
    signpostY = 370
    makeAnimatedLuaSprite('signpost', 'bgs/stardust speedway/signpost', signpostX, signpostY)
    addAnimationByPrefix('signpost', 'future', 'signpost future', 24, false)
    addOffset('signpost', 'future', 0, 0)
    addAnimationByPrefix('signpost', 'past', 'signpost past', 24, false)
    addOffset('signpost', 'past', 0, 0)
    addAnimationByPrefix('signpost', 'spinning', 'signpost spinning', 24, true)
    setScrollFactor('signpost', 1, 1)
    addLuaSprite('signpost', false)
    setProperty('signpost.visible', false)
    
    makeLuaSprite('BADbg2', 'bgs/stardust speedway/assets/badfuturebglayer2', -800, 110)
    setScrollFactor('BADbg2', 0.4, 0.7)
    addLuaSprite('BADbg2', false)
    setProperty('BADbg2.visible', false)

    makeLuaSprite('BADbg1', 'bgs/stardust speedway/assets/badfuturebglayer1', -1200, 390)
    setScrollFactor('BADbg1', 0.7, 0.8)
    addLuaSprite('BADbg1', false)
    setProperty('BADbg1.visible', false)

    BADspotlight4X = 0
    makeLuaSprite('BADspotlight4', 'badfuturespotlight1', BADspotlight4X, 1500)
    setScrollFactor('BADspotlight4', 1, 1)
    addLuaSprite('BADspotlight4', false)
    setProperty('BADspotlight4.visible', false)
    setProperty('BADspotlight4.scale.x', 2.3)
    setProperty('BADspotlight4.scale.y', 2.3)
    setBlendMode('BADspotlight4', 'add')
    setProperty('BADspotlight4.origin.y', 1700)
    doTweenAngle('BADspotlight4move2', 'BADspotlight4', -60, spotlightspeed/spotlightspeedvariable, 'sineInOut')

    BADspotlight3X = 800
    makeLuaSprite('BADspotlight3', 'bgs/stardust speedway/assets/badfuturespotlight1', BADspotlight3X, 1500)
    setScrollFactor('BADspotlight3', 1, 1)
    addLuaSprite('BADspotlight3', false)
    setProperty('BADspotlight3.visible', false)
    setProperty('BADspotlight3.scale.x', 2.3)
    setProperty('BADspotlight3.scale.y', 2.3)
    setBlendMode('BADspotlight3', 'add')
    setProperty('BADspotlight3.origin.y', 1700)
    doTweenAngle('BADspotlight3move1', 'BADspotlight3', 70, spotlightspeed, 'sineInOut')

    makeLuaSprite('BADfloorback', 'bgs/stardust speedway/assets/badfuturefloorback', -1200, 450)
    setScrollFactor('BADfloorback', 1, 1)
    addLuaSprite('BADfloorback', false)
    setProperty('BADfloorback.visible', false)

    makeLuaSprite('BADfloorfront', 'bgs/stardust speedway/assets/badfuturefloorfront', -1600, 800)
    setScrollFactor('BADfloorfront', 1, 1)
    addLuaSprite('BADfloorfront', true)
    setProperty('BADfloorfront.visible', false)
    setProperty('BADfloorfront.scale.x', 2.7)
    setProperty('BADfloorfront.scale.y', 2.7)

    BADbarseparation = 2032
    makeAnimatedLuaSprite('BADbar1', 'bgs/stardust speedway/assets/badfutureBARanimated', getProperty('BADfloorfront.x') + 1499, getProperty('BADfloorfront.y'))
    addAnimationByPrefix('BADbar1', 'anim', 'speed thing bad', 24, true)
    playAnim('BADbar1', 'anim', true)
    addLuaSprite('BADbar1', true)
    setProperty('BADbar1.visible', false)

    makeAnimatedLuaSprite('BADbar2', 'bgs/stardust speedway/assets/badfutureBARanimated', getProperty('BADbar1.x') + BADbarseparation, getProperty('BADfloorfront.y'))
    addAnimationByPrefix('BADbar2', 'anim', 'speed thing bad', 24, true)
    playAnim('BADbar2', 'anim', true)
    addLuaSprite('BADbar2', true)
    setProperty('BADbar2.visible', false)

    makeAnimatedLuaSprite('BADbar3', 'bgs/stardust speedway/assets/badfutureBARanimated', getProperty('BADbar1.x') + BADbarseparation * 2, getProperty('BADfloorfront.y'))
    addAnimationByPrefix('BADbar3', 'anim', 'speed thing bad', 24, true)
    playAnim('BADbar3', 'anim', true)
    addLuaSprite('BADbar3', true)
    setProperty('BADbar3.visible', false)

    BADbarseparation = 2032
    makeAnimatedLuaSprite('BADbar1', 'bgs/stardust speedway/badfutureBARanimated', getProperty('BADfloorfront.x') + 1499, getProperty('BADfloorfront.y'))
    addAnimationByPrefix('BADbar1', 'anim', 'speed thing bad', 24, true)
    playAnim('BADbar1', 'anim', true)
    setScrollFactor('BADbar1', 1, 1)
    setObjectCamera('BADbar1', 'camGame')
    addLuaSprite('BADbar1', true)
    setProperty('BADbar1.visible', false)

    makeAnimatedLuaSprite('BADbar2', 'bgs/stardust speedway/badfutureBARanimated', getProperty('BADbar1.x') + BADbarseparation, getProperty('BADfloorfront.y'))
    addAnimationByPrefix('BADbar2', 'anim', 'speed thing bad', 24, true)
    playAnim('BADbar2', 'anim', true)
    setScrollFactor('BADbar2', 1, 1)
    setObjectCamera('BADbar2', 'camGame')
    addLuaSprite('BADbar2', true)
    setProperty('BADbar2.visible', false)

    makeAnimatedLuaSprite('BADbar3', 'bgs/stardust speedway/badfutureBARanimated', getProperty('BADbar1.x') + BADbarseparation * 2, getProperty('BADfloorfront.y'))
    addAnimationByPrefix('BADbar3', 'anim', 'speed thing bad', 24, true)
    playAnim('BADbar3', 'anim', true)
    setScrollFactor('BADbar3', 1, 1)
    setObjectCamera('BADbar3', 'camGame')
    addLuaSprite('BADbar3', true)
    setProperty('BADbar3.visible', false)

    -- BAD LEDS (también animados)
    BADledseparation = 2032
    makeAnimatedLuaSprite('BADleds1', 'bgs/stardust speedway/badfutureLEDSanimated', getProperty('BADfloorfront.x') + 2065, getProperty('BADfloorfront.y') + 270)
    addAnimationByPrefix('BADleds1', 'anim', 'leds bad', 24, true)
    playAnim('BADleds1', 'anim', true)
    setScrollFactor('BADleds1', 1, 1)
    setObjectCamera('BADleds1', 'camGame')
    addLuaSprite('BADleds1', true)
    setProperty('BADleds1.visible', false)

    makeAnimatedLuaSprite('BADleds2', 'bgs/stardust speedway/badfutureLEDSanimated', getProperty('BADleds1.x') + BADledseparation, getProperty('BADleds1.y'))
    addAnimationByPrefix('BADleds2', 'anim', 'leds bad', 24, true)
    playAnim('BADleds2', 'anim', true)
    setScrollFactor('BADleds2', 1, 1)
    setObjectCamera('BADleds2', 'camGame')
    addLuaSprite('BADleds2', true)
    setProperty('BADleds2.visible', false)

    makeAnimatedLuaSprite('BADleds3', 'bgs/stardust speedway/badfutureLEDSanimated', getProperty('BADleds1.x') + BADledseparation * 2, getProperty('BADleds1.y'))
    addAnimationByPrefix('BADleds3', 'anim', 'leds bad', 24, true)
    playAnim('BADleds3', 'anim', true)
    setScrollFactor('BADleds3', 1, 1)
    setObjectCamera('BADleds3', 'camGame')
    addLuaSprite('BADleds3', true)
    setProperty('BADleds3.visible', false)

    BADspotlight1X = -700
    makeLuaSprite('BADspotlight1', 'bgs/stardust speedway/assets/badfuturespotlight1', -700, 2500)
    setScrollFactor('BADspotlight1', 1, 1)
    addLuaSprite('BADspotlight1', true)
    setProperty('BADspotlight1.visible', false)
    setBlendMode('BADspotlight1', 'add')
    setProperty('BADspotlight1.origin.y', 1900)
    doTweenAngle('BADspotlight1move1', 'BADspotlight1', 70, spotlightspeed, 'sineInOut')

    BADspotlight2X = 1100
    makeLuaSprite('BADspotlight2', 'bgs/stardust speedway/assets/badfuturespotlight1', 1100, 2500)
    setScrollFactor('BADspotlight2', 1, 1)
    addLuaSprite('BADspotlight2', true)
    setProperty('BADspotlight2.visible', false)
    setBlendMode('BADspotlight2', 'add')
    setProperty('BADspotlight2.origin.y', 1900)
    doTweenAngle('BADspotlight2move2', 'BADspotlight2', -60, spotlightspeed * spotlightspeedvariable, 'sineInOut')

    makeLuaSprite('BADoverlay', 'bgs/stardust speedway/assets/badfutureoverlay', -600, -300)
    setScrollFactor('BADoverlay', 0, 1)
    addLuaSprite('BADoverlay', true)
    setProperty('BADoverlay.visible', false)
    setBlendMode('BADoverlay', 'multiply')

    makeAnimatedLuaSprite('metalending', 'bgs/stardust speedway/assets/metal', getProperty('dad.x') - 200, getProperty('dad.y'))
    addAnimationByPrefix('metalending', 'land', 'metal finger wag', 24, false)
    addAnimationByIndices('metalending', 'wag', 'metal finger wag', '11,12,13,14,15,16,17,18,19,20,21,22', 24, true)
    setScrollFactor('metalending', 1, 1)
    setObjectCamera('metalending', 'camGame')
    scaleObject('metalending', 2.7,2.7)
    addLuaSprite('metalending', false)
    setProperty('metalending.visible', false)

    makeAnimatedLuaSprite('sonicbadending', 'results/sonic/L animation', getProperty('boyfriend.x'), getProperty('boyfriend.y'))
    addAnimationByIndices('sonicbadending', 'fall', 'sonic L animation', '14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,32.7,2.74,35,36,37,38,39,40,41', 24, false)
    addAnimationByIndices('sonicbadending', 'loop', 'sonic L animation', '20,21,22,23,24,25,26,27,28,29,30,31,32,32.7,2.74,35,36,37,38,39,40,41', 24, true)
    addLuaSprite('sonicbadending', false)
    setProperty('sonicbadending.visible', false)
    local sonicbadendingscale = 1.8
    setProperty('sonicbadending.scale.x', sonicbadendingscale)
    setProperty('sonicbadending.scale.y', sonicbadendingscale)

    makeLuaSprite('wall1', 'bgs/stardust speedway/assets/badfuturewall1', 2350 + badendingoffset, -370)
    addLuaSprite('wall1', false)
    setProperty('wall1.visible', true)
    setObjectOrder('wall1', getObjectOrder('boyfriendGroup') + 1)

    wallclosed = getProperty('wall1.y') + 390
    makeLuaSprite('wall2', 'bgs/stardust speedway/assets/badfuturewall2', getProperty('wall1.x') + 8, wallclosed - 600)
    addLuaSprite('wall2', false)
    setProperty('wall2.visible', true)
    setObjectOrder('wall2', getObjectOrder('wall1') - 1)

    setProperty('wall1.visible', false)
    setProperty('wall2.visible', false)

    --good future
    makeLuaSprite('GOODbg6', 'bgs/stardust speedway/assets/goodfuturebglayer6', -600, -420)
    setScrollFactor('GOODbg6', 0.1, 0.1)
    addLuaSprite('GOODbg6', false)
    setProperty('GOODbg6.visible', false)

    makeLuaSprite('GOODbg5', 'bgs/stardust speedway/assets/goodfuturebglayer5', -400, getProperty('GOODbg6.y')+ 668)
    setScrollFactor('GOODbg5', 0.2, 0.1)
    addLuaSprite('GOODbg5', false)
    setProperty('GOODbg5.visible', false)

    makeLuaSprite('GOODbg4', 'bgs/stardust speedway/assets/goodfuturebglayer4', -200, getProperty('GOODbg6.y')+ 790)
    setScrollFactor('GOODbg4', 0.25, 0.23)
    addLuaSprite('GOODbg4', false)
    setProperty('GOODbg4.visible', false)

    makeLuaSprite('GOODbg3', 'bgs/stardust speedway/assets/goodfuturebglayer3', -800, 160)
    setScrollFactor('GOODbg3', 0.3, 0.5)
    addLuaSprite('GOODbg3', false)
    setProperty('GOODbg3.visible', false)

    GOODfireworksstartingY = 400
    GOODfireworksfinalY = 0
    makeAnimatedLuaSprite('GOODfireworks1', 'bgs/stardust speedway/fireworks', 200, GOODfireworksfinalY)
    addAnimationByPrefix('GOODfireworks1', 'particle', 'firework particle', 24, false)
    addOffset('GOODfireworks1', 'particle', 0, 0)
    addAnimationByPrefix('GOODfireworks1', '1', 'firework sonic', 24, false)
    addOffset('GOODfireworks1', '1', 200, 150)
    addAnimationByPrefix('GOODfireworks1', '2', 'firework soniC2', 24, false)
    addOffset('GOODfireworks1', '2', 200, 150)
    addAnimationByPrefix('GOODfireworks1', '3', 'firework amy', 24, false)
    addOffset('GOODfireworks1', '3', 230, 150)
    addAnimationByPrefix('GOODfireworks1', '4', 'firework amY2', 24, false)
    addOffset('GOODfireworks1', '4', 200, 150)
	scaleObject('GOODfireworks1', 2,2)
    setProperty('GOODfireworks1.alpha', 0)
    setScrollFactor('GOODfireworks1', 0.3, 0.5)
    addLuaSprite('GOODfireworks1', false)
    setProperty('GOODfireworks1.visible', false)
    setBlendMode('GOODfireworks1', 'screen')
    
    makeAnimatedLuaSprite('GOODfireworks2', 'bgs/stardust speedway/fireworks', 1000, GOODfireworksfinalY)
    addAnimationByPrefix('GOODfireworks2', 'particle', 'firework particle', 24, false)
    addOffset('GOODfireworks2', 'particle', 0, 0)
    addAnimationByPrefix('GOODfireworks2', '1', 'firework sonic', 24, false)
    addOffset('GOODfireworks2', '1', 200, 150)
    addAnimationByPrefix('GOODfireworks2', '2', 'firework soniC2', 24, false)
    addOffset('GOODfireworks2', '2', 200, 150)
    addAnimationByPrefix('GOODfireworks2', '3', 'firework amy', 24, false)
    addOffset('GOODfireworks2', '3', 230, 150)
    addAnimationByPrefix('GOODfireworks2', '4', 'firework amY2', 24, false)
    addOffset('GOODfireworks2', '4', 200, 150)
	scaleObject('GOODfireworks2', 2.7,2.7)
    setProperty('GOODfireworks2.alpha', 0)
    setScrollFactor('GOODfireworks2', 0.3, 0.5)
    addLuaSprite('GOODfireworks2', false)
    setProperty('GOODfireworks2.visible', false)
    setBlendMode('GOODfireworks2', 'screen')

    makeLuaSprite('GOODbg2', 'bgs/stardust speedway/assets/goodfuturebglayer2', -800, 250)
    setScrollFactor('GOODbg2', 0.4, 0.7)
    addLuaSprite('GOODbg2', false)
    setProperty('GOODbg2.visible', false)

    makeLuaSprite('GOODbg1', 'bgs/stardust speedway/assets/goodfuturebglayer1', -1200, 170)
    setScrollFactor('GOODbg1', 0.7, 0.8)
    addLuaSprite('GOODbg1', false)
    setProperty('GOODbg1.visible', false)
    
    GOODspotlight4X = 0
    makeLuaSprite('GOODspotlight4', 'bgs/stardust speedway/assets/goodfuturespotlight1', BADspotlight4X, 1500)
    setScrollFactor('GOODspotlight4', 1, 1)
    addLuaSprite('GOODspotlight4', false)
    setProperty('GOODspotlight4.visible', false)
    setProperty('GOODspotlight4.scale.x', 2.3)
    setProperty('GOODspotlight4.scale.y', 2.3)
    setBlendMode('GOODspotlight4', 'add')
    setProperty('GOODspotlight4.origin.y', 1700)
    doTweenAngle('GOODspotlight4move2', 'GOODspotlight4', -60, spotlightspeed/spotlightspeedvariable, 'sineInOut')

    GOODspotlight3X = 800
    makeLuaSprite('GOODspotlight3', 'bgs/stardust speedway/assets/goodfuturespotlight1', BADspotlight3X, 1500)
    setScrollFactor('GOODspotlight3', 1, 1)
    addLuaSprite('GOODspotlight3', false)
    setProperty('GOODspotlight3.visible', false)
    setProperty('GOODspotlight3.scale.x', 2.3)
    setProperty('GOODspotlight3.scale.y', 2.3)
    setBlendMode('GOODspotlight3', 'add')
    setProperty('GOODspotlight3.origin.y', 1700)
    doTweenAngle('GOODspotlight3move1', 'GOODspotlight3', 70, spotlightspeed, 'sineInOut')

    makeLuaSprite('GOODfloorback', 'bgs/stardust speedway/assets/goodfuturefloorback', -1200, 450)
    setScrollFactor('GOODfloorback', 1, 1)
    addLuaSprite('GOODfloorback', false)
    setProperty('GOODfloorback.visible', false)

    goodspotlight1X = -700
    makeLuaSprite('GOODspotlight1', 'bgs/stardust speedway/assets/goodfuturespotlight1', -700, 2400)
    setScrollFactor('GOODspotlight1', 1, 1)
    addLuaSprite('GOODspotlight1', true)
    setProperty('GOODspotlight1.visible', false)
    setBlendMode('GOODspotlight1', 'add')
    scaleObject('GOODspotlight1', 2.3)
    setProperty('GOODspotlight1.origin.y', 1900)
    doTweenAngle('GOODspotlight1move1', 'GOODspotlight1', 70, spotlightspeed, 'sineInOut')

    GOODspotlight2X = 1100
    makeLuaSprite('GOODspotlight2', 'bgs/stardust speedway/assets/goodfuturespotlight1', 1100, 2400)
    setScrollFactor('GOODspotlight2', 1, 1)
    addLuaSprite('GOODspotlight2', true)
    setProperty('GOODspotlight2.visible', false)
    setBlendMode('GOODspotlight2', 'add')
    scaleObject('GOODspotlight2', 2.3)
    setProperty('GOODspotlight2.origin.y', 1900)
    doTweenAngle('GOODspotlight2move2', 'GOODspotlight2', -60, spotlightspeed * spotlightspeedvariable, 'sineInOut')
    fireworksactive = false

    -- PRESENTE
scaleObject('PRESENTbg5', 2.7,2.7)
scaleObject('PRESENTbg4', 2.7,2.7)
scaleObject('PRESENTbg3', 2.7,2.7)
scaleObject('PRESENTbg2', 2.7,2.7)
scaleObject('PRESENTbg1', 2.7,2.7)
scaleObject('PRESENTspotlight4', 1.6, 1.6)  -- Ya tiene scale 1.6, mantener
scaleObject('PRESENTspotlight3', 1.6, 1.6)  -- Ya tiene scale 1.6, mantener
scaleObject('PRESENTfloorback', 2.7, 2.7)   -- Ya tiene scale 2.6, mantener
scaleObject('PRESENTfloorfront', 2.7,2.7)  -- Agregar scale 2.6
scaleObject('PRESENTspotlight1', 2.7,2.7)  -- Ya tiene scale 2.3 con scaleObject
scaleObject('PRESENTspotlight2', 2.7,2.7)  -- Ya tiene scale 2.3 con scaleObject

-- TIME TRAVEL
scaleObject('timetravelbg', 2.7, 2.7)       -- Ya tiene scale 2.6
scaleObject('timetravelray1', 2, 2)         -- Ya tiene scale 2
scaleObject('timetravelray2', 2, 2)         -- Ya tiene scale 2
scaleObject('timetravelray3', 2, 2)         -- Ya tiene scale 2
scaleObject('timetravelray4', 2, 2)         -- Ya tiene scale 2

-- PASADO
scaleObject('PASTbg4', 2.7,2.7)
scaleObject('PASTbg3', 2.7,2.7)
scaleObject('PASTbg11', 2.7,2.7)
scaleObject('PASTbg12', 2.7,2.7)
scaleObject('PASTbg13', 2.7,2.7)
scaleObject('PASTbg21', 2.7,2.7)
scaleObject('PASTbg22', 2.7,2.7)
scaleObject('PASTbg23', 2.7,2.7)
scaleObject('PASTfloorback', 2.7, 2.7)
scaleObject('PASTbgelements', 2.7,2.7)
scaleObject('PASTfloorfront', 2.7, 2.7)

-- FUTURO MALO
scaleObject('BADbg5', 2.7,2.7)
scaleObject('BADbg4', 2.7,2.7)
scaleObject('BADbg3', 2.7,2.7)
scaleObject('signpost', 2,2)
scaleObject('BADbg2', 2.7,2.7)
scaleObject('BADbg1', 2.7,2.7)
scaleObject('BADspotlight4', 2.7,2.7)      -- Ya tiene scale 2.3
scaleObject('BADspotlight3', 2.7,2.7)      -- Ya tiene scale 2.3
scaleObject('BADfloorback', 2.7, 2.7)
scaleObject('BADfloorfront', 2.7,2.7)          -- Ya tiene scale 1
scaleObject('BADoverlay', 2.7,2.7)
scaleObject('wall1', 2.7,2.7)
scaleObject('wall2', 2.7,2.7)
scaleObject('BADspotlight1', 2.7,2.7)      -- Ya tiene scale 2.3
scaleObject('BADspotlight2', 2.7,2.7)      -- Ya tiene scale 2.3

-- FUTURO BUENO
scaleObject('GOODbg6', 2.7,2.7)
scaleObject('GOODbg5', 2.7,2.7)
scaleObject('GOODbg4', 2.7,2.7)
scaleObject('GOODbg3', 2.7,2.7)
scaleObject('GOODbg2', 2.7,2.7)
scaleObject('GOODbg1', 2.7,2.7)
scaleObject('GOODspotlight4', 2.7,2.7)     -- Ya tiene scale 2.3
scaleObject('GOODspotlight3', 2.7,2.7)     -- Ya tiene scale 2.3
scaleObject('GOODfloorback', 2.7, 2.7)
scaleObject('GOODspotlight1', 2.7,2.7)     -- Ya tiene scale 2.3
scaleObject('GOODspotlight2', 2.7,2.7)     -- Ya tiene scale 2.3

    makeAnimatedLuaSprite('amy', 'bgs/stardust speedway/assets/amy', 2000, 350)
    addAnimationByPrefix('amy', 'happy', 'amy happy', 24, true)
    addOffset('amy', 'happy', 0, 0)
    addAnimationByPrefix('amy', 'hostage', 'amy hostage', 24, true)
    addOffset('amy', 'hostage', 0, 0)
    setScrollFactor('amy', 1, 1)
    setObjectCamera('amy', 'camGame')
    scaleObject('amy', 2.7,2.7)
    addLuaSprite('amy', false)
    setProperty('amy.visible', false)

    -- SONIC ENDING (personaje animado)
    makeAnimatedLuaSprite('sonicending', 'bgs/stardust speedway/assets/sonic', getProperty('boyfriend.x'), getProperty('boyfriend.y') + 250)
    addAnimationByIndices('sonicending', 'brake', 'sonic brake', '0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24', 24, false)
    addAnimationByIndices('sonicending', 'brakeloop', 'sonic brake', '10,11,12', 24, true)
    addAnimationByIndices('sonicending', 'smugtransition', 'sonic brake', '25,26,27,28,29,30', 24, false)
    addAnimationByIndices('sonicending', 'smug', 'sonic brake', '31,32,33,34,35,36,37,38,39,40,41,42', 24, true)
    addOffset('sonicending', 'brake', 0, 0)
    setScrollFactor('sonicending', 1, 1)
    setObjectCamera('sonicending', 'camGame')
    scaleObject('sonicending', 2.7,2.7)
    addLuaSprite('sonicending', false)
    setProperty('sonicending.visible', false)

    makeAnimatedLuaSprite('cdtimeicon', 'bgs/stardust speedway/TIME icons', getProperty('iconP1.x'), getProperty('iconP1.y'))
    addAnimationByPrefix('cdtimeicon', 'past', 'icon past', 24, false)
    addAnimationByPrefix('cdtimeicon', 'future', 'icon future', 24, false)
    addLuaSprite('cdtimeicon', true)
    setObjectOrder('cdtimeicon', getObjectOrder('iconP1') + 1)
    setObjectCamera('cdtimeicon', 'camHUD')

    makeAnimatedLuaSprite('timeperiodicon', 'bgs/stardust speedway/TIME icons', 890, 45)
    addAnimationByPrefix('timeperiodicon', 'past', 'icon SIGNpast', 24, false)
    addAnimationByPrefix('timeperiodicon', 'future', 'icon SIGNfuture', 24, false)
    addLuaSprite('timeperiodicon', true)
    setObjectOrder('timeperiodicon', getObjectOrder('iconP1') + 1)
    setObjectCamera('timeperiodicon', 'camHUD')
    local periodsize = 0.7
    setProperty('timeperiodicon.scale.x', periodsize)
    setProperty('timeperiodicon.scale.y', periodsize)
    if not downscroll then
        setProperty('timeperiodicon.y', 610)
        setProperty('timeperiodicon.visible', false)
    end
end

fireworksound = 1
function onTimerCompleted(tag)
	if tag == 'disappearsignpost' then
		if getProperty('signpost.visible') then
			setProperty('signpost.visible', false)
		end
	end
	if tag == 'dadbadending1' then
		doTweenY('dadbadendingY', 'dad', getProperty('dad.y') + 100, 0.7, 'quadIn')
			runTimer('dadbadending2', 0.7)
			runTimer('closedoor', 0.35)
	end
	if tag == 'closedoor' then
		doTweenY('wallclose', 'wall2', wallclosed, 0.4, 'quadIn')
		setObjectOrder('BFBALL', getObjectOrder('wall2') - 1)
	end
	if tag == 'dadbadending2' then
			setProperty('dad.visible', false)
			setProperty('metalending.visible', true)
			playAnim('metalending', 'land', true)
			bgscrolling = false
			setProperty('dad.alpha', 0)
			setProperty('boyfriend.visible', false)
			setProperty('boyfriend.alpha', 0)
			setProperty('BFBALL.visible', true)
			setProperty('BFBALL.alpha', 1)
			setProperty('BFBALL.x', getProperty('boyfriend.x'))
			setProperty('BFBALL.y', getProperty('boyfriend.y'))
			playAnim('BFBALL', 'hurt', true)
			doTweenY('badendingball1', 'BFBALL', getProperty('BFBALL.y') - 100, 0.3, 'quadOut')
			doTweenX('badendingball3', 'BFBALL', getProperty('BFBALL.x') - 400, 0.8, 'quadOut')
			
	end
	if getProperty('bgscene.x') == 3 then
if luaSpriteExists('GOODfireworks1') then
	if tag == 'goodfirework1fire' then
		playAnim('GOODfireworks1', 'particle', true)
		setProperty('GOODfireworks1.alpha', 1)
		setProperty('GOODfireworks1.y', GOODfireworksstartingY)
		doTweenY('GOODfireworks1launch', 'GOODfireworks1', GOODfireworksfinalY, 1, 'quadOut')
		playSound('fireworklaunch', fireworksound)
	end
end
if luaSpriteExists('GOODfireworks2') then
	if tag == 'goodfirework2fire' then
		playAnim('GOODfireworks2', 'particle', true)
		setProperty('GOODfireworks2.alpha', 1)
		setProperty('GOODfireworks2.y', GOODfireworksstartingY)
		doTweenY('GOODfireworks2launch', 'GOODfireworks2', GOODfireworksfinalY, 1, 'quadOut')
		playSound('fireworklaunch', fireworksound)
	end
end
    end
end

function onTweenCompleted(tag)
	if tag == 'timeperioddisappear' then
		setProperty('timeperiodicon.visible', false)
	end
	if tag == 'badendingball1' then
		doTweenY('badendingball2', 'BFBALL', getProperty('BFBALL.y') + 100, 0.3, 'quadIn')
	end
	if tag == 'wallclose' then
		playSound('thud')
	end
	if tag == 'badendingball2' then
		setProperty('BFBALL.visible', false)
		setProperty('sonicbadending.visible', true)
		playAnim('sonicbadending', 'fall', true)
		playSound('land')
		setProperty('sonicbadending.x', getProperty('BFBALL.x'))
		setProperty('sonicbadending.y', getProperty('BFBALL.y') - 60)
	end
	if tag == 'dadbyelol' then
		setProperty('dad.visible', false)
		setProperty('dad.alpha', 0)
    end
	--good future fireworks
	if getProperty('bgscene.x') == 3 then
if luaSpriteExists('GOODfireworks1') then
	if tag == 'GOODfireworks1launch' then
		playSound('fireworkexplode', fireworksound)
		playAnim('GOODfireworks1', getRandomInt(1, 4), true)
		setProperty('GOODfireworks1.scale.x', 0.4)
		setProperty('GOODfireworks1.scale.y', 0.4)
		doTweenX('GOODfireworks1sizeX', 'GOODfireworks1.scale', 2, 1, 'expoOut')
		doTweenY('GOODfireworks1sizeY', 'GOODfireworks1.scale', 2, 1, 'expoOut')
		doTweenAlpha('GOODfirework1alpha1', 'GOODfireworks1', 0.5, 1, 'expoOut')
	end
	if tag == 'GOODfireworks1sizeX' then
		doTweenAlpha('GOODfirework1alpha2', 'GOODfireworks1', 0, 1)
	end
	if tag == 'GOODfirework1alpha2' then
		runTimer('goodfirework1fire', getRandomFloat(0.2, 3))
	end
end
if luaSpriteExists('GOODfireworks2') then
	if tag == 'GOODfireworks2launch' then
		playSound('fireworkexplode', fireworksound)
		playAnim('GOODfireworks2', getRandomInt(1, 4), true)
		setProperty('GOODfireworks2.scale.x', 0.4)
		setProperty('GOODfireworks2.scale.y', 0.4)
		doTweenX('GOODfireworks2sizeX', 'GOODfireworks2.scale', 2, 1, 'expoOut')
		doTweenY('GOODfireworks2sizeY', 'GOODfireworks2.scale', 2, 1, 'expoOut')
		doTweenAlpha('GOODfirework1a2pha1', 'GOODfireworks2', 0.5, 1, 'expoOut')
	end
	if tag == 'GOODfireworks2sizeX' then
		doTweenAlpha('GOODfirework2alpha2', 'GOODfireworks2', 0, 1)
	end
	if tag == 'GOODfirework2alpha2' then
		runTimer('goodfirework2fire', getRandomFloat(0.2, 3))
	end
end
    end
	--present spotlight
	if luaSpriteExists('PRESENTspotlight1') then
        if tag == 'PRESENTspotlight1move1' then
            doTweenAngle('PRESENTspotlight1move2', 'PRESENTspotlight1', -60, spotlightspeed, 'sineInOut')
        end
        if tag == 'PRESENTspotlight1move2' then
            doTweenAngle('PRESENTspotlight1move1', 'PRESENTspotlight1', 70, spotlightspeed, 'sineInOut')
        end
	end
	if luaSpriteExists('PRESENTspotlight2') then
        if tag == 'PRESENTspotlight2move1' then
            doTweenAngle('PRESENTspotlight2move2', 'PRESENTspotlight2', -60, spotlightspeed* spotlightspeedvariable, 'sineInOut')
        end
        if tag == 'PRESENTspotlight2move2' then
            doTweenAngle('PRESENTspotlight2move1', 'PRESENTspotlight2', 70, spotlightspeed* spotlightspeedvariable, 'sineInOut')
        end
	end
	if luaSpriteExists('PRESENTspotlight3') then
        if tag == 'PRESENTspotlight3move1' then
            doTweenAngle('PRESENTspotlight3move2', 'PRESENTspotlight3', -60, spotlightspeed, 'sineInOut')
        end
        if tag == 'PRESENTspotlight3move2' then
            doTweenAngle('PRESENTspotlight3move1', 'PRESENTspotlight3', 70, spotlightspeed, 'sineInOut')
        end
	end
	if luaSpriteExists('PRESENTspotlight4') then
        if tag == 'PRESENTspotlight4move1' then
            doTweenAngle('PRESENTspotlight4move2', 'PRESENTspotlight4', -60, spotlightspeed /spotlightspeedvariable, 'sineInOut')
        end
        if tag == 'PRESENTspotlight4move2' then
            doTweenAngle('PRESENTspotlight4move1', 'PRESENTspotlight4', 70, spotlightspeed/spotlightspeedvariable, 'sineInOut')
        end
	end
	--badfuture spotlight
	if luaSpriteExists('BADspotlight1') then
        if tag == 'BADspotlight1move1' then
            doTweenAngle('BADspotlight1move2', 'BADspotlight1', -60, spotlightspeed, 'sineInOut')
        end
        if tag == 'BADspotlight1move2' then
            doTweenAngle('BADspotlight1move1', 'BADspotlight1', 70, spotlightspeed, 'sineInOut')
        end
	end
	if luaSpriteExists('BADspotlight2') then
        if tag == 'BADspotlight2move1' then
            doTweenAngle('BADspotlight2move2', 'BADspotlight2', -60, spotlightspeed* spotlightspeedvariable, 'sineInOut')
        end
        if tag == 'BADspotlight2move2' then
            doTweenAngle('BADspotlight2move1', 'BADspotlight2', 70, spotlightspeed* spotlightspeedvariable, 'sineInOut')
        end
	end
	if luaSpriteExists('BADspotlight3') then
        if tag == 'BADspotlight3move1' then
            doTweenAngle('BADspotlight3move2', 'BADspotlight3', -60, spotlightspeed, 'sineInOut')
        end
        if tag == 'BADspotlight3move2' then
            doTweenAngle('BADspotlight3move1', 'BADspotlight3', 70, spotlightspeed, 'sineInOut')
        end
	end
	if luaSpriteExists('BADspotlight4') then
        if tag == 'BADspotlight4move1' then
            doTweenAngle('BADspotlight4move2', 'BADspotlight4', -60, spotlightspeed /spotlightspeedvariable, 'sineInOut')
        end
        if tag == 'BADspotlight4move2' then
            doTweenAngle('BADspotlight4move1', 'BADspotlight4', 70, spotlightspeed/spotlightspeedvariable, 'sineInOut')
        end
	end
	--goodfuture spotlight
	if luaSpriteExists('GOODspotlight1') then
        if tag == 'GOODspotlight1move1' then
            doTweenAngle('GOODspotlight1move2', 'GOODspotlight1', -60, spotlightspeed, 'sineInOut')
        end
        if tag == 'GOODspotlight1move2' then
            doTweenAngle('GOODspotlight1move1', 'GOODspotlight1', 70, spotlightspeed, 'sineInOut')
        end
	end
	if luaSpriteExists('GOODspotlight2') then
        if tag == 'GOODspotlight2move1' then
            doTweenAngle('GOODspotlight2move2', 'GOODspotlight2', -60, spotlightspeed* spotlightspeedvariable, 'sineInOut')
        end
        if tag == 'GOODspotlight2move2' then
            doTweenAngle('GOODspotlight2move1', 'GOODspotlight2', 70, spotlightspeed* spotlightspeedvariable, 'sineInOut')
        end
	end
	if luaSpriteExists('GOODspotlight3') then
        if tag == 'GOODspotlight3move1' then
            doTweenAngle('GOODspotlight3move2', 'GOODspotlight3', -60, spotlightspeed, 'sineInOut')
        end
        if tag == 'GOODspotlight3move2' then
            doTweenAngle('GOODspotlight3move1', 'GOODspotlight3', 70, spotlightspeed, 'sineInOut')
        end
	end
	if luaSpriteExists('GOODspotlight4') then
        if tag == 'GOODspotlight4move1' then
            doTweenAngle('GOODspotlight4move2', 'GOODspotlight4', -60, spotlightspeed /spotlightspeedvariable, 'sineInOut')
        end
        if tag == 'GOODspotlight4move2' then
            doTweenAngle('GOODspotlight4move1', 'GOODspotlight4', 70, spotlightspeed/spotlightspeedvariable, 'sineInOut')
        end
	end
		--
    if tag == 'timetravelscroll1' then
        setProperty('timetravelbg.x', -750)
        doTweenX('timetravelscroll1', 'timetravelbg', -1425, timetravelscrollspeed)
    end
    if tag == 'timetravelray1scroll' then
        setProperty('timetravelray1.x', 1900)
        doTweenX('timetravelray1scroll', 'timetravelray1', -1900, timetravelscrollspeed / 0.5)
    end
    if tag == 'timetravelray2scroll' then
        setProperty('timetravelray2.x', 1900)
        doTweenX('timetravelray2scroll', 'timetravelray2', -1900, timetravelscrollspeed / 0.4)
    end
    if tag == 'timetravelray3scroll' then
        setProperty('timetravelray3.x', 1900)
        doTweenX('timetravelray3scroll', 'timetravelray3', -1900, timetravelscrollspeed / 0.6)
    end
    if tag == 'timetravelray4scroll' then
        setProperty('timetravelray4.x', 1900)
        doTweenX('timetravelray4scroll', 'timetravelray4', -1900, timetravelscrollspeed / 0.3)
    end
end

function onStepHit()
	if curStep == 1128 then
		playAnim('signpost', 'past', true)
		playAnim('timeperiodicon', 'past', true)
		setProperty('signpost.visible', true)
		setProperty('signpost.x', signpostX)
	end
	if curStep == 1264 then
		sonicsparkling = false
	end
	if curStep == 1642 then
		playAnim('signpost', 'future', true)
		playAnim('timeperiodicon', 'future', true)
		setProperty('signpost.visible', true)
		setProperty('signpost.x', signpostX)
	end
	if curStep == 1776 and getProperty('future.x') == 0 then
		sonicsparkling = false
	end
	if curStep == 2448 and getProperty('future.x') == 1 then
		sonicsparkling = false
	end
end

brakinganimfinished = false
metalbadlydamaged = false
function onUpdatePost()
	if sonicsparkling and not getProperty('timeperiodicon.visible') then
		setProperty('timeperiodicon.visible', true)
		setProperty('timeperiodicon.alpha', 1)
		setProperty('timeperiodicon.scale.x', 0.85)
		setProperty('timeperiodicon.scale.y', 0.85)
		doTweenX('timeperiodappear', 'timeperiodicon.scale', 0.7, 1, 'expoOut')
		doTweenY('timeperiodappear2', 'timeperiodicon.scale', 0.7, 1, 'expoOut')
	end
	if not sonicsparkling and getProperty('timeperiodicon.alpha') == 1 then
		doTweenAlpha('timeperioddisappear', 'timeperiodicon', 0, 0.5)
	end
	if getProperty('bgscene.x') == 0 or getProperty('bgscene.x') == 1 then
		if getProperty('cdtimeicon.visible') then
		    setProperty('cdtimeicon.visible', false)
		    setProperty('iconP1.visible', true)
		end
	elseif getProperty('bgscene.x') == 2 then
		if not getProperty('cdtimeicon.visible') then
		    setProperty('cdtimeicon.visible', true)
		    playAnim('cdtimeicon', 'past', true)
		    setProperty('iconP1.visible', false)
		end
	elseif getProperty('bgscene.x') == 3 or getProperty('bgscene.x') == 4 then
		if not getProperty('cdtimeicon.visible') then
		    setProperty('cdtimeicon.visible', true)
		    playAnim('cdtimeicon', 'future', true)
		    setProperty('iconP1.visible', false)
		end
	end
	if luaSpriteExists('cdtimeicon') and getProperty('cdtimeicon.visible') then
		setProperty('cdtimeicon.x', getProperty('iconP1.x') + 20)
		setProperty('cdtimeicon.y', getProperty('iconP1.y') + 30)
		setProperty('cdtimeicon.scale.x', getProperty('iconP1.scale.x'))
		setProperty('cdtimeicon.scale.y', getProperty('iconP1.scale.y'))
	end
	if luaSpriteExists('signpost') and getProperty('signpost.visible') then
		if getProperty('signpost.x') < getProperty('boyfriend.x') + 200 and getProperty('signpost.animation.curAnim.name') ~= 'spinning' then
			playAnim('signpost', 'spinning', true)
			runTimer('disappearsignpost', 2)
			sonicsparkling = true
		end
		if getProperty('signpost.animation.curAnim.name') ~= 'spinning' then
		    setProperty('signpost.y', signpostY)
		else
		    setProperty('signpost.y', signpostY - 7)
		end
		if getProperty('bgscene.x') == 1 then
			setProperty('signpost.visible', false)
			setProperty('signpost.x', signpostX)
		end
	end
	if getProperty('gameoveractive.x') == 1 then
		close()
	end
		
	if luaSpriteExists('metalending') and getProperty('metalending.visible') then
		if getProperty('metalending.animation.curAnim.name') == 'land' and getProperty('metalending.animation.curAnim.finished') == true then
            playAnim('metalending', 'wag', true)
        end
	end
	if luaSpriteExists('sonicbadending') and getProperty('sonicbadending.visible') then
		if getProperty('sonicbadending.animation.curAnim.name') == 'fall' and getProperty('sonicbadending.animation.curAnim.finished') == true then
            playAnim('sonicbadending', 'loop', true)
        end
	end
	if metalbadlydamaged then
		if getProperty('dad.animation.curAnim.name') == 'tired' and getProperty('dad.animation.curAnim.finished') == true then
            objectPlayAnimation('dad', 'tired', true)
        end
	end
	if PRESENTspeedmultiplier ~= 0 and getProperty('sonicending.visible') then
		if getProperty('sonicending.animation.curAnim.name') == 'brake' and getProperty('sonicending.animation.curAnim.finished') == true then
            objectPlayAnimation('sonicending', 'brakeloop', true)
			brakinganimfinished = true
		end
	elseif PRESENTspeedmultiplier == 0 and getProperty('sonicending.visible') then
		if brakinganimfinished then
			playAnim('sonicending', 'smugtransition', true)
			brakinganimfinished = false
		end
		if getProperty('sonicending.animation.curAnim.name') == 'smugtransition' and getProperty('sonicending.animation.curAnim.finished') == true then
            objectPlayAnimation('sonicending', 'smug', true)
		end
    end
	if getProperty('resultsscreen.x') == 1 then
		close()
	end
	if bgscrolling then
		setProperty('scrollingspeedway.x', 1) --0=not scrolling 1=scrolling
	else
		setProperty('scrollingspeedway.x', 0) --0=not scrolling 1=scrolling
	end
	if keyboardJustPressed('O') then
		setProperty('GOODfireworks1.x', -1200)
	end
	if keyboardJustPressed('P') then
		setProperty('GOODfireworks1.x', getProperty('GOODfireworks1.x') + 20)
		--setProperty('GOODfireworks1.x', -3254)
		debugPrint(getProperty('GOODfireworks1.x'))
	end
	if not fireworksactive and getProperty('bgscene.x') == 3 then
		fireworksactive = true
	    runTimer('goodfirework1fire', getRandomFloat(0.2, 3))
	    runTimer('goodfirework2fire', getRandomFloat(0.2, 3))
	end
	--scrolling
	--
	-- GOOD future
if luaSpriteExists('GOODfireworks2') and getProperty('GOODfireworks2.x') < -700 then
    setProperty('GOODfireworks2.x', 1840)
end
if luaSpriteExists('GOODfireworks1') and getProperty('GOODfireworks1.x') < -700 then
    setProperty('GOODfireworks1.x', 1840)
end
if luaSpriteExists('GOODfloorback') and getProperty('GOODfloorback.x') < -3254 then
    setProperty('GOODfloorback.x', -1200)
end
if luaSpriteExists('GOODbg1') and getProperty('GOODbg1.x') < -3080 then
    setProperty('GOODbg1.x', -1200)
end
if luaSpriteExists('GOODbg2') and getProperty('GOODbg2.x') < -3572 then
    setProperty('GOODbg2.x', -800)
end
if luaSpriteExists('GOODbg3') and getProperty('GOODbg3.x') < -2750 then
    setProperty('GOODbg3.x', -800)
end
if luaSpriteExists('GOODbg4') and getProperty('GOODbg4.x') < -1198 then
    setProperty('GOODbg4.x', -200)
end
if luaSpriteExists('GOODbg5') and getProperty('GOODbg5.x') < -1390 then
    setProperty('GOODbg5.x', -400)
end
if luaSpriteExists('GOODbg6') and getProperty('GOODbg6.x') < -2217 then
    setProperty('GOODbg6.x', -600)
end
if luaSpriteExists('GOODspotlight1') and getProperty('GOODspotlight1.x') < -2400 then
    setProperty('GOODspotlight1.x', 2700)
end
if luaSpriteExists('GOODspotlight2') and getProperty('GOODspotlight2.x') < -2400 then
    setProperty('GOODspotlight2.x', 2700)
end
if luaSpriteExists('GOODspotlight3') and getProperty('GOODspotlight3.x') < -2400 then
    setProperty('GOODspotlight3.x', 2700)
end
if luaSpriteExists('GOODspotlight4') and getProperty('GOODspotlight4.x') < -2400 then
    setProperty('GOODspotlight4.x', 2700)
end

-- BAD future
if luaSpriteExists('BADbg5') and getProperty('BADbg5.x') < -2463 then
    setProperty('BADbg5.x', -600)
end
if luaSpriteExists('BADbg4') and getProperty('BADbg4.x') < -2463 then
    setProperty('BADbg4.x', -600)
end
if luaSpriteExists('BADbg3') and getProperty('BADbg3.x') < -1312 then
    setProperty('BADbg3.x', -800)
end
if luaSpriteExists('BADbg2') and getProperty('BADbg2.x') < -2520 then
    setProperty('BADbg2.x', -800)
end
if luaSpriteExists('BADbg1') and getProperty('BADbg1.x') < -3819 then
    setProperty('BADbg1.x', -1200)
end
if luaSpriteExists('BADfloorback') and getProperty('BADfloorback.x') < -3232 then
    setProperty('BADfloorback.x', -1200)
end
if luaSpriteExists('BADfloorfront') and getProperty('BADfloorfront.x') < -3632 then
    setProperty('BADfloorfront.x', -1600)

    if luaSpriteExists('BADleds1') then
        setProperty('BADleds1.x', getProperty('BADfloorfront.x') + 2065)
    end
    if luaSpriteExists('BADleds2') then
        setProperty('BADleds2.x', getProperty('BADleds1.x') + BADledseparation)
    end
    if luaSpriteExists('BADleds3') then
        setProperty('BADleds3.x', getProperty('BADleds1.x') + BADledseparation)
    end

    if luaSpriteExists('BADbar1') then
        setProperty('BADbar1.x', getProperty('BADfloorfront.x') + 1499)
    end
    if luaSpriteExists('BADbar2') then
        setProperty('BADbar2.x', getProperty('BADbar1.x') + BADbarseparation)
    end
    if luaSpriteExists('BADbar3') then
        setProperty('BADbar3.x', getProperty('BADbar1.x') + BADbarseparation)
    end
end
if luaSpriteExists('BADspotlight1') and getProperty('BADspotlight1.x') < -2400 then
    setProperty('BADspotlight1.x', 2700)
end
if luaSpriteExists('BADspotlight2') and getProperty('BADspotlight2.x') < -2400 then
    setProperty('BADspotlight2.x', 2700)
end
if luaSpriteExists('BADspotlight3') and getProperty('BADspotlight3.x') < -2400 then
    setProperty('BADspotlight3.x', 2700)
end
if luaSpriteExists('BADspotlight4') and getProperty('BADspotlight4.x') < -2400 then
    setProperty('BADspotlight4.x', 2700)
end

	--
	if luaSpriteExists('PASTbg4') then
	    if getProperty('PASTbg4.x') < -2222 then
	    	setProperty('PASTbg4.x', -600)
	    end
	end
	if luaSpriteExists('PASTbg3') then
	    if getProperty('PASTbg3.x') < -1609 then
	    	setProperty('PASTbg3.x', -800)
	    end
	end
	if luaSpriteExists('PASTbgelements') then
	    if getProperty('PASTbgelements.x') < -1200 then
	    	playAnim('PASTbgelements', tostring(math.random(1, 4)), false)
	    	setProperty('PASTbgelements.x', 1780)
	    end
	end
	if luaSpriteExists('PASTbg11') then
	    if getProperty('PASTbg11.x') < -3068 then
	    	setProperty('PASTbg11.x', -800 + pastbg1spacing * 2)
	    end
	end
	if luaSpriteExists('PASTbg12') then
		if getProperty('PASTbg12.x') < -3068 then
			setProperty('PASTbg12.x', -800 + pastbg1spacing * 2)
	    end
	end
	if luaSpriteExists('PASTbg13') then
	    if getProperty('PASTbg13.x') < -3068 then
	    	setProperty('PASTbg13.x', -800 + pastbg1spacing * 2)
	    end
	end
	if luaSpriteExists('PASTbg21') then
	    if getProperty('PASTbg21.x') < -3068 then
	    	setProperty('PASTbg21.x', -800 + pastbg1spacing * 2)
	    end
	end
	if luaSpriteExists('PASTbg22') then
	    if getProperty('PASTbg22.x') < -3068 then
	    	setProperty('PASTbg22.x', -800 + pastbg1spacing * 2)
	    end
	end
	if luaSpriteExists('PASTbg23') then
	    if getProperty('PASTbg23.x') < -3068 then
	    	setProperty('PASTbg23.x', -800 + pastbg1spacing * 2)
	    end
	end
	if luaSpriteExists('PASTfloorback') then
	    if getProperty('PASTfloorback.x') < -2580 then
	    	setProperty('PASTfloorback.x', -1200)
	    end
	end
	if luaSpriteExists('PASTfloorfront') then
	    if getProperty('PASTfloorfront.x') < -4205 then
	    	setProperty('PASTfloorfront.x', -1600)
	    end
	end
	--present
	if luaSpriteExists('PRESENTspotlight1') then
	    if getProperty('PRESENTspotlight1.x') < -2400 then
	    	setProperty('PRESENTspotlight1.x', 2700)
	    end
	end
	if luaSpriteExists('PRESENTspotlight2') then
	    if getProperty('PRESENTspotlight2.x') < -2400 then
	    	setProperty('PRESENTspotlight2.x', 2700)
	    end
	end
	if luaSpriteExists('PRESENTspotlight3') then
	    if getProperty('PRESENTspotlight3.x') < -2400 then
	    	setProperty('PRESENTspotlight3.x', 2700)
	    end
	end
	if luaSpriteExists('PRESENTspotlight4') then
	    if getProperty('PRESENTspotlight4.x') < -2400 then
	    	setProperty('PRESENTspotlight4.x', 2700)
	    end
	end
	if luaSpriteExists('PRESENTbg4') then
	    if getProperty('PRESENTbg4.x') < -2412 then
	    	setProperty('PRESENTbg4.x', -800)
	    end
	end
	if luaSpriteExists('PRESENTbg3') then
	    if getProperty('PRESENTbg3.x') < -2745 then
	    	setProperty('PRESENTbg3.x', -800)
	    end
	end
	if luaSpriteExists('PRESENTbg2') then
	    if getProperty('PRESENTbg2.x') < -3507 then
	    	setProperty('PRESENTbg2.x', -1200)
	    end
	end
	if luaSpriteExists('PRESENTbg1') then
	    if getProperty('PRESENTbg1.x') < -2310 then
	    	setProperty('PRESENTbg1.x', -1200)
	    end
	end
	if luaSpriteExists('PRESENTfloorback') then --back -3232 front -3632
		if getProperty('PRESENTfloorback.x') < -3232 then
			setProperty('PRESENTfloorback.x', -1200)
		end
	end
	if luaSpriteExists('PRESENTfloorfront') then
	    if getProperty('PRESENTfloorfront.x') < -3632 then
	    	setProperty('PRESENTfloorfront.x', -1600)
	    end
	end
	if detsongstarted then
        if getProperty('bgscene.x') == 1 then --time traveling
            setProperty('timetravelbg.visible', true)
            setProperty('timetravelray1.visible', true)
            setProperty('timetravelray2.visible', true)
            setProperty('timetravelray3.visible', true)
            setProperty('timetravelray4.visible', true)
        else
            setProperty('timetravelbg.visible', false)
            setProperty('timetravelray1.visible', false)
            setProperty('timetravelray2.visible', false)
            setProperty('timetravelray3.visible', false)
            setProperty('timetravelray4.visible', false)
        end
        if getProperty('bgscene.x') == 0 then --present
			if luaSpriteExists('PRESENTbg1') then
                setProperty('PRESENTbg1.visible', true)
			end
			if luaSpriteExists('PRESENTbg2') then
                setProperty('PRESENTbg2.visible', true)
			end
			if luaSpriteExists('PRESENTbg3') then
                setProperty('PRESENTbg3.visible', true)
			end
			if luaSpriteExists('PRESENTbg4') then
                setProperty('PRESENTbg4.visible', true)
			end
			if luaSpriteExists('PRESENTbg5') then
                setProperty('PRESENTbg5.visible', true)
			end
	 		if luaSpriteExists('PRESENTfloorback') then
                setProperty('PRESENTfloorback.visible', true)
			end
	 		if luaSpriteExists('PRESENTfloorfront') then
                setProperty('PRESENTfloorfront.visible', true)
			end
	 		if luaSpriteExists('PRESENTspotlight1') then
                setProperty('PRESENTspotlight1.visible', true)
			end
	 		if luaSpriteExists('PRESENTspotlight2') then
                setProperty('PRESENTspotlight2.visible', true)
			end
	 		if luaSpriteExists('PRESENTspotlight3') then
                setProperty('PRESENTspotlight3.visible', true)
			end
	 		if luaSpriteExists('PRESENTspotlight4') then
                setProperty('PRESENTspotlight4.visible', true)
			end
        else
			if luaSpriteExists('PRESENTbg1') then
                setProperty('PRESENTbg1.visible', false)
			end
			if luaSpriteExists('PRESENTbg2') then
                setProperty('PRESENTbg2.visible', false)
			end
			if luaSpriteExists('PRESENTbg3') then
                setProperty('PRESENTbg3.visible', false)
			end
			if luaSpriteExists('PRESENTbg4') then
                setProperty('PRESENTbg4.visible', false)
			end
			if luaSpriteExists('PRESENTbg5') then
                setProperty('PRESENTbg5.visible', false)
			end
	 		if luaSpriteExists('PRESENTfloorback') then
                setProperty('PRESENTfloorback.visible', false)
			end
	 		if luaSpriteExists('PRESENTfloorfront') then
                setProperty('PRESENTfloorfront.visible', false)
			end
	 		if luaSpriteExists('PRESENTspotlight1') then
                setProperty('PRESENTspotlight1.visible', false)
			end
	 		if luaSpriteExists('PRESENTspotlight2') then
                setProperty('PRESENTspotlight2.visible', false)
			end
	 		if luaSpriteExists('PRESENTspotlight3') then
                setProperty('PRESENTspotlight3.visible', false)
			end
	 		if luaSpriteExists('PRESENTspotlight4') then
                setProperty('PRESENTspotlight4.visible', false)
			end
        end
        if getProperty('bgscene.x') == 2 then -- past
    if luaSpriteExists('PASTbg11') then
        setProperty('PASTbg11.visible', true)
    end
    if luaSpriteExists('PASTbg12') then
        setProperty('PASTbg12.visible', true)
    end
    if luaSpriteExists('PASTbg13') then
        setProperty('PASTbg13.visible', true)
    end
    if luaSpriteExists('PASTbg21') then
        setProperty('PASTbg21.visible', true)
    end
    if luaSpriteExists('PASTbg22') then
        setProperty('PASTbg22.visible', true)
    end
    if luaSpriteExists('PASTbg23') then
        setProperty('PASTbg23.visible', true)
    end
    if luaSpriteExists('PASTbg3') then
        setProperty('PASTbg3.visible', true)
    end
    if luaSpriteExists('PASTbg4') then
        setProperty('PASTbg4.visible', true)
    end
    if luaSpriteExists('PASTfloorback') then
        setProperty('PASTfloorback.visible', true)
    end
    if luaSpriteExists('PASTbgelements') then
        setProperty('PASTbgelements.visible', true)
    end
    if luaSpriteExists('PASTfloorfront') then
        setProperty('PASTfloorfront.visible', true)
    end
else
    if luaSpriteExists('PASTbg11') then
        setProperty('PASTbg11.visible', false)
    end
    if luaSpriteExists('PASTbg12') then
        setProperty('PASTbg12.visible', false)
    end
    if luaSpriteExists('PASTbg13') then
        setProperty('PASTbg13.visible', false)
    end
    if luaSpriteExists('PASTbg21') then
        setProperty('PASTbg21.visible', false)
    end
    if luaSpriteExists('PASTbg22') then
        setProperty('PASTbg22.visible', false)
    end
    if luaSpriteExists('PASTbg23') then
        setProperty('PASTbg23.visible', false)
    end
    if luaSpriteExists('PASTbg3') then
        setProperty('PASTbg3.visible', false)
    end
    if luaSpriteExists('PASTbg4') then
        setProperty('PASTbg4.visible', false)
    end
    if luaSpriteExists('PASTfloorback') then
        setProperty('PASTfloorback.visible', false)
    end
    if luaSpriteExists('PASTbgelements') then
        setProperty('PASTbgelements.visible', false)
    end
    if luaSpriteExists('PASTfloorfront') then
        setProperty('PASTfloorfront.visible', false)
    end
end

        if getProperty('bgscene.x') == 3 then -- good future
    if luaSpriteExists('GOODbg1') then
        setProperty('GOODbg1.visible', true)
    end
    if luaSpriteExists('GOODbg2') then
        setProperty('GOODbg2.visible', true)
    end
    if luaSpriteExists('GOODbg3') then
        setProperty('GOODbg3.visible', true)
    end
    if luaSpriteExists('GOODbg4') then
        setProperty('GOODbg4.visible', true)
    end
    if luaSpriteExists('GOODbg5') then
        setProperty('GOODbg5.visible', true)
    end
    if luaSpriteExists('GOODbg6') then
        setProperty('GOODbg6.visible', true)
    end
    if luaSpriteExists('GOODfloorback') then
        setProperty('GOODfloorback.visible', true)
    end
    if luaSpriteExists('GOODspotlight1') then
        setProperty('GOODspotlight1.visible', true)
    end
    if luaSpriteExists('GOODspotlight2') then
        setProperty('GOODspotlight2.visible', true)
    end
    if luaSpriteExists('GOODspotlight3') then
        setProperty('GOODspotlight3.visible', true)
    end
    if luaSpriteExists('GOODspotlight4') then
        setProperty('GOODspotlight4.visible', true)
    end
    if luaSpriteExists('GOODfireworks1') then
        setProperty('GOODfireworks1.visible', true)
    end
    if luaSpriteExists('GOODfireworks2') then
        setProperty('GOODfireworks2.visible', true)
    end
else
    if luaSpriteExists('GOODbg1') then
        setProperty('GOODbg1.visible', false)
    end
    if luaSpriteExists('GOODbg2') then
        setProperty('GOODbg2.visible', false)
    end
    if luaSpriteExists('GOODbg3') then
        setProperty('GOODbg3.visible', false)
    end
    if luaSpriteExists('GOODbg4') then
        setProperty('GOODbg4.visible', false)
    end
    if luaSpriteExists('GOODbg5') then
        setProperty('GOODbg5.visible', false)
    end
    if luaSpriteExists('GOODbg6') then
        setProperty('GOODbg6.visible', false)
    end
    if luaSpriteExists('GOODfloorback') then
        setProperty('GOODfloorback.visible', false)
    end
    if luaSpriteExists('GOODspotlight1') then
        setProperty('GOODspotlight1.visible', false)
    end
    if luaSpriteExists('GOODspotlight2') then
        setProperty('GOODspotlight2.visible', false)
    end
    if luaSpriteExists('GOODspotlight3') then
        setProperty('GOODspotlight3.visible', false)
    end
    if luaSpriteExists('GOODspotlight4') then
        setProperty('GOODspotlight4.visible', false)
    end
    if luaSpriteExists('GOODfireworks1') then
        setProperty('GOODfireworks1.visible', false)
    end
    if luaSpriteExists('GOODfireworks2') then
        setProperty('GOODfireworks2.visible', false)
    end
end

if getProperty('bgscene.x') == 4 then -- bad future
    if luaSpriteExists('BADbg1') then
        setProperty('BADbg1.visible', true)
    end
    if luaSpriteExists('BADbg2') then
        setProperty('BADbg2.visible', true)
    end
    if luaSpriteExists('BADbg3') then
        setProperty('BADbg3.visible', true)
    end
    if luaSpriteExists('BADbg4') then
        setProperty('BADbg4.visible', true)
    end
    if luaSpriteExists('BADbg5') then
        setProperty('BADbg5.visible', true)
    end
    if luaSpriteExists('BADfloorback') then
        setProperty('BADfloorback.visible', true)
    end
    if luaSpriteExists('BADfloorfront') then
        setProperty('BADfloorfront.visible', true)
    end
    if luaSpriteExists('BADspotlight1') then
        setProperty('BADspotlight1.visible', true)
    end
    if luaSpriteExists('BADspotlight2') then
        setProperty('BADspotlight2.visible', true)
    end
    if luaSpriteExists('BADspotlight3') then
        setProperty('BADspotlight3.visible', true)
    end
    if luaSpriteExists('BADspotlight4') then
        setProperty('BADspotlight4.visible', true)
    end
    if luaSpriteExists('BADbar1') then
        setProperty('BADbar1.visible', true)
    end
    if luaSpriteExists('BADbar2') then
        setProperty('BADbar2.visible', true)
    end
    if luaSpriteExists('BADbar3') then
        setProperty('BADbar3.visible', true)
    end
    if luaSpriteExists('BADleds1') then
        setProperty('BADleds1.visible', true)
    end
    if luaSpriteExists('BADleds2') then
        setProperty('BADleds2.visible', true)
    end
    if luaSpriteExists('BADleds3') then
        setProperty('BADleds3.visible', true)
    end
    if luaSpriteExists('BADoverlay') then
        setProperty('BADoverlay.visible', true)
    end
else
    if luaSpriteExists('BADbg1') then
        setProperty('BADbg1.visible', false)
    end
    if luaSpriteExists('BADbg2') then
        setProperty('BADbg2.visible', false)
    end
    if luaSpriteExists('BADbg3') then
        setProperty('BADbg3.visible', false)
    end
    if luaSpriteExists('BADbg4') then
        setProperty('BADbg4.visible', false)
    end
    if luaSpriteExists('BADbg5') then
        setProperty('BADbg5.visible', false)
    end
    if luaSpriteExists('BADfloorback') then
        setProperty('BADfloorback.visible', false)
    end
    if luaSpriteExists('BADfloorfront') then
        setProperty('BADfloorfront.visible', false)
    end
    if luaSpriteExists('BADspotlight1') then
        setProperty('BADspotlight1.visible', false)
    end
    if luaSpriteExists('BADspotlight2') then
        setProperty('BADspotlight2.visible', false)
    end
    if luaSpriteExists('BADspotlight3') then
        setProperty('BADspotlight3.visible', false)
    end
    if luaSpriteExists('BADspotlight4') then
        setProperty('BADspotlight4.visible', false)
    end
    if luaSpriteExists('BADbar1') then
        setProperty('BADbar1.visible', false)
    end
    if luaSpriteExists('BADbar2') then
        setProperty('BADbar2.visible', false)
    end
    if luaSpriteExists('BADbar3') then
        setProperty('BADbar3.visible', false)
    end
    if luaSpriteExists('BADleds1') then
        setProperty('BADleds1.visible', false)
    end
    if luaSpriteExists('BADleds2') then
        setProperty('BADleds2.visible', false)
    end
    if luaSpriteExists('BADleds3') then
        setProperty('BADleds3.visible', false)
    end
    if luaSpriteExists('BADoverlay') then
        setProperty('BADoverlay.visible', false)
    end
end

	end
end

function spawnTimeSparkle()
    if sonicsparkling then

    sparkleIndex = sparkleIndex + 1
    local tag = 'TIMEsparkle' .. sparkleIndex


    makeLuaSprite(tag, 'bgs/stardust speedway/assets/sparkle', getProperty('BFBALL.x') + math.random(0, 400), getProperty('BFBALL.y') + math.random(0, 350))

    addAnimationByPrefix(tag, 'sparkle', 'sparkle', 24, true)
    playAnim(tag, 'sparkle')

    addLuaSprite(tag, true)
    setObjectOrder(tag, getObjectOrder('BFBALL') + 1)

	setProperty(tag..'scale.x', getRandomFloat(1,2))

	
	setProperty(tag..'scale.y', getRandomFloat(1,2))

	doTweenAlpha(tag..'alphatween', tag, 0, 1.2)
	end
end



function spawnFirefly()
    fireflyIndex = fireflyIndex + 1
    local fireflyTag = 'PASTfirefly' .. fireflyIndex

    local fireflyY = getRandomFloat(fireflyMinY, fireflyMaxY)
    local fireflyScale = getRandomFloat(fireflyMinScale, fireflyMaxScale)

    makeLuaSprite(fireflyTag, 'bgs/stardust speedway/assets/pastfirefly', fireflySpawnX, fireflyY)
    setScrollFactor(fireflyTag, 1.2, 1.2)
    scaleObject(fireflyTag, fireflyScale, fireflyScale)
    setBlendMode(fireflyTag, 'add')

    local randomvar = math.random(1,2)
    if randomvar == 1 then
        addLuaSprite(fireflyTag, true)
    else
        addLuaSprite(fireflyTag, false)
    end

    fireflySpeeds[fireflyTag] = math.random(1100, 1500)
end



PRESENTspeed = 1500
PRESENTspeedmultiplier = 1
PASTspeed = 1200
PASTspeedmultiplier = 1
function onUpdate(elapsed)
	if sonicsparkling then
        sparkleTimer = sparkleTimer + elapsed
        if sparkleTimer >= 0.1 then
            sparkleTimer = 0
            spawnTimeSparkle()
        end
    end
	if stopscrolling then
		if PRESENTspeedmultiplier > 0 then
		    PRESENTspeedmultiplier = PRESENTspeedmultiplier - 0.5 * elapsed
		else
			stopscrolling = false
			PRESENTspeedmultiplier = 0
		end
		if PASTspeedmultiplier > 0 then
		    PASTspeedmultiplier = PASTspeedmultiplier - 0.5 * elapsed
		else
			stopscrolling = false
			PASTspeedmultiplier = 0
		end
	end
-- ================= FIRELIES =================
if not lowQuality then
fireflySpawnTimer = fireflySpawnTimer + elapsed
end

-- Freeze spawning if bgscrolling is false
local currentSpawnCooldown = bgscrolling and fireflySpawnCooldown or 999

-- Spawn fireflies only while in PAST
if getProperty('bgscene.x') == 2 and fireflySpawnTimer >= currentSpawnCooldown then
	
if not lowQuality then
    fireflySpawnTimer = 0
    spawnFirefly()
end
end

for i = sparkleIndex, 1, -1 do
    local tag = 'TIMEsparkle' .. i
    if luaSpriteExists(tag) then
        if bgscrolling then
            setProperty(tag .. '.x', getProperty(tag .. '.x') - PRESENTspeed * PRESENTspeedmultiplier * elapsed)
	    else
            setProperty(tag .. '.x', getProperty(tag .. '.x') - PRESENTspeed * PRESENTspeedmultiplier / 2 * elapsed)
	    end
		if getProperty(tag .. '.x') < fireflyDespawnX then
            removeLuaSprite(tag, true)
        end
		if not sonicsparkling then
            removeLuaSprite(tag, true)
        end
    end
end

if not sonicsparkling then
    sparkleIndex = 0
end


for i = fireflyIndex, 1, -1 do
    local tag = 'PASTfirefly' .. i
    if luaSpriteExists(tag) then
        -- visibility
        setProperty(tag .. '.visible', getProperty('bgscene.x') == 2)

        -- speed
        local fireflySpeed = getRandomFloat(1100, 1500)
        if not bgscrolling then
            fireflySpeed = fireflySpeed / 10
        end

        setProperty(
            tag .. '.x',
            getProperty(tag .. '.x') - fireflySpeed * PASTspeedmultiplier * elapsed
        )

        -- despawn
        if getProperty(tag .. '.x') < fireflyDespawnX then
            removeLuaSprite(tag, true)
        end
    end
end

	if getProperty('deathindicator.x') == 1 then
		bgscrolling = false
		setProperty('dad.x', getProperty('dad.x') + PRESENTspeed * PRESENTspeedmultiplier * elapsed)
	end
	if bgscrolling then
		if getProperty('bgscene.x') == 0 then
	        if luaSpriteExists('signpost') and getProperty('signpost.visible') then
		        setProperty('signpost.x', getProperty('signpost.x') - PRESENTspeed * 1 * PRESENTspeedmultiplier * elapsed)
			end
		elseif getProperty('bgscene.x') == 2 then
		        setProperty('signpost.x', getProperty('signpost.x') - PASTspeed * PASTspeedmultiplier * elapsed)
		end
	end
    if getProperty('bgscene.x') == 0 then --present
		if bgscrolling then
			--
	        if luaSpriteExists('PRESENTspotlight1') then
		        setProperty('PRESENTspotlight1.x', getProperty('PRESENTspotlight1.x') - PRESENTspeed * 1.1 * PRESENTspeedmultiplier * elapsed)
			end
	        if luaSpriteExists('PRESENTspotlight2') then
		        setProperty('PRESENTspotlight2.x', getProperty('PRESENTspotlight2.x') - PRESENTspeed * 1.1 * PRESENTspeedmultiplier * elapsed)
			end
	        if luaSpriteExists('PRESENTspotlight3') then
		        setProperty('PRESENTspotlight3.x', getProperty('PRESENTspotlight3.x') - PRESENTspeed * 0.9 * PRESENTspeedmultiplier * elapsed)
			end
	        if luaSpriteExists('PRESENTspotlight4') then
		        setProperty('PRESENTspotlight4.x', getProperty('PRESENTspotlight4.x') - PRESENTspeed * 0.9 * PRESENTspeedmultiplier * elapsed)
			end
	 		if luaSpriteExists('PRESENTfloorfront') then
		        setProperty('PRESENTfloorfront.x', getProperty('PRESENTfloorfront.x') - PRESENTspeed * PRESENTspeedmultiplier * elapsed)
			end
	 		if luaSpriteExists('PRESENTfloorback') then
		        setProperty('PRESENTfloorback.x', getProperty('PRESENTfloorback.x') - PRESENTspeed * PRESENTspeedmultiplier * elapsed)
			end
			if luaSpriteExists('PRESENTbg1') then
		        setProperty('PRESENTbg1.x', getProperty('PRESENTbg1.x') - PRESENTspeed/3 * PRESENTspeedmultiplier * elapsed)
			end
			if luaSpriteExists('PRESENTbg2') then
		        setProperty('PRESENTbg2.x', getProperty('PRESENTbg2.x') - PRESENTspeed/3 * PRESENTspeedmultiplier * elapsed)
			end
			if luaSpriteExists('PRESENTbg3') then
		        setProperty('PRESENTbg3.x', getProperty('PRESENTbg3.x') - PRESENTspeed/4 * PRESENTspeedmultiplier * elapsed)
			end
			if luaSpriteExists('PRESENTbg4') then
		        setProperty('PRESENTbg4.x', getProperty('PRESENTbg4.x') - PRESENTspeed/6 * PRESENTspeedmultiplier * elapsed)
			end
		end
	end
	if getProperty('bgscene.x') == 2 then -- past
    if bgscrolling then
        if luaSpriteExists('PASTbgelements') then
            setProperty('PASTbgelements.x', getProperty('PASTbgelements.x') - PASTspeed * PASTspeedmultiplier * elapsed)
        end
        if luaSpriteExists('PASTfloorfront') then
            setProperty('PASTfloorfront.x', getProperty('PASTfloorfront.x') - PASTspeed * PASTspeedmultiplier * elapsed)
        end
        if luaSpriteExists('PASTfloorback') then
            setProperty('PASTfloorback.x', getProperty('PASTfloorback.x') - PASTspeed * PASTspeedmultiplier * elapsed)
        end
        if luaSpriteExists('PASTbg11') then
            setProperty('PASTbg11.x', getProperty('PASTbg11.x') - PASTspeed/3 * PASTspeedmultiplier * elapsed)
        end
        if luaSpriteExists('PASTbg12') then
            setProperty('PASTbg12.x', getProperty('PASTbg12.x') - PASTspeed/3 * PASTspeedmultiplier * elapsed)
        end
        if luaSpriteExists('PASTbg13') then
            setProperty('PASTbg13.x', getProperty('PASTbg13.x') - PASTspeed/3 * PASTspeedmultiplier * elapsed)
        end
        if luaSpriteExists('PASTbg21') then
            setProperty('PASTbg21.x', getProperty('PASTbg21.x') - PASTspeed/3 * PASTspeedmultiplier * elapsed)
        end
        if luaSpriteExists('PASTbg22') then
            setProperty('PASTbg22.x', getProperty('PASTbg22.x') - PASTspeed/3 * PASTspeedmultiplier * elapsed)
        end
        if luaSpriteExists('PASTbg23') then
            setProperty('PASTbg23.x', getProperty('PASTbg23.x') - PASTspeed/3 * PASTspeedmultiplier * elapsed)
        end
        if luaSpriteExists('PASTbg3') then
            setProperty('PASTbg3.x', getProperty('PASTbg3.x') - PASTspeed/6 * PASTspeedmultiplier * elapsed)
        end
        if luaSpriteExists('PASTbg4') then
            setProperty('PASTbg4.x', getProperty('PASTbg4.x') - PASTspeed/10 * PASTspeedmultiplier * elapsed)
        end
    end
end

if getProperty('bgscene.x') == 3 then -- good future
    if bgscrolling then
			if luaSpriteExists('amy') and getProperty('amy.visible') then --sonicending
				setProperty('amy.x', getProperty('amy.x') - PRESENTspeed * PRESENTspeedmultiplier * elapsed)
			end
			if luaSpriteExists('sonicending') and getProperty('sonicending.visible') then --
				setProperty('sonicending.x', getProperty('sonicending.x') - PRESENTspeed * PRESENTspeedmultiplier / 2.1 * elapsed)
			end
        if luaSpriteExists('GOODspotlight1') then
            setProperty('GOODspotlight1.x', getProperty('GOODspotlight1.x') - PRESENTspeed * 1.1 * PRESENTspeedmultiplier * elapsed)
        end
        if luaSpriteExists('GOODspotlight2') then
            setProperty('GOODspotlight2.x', getProperty('GOODspotlight2.x') - PRESENTspeed * 1.1 * PRESENTspeedmultiplier * elapsed)
        end
        if luaSpriteExists('GOODspotlight3') then
            setProperty('GOODspotlight3.x', getProperty('GOODspotlight3.x') - PRESENTspeed * 0.9 * PRESENTspeedmultiplier * elapsed)
        end
        if luaSpriteExists('GOODspotlight4') then
            setProperty('GOODspotlight4.x', getProperty('GOODspotlight4.x') - PRESENTspeed * 0.9 * PRESENTspeedmultiplier * elapsed)
        end
        if luaSpriteExists('GOODfloorback') then
            setProperty('GOODfloorback.x', getProperty('GOODfloorback.x') - PRESENTspeed * PRESENTspeedmultiplier * elapsed)
        end
        if luaSpriteExists('GOODbg1') then
            setProperty('GOODbg1.x', getProperty('GOODbg1.x') - PRESENTspeed/2 * PRESENTspeedmultiplier * elapsed)
        end
        if luaSpriteExists('GOODbg2') then
            setProperty('GOODbg2.x', getProperty('GOODbg2.x') - PRESENTspeed/3 * PRESENTspeedmultiplier * elapsed)
        end
        if luaSpriteExists('GOODbg3') then
            setProperty('GOODbg3.x', getProperty('GOODbg3.x') - PRESENTspeed/4 * PRESENTspeedmultiplier * elapsed)
        end
        if luaSpriteExists('GOODfireworks1') then
            setProperty('GOODfireworks1.x', getProperty('GOODfireworks1.x') - PRESENTspeed/4 * PRESENTspeedmultiplier * elapsed)
        end
        if luaSpriteExists('GOODfireworks2') then
            setProperty('GOODfireworks2.x', getProperty('GOODfireworks2.x') - PRESENTspeed/4 * PRESENTspeedmultiplier * elapsed)
        end
        if luaSpriteExists('GOODbg4') then
            setProperty('GOODbg4.x', getProperty('GOODbg4.x') - PRESENTspeed/6 * PRESENTspeedmultiplier * elapsed)
        end
        if luaSpriteExists('GOODbg5') then
            setProperty('GOODbg5.x', getProperty('GOODbg5.x') - PRESENTspeed/10 * PRESENTspeedmultiplier * elapsed)
        end
        if luaSpriteExists('GOODbg6') then
            setProperty('GOODbg6.x', getProperty('GOODbg6.x') - PRESENTspeed/12 * PRESENTspeedmultiplier * elapsed)
        end
    end
end

if getProperty('bgscene.x') == 4 then -- bad future
    if bgscrolling then
			--bad ending
			if luaSpriteExists('amy') and getProperty('amy.visible') then --sonicending
				setProperty('amy.x', getProperty('amy.x') - PRESENTspeed * PRESENTspeedmultiplier * elapsed)
			end
			if luaSpriteExists('wall1') and getProperty('wall1.visible') then
		        setProperty('wall1.x', getProperty('wall1.x') - PRESENTspeed * PRESENTspeedmultiplier * elapsed)
			end
			if luaSpriteExists('wall2') and getProperty('wall2.visible') then
		        setProperty('wall2.x', getProperty('wall2.x') - PRESENTspeed * PRESENTspeedmultiplier * elapsed)
			end
        if luaSpriteExists('BADspotlight1') then
            setProperty('BADspotlight1.x', getProperty('BADspotlight1.x') - PRESENTspeed * 1.1 * PRESENTspeedmultiplier * elapsed)
        end
        if luaSpriteExists('BADspotlight2') then
            setProperty('BADspotlight2.x', getProperty('BADspotlight2.x') - PRESENTspeed * 1.1 * PRESENTspeedmultiplier * elapsed)
        end
        if luaSpriteExists('BADspotlight3') then
            setProperty('BADspotlight3.x', getProperty('BADspotlight3.x') - PRESENTspeed * 0.9 * PRESENTspeedmultiplier * elapsed)
        end
        if luaSpriteExists('BADspotlight4') then
            setProperty('BADspotlight4.x', getProperty('BADspotlight4.x') - PRESENTspeed * 0.9 * PRESENTspeedmultiplier * elapsed)
        end
        if luaSpriteExists('BADfloorback') then
            setProperty('BADfloorback.x', getProperty('BADfloorback.x') - PRESENTspeed * PRESENTspeedmultiplier * elapsed)
        end
        if luaSpriteExists('BADfloorfront') then
            setProperty('BADfloorfront.x', getProperty('BADfloorfront.x') - PRESENTspeed * PRESENTspeedmultiplier * elapsed)
        end
        if luaSpriteExists('BADleds1') then
            setProperty('BADleds1.x', getProperty('BADleds1.x') - PRESENTspeed * PRESENTspeedmultiplier * elapsed)
        end
        if luaSpriteExists('BADleds2') then
            setProperty('BADleds2.x', getProperty('BADleds2.x') - PRESENTspeed * PRESENTspeedmultiplier * elapsed)
        end
        if luaSpriteExists('BADleds3') then
            setProperty('BADleds3.x', getProperty('BADleds3.x') - PRESENTspeed * PRESENTspeedmultiplier * elapsed)
        end
        if luaSpriteExists('BADbar1') then
            setProperty('BADbar1.x', getProperty('BADbar1.x') - PRESENTspeed * PRESENTspeedmultiplier * elapsed)
        end
        if luaSpriteExists('BADbar2') then
            setProperty('BADbar2.x', getProperty('BADbar2.x') - PRESENTspeed * PRESENTspeedmultiplier * elapsed)
        end
        if luaSpriteExists('BADbar3') then
            setProperty('BADbar3.x', getProperty('BADbar3.x') - PRESENTspeed * PRESENTspeedmultiplier * elapsed)
        end
        if luaSpriteExists('BADbg1') then
            setProperty('BADbg1.x', getProperty('BADbg1.x') - PRESENTspeed/2 * PRESENTspeedmultiplier * elapsed)
        end
        if luaSpriteExists('BADbg2') then
            setProperty('BADbg2.x', getProperty('BADbg2.x') - PRESENTspeed/3 * PRESENTspeedmultiplier * elapsed)
        end
        if luaSpriteExists('BADbg3') then
            setProperty('BADbg3.x', getProperty('BADbg3.x') - PRESENTspeed/4 * PRESENTspeedmultiplier * elapsed)
        end
        if luaSpriteExists('BADbg4') then
            setProperty('BADbg4.x', getProperty('BADbg4.x') - PRESENTspeed/6 * PRESENTspeedmultiplier * elapsed)
        end
        if luaSpriteExists('BADbg5') then
            setProperty('BADbg5.x', getProperty('BADbg5.x') - PRESENTspeed/12 * PRESENTspeedmultiplier * elapsed)
        end
    end
end

end

function onSongStart()
		detsongstarted = true
end

function onSectionHit()
	if curSection == 8 then
		bgscrolling = true
	end
end

function onBeatHit()
	if getProperty('deathindicator.x') == 0 then
	--badfuture ending
		if getProperty('future.x') == 0 then
		if curBeat == 544 then
			setProperty('metalending.x',getProperty('dad.x') + 700)
			setProperty('metalending.y',getProperty('dad.y') - 100)
			setObjectOrder('metalending', getObjectOrder('wall2') + 1)
				setProperty('amy.visible', true)
				playAnim('amy', 'hostage', true)
				setProperty('amy.x', 3200 + badendingoffset)
				setProperty('amy.y', getProperty('amy.y')- 200)
				setObjectOrder('amy', getObjectOrder('BADfloorback') - 1)
			setProperty('wall1.visible', true)
			setProperty('wall2.visible', true)
		    setProperty('canjumpindicator.x', 0)
            setProperty('boyfriend.stunned', true)
			doTweenX('dadbadending', 'dad', getProperty('dad.x') + 800, 1.4, 'quadIn')
			doTweenX('bfbadending', 'boyfriend', getProperty('boyfriend.x') - 800, 1.4, 'quadIn')
			runTimer('dadbadending1', 0.7)
		end
	end
	--goodfuture ending
	if curBeat == 670 then --metal goes into the sunset
		metalbadlydamaged = true
		setProperty('canhomingindicator.x', 0)
		doTweenX('dadbyelol', 'dad', getProperty('dad.x') - 800, 3, 'quadIn')
		playAnim('dad', 'tired', true)
		setProperty('dad.specialAnim', true)
	end
	if curBeat == 678 then
		setProperty('canjumpindicator.x', 0)
	end
	if curBeat == 682 then
		if getProperty('future.x') == 1 then
		stopscrolling = true
		setProperty('canjumpindicator.x', 0)
            setProperty('boyfriend.stunned', true)
	setProperty('amy.x', 2200)
	setProperty('amy.visible', true)
	playAnim('amy', 'happy', true)
	setProperty('sonicending.x', getProperty('boyfriend.x'))
	setProperty('sonicending.y', getProperty('boyfriend.y') - 40)
	setProperty('sonicending.visible', true)
	playAnim('sonicending', 'brake', true)
	setProperty('boyfriend.visible', false)
	setProperty('boyfriend.alpha', 0)
	end
end
end
	--
	if curBeat == 288 then
		deletePresent()
	end
	if curBeat == 418 then
		deletePast()
		if getProperty('future.x') == 0 then
			deleteGood()
		elseif getProperty('future.x') == 1 then
			deleteBad()
		end
	end
	if curBeat == 682 and getProperty('future.x') == 1 then
		stopscrolling = true
	end
end


function deletePresent()
	cancelTween('PRESENTspotlight1move1')
	cancelTween('PRESENTspotlight1move2')
	cancelTween('PRESENTspotlight2move1')
	cancelTween('PRESENTspotlight2move2')
	cancelTween('PRESENTspotlight3move1')
	cancelTween('PRESENTspotlight3move2')
	cancelTween('PRESENTspotlight4move1')
	cancelTween('PRESENTspotlight4move2')
	removeLuaSprite('PRESENTbg1', true)
	removeLuaSprite('PRESENTbg2', true)
	removeLuaSprite('PRESENTbg3', true)
	removeLuaSprite('PRESENTbg4', true)
	removeLuaSprite('PRESENTbg5', true)
	removeLuaSprite('PRESENTfloorback', true)
	removeLuaSprite('PRESENTfloorfront', true)
	removeLuaSprite('PRESENTspotlight1', true)
	removeLuaSprite('PRESENTspotlight2', true)
	removeLuaSprite('PRESENTspotlight3', true)
	removeLuaSprite('PRESENTspotlight4', true)
end

function deletePast()
	cancelTween('BADspotlight1move1')
	cancelTween('BADspotlight1move2')
	cancelTween('BADspotlight2move1')
	cancelTween('BADspotlight2move2')
	cancelTween('BADspotlight3move1')
	cancelTween('BADspotlight3move2')
	cancelTween('BADspotlight4move1')
	cancelTween('BADspotlight4move2')
	addLuaSprite('BADoverlay', true)
	addLuaSprite('BADleds1', true)
	addLuaSprite('BADleds2', true)
	addLuaSprite('BADleds3', true)
	addLuaSprite('BADbar1', true)
	addLuaSprite('BADbar2', true)
	addLuaSprite('BADbar3', true)
	addLuaSprite('BADfloorfront', true)
	addLuaSprite('BADfloorback', false)
	addLuaSprite('BADspotlight1', false)
	addLuaSprite('BADspotlight2', false)
	addLuaSprite('BADspotlight3', false)
	addLuaSprite('BADspotlight4', false)
	addLuaSprite('BADbg1', false)
	addLuaSprite('BADbg2', false)
	addLuaSprite('BADbg3', false)
	addLuaSprite('BADbg4', false)
	addLuaSprite('BADbg5', false)
end

function deleteBad()
				removeLuaSprite('metalending', true)
				removeLuaSprite('sonicbadending', true)
				removeLuaSprite('wall1', true)
				removeLuaSprite('wall2', true)
	removeLuaSprite('BADbg3', true)
	removeLuaSprite('PASTbg4', true)
	removeLuaSprite('PASTbg11', true)
	removeLuaSprite('PASTbg12', true)
	removeLuaSprite('PASTbg13', true)
	removeLuaSprite('PASTbg21', true)
	removeLuaSprite('PASTbg22', true)
	removeLuaSprite('PASTbg23', true)
	removeLuaSprite('PASTfloorback', true)
	removeLuaSprite('PASTfloorfront', true)
	removeLuaSprite('PASTbgelements', true)
end

function deleteGood()
	cancelTween('GOODspotlight1move1')
	cancelTween('GOODspotlight1move2')
	cancelTween('GOODspotlight2move1')
	cancelTween('GOODspotlight2move2')
	cancelTween('GOODspotlight3move1')
	cancelTween('GOODspotlight3move2')
	cancelTween('GOODspotlight4move1')
	cancelTween('GOODspotlight4move2')
	cancelTween('GOODfireworks1launch')
	cancelTween('GOODfireworks1sizeX')
	cancelTween('GOODfireworks1sizeY')
	cancelTween('GOODfirework1alpha1')
	cancelTween('GOODfirework1alpha2')
	cancelTween('GOODfireworks2launch')
	cancelTween('GOODfireworks2sizeX')
	cancelTween('GOODfireworks2sizeY')
	cancelTween('GOODfirework2alpha1')
	cancelTween('GOODfirework2alpha2')
	removeLuaSprite('GOODbg6', true)
	removeLuaSprite('GOODbg5', true)
	removeLuaSprite('GOODbg4', true)
	removeLuaSprite('GOODbg3', true)
	removeLuaSprite('GOODbg2', true)
	removeLuaSprite('GOODbg1', true)
	removeLuaSprite('GOODfloorback', true)
	removeLuaSprite('GOODspotlight1', true)
	removeLuaSprite('GOODspotlight2', true)
	removeLuaSprite('GOODspotlight3', true)
	removeLuaSprite('GOODspotlight4', true)
	removeLuaSprite('GOODfireworks1', true)
	removeLuaSprite('GOODfireworks2', true)
end
