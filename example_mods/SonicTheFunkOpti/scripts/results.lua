local rankOrder = {L = 1, C = 2, B = 3, A = 4, S = 5, SS = 6}
local difficultylol = getDataFromSave('globalsave', 'lastDifficulty')

function onCreate()
    precacheMusic('resultsPre')
    --
    initSaveData('globalsave')
    --setDataFromSave('globalsave', 'lastSong', nil)
    makeLuaSprite('resultsscreen') --
    makeGraphic('resultsscreen', 1, 1, 'ffffff') --0000ff
    setProperty('resultsscreen.alpha', 0)
    addLuaSprite('resultsscreen', false)
    setObjectCamera('resultsscreen', 'hud')
    setProperty('resultsscreen.x', 0) --1=is on results screen 0=isn't on results screen
formattedsongname = songName

formattedsongname = string.gsub(formattedsongname, "(%a)([%w_]*)", function(first, rest)
    return string.upper(first) .. string.lower(rest)
end)

    if formattedsongname == "Break Down" then
        maxrings = 3
    elseif formattedsongname == "Unbound" then
        maxrings = 37
    elseif formattedsongname == "Rock Solid" then
        maxrings = 47
    elseif formattedsongname == "Ultimatum" then
        maxrings = 47
    elseif formattedsongname == "Blueprint" then
        maxrings = 88
    else
        maxrings = 999
    end
end

