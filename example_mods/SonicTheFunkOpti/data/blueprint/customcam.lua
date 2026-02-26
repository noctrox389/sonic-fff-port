normalishcam = false
camchanged = false
function onCreatePost()
    setProperty('ringcountindicator.x', 1)
    defaultcamzoom = getProperty('defaultCamZoom')
    dadcamINTROX = getProperty('dad.x') + 700
    dadcamINTROY = getProperty('dad.y') + 100
    bfcamINTROX = getProperty('boyfriend.x') - 600
    bfcamINTROY = getProperty('boyfriend.y') + 10
    
    dadcamX = 400
    dadcamY = 380
    bfcamX = 620
    bfcamY = 470
    makeLuaSprite('customcamindicator') --
    makeGraphic('customcamindicator', 1, 1, 'ffffff') --0000ff
    setProperty('customcamindicator.alpha', 0)
    addLuaSprite('customcamindicator', false)
    setObjectCamera('customcamindicator', 'hud')
    setProperty('customcamindicator.x', 0) --1=active 0=not active

    makeLuaSprite('newcamlol') --
    makeGraphic('newcamlol', 0, 0, 'ffffff') --0000ff
    setProperty('newcamlol.alpha', 0)
    addLuaSprite('newcamlol', false)
    setObjectCamera('newcamlol', 'hud')
    setProperty('newcamlol.x', (dadcamINTROX + bfcamINTROX)/2)
    setProperty('newcamlol.y', (dadcamINTROY + bfcamINTROY)/2)--

    makeLuaSprite('redoverlay', nil, getProperty('gf.x') -800, -240)
    makeGraphic('redoverlay', screenWidth + 1300, screenHeight + 500, 'F63E51')
    setObjectCamera('redoverlay', 'cameraGame')
    setScrollFactor('redoverlay', 0, 0)
    addLuaSprite('redoverlay', true)
    setBlendMode('redoverlay', 'multiply')
    setProperty('redoverlay.visible', false)
    setProperty('redoverlay.alpha', 0)

    makeLuaSprite('eyeflash', 'eyeflash', getProperty('dad.x') + 595, getProperty('dad.y') - 450)
    addLuaSprite('eyeflash', true)
    setBlendMode('eyeflash', 'add')
    setProperty('eyeflash.visible', false)

    makeLuaSprite('metalgo', 'metalgo', 1305, 300)
    setProperty('metalgo.scale.x', 0.6)
    setProperty('metalgo.scale.y', 0.6)
    addLuaSprite('metalgo', true)
    setProperty('metalgo.visible', false)
end

newcamspeed = 1
tweentype1 = 'cubeOut'
tweentype2 = 'cubeIn'
tweentype3 = 'cubeInOut'
function onSongStart()
    setProperty('camGame.zoom', 1.1)
    doTweenZoom('camtweenlolzoom', 'camGame', 0.9, newcamspeed, tweentype1)
    setProperty('defaultCamZoom', 0.9)
    doTweenX('camtweenlolX', 'newcamlol', dadcamINTROX, newcamspeed, tweentype1)
    doTweenY('camtweenlolY', 'newcamlol', dadcamINTROY, newcamspeed, tweentype1)
end

function onUpdatePost()
    setProperty('cameraSpeed', 100)
    triggerEvent('Camera Follow Pos', getProperty('newcamlol.x'), getProperty('newcamlol.y')) 

    if normalishcam then
        if mustHitSection and not camchanged then
        doTweenX('changecamX', 'newcamlol', bfcamX, newcamspeed, tweentype1)
        doTweenY('changecamY', 'newcamlol',  bfcamY, newcamspeed, tweentype1)
        camchanged = true
        --setProperty('camindicator.x', bfcamX)
        --setProperty('camindicator.y', bfcamY)
    elseif not mustHitSection and camchanged then
        doTweenX('changecamX', 'newcamlol',  dadcamX, newcamspeed, tweentype1)
        doTweenY('changecamY', 'newcamlol',  dadcamY, newcamspeed, tweentype1)
        camchanged = false
        --setProperty('camindicator.x', dadcamX)
        --setProperty('camindicator.y', dadcamY)
    end
