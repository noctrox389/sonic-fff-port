function onCreatePost()
    nextpunch = 1
    timehit = 120/bpm --240

    value1 = 700
    value2 = 300

    missSound = 'OSUhit'
    missSoundVolume = '1'

    hitSound = 'OSUpunch'
    hitSoundVolume = '0.7'

---------------------- NOTE 1
    makeLuaSprite('OSUindicator1', 'osu/indicator', 100, 100)
    setObjectCamera('OSUindicator1', 'hud')
    addLuaSprite('OSUindicator1', true)
    setProperty('OSUindicator1.alpha', 0)
    doTweenX('OSUindicator1size', 'OSUindicator1.scale', 3, 0.01)
    doTweenY('OSUindicator1size2', 'OSUindicator1.scale', 3, 0.01)

    makeAnimatedLuaSprite('OSUnote1', 'osu/bumper', 100, 100)
    addAnimationByPrefix('OSUnote1', 'blank', 'bumperblank', 24, true)
    addAnimationByPrefix('OSUnote1', '1', 'bumper1', 24, true)
    addAnimationByPrefix('OSUnote1', '2', 'bumper2', 24, true)
    addAnimationByPrefix('OSUnote1', '3', 'bumper3', 24, true)
    addAnimationByPrefix('OSUnote1', '4', 'bumper4', 24, true)
    addAnimationByPrefix('OSUnote1', '5', 'bumper5', 24, true)
    playAnim('OSUnote1', 'blank')
    setObjectCamera('OSUnote1', 'hud')
    addLuaSprite('OSUnote1', true)
    setProperty('OSUnote1.alpha', 0)
    osu1active = false


---------------------- NOTE 2
    makeLuaSprite('OSUindicator2', 'osu/indicator', 100, 100)
    setObjectCamera('OSUindicator2', 'hud')
    addLuaSprite('OSUindicator2', true)
    setProperty('OSUindicator2.alpha', 0)
    doTweenX('OSUindicator2size', 'OSUindicator2.scale', 3, 0.01)
    doTweenY('OSUindicator2size2', 'OSUindicator2.scale', 3, 0.01)

    makeAnimatedLuaSprite('OSUnote2', 'osu/bumper', 100, 100)
    addAnimationByPrefix('OSUnote2', 'blank', 'bumperblank', 24, true)
    addAnimationByPrefix('OSUnote2', '1', 'bumper1', 24, true)
    addAnimationByPrefix('OSUnote2', '2', 'bumper2', 24, true)
    addAnimationByPrefix('OSUnote2', '3', 'bumper3', 24, true)
    addAnimationByPrefix('OSUnote2', '4', 'bumper4', 24, true)
    addAnimationByPrefix('OSUnote2', '5', 'bumper5', 24, true)
    playAnim('OSUnote2', 'blank')
    setObjectCamera('OSUnote2', 'hud')
    addLuaSprite('OSUnote2', true)
    setProperty('OSUnote2.alpha', 0)
    osu2active = false

---------------------- NOTE 3
    makeLuaSprite('OSUindicator3', 'osu/indicator', 100, 100)
    setObjectCamera('OSUindicator3', 'hud')
    addLuaSprite('OSUindicator3', true)
    setProperty('OSUindicator3.alpha', 0)
    doTweenX('OSUindicator3size', 'OSUindicator3.scale', 3, 0.01)
    doTweenY('OSUindicator3size2', 'OSUindicator3.scale', 3, 0.01)

    makeAnimatedLuaSprite('OSUnote3', 'osu/bumper', 100, 100)
    addAnimationByPrefix('OSUnote3', 'blank', 'bumperblank', 24, true)
    addAnimationByPrefix('OSUnote3', '1', 'bumper1', 24, true)
    addAnimationByPrefix('OSUnote3', '2', 'bumper2', 24, true)
    addAnimationByPrefix('OSUnote3', '3', 'bumper3', 24, true)
    addAnimationByPrefix('OSUnote3', '4', 'bumper4', 24, true)
    addAnimationByPrefix('OSUnote3', '5', 'bumper5', 24, true)
    playAnim('OSUnote3', 'blank')
    setObjectCamera('OSUnote3', 'hud')
    addLuaSprite('OSUnote3', true)
    setProperty('OSUnote3.alpha', 0)
    osu3active = false