function resultsScreen()
    setProperty('canjumpindicator.x', 0)
    precacheMusic('resultsGood')
    precacheMusic('resultsBad')
    playMusic('resultsPre', 1, false)
    canconfirm = true
    doTweenAlpha('fadefaade', 'fadebgt', 0, 0.3)
    setProperty('boyfriend.visible', false)
    setProperty('dad.visible', false)
    setProperty('gf.visible', false)

    --hide HUD
    setProperty('TIMEICON.visible', false)
    setProperty('TIMECOUNTER.visible', false)
    setProperty('scoreTxt.visible', false)
    setProperty('timeBar.visible', false)
    setProperty('timeTxt.visible', false)
    --setObjectCamera('timeTxt', 'hud')wheel
    setProperty('timeBarBG.visible', false)
    setProperty('iconP1.visible', false)
    setProperty('healthBar.visible', false)
    setProperty('healthBarBG.visible', false)
    setProperty('iconP2.visible', false)

    --hide NOTES
    for i = 0,7 do
        noteTweenAlpha('notessAlpha'..i, i, 0, 0.01, 'quadInOut')
    end
    


    makeLuaSprite('bgresults1','results/bg1', -10, 0)
    setObjectCamera('bgresults1', 'hud')
    scaleObject('bgresults1', 2,2)
    addLuaSprite('bgresults1')

    makeLuaSprite('wheelbg')
    makeGraphic('wheelbg', 350, 800, '325dff') --325dff
    addLuaSprite('wheelbg', false)
    setObjectCamera('wheelbg', 'hud')
    setProperty('wheelbg.x', -400)
    doTweenX('wheelbgin', 'wheelbg', 0, 1, 'quadOut')

    makeLuaSprite('bgwheel','results/wheel', 50, 70)
    setObjectCamera('bgwheel', 'hud')
    addLuaSprite('bgwheel')
    scaleObject('bgwheel', 2,2)
    doTweenAngle('bgwheelangle', 'bgwheel', 360, 1, 'quadOut')
    setProperty('bgwheel.x', -600)
    doTweenX('bgwheelin', 'bgwheel', 50, 1, 'quadOut')

    makeLuaSprite('bgresults2','results/bg2', 310, 170)
    setObjectCamera('bgresults2', 'hud')
    addLuaSprite('bgresults2')
    doTweenX('bgresults2size', 'bgresults2.scale', 3, 0.01)
    doTweenY('bgresults2size2', 'bgresults2.scale', 3, 0.01)

    makeLuaSprite('ringsresults','results/rings', 630, 110)
    setObjectCamera('ringsresults', 'hud')
    addLuaSprite('ringsresults')

    makeAnimatedLuaSprite('ringcrown','results/crown', getProperty('ringsresults.x') - 40, getProperty('ringsresults.y') + 20)
    setObjectCamera('ringcrown', 'hud')
    currRings = tonumber(getProperty('ringcountindicator.x'))
    addAnimationByPrefix('ringcrown', 'empty', 'crowNEmpty', 24, false)
    addAnimationByPrefix('ringcrown', 'full', 'crown', 24, false)
    setProperty('ringcrown.visible', false)
    addLuaSprite('ringcrown', true)
    if currRings >= maxrings then
        playAnim('ringcrown', 'full', true)
    setProperty('ringcrown.alpha', 0)
    runTimer('ringcrownalphalol', 1)
    setProperty('ringcrown.visible', true)
    end

    
    makeLuaText('songtitle', ' '..formattedsongname..' ', 1200, 60, 30)
    if difficultylol == '' or difficultylol == nil then
    elseif difficultylol == '-easy' then
        setTextString('songtitle', ' '..formattedsongname..' (EASY) ')
    elseif difficultylol == '-encore' then
        setTextString('songtitle', ' '..formattedsongname..' (ENCORE) ')
    end
    setTextSize('songtitle', 45)
    setTextBorder('songtitle', 0, '000000')
    setTextColor('songtitle', 'ffffff')
    setTextFont('songtitle', 'Kimberley.ttf')
    addLuaText('songtitle', true)
    setTextAlignment('songtitle', 'right')
    setProperty('songtitle.x', getProperty('songtitle.x') + 650)
    doTweenX('songtitlein', 'songtitle', getProperty('songtitle.x') - 650, 1, 'cubeOut')

    makeLuaText('ringsresultsTxt', ' '..currRings..' / '..maxrings, 400, 920, 120)
    setTextSize('ringsresultsTxt', 55)
    setTextBorder('ringsresultsTxt', 5, '000000')
    setTextColor('ringsresultsTxt', 'ffffff')
    setTextFont('ringsresultsTxt', 'Kimberley.ttf')
    addLuaText('ringsresultsTxt', true)
    setTextAlignment('ringsresultsTxt', 'left')
    setProperty('ringsresults.x', getProperty('ringsresults.x') + 650)
    doTweenX('ringsresultsin', 'ringsresults', getProperty('ringsresults.x') - 650, 1, 'cubeOut')
    setProperty('ringsresultsTxt.x', getProperty('ringsresultsTxt.x') + 650)
    doTweenX('ringsresultsTxtin', 'ringsresultsTxt', getProperty('ringsresultsTxt.x') - 650, 1, 'cubeOut')
    runTimer('missesIN', 0.2)
    playSound('slide', 0.5)

    makeLuaSprite('missesresults','results/misses', 630, 200)
    setObjectCamera('missesresults', 'hud')
    addLuaSprite('missesresults')
    makeLuaText('missesresultsTxt', ' '.. misses, 400, 950, 210)
    setTextSize('missesresultsTxt', 55)
    setTextBorder('missesresultsTxt', 5, '000000')
    setTextColor('missesresultsTxt', 'ffffff')
    setTextFont('missesresultsTxt', 'Kimberley.ttf')
    addLuaText('missesresultsTxt', true)
    setTextAlignment('missesresultsTxt', 'left')
    setProperty('missesresults.visible', false)
    setProperty('missesresultsTxt.visible', false)

    makeLuaSprite('scoreresults','results/score', 630, 290)
    setObjectCamera('scoreresults', 'hud')
    addLuaSprite('scoreresults')
    makeLuaText('scoreresultsTxt', ' '..score, 400, 910, 300)
    setTextSize('scoreresultsTxt', 55)
    setTextBorder('scoreresultsTxt', 5, '000000')
    setTextColor('scoreresultsTxt', 'ffffff')
    setTextFont('scoreresultsTxt', 'Kimberley.ttf')
    addLuaText('scoreresultsTxt', true)
    setTextAlignment('scoreresultsTxt', 'left')
    setProperty('scoreresults.visible', false)
    setProperty('scoreresultsTxt.visible', false)

    makeLuaSprite('accuracyresults','results/accuracy', 630, 380)
    setObjectCamera('accuracyresults', 'hud')
    addLuaSprite('accuracyresults')
    makeLuaText('accuracyresultsTxt', ' '..accuracypercentresult ..'%', 400, 1010, 390)
    setTextSize('accuracyresultsTxt', 55)
    setTextBorder('accuracyresultsTxt', 5, '000000')
    setTextColor('accuracyresultsTxt', 'ffffff')
    setTextFont('accuracyresultsTxt', 'Kimberley.ttf')
    addLuaText('accuracyresultsTxt', true)
    setTextAlignment('accuracyresultsTxt', 'left')
    setProperty('accuracyresults.visible', false)
    setProperty('accuracyresultsTxt.visible', false)

    makeLuaSprite('rankresults','results/rank', 630, 480)
    setObjectCamera('rankresults', 'hud')
    addLuaSprite('rankresults')
    setProperty('rankresults.visible', false)

    

    makeAnimatedLuaSprite('rankresultsS','results/ranks', 1050, 480)
    addAnimationByPrefix('rankresultsS', 'SS', 'ranK SS', 24, false)
    addAnimationByPrefix('rankresultsS', 'S', 'rank s', 24, false)
    addAnimationByPrefix('rankresultsS', 'A', 'rank a', 24, false)
    addAnimationByPrefix('rankresultsS', 'B', 'rank b', 24, false)
    addAnimationByPrefix('rankresultsS', 'C', 'rank c', 24, false)
    addAnimationByPrefix('rankresultsS', 'L', 'rank l', 24, false)
    setObjectCamera('rankresultsS', 'hud')
    addLuaSprite('rankresultsS')
    setProperty('rankresultsS.visible', false)
    doTweenX('rankresultsSsize', 'rankresultsS.scale', 3, 0.1)
    doTweenY('rankresultsSsize2', 'rankresultsS.scale', 3, 0.1)
    
    if rankgiven == 'SS' then
        playAnim('rankresultsS', 'SS', true)
    elseif rankgiven == 'S' then
        playAnim('rankresultsS', 'S', true)
    elseif rankgiven == 'A' then
        playAnim('rankresultsS', 'A', true)
    elseif rankgiven == 'B' then
        playAnim('rankresultsS', 'B', true)
    elseif rankgiven == 'C' then
        playAnim('rankresultsS', 'C', true)
    elseif rankgiven == 'L' then
        playAnim('rankresultsS', 'L', true)
    end


    if luaSpriteExists('future') then
        local futureoffsetX = -180
        local futureoffsetY = 80
        scaleoffsetfuture = 0.7
        makeAnimatedLuaSprite('futureresult','bgs/stardust speedway/future logo', getProperty('rankresultsS.x') + futureoffsetX, getProperty('rankresultsS.y') + futureoffsetY)
        addAnimationByPrefix('futureresult', 'good', 'good future icon', 24, false)
        addOffset('futureresult', 'good', -40, 40)
        addAnimationByPrefix('futureresult', 'bad', 'bad future icon', 24, false)
        addOffset('futureresult', 'bad', 0, 0)
        if getProperty('future.x') == 1 then
            playAnim('futureresult', 'good', true)
        else
            playAnim('futureresult', 'bad', true)
        end
        setObjectCamera('futureresult', 'hud')
        addLuaSprite('futureresult')
        setProperty('futureresult.visible', false)

        
        doTweenX('futureresultsize', 'futureresult.scale', 3 * scaleoffsetfuture, 0.1)
        doTweenY('futureresultsize2', 'futureresult.scale', 3 * scaleoffsetfuture, 0.1)
    end

    SonicresultsoffsetX = -10
    SonicresultsoffsetY = 10
    makeAnimatedLuaSprite('sonicFalling', 'results/sonic/falling', 100 + SonicresultsoffsetX, -750 + SonicresultsoffsetY)
    addAnimationByPrefix('sonicFalling', 'falling', 'sonic fall', 24, false)
    addAnimationByIndices('sonicFalling', 'looping', 'sonic fall', '14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31', 24, true)
    setProperty('sonicFalling.visible', false)
    addLuaSprite('sonicFalling', true)
    scaleObject('sonicFalling', 2,2)
    setObjectCamera('sonicFalling', 'hud')
    runTimer('sonicfall', 0.5)
    
    