end
end

function onStepHit()
if getProperty('deathindicator.x') == 0 then
    if curStep == 32 then
        doTweenX('camtweenlolX', 'newcamlol', bfcamINTROX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', bfcamINTROY, newcamspeed, tweentype1)
    end
    if curStep == 64 then
        doTweenX('camtweenlolX', 'newcamlol', dadcamINTROX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', dadcamINTROY, newcamspeed, tweentype1)
    end
    if curStep == 96 then
        doTweenX('camtweenlolX', 'newcamlol', bfcamINTROX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', bfcamINTROY, newcamspeed, tweentype1)
    end
    if curStep == 104 then
        setProperty('redoverlay.visible', true)
        setProperty('redoverlay.alpha', 0)
        doTweenAlpha('redoverlayalpha', 'redoverlay', 1, 1.93, newcamspeed, 'expoIn')
        doTweenZoom('camtweenlolzoom', 'camGame', 1.2, 1.93, 'backIn')
        doTweenY('camtweenlolY', 'newcamlol', dadcamINTROY, 1.93, 'backIn')
        doTweenX('camtweenlolX', 'newcamlol', dadcamINTROX+200, 1.91, 'backIn')
    end
    if curStep == 126 then --126
        setProperty('metalgo.visible', true)
        doTweenX('metalgox', 'metalgo', 605, 0.22, tweentype1)
        setProperty('eyeflash.visible', true)
        doTweenAngle('eyeflashangle', 'eyeflash', 90, 0.44, 'expoOut')
    end
    if curStep == 128 then
        setProperty('metalgo.visible', false)
        setProperty('eyeflash.visible', false)
        setProperty('redoverlay.visible', false)
        doTweenZoom('camtweenlolzoom', 'newcamlol', defaultcamzoom, newcamspeed, tweentype1)
        setProperty('defaultCamZoom',defaultcamzoom)
        doTweenX('camtweenlolX', 'newcamlol', bfcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', bfcamY, newcamspeed, tweentype1)
    end
    if curStep == 224 then--value minus 12
        doTweenX('camtweenlolX', 'newcamlol', dadcamX - 100, 1.06, tweentype2)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY - 50, 1.06, tweentype2)
    end
    if curStep == 236 then 
        doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype1)
    end
    if curStep == 256 then
        doTweenX('camtweenlolX', 'newcamlol', bfcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', bfcamY, newcamspeed, tweentype1)
    end
    if curStep == 352 then
        doTweenX('camtweenlolX', 'newcamlol', dadcamX - 100, 1.06, tweentype2)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY - 50, 1.06, tweentype2)
    end
    if curStep == 364 then
        doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype1)
    end
    if curStep == 378 or curStep == 410 or curStep == 442 or curStep == 474 then
        doTweenX('camtweenlolX', 'newcamlol', bfcamX, newcamspeed, tweentype3)
        doTweenY('camtweenlolY', 'newcamlol', bfcamY, newcamspeed, tweentype3)
    end
    if curStep == 394 or curStep == 426 or curStep == 458 or curStep == 490 then
        doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype3)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype3)
    end
    if curStep == 384 then
        doTweenZoom('camtweenlolzoom', 'camGame', defaultcamzoom + 0.2, newcamspeed, tweentype1)
        setProperty('defaultCamZoom', defaultcamzoom + 0.2)
    end
    if curStep == 496 then
        doTweenZoom('camtweenlolzoom', 'camGame', defaultcamzoom + 0.4, 1.23, tweentype1)
        setProperty('defaultCamZoom', defaultcamzoom)
    end
    if curStep == 542 then
        doTweenX('camtweenlolX', 'newcamlol', bfcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', bfcamY, newcamspeed, tweentype1)
    end
    if curStep == 574 then
        doTweenX('camtweenlolX', 'newcamlol', (bfcamX + dadcamX)/2, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', (bfcamY + dadcamY)/2, newcamspeed, tweentype1)
    end
    if curStep == 616 then
        doTweenX('camtweenlolX', 'newcamlol', dadcamX - 100, 1.06, tweentype2)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY - 50, 1.06, tweentype2)
    end
    if curStep == 628 then
        doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype1)
    end
    if curStep == 630 then
        doTweenX('camtweenlolX', 'newcamlol', dadcamX - 80, 0.17, tweentype2)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY - 35, 0.17, tweentype2)
    end
    if curStep == 632 then
        doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype1)
    end
    if curStep == 638 then
        doTweenX('camtweenlolX', 'newcamlol', bfcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', bfcamY, newcamspeed, tweentype1)
    end
    if curStep == 670 then
        doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype1)
    end
    if curStep == 702 then
        doTweenX('camtweenlolX', 'newcamlol', (bfcamX + dadcamX)/2, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', (bfcamY + dadcamY)/2, newcamspeed, tweentype1)
    end
    if curStep == 766 then
        doTweenX('camtweenlolX', 'newcamlol', bfcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', bfcamY, newcamspeed, tweentype1)
    end
    if curStep == 798 then
        doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype1)
    end
    if curStep == 818 then
        doTweenX('camtweenlolX', 'newcamlol', dadcamX - 80, 0.17, tweentype2)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY - 35, 0.17, tweentype2)
    end
    if curStep == 820 then
        doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype1)
    end
    if curStep == 822 then
        doTweenX('camtweenlolX', 'newcamlol', dadcamX - 80, 0.17, tweentype2)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY - 35, 0.17, tweentype2)
    end
    if curStep == 824 then
        doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype1)
    end
    if curStep == 830 then
        doTweenX('camtweenlolX', 'newcamlol', (bfcamX + dadcamX)/2, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', (bfcamY + dadcamY)/2, newcamspeed, tweentype1)
    end
    if curStep == 862 then
        doTweenX('camtweenlolX', 'newcamlol', bfcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', bfcamY, newcamspeed, tweentype1)
    end
    if curStep == 880 then
        doTweenZoom('camtweenlolzoom', 'camGame', defaultcamzoom + 0.2, newcamspeed, tweentype1)
        setProperty('defaultCamZoom', defaultcamzoom + 0.2)
    end
    if curStep == 896 then
        doTweenZoom('camtweenlolzoom', 'camGame', defaultcamzoom, newcamspeed, tweentype1)
        setProperty('defaultCamZoom', defaultcamzoom)
    end
    if curStep == 888 then
        normalishcam = true
    end
    if curStep == 944 then
        normalishcam = false
    end
    if curStep == 950 then --hit it, 2 BEFORE
        doTweenX('camtweenlolX', 'newcamlol', dadcamX - 80, 0.17, tweentype2)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY - 35, 0.17, tweentype2)
    end
    if curStep == 952 then
        doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype1)
    end
    if curStep == 954 then
        doTweenX('camtweenlolX', 'newcamlol', dadcamX - 80, 0.17, tweentype2)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY - 35, 0.17, tweentype2)
    end
    if curStep == 956 then
        doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype1)
    end
    if curStep == 960 then
        normalishcam = true
    end
    if curStep == 1120 then
        normalishcam = false
    end
    if curStep == 1126 then
        doTweenX('camtweenlolX', 'newcamlol', dadcamX - 80, 0.17, tweentype2)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY - 35, 0.17, tweentype2)
    end
    if curStep == 1128 then
        doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype1)
    end
    if curStep == 1130 then
        doTweenX('camtweenlolX', 'newcamlol', dadcamX - 80, 0.17, tweentype2)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY - 35, 0.17, tweentype2)
    end
    if curStep == 1132 then
        doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype1)
    end
    if curStep == 1152 then
        doTweenZoom('camtweenlolzoom', 'camGame', defaultcamzoom + 0.2, newcamspeed, tweentype1)
        setProperty('defaultCamZoom', defaultcamzoom + 0.2)
    end
    if curStep == 1260 then
        doTweenZoom('camtweenlolzoom', 'camGame', defaultcamzoom, newcamspeed, tweentype1)
        setProperty('defaultCamZoom', defaultcamzoom)
    end
    if curStep == 1146 or curStep == 1178 then --1152, 384 - 378
        doTweenX('camtweenlolX', 'newcamlol', bfcamX, newcamspeed, tweentype3)
        doTweenY('camtweenlolY', 'newcamlol', bfcamY, newcamspeed, tweentype3)
    end
    if curStep == 1162 or curStep == 1194 then
        doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype3)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype3)
    end
    if curStep == 1310 then
        doTweenX('camtweenlolX', 'newcamlol', bfcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', bfcamY, newcamspeed, tweentype1)
    end
    --new hit it sect
    if curStep == 1384 then--value minus 10
        doTweenX('camtweenlolX', 'newcamlol', dadcamX - 100, 1.06, tweentype2)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY - 50, 1.06, tweentype2)
    end
    if curStep == 1393 then -- hit it pt2, 2 more than before
        doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype1)
    end
    if curStep == 1394 then --hit it, 2 BEFORE
        doTweenX('camtweenlolX', 'newcamlol', dadcamX - 80, 0.17, tweentype2)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY - 35, 0.17, tweentype2)
    end
    if curStep == 1396 then -- hit it pt2, 2 more than before
        doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype1)
    end
    if curStep == 1398 then --hit it, 2 BEFORE
        doTweenX('camtweenlolX', 'newcamlol', dadcamX - 80, 0.17, tweentype2)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY - 35, 0.17, tweentype2)
    end
    if curStep == 1400 then -- hit it pt2, 2 more than before
        doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype1)
    end
    if curStep == 1402 then --hit it, 2 BEFORE
        doTweenX('camtweenlolX', 'newcamlol', dadcamX - 80, 0.17, tweentype2)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY - 35, 0.17, tweentype2)
    end
    if curStep == 1404 then -- hit it pt2, 2 more than before
        doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype1)
    end
    if curStep == 1456 then --hit it, 2 BEFORE
        doTweenX('camtweenlolX', 'newcamlol', dadcamX - 80, 0.17, tweentype2)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY - 35, 0.17, tweentype2)
    end
    if curStep == 1457 then -- hit it pt2, 2 more than before
        doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype1)
    end
    if curStep == 1458 then --hit it, 2 BEFORE
        doTweenX('camtweenlolX', 'newcamlol', dadcamX - 80, 0.17, tweentype2)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY - 35, 0.17, tweentype2)
    end
    if curStep == 1460 then -- hit it pt2, 2 more than before
        doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype1)
    end
    if curStep == 1462 then --hit it, 2 BEFORE
        doTweenX('camtweenlolX', 'newcamlol', dadcamX - 80, 0.17, tweentype2)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY - 35, 0.17, tweentype2)
    end
    if curStep == 1464 then -- hit it pt2, 2 more than before
        doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype1)
    end
    if curStep == 1466 then --hit it, 2 BEFORE
        doTweenX('camtweenlolX', 'newcamlol', dadcamX - 80, 0.17, tweentype2)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY - 35, 0.17, tweentype2)
    end
    if curStep == 1468 then -- hit it pt2, 2 more than before
        doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype1)
    end
    if curStep == 1474 then
        doTweenX('camtweenlolX', 'newcamlol', bfcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', bfcamY, newcamspeed, tweentype1)
    end
    --new hit it sect
    if curStep == 1512 then--value minus 9
        doTweenX('camtweenlolX', 'newcamlol', dadcamX - 100, 1.06, tweentype2)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY - 50, 1.06, tweentype2)
    end
    if curStep == 1521 then -- hit it pt2, 2 more than before
        doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype1)
    end
    if curStep == 1522 then --hit it, 2 BEFORE
        doTweenX('camtweenlolX', 'newcamlol', dadcamX - 80, 0.17, tweentype2)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY - 35, 0.17, tweentype2)
    end
    if curStep == 1524 then -- hit it pt2, 2 more than before
        doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype1)
    end
    if curStep == 1526 then --hit it, 2 BEFORE
        doTweenX('camtweenlolX', 'newcamlol', dadcamX - 80, 0.17, tweentype2)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY - 35, 0.17, tweentype2)
    end
    if curStep == 1528 then -- hit it pt2, 2 more than before
        doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype1)
    end
    --new hit it sect
    if curStep == 1554 then --hit it, 2 BEFORE
        doTweenX('camtweenlolX', 'newcamlol', dadcamX - 80, 0.17, tweentype2)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY - 35, 0.17, tweentype2)
    end
    if curStep == 1556 then -- hit it pt2, 2 more than before
        doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype1)
    end
    if curStep == 1558 then --hit it, 2 BEFORE
        doTweenX('camtweenlolX', 'newcamlol', dadcamX - 80, 0.17, tweentype2)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY - 35, 0.17, tweentype2)
    end
    if curStep == 1560 then -- hit it pt2, 2 more than before
        doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype1)
    end
    --new hit it sect
    if curStep == 1591 then --hit it, 2 BEFORE
        doTweenX('camtweenlolX', 'newcamlol', dadcamX - 80, 0.17, tweentype2)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY - 35, 0.17, tweentype2)
    end
    if curStep == 1593 then -- hit it pt2, 2 more than before
        doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype1)
    end
    if curStep == 1594 then --hit it, 2 BEFORE
        doTweenX('camtweenlolX', 'newcamlol', dadcamX - 80, 0.17, tweentype2)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY - 35, 0.17, tweentype2)
    end
    if curStep == 1596 then -- hit it pt2, 2 more than before
        doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype1)
    end
    --new hit it sect
    if curStep == 1618 then --hit it, 2 BEFORE
        doTweenX('camtweenlolX', 'newcamlol', dadcamX - 80, 0.17, tweentype2)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY - 35, 0.17, tweentype2)
    end
    if curStep == 1620 then -- hit it pt2, 2 more than before
        doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype1)
    end
    if curStep == 1622 then --hit it, 2 BEFORE
        doTweenX('camtweenlolX', 'newcamlol', dadcamX - 80, 0.17, tweentype2)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY - 35, 0.17, tweentype2)
    end
    if curStep == 1624 then -- hit it pt2, 2 more than before
        doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype1)
    end
    --new hit it sect
    if curStep == 1634 then --hit it, 2 BEFORE
        doTweenX('camtweenlolX', 'newcamlol', dadcamX - 80, 0.17, tweentype2)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY - 35, 0.17, tweentype2)
    end
    if curStep == 1636 then -- hit it pt2, 2 more than before
        doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype1)
    end
    if curStep == 1638 then --hit it, 2 BEFORE
        doTweenX('camtweenlolX', 'newcamlol', dadcamX - 80, 0.17, tweentype2)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY - 35, 0.17, tweentype2)
    end
    if curStep == 1640 then -- hit it pt2, 2 more than before
        doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype1)
        doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype1)
    end
    --BAD FUTURE
    if getProperty('future.x') == 0 then
        if curStep == 1664 then
            doTweenZoom('camtweenlolzoom', 'camGame', defaultcamzoom + 0.2, newcamspeed, tweentype1)
            setProperty('defaultCamZoom', defaultcamzoom + 0.2)
        end
        if curStep == 1772 then
            doTweenZoom('camtweenlolzoom', 'camGame', defaultcamzoom, newcamspeed, tweentype1)
            setProperty('defaultCamZoom', defaultcamzoom)
        end
        if curStep == 1661 then
            doTweenX('camtweenlolX', 'newcamlol', bfcamX, newcamspeed, tweentype3)
            doTweenY('camtweenlolY', 'newcamlol', bfcamY, newcamspeed, tweentype3)
        end
        if curStep == 1676 then
            doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype3)
            doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype3)
        end
        if curStep == 1692 then
            doTweenX('camtweenlolX', 'newcamlol', bfcamX, newcamspeed, tweentype3)
            doTweenY('camtweenlolY', 'newcamlol', bfcamY, newcamspeed, tweentype3)
        end
        if curStep == 1707 then
            doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype3)
            doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype3)
        end
        if curStep == 1722 then
            doTweenX('camtweenlolX', 'newcamlol', bfcamX, newcamspeed, tweentype3)
            doTweenY('camtweenlolY', 'newcamlol', bfcamY, newcamspeed, tweentype3)
        end
        if curStep == 1738 then
            doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype3)
            doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype3)
        end
        if curStep == 1754 then
            doTweenX('camtweenlolX', 'newcamlol', bfcamX, newcamspeed, tweentype3)
            doTweenY('camtweenlolY', 'newcamlol', bfcamY, newcamspeed, tweentype3)
        end
        if curStep == 1920 then
            doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype1)
            doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype1)
        end
        if curStep == 1984 then
            doTweenX('camtweenlolX', 'newcamlol', bfcamX, newcamspeed, tweentype1)
            doTweenY('camtweenlolY', 'newcamlol', bfcamY, newcamspeed, tweentype1)
        end
        if curStep == 2048 then
            doTweenX('camtweenlolX', 'newcamlol', (dadcamX + bfcamX)/2, newcamspeed, tweentype1)
            doTweenY('camtweenlolY', 'newcamlol', (dadcamY + bfcamY)/2, newcamspeed, tweentype1)
        end
        if curStep == 2112 then
            doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype1)
            doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype1)
        end
        if curStep == 2176 then
            doTweenX('camtweenlolX', 'newcamlol', bfcamX, 1.4, tweentype3)
            doTweenY('camtweenlolY', 'newcamlol', bfcamY, 1.4, tweentype3)
        end
    end
    --GOOD FUTURE
    if getProperty('future.x') == 1 then
        if curStep == 2336 then
            doTweenZoom('camtweenlolzoom', 'camGame', defaultcamzoom + 0.2, newcamspeed, tweentype1)
            setProperty('defaultCamZoom', defaultcamzoom + 0.2)
        end
        if curStep == 2444 then
            doTweenZoom('camtweenlolzoom', 'camGame', defaultcamzoom, newcamspeed, tweentype1)
            setProperty('defaultCamZoom', defaultcamzoom)
        end
        if curStep == 2349 then
            doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype3)
            doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype3)
        end
        if curStep == 2365 then
            doTweenX('camtweenlolX', 'newcamlol', bfcamX, newcamspeed, tweentype3)
            doTweenY('camtweenlolY', 'newcamlol', bfcamY, newcamspeed, tweentype3)
        end
        if curStep == 2380 then
            doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype3)
            doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype3)
        end
        if curStep == 2396 then
            doTweenX('camtweenlolX', 'newcamlol', bfcamX, newcamspeed, tweentype3)
            doTweenY('camtweenlolY', 'newcamlol', bfcamY, newcamspeed, tweentype3)
        end
        if curStep == 2410 then
            doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype3)
            doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype3)
        end
        if curStep == 2426 then
            doTweenX('camtweenlolX', 'newcamlol', bfcamX, newcamspeed, tweentype3)
            doTweenY('camtweenlolY', 'newcamlol', bfcamY, newcamspeed, tweentype3)
        end
        if curStep == 2448 then
            doTweenX('camtweenlolX', 'newcamlol', bfcamX, newcamspeed, tweentype1)
            doTweenY('camtweenlolY', 'newcamlol', bfcamY, newcamspeed, tweentype1)
        end
        if curStep == 2592 then
            doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype1)
            doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype1)
        end
        if curStep == 2620 then
            doTweenX('camtweenlolX', 'newcamlol', bfcamX, newcamspeed, tweentype1)
            doTweenY('camtweenlolY', 'newcamlol', bfcamY, newcamspeed, tweentype1)
        end
        if curStep == 2656 then
            doTweenX('camtweenlolX', 'newcamlol', dadcamX, newcamspeed, tweentype1)
            doTweenY('camtweenlolY', 'newcamlol', dadcamY, newcamspeed, tweentype1)
        end
        if curStep == 2684 then
            doTweenX('camtweenlolX', 'newcamlol', bfcamX, newcamspeed, tweentype3)
            doTweenY('camtweenlolY', 'newcamlol', bfcamY, newcamspeed, tweentype3)
        end
    end
end
end