---------------------- NOTE 4
    makeLuaSprite('OSUindicator4', 'osu/indicator', 100, 100)
    setObjectCamera('OSUindicator4', 'hud')
    addLuaSprite('OSUindicator4', true)
    setProperty('OSUindicator4.alpha', 0)
    doTweenX('OSUindicator4size', 'OSUindicator4.scale', 3, 0.01)
    doTweenY('OSUindicator4size2', 'OSUindicator4.scale', 3, 0.01)

    makeAnimatedLuaSprite('OSUnote4', 'osu/bumper', 100, 100)
    addAnimationByPrefix('OSUnote4', 'blank', 'bumperblank', 24, true)
    addAnimationByPrefix('OSUnote4', '1', 'bumper1', 24, true)
    addAnimationByPrefix('OSUnote4', '2', 'bumper2', 24, true)
    addAnimationByPrefix('OSUnote4', '3', 'bumper3', 24, true)
    addAnimationByPrefix('OSUnote4', '4', 'bumper4', 24, true)
    addAnimationByPrefix('OSUnote4', '5', 'bumper5', 24, true)
    playAnim('OSUnote4', 'blank')
    setObjectCamera('OSUnote4', 'hud')
    addLuaSprite('OSUnote4', true)
    setProperty('OSUnote4.alpha', 0)
    osu4active = false
end

function osuHit1() -- 
    osu1active = true
    doTweenAlpha('OSUnote1IN', 'OSUnote1', 1, 0.3)
    doTweenX('OSUnote1size', 'OSUnote1.scale', 1, 0.01)
    doTweenY('OSUnote1size2', 'OSUnote1.scale', 1, 0.01)
    OSUnote1hittable = true
    osunote1ishit = false
    hit1bad = true
    hit1sick = false
    hit1good = false

    runTimer('osuhit1good', timehit - timehit/4) --good indicator

    runTimer('osuhit1', timehit)
    doTweenAlpha('OSUindicator1Alpha', 'OSUindicator1', 1, timehit)
    doTweenX('OSUindicator1sizePRE', 'OSUindicator1.scale', 3, 0.01)
    doTweenY('OSUindicator1sizePRE2', 'OSUindicator1.scale', 3, 0.01)
end --
function osuHit2() -- 
    osu2active = true
    doTweenAlpha('OSUnote2IN', 'OSUnote2', 1, 0.3)
    doTweenX('OSUnote2size', 'OSUnote2.scale', 1, 0.01)
    doTweenY('OSUnote2size2', 'OSUnote2.scale', 1, 0.01)
    OSUnote2hittable = true
    osunote2ishit = false
    hit2bad = true
    hit2sick = false
    hit2good = false

    runTimer('osuhit2good', timehit - timehit/4) --good indicator

    runTimer('osuhit2', timehit)
    doTweenAlpha('OSUindicator2Alpha', 'OSUindicator2', 1, timehit)
    doTweenX('OSUindicator2sizePRE', 'OSUindicator2.scale', 3, 0.01)
    doTweenY('OSUindicator2sizePRE2', 'OSUindicator2.scale', 3, 0.01)
end --
function osuHit3() -- 
    osu3active = true
    doTweenAlpha('OSUnote3IN', 'OSUnote3', 1, 0.3)
    doTweenX('OSUnote3size', 'OSUnote3.scale', 1, 0.01)
    doTweenY('OSUnote3size2', 'OSUnote3.scale', 1, 0.01)
    OSUnote3hittable = true
    osunote3ishit = false
    hit3bad = true
    hit3sick = false
    hit3good = false

    runTimer('osuhit3good', timehit - timehit/4) --good indicator

    runTimer('osuhit3', timehit)
    doTweenAlpha('OSUindicator3Alpha', 'OSUindicator3', 1, timehit)
    doTweenX('OSUindicator3sizePRE', 'OSUindicator3.scale', 3, 0.01)
    doTweenY('OSUindicator3sizePRE2', 'OSUindicator3.scale', 3, 0.01)
end --
function osuHit4() -- 
    osu4active = true
    doTweenAlpha('OSUnote4IN', 'OSUnote4', 1, 0.3)
    doTweenX('OSUnote4size', 'OSUnote4.scale', 1, 0.01)
    doTweenY('OSUnote4size2', 'OSUnote4.scale', 1, 0.01)
    OSUnote4hittable = true
    osunote4ishit = false
    hit4bad = true
    hit4sick = false
    hit4good = false

    runTimer('osuhit4good', timehit - timehit/4) --good indicator

    runTimer('osuhit4', timehit)
    doTweenAlpha('OSUindicator4Alpha', 'OSUindicator4', 1, timehit)
    doTweenX('OSUindicator4sizePRE', 'OSUindicator4.scale', 3, 0.01)
    doTweenY('OSUindicator4sizePRE2', 'OSUindicator4.scale', 3, 0.01)