end

function onEndSong()
    accuracypercentresult = tonumber(getProperty('newaccthing.x'))
    if getProperty('deathindicator.x') == 0 then --1=dead 0=alive
        setProperty('resultsscreen.x', 1)
        canconfirm = false
        setProperty('canjumpindicator.x', 0)
        setProperty('canReset', false)
        setProperty('canPause', false)
        setProperty('boyfriend.stunned', true)
        runTimer('resultsScreenFADE', 1)

        makeLuaSprite('fadebgt')
        makeGraphic('fadebgt', 1920, 1080, '000000') --325dff
        setProperty('fadebgt.alpha', 0)
        addLuaSprite('fadebgt', false)
        setObjectCamera('fadebgt', 'camOther')
        doTweenAlpha('fadefaade', 'fadebgt', 1, 1)
    else
        --
    end
    if not confirmed then
        return Function_Stop
    end
end

function onTimerCompleted(tag)
    if tag == 'ringcrownalphalol' then
        doTweenAlpha('ringcrownalpha', 'ringcrown', 1, 0.6)
    end
    if tag == 'sonicfall' then
        setProperty('sonicFalling.visible', true)
        playAnim('sonicFalling', 'falling', true)
    end
    if tag == 'transouttimer' then
        confirmed = true
        --endSong()
        
        local namereformat = songName:gsub("%s+", "-"):lower()
        setProperty('ratingPercent', accuracypercentresult / 100)
        runHaxeCode('game.updateScore();')

        if not getPropertyFromClass('states.PlayState', 'chartingMode') then
        callMethodFromClass('backend.Highscore', 'saveScore', {songName, score, difficulty, rating})
        setDataFromSave('globalsave', 'lastSong', songName)
        local previousRank = getDataFromSave('globalsave', 'rank-' .. namereformat .. difficultylol, '???')
        if previousRank == '???' or rankOrder[rankgiven] > rankOrder[previousRank] then
            setDataFromSave('globalsave', 'rank-' .. namereformat .. difficultylol, rankgiven)
            
        end
        local previousScore = getDataFromSave('globalsave', 'score-' .. namereformat .. difficultylol, '???')
        if previousScore == '???' or score > previousScore then
            setDataFromSave('globalsave', 'score-' .. namereformat .. difficultylol, score)
        end
        local previousAcc = getDataFromSave('globalsave', 'acc-' .. namereformat .. difficultylol, '???')
        if previousAcc == '???' or tonumber(getProperty('newaccthing.x')) > previousAcc then
            setDataFromSave('globalsave', 'acc-' .. namereformat .. difficultylol, tonumber(getProperty('newaccthing.x')))
        end
        setPropertyFromClass('backend.Difficulty', 'list', {'normal'})
        end
        if getPropertyFromClass('states.PlayState', 'chartingMode') then
            restartSong()
        else
            loadSong('menu', 0)
        end
        if currRings >= maxrings then
            setDataFromSave('globalsave', 'crown-' .. namereformat .. difficultylol, true)
        end
    end
    if tag == 'resultsScreenFADE' then
        resultsScreen()
    end
    if tag == 'missesIN' then
        if not transitionstarted then
            playSound('slide', 0.5)
        end
        setProperty('missesresults.visible', true)
        setProperty('missesresultsTxt.visible', true)
        setProperty('missesresults.x', getProperty('missesresults.x') + 650)
        doTweenX('missesresultsin', 'missesresults', getProperty('missesresults.x') - 650, 1, 'cubeOut')
        setProperty('missesresultsTxt.x', getProperty('missesresultsTxt.x') + 650)
        doTweenX('missesresultsTxtin', 'missesresultsTxt', getProperty('missesresultsTxt.x') - 650, 1, 'cubeOut')   
        runTimer('scoreIN', 0.2) 
    end
    if tag == 'scoreIN' then
        if not transitionstarted then
            playSound('slide', 0.5)
        end
        setProperty('scoreresults.visible', true)
        setProperty('scoreresultsTxt.visible', true)
        setProperty('scoreresults.x', getProperty('scoreresults.x') + 650)
        doTweenX('scoreresultsin', 'scoreresults', getProperty('scoreresults.x') - 650, 1, 'cubeOut')
        setProperty('scoreresultsTxt.x', getProperty('scoreresultsTxt.x') + 650)
        doTweenX('scoreresultsTxtin', 'scoreresultsTxt', getProperty('scoreresultsTxt.x') - 650, 1, 'cubeOut')   
        runTimer('accuracyIN', 0.2) 
    end
    if tag == 'accuracyIN' then
        if not transitionstarted then
            playSound('slide', 0.5)
        end
        setProperty('accuracyresults.visible', true)
        setProperty('accuracyresultsTxt.visible', true)
        setProperty('accuracyresults.x', getProperty('accuracyresults.x') + 650)
        doTweenX('accuracyresultsin', 'accuracyresults', getProperty('accuracyresults.x') - 650, 1, 'cubeOut')
        setProperty('accuracyresultsTxt.x', getProperty('accuracyresultsTxt.x') + 650)
        doTweenX('accuracyresultsTxtin', 'accuracyresultsTxt', getProperty('accuracyresultsTxt.x') - 650, 1, 'cubeOut')   
        runTimer('rankIN', 0.2) 
    end
    if tag == 'rankIN' then
        if not transitionstarted then
            playSound('slide', 0.5)
        end
        setProperty('rankresults.visible', true)
        setProperty('rankresults.x', getProperty('rankresults.x') + 650)
        doTweenX('rankresultsin', 'rankresults', getProperty('rankresults.x') - 650, 1, 'cubeOut')
        runTimer('rankLETTERIN', 0.5) 
    end
    if tag == 'rankLETTERIN' then
        if not transitionstarted then
            playSound('rank', 0.8)
        end
        setProperty('rankresultsS.visible', true)
        setProperty('rankresultsS.alpha', 0)
        doTweenAlpha('rankresultsSalpha', 'rankresultsS', 1, 0.5)
        doTweenX('rankresultsSsize', 'rankresultsS.scale', 1, 0.8, 'bounceOut')
        doTweenY('rankresultsSsize2', 'rankresultsS.scale', 1, 0.8, 'bounceOut')
        runTimer('resultsmusic', 1.2)
        if luaSpriteExists('future') then
            runTimer('futuretimer', 1.4)
        end
    end
    if tag == 'futuretimer' then
        runTimer('futuresound', 0.2)
        setProperty('futureresult.visible', true)
        setProperty('futureresult.alpha', 0)
        doTweenAlpha('futureresultalpha', 'futureresult', 1, 0.5)
        doTweenX('futureresultsize', 'futureresult.scale', 1* scaleoffsetfuture, 0.8, 'bounceOut')
        doTweenY('futureresultsize2', 'futureresult.scale', 1* scaleoffsetfuture, 0.8, 'bounceOut')
    end
    if tag == 'futuresound' then
        playSound('coolHit', 0.7)
    end
    if tag == 'resultsmusic' then
        setProperty('sonicFalling.visible', false)
        if rankgiven == 'SS' or rankgiven == 'S' or rankgiven == 'A' then
        makeAnimatedLuaSprite('sonicS', 'results/sonic/S animation', 75 + SonicresultsoffsetX, 54 + SonicresultsoffsetY)
        addAnimationByPrefix('sonicS', 'S', 'sonic S animation', 24, false)
        playAnim('sonicS', 'S', false)
        addLuaSprite('sonicS', true)
        scaleObject('sonicS', 2,2)
        setObjectCamera('sonicS', 'hud')
    elseif rankgiven == 'B' then
        makeAnimatedLuaSprite('sonicA', 'results/sonic/A animation', 69 + SonicresultsoffsetX, 20 + SonicresultsoffsetY)
        addAnimationByPrefix('sonicA', 'A', 'sonic A animation', 24, false)
        playAnim('sonicA', 'A', false)
        addLuaSprite('sonicA', true)
        scaleObject('sonicA', 2,2)
        setObjectCamera('sonicA', 'hud')
    elseif rankgiven == 'C' then
        makeAnimatedLuaSprite('sonicC', 'results/sonic/C animation', 109 + SonicresultsoffsetX, 36 + SonicresultsoffsetY)
        addAnimationByPrefix('sonicC', 'C', 'sonic C animation', 24, false)
        playAnim('sonicC', 'C', false)
        scaleObject('sonicC', 2,2)
        addLuaSprite('sonicC', true)
        setObjectCamera('sonicC', 'hud')
    elseif rankgiven == 'L' then
        makeAnimatedLuaSprite('sonicL', 'results/sonic/L animation', -13 + SonicresultsoffsetX, 95 + SonicresultsoffsetY)
        addAnimationByPrefix('sonicL', 'L', 'sonic L animation', 24, false)
        addAnimationByIndices('sonicL', 'looping', 'sonic L animation', '20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41', 24, true)
        playAnim('sonicL', 'L', false)
        addLuaSprite('sonicL', true)
        scaleObject('sonicL', 2,2)
        setObjectCamera('sonicL', 'hud')
    end
        if rankgiven == 'C' or rankgiven == 'L' then
            if not transitionstarted then
                playMusic('resultsBad', 1, true)
            end
        else
            if not transitionstarted then
                playMusic('resultsGood', 1, true)
            end
        end
    end