end --


function onTimerCompleted(tag)
--------------------- NOTE1
    if tag == 'osuhit1' then
        doTweenAlpha('OSUindicator1diss', 'OSUindicator1', 0, 0.3)
    end
    if tag == 'osuhit1good' then
        if osunote1ishit == false then
            hit1bad = false
            hit1good = true
            hit1sick = false
            runTimer('osuhit1sick', timehit/5) --
        end
    end
    if tag == 'osuhit1sick' then
        if osunote1ishit == false then
            hit1sick = true
            hit1good = false
            runTimer('osuhit1good2', timehit/5)
        end
    end
    if tag == 'osuhit1good2' then
        if osunote1ishit == false then
            hit1good = true
            hit1sick = false
            runTimer('osuhit1miss', timehit/5) --
        end
    end
    if tag == 'osuhit1miss' then
        if osunote1ishit == false then
            hit1good = false
            hit1sick = false
            hit1bad = true
            OSUnote1hittable = false
            doTweenAlpha('OSUnote1diss', 'OSUnote1', 0, 0.3)
            --animthing
            if getProperty('deathindicator.x') == 0 then
                playAnim('boyfriend', 'hurt', true)
                setProperty('boyfriend.specialAnim', true)
            end
            
        if osu1animation == 'hurt' then
            if nextpunch == 1 then
                playAnim('dad', 'punch1', true)
                nextpunch = 2
            elseif nextpunch == 2 then
                playAnim('dad', 'punch2', true)
                nextpunch = 1
            end
        else
            playAnim('dad', osu1animation, true)
        end
            setProperty('dad.specialAnim', true)
            --
            hitRegisteredMiss()
        end
    end
--------------------- NOTE2
    if tag == 'osuhit2' then
        doTweenAlpha('OSUindicator2diss', 'OSUindicator2', 0, 0.3)
    end
    if tag == 'osuhit2good' then
        if osunote2ishit == false then
            hit2bad = false
            hit2good = true
            hit2sick = false
            runTimer('osuhit2sick', timehit/5) --
        end
    end
    if tag == 'osuhit2sick' then
        if osunote2ishit == false then
            hit2sick = true
            hit2good = false
            runTimer('osuhit2good2', timehit/5)
        end
    end
    if tag == 'osuhit2good2' then
        if osunote2ishit == false then
            hit2good = true
            hit2sick = false
            runTimer('osuhit2miss', timehit/5) --
        end
    end
    if tag == 'osuhit2miss' then
        if osunote2ishit == false then
            hit2good = false
            hit2sick = false
            hit2bad = true
            OSUnote2hittable = false
            doTweenAlpha('OSUnote2diss', 'OSUnote2', 0, 0.3)
            --animthing
            if getProperty('deathindicator.x') == 0 then
                playAnim('boyfriend', 'hurt', true)
                setProperty('boyfriend.specialAnim', true)
            end
        if osu2animation == 'hurt' then
            if nextpunch == 1 then
                playAnim('dad', 'punch1', true)
                nextpunch = 2
            elseif nextpunch == 2 then
                playAnim('dad', 'punch2', true)
                nextpunch = 1
            end
        else
            playAnim('dad', osu2animation, true)
        end
            setProperty('dad.specialAnim', true)
            --
            hitRegisteredMiss()
        end
    end