end

function onTweenCompleted(tag)
    if tag == 'bgwheelangle' then
        setProperty('bgwheel.angle', 0)
        doTweenAngle('bgwheelangle', 'bgwheel', 360, 15)
    end
    if tag == 'bgresults2size' then
        doTweenX('bgresults2size22', 'bgresults2.scale', 2, 0.6, 'quadOut')
        doTweenY('bgresults2size222', 'bgresults2.scale', 2, 0.6, 'quadOut')
    end
end

local transitionstarted = false
function onUpdatePost()
    if not confirmed and canconfirm then
        if not transitionstarted then
            if (keyJustPressed('accept') or mouseClicked()) or keyJustPressed('back') then
                --if not getProperty('cpuControlled') then
                    setProperty('transInIndicator.x', 1)
                    runTimer('transouttimer', 1)
                    soundFadeOut(nil, 0.8, 0)
                    transitionstarted = true
                --else
                --    restartSong()
                --end
            end
        end
    end
    if misses == 0 and accuracypercentresult == 100 then 
        rankgiven = 'SS'
    elseif misses == 0 and accuracypercentresult < 100 and accuracypercentresult > 90 then 
        rankgiven = 'S'
    elseif accuracypercentresult > 90 then
        rankgiven = 'A'
    elseif accuracypercentresult > 80 then
        rankgiven = 'B'
    elseif accuracypercentresult > 65 then
        rankgiven = 'C'
    else
        rankgiven = 'L'
    end
    
        if getProperty('sonicFalling.animation.curAnim.name') == 'falling' and getProperty('sonicFalling.animation.curAnim.finished') == true then
            objectPlayAnimation('sonicFalling', 'looping', true)
        end
    if rankgiven == 'L' then
        if getProperty('sonicL.animation.curAnim.name') == 'L' and getProperty('sonicL.animation.curAnim.finished') == true then
            objectPlayAnimation('sonicL', 'looping', true)
        end
    end

end