--------------------- NOTE3
    if tag == 'osuhit3' then
        doTweenAlpha('OSUindicator3diss', 'OSUindicator3', 0, 0.3)
    end
    if tag == 'osuhit3good' then
        if osunote3ishit == false then
            hit3bad = false
            hit3good = true
            hit3sick = false
            runTimer('osuhit3sick', timehit/5) --
        end
    end
    if tag == 'osuhit3sick' then
        if osunote3ishit == false then
            hit3sick = true
            hit3good = false
            runTimer('osuhit3good2', timehit/5)
        end
    end
    if tag == 'osuhit3good2' then
        if osunote3ishit == false then
            hit3good = true
            hit3sick = false
            runTimer('osuhit3miss', timehit/5) --
        end
    end
    if tag == 'osuhit3miss' then
        if osunote3ishit == false then
            hit3good = false
            hit3sick = false
            hit3bad = true
            OSUnote3hittable = false
            doTweenAlpha('OSUnote3diss', 'OSUnote3', 0, 0.3)
            --animthing
            if getProperty('deathindicator.x') == 0 then
                playAnim('boyfriend', 'hurt', true)
                setProperty('boyfriend.specialAnim', true)
            end
        if osu3animation == 'hurt' then
            if nextpunch == 1 then
                playAnim('dad', 'punch1', true)
                nextpunch = 2
            elseif nextpunch == 2 then
                playAnim('dad', 'punch2', true)
                nextpunch = 1
            end
        else
            playAnim('dad', osu3animation, true)
        end
            setProperty('dad.specialAnim', true)
            --
            hitRegisteredMiss()
        end
    end
    
--------------------- NOTE4
    if tag == 'osuhit4' then
        doTweenAlpha('OSUindicator4diss', 'OSUindicator4', 0, 0.3)
    end
    if tag == 'osuhit4good' then
        if osunote4ishit == false then
            hit4bad = false
            hit4good = true
            hit4sick = false
            runTimer('osuhit4sick', timehit/5) --
        end
    end
    if tag == 'osuhit4sick' then
        if osunote4ishit == false then
            hit4sick = true
            hit4good = false
            runTimer('osuhit4good2', timehit/5)
        end
    end
    if tag == 'osuhit4good2' then
        if osunote4ishit == false then
            hit4good = true
            hit4sick = false
            runTimer('osuhit4miss', timehit/5) --
        end
    end
    if tag == 'osuhit4miss' then
        if osunote4ishit == false then
            hit4good = false
            hit4sick = false
            hit4bad = true
            OSUnote4hittable = false
            doTweenAlpha('OSUnote4diss', 'OSUnote4', 0, 0.3)
            --animthing
            if getProperty('deathindicator.x') == 0 then
                playAnim('boyfriend', 'hurt', true)
                setProperty('boyfriend.specialAnim', true)
            end
        if osu4animation == 'hurt' then
            if nextpunch == 1 then
                playAnim('dad', 'punch1', true)
                nextpunch = 2
            elseif nextpunch == 2 then
                playAnim('dad', 'punch2', true)
                nextpunch = 1
            end
        else
            playAnim('dad', osu4animation, true)
        end
            setProperty('dad.specialAnim', true)
            --
            hitRegisteredMiss()
        end
    end
end

function hitRegisteredGood()
    setProperty('goodhitindicator.x', 1)
    playSound(hitSound, hitSoundVolume)
    addScore(200)
end

function hitRegisteredSick()
    setProperty('sickhitindicator.x', 1)
    playSound(hitSound, hitSoundVolume)
    addScore(350)
end

function hitRegisteredMiss()
    setProperty('shithitindicator.x', 1)
    playSound(missSound, missSoundVolume)
    addMisses(1)
    addScore(-350)
    setProperty('hurtRing.x', 1)
end

function onUpdatePost(elapsed)
    if osu1active or osu2active or osu3active or osu4active then
        --setProperty('canjumpindicator.x', 0)
    else
        --setProperty('canjumpindicator.x', 1)
    end
    if not getProperty('cpuControlled') then
---------------------NOTE1
    if callMethodFromClass('flixel.FlxG', 'mouse.overlaps', {instanceArg('OSUnote1'), instanceArg('camHUD')}) and mouseClicked() and OSUnote1hittable == true then
        OSUnote1hittable = false
        OSUnote1ishit = true
        cancelTimer('osuhit1good')
        cancelTimer('osuhit1sick')
        cancelTimer('osuhit1good2')
        cancelTimer('osuhit1miss')

        cancelTween('OSUindicator1Alpha')
        cancelTween('OSUindicator1size')
        cancelTween('OSUindicator1size2')
        if getProperty('OSUindicator1.alpha') < 0.5 then
            doTweenAlpha('OSUindicator1diss', 'OSUindicator1', 0, 0.3)
        else
            doTweenAlpha('OSUindicator1diss', 'OSUindicator1', 0, 0.01)
        end
        doTweenAlpha('OSUnote1diss', 'OSUnote1', 0, 0.3)
        doTweenX('OSUnote1size', 'OSUnote1.scale', 1.3, 0.4, 'quadOut')
        doTweenY('OSUnote1size2', 'OSUnote1.scale', 1.3, 0.4, 'quadOut')
        if hit1good then
            hitRegisteredGood()
        elseif hit1sick then
            hitRegisteredSick()
        end
        osuAnimation1()
        
        if hit1bad then
            hitRegisteredMiss()
        end
    end
---------------------NOTE2
    if callMethodFromClass('flixel.FlxG', 'mouse.overlaps', {instanceArg('OSUnote2'), instanceArg('camHUD')}) and mouseClicked() and OSUnote2hittable == true then
        OSUnote2hittable = false
        OSUnote2ishit = true
        cancelTimer('osuhit2good')
        cancelTimer('osuhit2sick')
        cancelTimer('osuhit2good2')
        cancelTimer('osuhit2miss')
    
        cancelTween('OSUindicator2Alpha')
        cancelTween('OSUindicator2size')
        cancelTween('OSUindicator2size2')
        if getProperty('OSUindicator2.alpha') < 0.5 then
            doTweenAlpha('OSUindicator2diss', 'OSUindicator2', 0, 0.3)
        else
            doTweenAlpha('OSUindicator2diss', 'OSUindicator2', 0, 0.01)
        end
        doTweenAlpha('OSUnote2diss', 'OSUnote2', 0, 0.3)
        doTweenX('OSUnote2size', 'OSUnote2.scale', 1.3, 0.4, 'quadOut')
        doTweenY('OSUnote2size2', 'OSUnote2.scale', 1.3, 0.4, 'quadOut')
        if hit2good then
            hitRegisteredGood()
        elseif hit2sick then
            hitRegisteredSick()
        end
        osuAnimation2()
        if hit2bad then
            hitRegisteredMiss()
        end
    end
---------------------NOTE3
    if callMethodFromClass('flixel.FlxG', 'mouse.overlaps', {instanceArg('OSUnote3'), instanceArg('camHUD')}) and mouseClicked() and OSUnote3hittable == true then
        OSUnote3hittable = false
        OSUnote3ishit = true
        cancelTimer('osuhit3good')
        cancelTimer('osuhit3sick')
        cancelTimer('osuhit3good2')
        cancelTimer('osuhit3miss')

        cancelTween('OSUindicator3Alpha')
        cancelTween('OSUindicator3size')
        cancelTween('OSUindicator3size2')
        if getProperty('OSUindicator3.alpha') < 0.5 then
            doTweenAlpha('OSUindicator3diss', 'OSUindicator3', 0, 0.3)
        else
            doTweenAlpha('OSUindicator3diss', 'OSUindicator3', 0, 0.01)
        end
        doTweenAlpha('OSUnote3diss', 'OSUnote3', 0, 0.3)
        doTweenX('OSUnote3size', 'OSUnote3.scale', 1.3, 0.4, 'quadOut')
        doTweenY('OSUnote3size2', 'OSUnote3.scale', 1.3, 0.4, 'quadOut')
        if hit3good then
            hitRegisteredGood()
        elseif hit3sick then
            hitRegisteredSick()
        end
        osuAnimation3()
        if hit3bad then
            hitRegisteredMiss()
        end
    end
---------------------NOTE4
    if callMethodFromClass('flixel.FlxG', 'mouse.overlaps', {instanceArg('OSUnote4'), instanceArg('camHUD')}) and mouseClicked() and OSUnote4hittable == true then
        OSUnote4hittable = false
        OSUnote4ishit = true
        cancelTimer('osuhit4good')
        cancelTimer('osuhit4sick')
        cancelTimer('osuhit4good2')
        cancelTimer('osuhit4miss')
    
        cancelTween('OSUindicator4Alpha')
        cancelTween('OSUindicator4size')
        cancelTween('OSUindicator4size2')
        if getProperty('OSUindicator4.alpha') < 0.5 then
            doTweenAlpha('OSUindicator4diss', 'OSUindicator4', 0, 0.3)
        else
            doTweenAlpha('OSUindicator4diss', 'OSUindicator4', 0, 0.01)
        end
        doTweenAlpha('OSUnote4diss', 'OSUnote4', 0, 0.3)
        doTweenX('OSUnote4size', 'OSUnote4.scale', 1.3, 0.4, 'quadOut')
        doTweenY('OSUnote4size2', 'OSUnote4.scale', 1.3, 0.4, 'quadOut')
        if hit4good then
            hitRegisteredGood()
        elseif hit4sick then
            hitRegisteredSick()
        end
        osuAnimation4()
        if hit4bad then
            hitRegisteredMiss()
        end
    end
else
    if OSUnote1hittable == true and getProperty('OSUindicator1.alpha') >= 0.99 then
        OSUnote1hittable = false
        OSUnote1ishit = true
        cancelTimer('osuhit1good')
        cancelTimer('osuhit1sick')
        cancelTimer('osuhit1good2')
        cancelTimer('osuhit1miss')
        cancelTween('OSUindicator1Alpha')
        cancelTween('OSUindicator1size')
        cancelTween('OSUindicator1size2')
        doTweenAlpha('OSUnote1diss', 'OSUnote1', 0, 0.3)
        doTweenX('OSUnote1size', 'OSUnote1.scale', 1.3, 0.4, 'quadOut')
        doTweenY('OSUnote1size2', 'OSUnote1.scale', 1.3, 0.4, 'quadOut')
        doTweenAlpha('OSUindicator1diss', 'OSUindicator1', 0, 0.3)
        osuAnimation1()
        hitRegisteredSick()
    end
    if OSUnote2hittable == true and getProperty('OSUindicator2.alpha') >= 0.99 then
        OSUnote2hittable = false
        OSUnote2ishit = true
        cancelTimer('osuhit2good')
        cancelTimer('osuhit2sick')
        cancelTimer('osuhit2good2')
        cancelTimer('osuhit2miss')
        cancelTween('OSUindicator2Alpha')
        cancelTween('OSUindicator2size')
        cancelTween('OSUindicator2size2')
        doTweenAlpha('OSUnote2diss', 'OSUnote2', 0, 0.3)
        doTweenX('OSUnote2size', 'OSUnote2.scale', 1.3, 0.4, 'quadOut')
        doTweenY('OSUnote2size2', 'OSUnote2.scale', 1.3, 0.4, 'quadOut')
        doTweenAlpha('OSUindicator2diss', 'OSUindicator2', 0, 0.3)
        osuAnimation2()
        hitRegisteredSick()
    end
    if OSUnote3hittable == true and getProperty('OSUindicator3.alpha') >= 0.99 then
        OSUnote3hittable = false
        OSUnote3ishit = true
        cancelTimer('osuhit3good')
        cancelTimer('osuhit3sick')
        cancelTimer('osuhit3good2')
        cancelTimer('osuhit3miss')
        cancelTween('OSUindicator3Alpha')
        cancelTween('OSUindicator3size')
        cancelTween('OSUindicator3size2')
        doTweenAlpha('OSUnote3diss', 'OSUnote3', 0, 0.3)
        doTweenX('OSUnote3size', 'OSUnote3.scale', 1.3, 0.4, 'quadOut')
        doTweenY('OSUnote3size2', 'OSUnote3.scale', 1.3, 0.4, 'quadOut')
        doTweenAlpha('OSUindicator3diss', 'OSUindicator3', 0, 0.3)
        osuAnimation3()
        hitRegisteredSick()
    end
    if OSUnote4hittable == true and getProperty('OSUindicator4.alpha') >= 0.99 then
        OSUnote4hittable = false
        OSUnote4ishit = true
        cancelTimer('osuhit4good')
        cancelTimer('osuhit4sick')
        cancelTimer('osuhit4good2')
        cancelTimer('osuhit4miss')
        cancelTween('OSUindicator4Alpha')
        cancelTween('OSUindicator4size')
        cancelTween('OSUindicator4size2')
        doTweenAlpha('OSUnote4diss', 'OSUnote4', 0, 0.3)
        doTweenX('OSUnote4size', 'OSUnote4.scale', 1.3, 0.4, 'quadOut')
        doTweenY('OSUnote4size2', 'OSUnote4.scale', 1.3, 0.4, 'quadOut')
        doTweenAlpha('OSUindicator4diss', 'OSUindicator4', 0, 0.3)
        osuAnimation4()
        hitRegisteredSick()
    end
end
end

function osuAnimation1()
    if hit1good or hit1sick then
        if osu1animation ~= '' then
            playAnim('boyfriend', osu1bfanimation, true)
            setProperty('boyfriend.specialAnim', true)
            playAnim('dad', osu1animation, true)
            setProperty('dad.specialAnim', true)
        end
    elseif hit1bad then
        playAnim('boyfriend', 'hurt', true)
        setProperty('boyfriend.specialAnim', true)
        if osu1animation == 'hurt' then
            if nextpunch == 1 then
                playAnim('dad', 'punch1', true)
                nextpunch = 2
            elseif nextpunch == 2 then
                playAnim('dad', 'punch2', true)
                nextpunch = 1
            end
        else
            playAnim('dad', osu1animation, true)
        end
        setProperty('dad.specialAnim', true)
    end
end

function osuAnimation2()
    if hit2good or hit2sick then
        if osu2animation ~= '' then
            playAnim('boyfriend', osu2bfanimation, true)
            setProperty('boyfriend.specialAnim', true)
            playAnim('dad', osu2animation, true)
            setProperty('dad.specialAnim', true)
        end
    elseif hit2bad then
        playAnim('boyfriend', 'hurt', true)
        setProperty('boyfriend.specialAnim', true)
        if osu2animation == 'hurt' then
            if nextpunch == 1 then
                playAnim('dad', 'punch1', true)
                nextpunch = 2
            elseif nextpunch == 2 then
                playAnim('dad', 'punch2', true)
                nextpunch = 1
            end
        else
            playAnim('dad', osu2animation, true)
        end
        setProperty('dad.specialAnim', true)
    end
end

function osuAnimation3()
    if hit3good or hit3sick then
        if osu3animation ~= '' then
            playAnim('boyfriend', osu3bfanimation, true)
            setProperty('boyfriend.specialAnim', true)
            playAnim('dad', osu3animation, true)
            setProperty('dad.specialAnim', true)
        end
    elseif hit3bad then
        playAnim('boyfriend', 'hurt', true)
        setProperty('boyfriend.specialAnim', true)
        if osu3animation == 'hurt' then
            if nextpunch == 1 then
                playAnim('dad', 'punch1', true)
                nextpunch = 2
            elseif nextpunch == 2 then
                playAnim('dad', 'punch2', true)
                nextpunch = 1
            end
        else
            playAnim('dad', osu3animation, true)
        end
        setProperty('dad.specialAnim', true)
    end
end

function osuAnimation4()
    if hit4good or hit4sick then
        if osu4animation ~= '' then
            playAnim('boyfriend', osu4bfanimation, true)
            setProperty('boyfriend.specialAnim', true)
            playAnim('dad', osu4animation, true)
            setProperty('dad.specialAnim', true)
        end
    elseif hit4bad then
        playAnim('boyfriend', 'hurt', true)
        setProperty('boyfriend.specialAnim', true)
        if osu4animation == 'hurt' then
            if nextpunch == 1 then
                playAnim('dad', 'punch1', true)
                nextpunch = 2
            elseif nextpunch == 2 then
                playAnim('dad', 'punch2', true)
                nextpunch = 1
            end
        else
            playAnim('dad', osu4animation, true)
        end
        setProperty('dad.specialAnim', true)
    end
end

function onTweenCompleted(tag)

    if tag == 'OSUnote1diss' then
        osu1active = false
    end
    if tag == 'OSUindicator1sizePRE' then
        doTweenX('OSUindicator1size', 'OSUindicator1.scale', 1, timehit)
        doTweenY('OSUindicator1size2', 'OSUindicator1.scale', 1, timehit)
    end
    
    if tag == 'OSUnote2diss' then
        osu2active = false
    end
    if tag == 'OSUindicator2sizePRE' then
        doTweenX('OSUindicator2size', 'OSUindicator2.scale', 1, timehit)
        doTweenY('OSUindicator2size2', 'OSUindicator2.scale', 1, timehit)
    end
    
    if tag == 'OSUnote3diss' then
        osu3active = false
    end
    if tag == 'OSUindicator3sizePRE' then
        doTweenX('OSUindicator3size', 'OSUindicator3.scale', 1, timehit)
        doTweenY('OSUindicator3size2', 'OSUindicator3.scale', 1, timehit)
    end
    
    if tag == 'OSUnote4diss' then
        osu4active = false
    end
    if tag == 'OSUindicator4sizePRE' then
        doTweenX('OSUindicator4size', 'OSUindicator4.scale', 1, timehit)
        doTweenY('OSUindicator4size2', 'OSUindicator4.scale', 1, timehit)
    end
end

function onEvent(name, value1, value2)
    if getProperty('eventsindicator.x') == 1 or getProperty('eventsindicator.x') == nil then
    if name == 'OSU' then
        local splitv1 = stringSplit(value1, ',')
        local splitv2 = stringSplit(value2, ',')
        firstvalue = splitv1[1]
        secondvalue = splitv1[2]
        thirdvalue = splitv2[1]
        fourthvalue = splitv2[2]
        if osu1active == false then
            setProperty('OSUnote1.x', firstvalue)
            setProperty('OSUnote1.y', secondvalue)
            setProperty('OSUindicator1.x', firstvalue)
            setProperty('OSUindicator1.y', secondvalue)
            if thirdvalue ~= '' then
                playAnim('OSUnote1', thirdvalue, true)
            else
                playAnim('OSUnote1', 'blank', true)
            end
            if fourthvalue == ' 1' then
                osu1animation = 'punch1'
                osu1bfanimation = 'dodge1'
            elseif fourthvalue == ' 2' then
                osu1animation = 'punch2'
                osu1bfanimation = 'dodge2'
            elseif fourthvalue == ' 3' then
                osu1animation = 'hurt'
                osu1bfanimation = 'punch2'
            elseif fourthvalue == ' 4' then
                osu1animation = 'hurt'
                osu1bfanimation = 'punch1'
            else
                osu1animation = ''
                osu1bfanimation = ''
            end
            osuHit1()
        elseif osu2active == false then
            setProperty('OSUnote2.x', firstvalue)
            setProperty('OSUnote2.y', secondvalue)
            setProperty('OSUindicator2.x', firstvalue)
            setProperty('OSUindicator2.y', secondvalue)
            if thirdvalue ~= '' then
                playAnim('OSUnote2', thirdvalue, true)
            else
                playAnim('OSUnote2', 'blank', true)
            end
            if fourthvalue == ' 1' then
                osu2animation = 'punch1'
                osu2bfanimation = 'dodge1'
            elseif fourthvalue == ' 2' then
                osu2animation = 'punch2'
                osu2bfanimation = 'dodge2'
            elseif fourthvalue == ' 3' then
                osu2animation = 'hurt'
                osu2bfanimation = 'punch2'
            elseif fourthvalue == ' 4' then
                osu2animation = 'hurt'
                osu2bfanimation = 'punch1'
            else
                osu2animation = ''
                osu2bfanimation = ''
            end
            osuHit2()
        elseif osu3active == false then
            setProperty('OSUnote3.x', firstvalue)
            setProperty('OSUnote3.y', secondvalue)
            setProperty('OSUindicator3.x', firstvalue)
            setProperty('OSUindicator3.y', secondvalue)
            if thirdvalue ~= '' then
                playAnim('OSUnote3', thirdvalue, true)
            else
                playAnim('OSUnote3', 'blank', true)
            end
            if fourthvalue == ' 1' then
                osu3animation = 'punch1'
                osu3bfanimation = 'dodge1'
            elseif fourthvalue == ' 2' then
                osu3animation = 'punch2'
                osu3bfanimation = 'dodge2'
            elseif fourthvalue == ' 3' then
                osu3animation = 'hurt'
                osu3bfanimation = 'punch2'
            elseif fourthvalue == ' 4' then
                osu3animation = 'hurt'
                osu3bfanimation = 'punch1'
            else
                osu3animation = ''
                osu3bfanimation = ''
            end
            osuHit3()
        elseif osu4active == false then
            setProperty('OSUnote4.x', firstvalue)
            setProperty('OSUnote4.y', secondvalue)
            setProperty('OSUindicator4.x', firstvalue)
            setProperty('OSUindicator4.y', secondvalue)
            if thirdvalue ~= '' then
                playAnim('OSUnote4', thirdvalue, true)
            else
                playAnim('OSUnote4', 'blank', true)
            end
            if fourthvalue == ' 1' then
                osu4animation = 'punch1'
                osu4bfanimation = 'dodge1'
            elseif fourthvalue == ' 2' then
                osu4animation = 'punch2'
                osu4bfanimation = 'dodge2'
            elseif fourthvalue == ' 3' then
                osu4animation = 'hurt'
                osu4bfanimation = 'punch2'
            elseif fourthvalue == ' 4' then
                osu4animation = 'hurt'
                osu4bfanimation = 'punch1'
            else
                osu4animation = ''
                osu4bfanimation = ''
            end
            osuHit4()
        end
    end
end
end