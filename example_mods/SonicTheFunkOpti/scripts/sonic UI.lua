local newaccuracy = 0
local numnoteshit = 0
local sickCount = 0
local goodCount = 0
local badCount = 0
local shitCount = 0
local numnoteshit = 0
local missCount = 0

local timertime = 0.01
local secondcounter = 0
local minutecounter = 0
local timecounteractive = false
local timecountermultiplier = 1

function onSongStart()
	timecounteractive = true
end

function onCreate()
    setProperty('showComboNum', false)
    setProperty('showRating', false)
    setProperty('showCombo', false)
end

function onCreatePost()
	makeLuaSprite('countermultiplier') --
    makeGraphic('countermultiplier', 1, 1, 'ffffff') --0000ff
    setProperty('countermultiplier.alpha', 0)
    addLuaSprite('countermultiplier', false)
    setObjectCamera('countermultiplier', 'hud')
    setProperty('countermultiplier.x', 1)

	makeLuaSprite('newaccthing') --
    makeGraphic('newaccthing', 1, 1, 'ffffff') --0000ff
    setProperty('newaccthing.alpha', 0)
    addLuaSprite('newaccthing', false)
    setObjectCamera('newaccthing', 'hud')
    setProperty('newaccthing.x', 0) --1=hurt 0=not hurt

	makeLuaSprite('giveringz') --
    makeGraphic('giveringz', 1, 1, 'ffffff') --0000ff
    setProperty('giveringz.alpha', 0)
    addLuaSprite('giveringz', false)
    setObjectCamera('giveringz', 'hud')
    setProperty('giveringz.x', 0) --1=hit 0=not hit

	makeLuaSprite('sickhitindicator') --
    makeGraphic('sickhitindicator', 1, 1, 'ffffff') --0000ff
    setProperty('sickhitindicator.alpha', 0)
    addLuaSprite('sickhitindicator', false)
    setObjectCamera('sickhitindicator', 'hud')
    setProperty('sickhitindicator.x', 0) --1=hit 0=not hit

	makeLuaSprite('goodhitindicator') --
    makeGraphic('goodhitindicator', 1, 1, 'ffffff') --0000ff
    setProperty('goodhitindicator.alpha', 0)
    addLuaSprite('goodhitindicator', false)
    setObjectCamera('goodhitindicator', 'hud')
    setProperty('goodhitindicator.x', 0) --1=hit 0=not hit
	
	makeLuaSprite('shithitindicator') --
    makeGraphic('shithitindicator', 1, 1, 'ffffff') --0000ff
    setProperty('shithitindicator.alpha', 0)
    addLuaSprite('shithitindicator', false)
    setObjectCamera('shithitindicator', 'hud')
    setProperty('shithitindicator.x', 0) --1=hit 0=not hit

	setObjectOrder('iconP1', getObjectOrder('dadGroup') - 1)
	setObjectOrder('iconP2', getObjectOrder('dadGroup') - 1)

	makeAnimatedLuaSprite('ratingsNEW', 'ratings', 520, 450, true)
	addAnimationByPrefix('ratingsNEW', 'cool', 'cool', 24, false)
	addAnimationByPrefix('ratingsNEW', 'good', 'good', 24, false)
	addAnimationByPrefix('ratingsNEW', 'ehh', 'ehh', 24, false)
	addAnimationByPrefix('ratingsNEW', 'ouch', 'ouch', 24, false)
	addAnimationByPrefix('ratingsNEW', 'blank', 'blank', 24, false)
	setObjectCamera('ratingsNEW', 'HUD')
	addLuaSprite('ratingsNEW', true)
	playAnim('ratingsNEW', 'blank', false)
	
	combocounterNEW= 0
	makeLuaText('combocounter', combocounterNEW, 100, getProperty('ratingsNEW.x') + 140, getProperty('ratingsNEW.y') + 80)
	setTextSize('combocounter', 45)
	setTextBorder('combocounter', 5, '2d2b53')
	setTextColor('combocounter', 'ffffff')
	setTextFont('combocounter', 'Kimberley.ttf')
	addLuaText('combocounter', true)
	setProperty('combocounter.alpha', 0)

	ccY = getProperty('combocounter.y')
	ccX = getProperty('combocounter.x')

	if downscroll then
		makeLuaSprite('RINGUI1','UIring', 1100, 40)
		setObjectCamera('RINGUI1', 'hud')
		addLuaSprite('RINGUI1')
		setObjectOrder('RINGUI1', getObjectOrder('dadGroup') - 1)
	
		makeLuaSprite('RINGUI2','UIring', 150, 40)
		setObjectCamera('RINGUI2', 'hud')
		addLuaSprite('RINGUI2')
		setObjectOrder('RINGUI2', getObjectOrder('dadGroup') - 1)
	
		makeLuaText('SCOREUI', 'SCORE:', 1260, 0, 567)
		setTextSize('SCOREUI', 30)
		setTextBorder('SCOREUI', 4, '000000')
		setTextColor('SCOREUI', 'ffce5c')
		setTextFont('SCOREUI', 'TestDrive.ttf')
		addLuaText('SCOREUI', true)
		setObjectOrder('SCOREUI', getObjectOrder('dadGroup') - 1)
	
		makeLuaText('MISSESUI', 'MISSES:', 1260, 0, 20)
		setTextSize('MISSESUI', 30)
		setTextBorder('MISSESUI', 4, '000000')
		setTextColor('MISSESUI', 'ffce5c')
		setTextFont('MISSESUI', 'TestDrive.ttf')
		addLuaText('MISSESUI', true)
		setObjectOrder('MISSESUI', getObjectOrder('dadGroup') - 1)
	
		makeLuaText('ratingTxt', '0% (?)', 700, 280, 50)
		setTextBorder('ratingTxt', 5, '000000')
		setTextColor('ratingTxt', 'ffffff')
		setTextAlignment('ratingTxt', 'center')
		setTextSize('ratingTxt', 45)
		setTextFont('ratingTxt', 'TestDrive.ttf')
		addLuaText('ratingTxt', true)
		setObjectOrder('ratingTxt', getObjectOrder('dadGroup') - 1)

		makeLuaText('ratingTxt2', '0%', 700, 280, 96)
		setTextBorder('ratingTxt2', 4, '000000')
		setTextColor('ratingTxt2', 'ffffff')
		setTextAlignment('ratingTxt2', 'center')
		setTextSize('ratingTxt2', 30)
		setTextFont('ratingTxt2', 'TestDrive.ttf')
		addLuaText('ratingTxt2', true)
		setObjectOrder('ratingTxt2', getObjectOrder('dadGroup') - 1)
	
		makeLuaText('scoreTxt2', '0', 700, 280, 595)
		setTextBorder('scoreTxt2', 5, '000000')
		setTextColor('scoreTxt2', 'ffffff')
		setTextAlignment('scoreTxt2', 'center')
		setTextSize('scoreTxt2', 45)
		setTextFont('scoreTxt2', 'TestDrive.ttf')
		addLuaText('scoreTxt2', true)
		setObjectOrder('scoreTxt2', getObjectOrder('dadGroup') - 1)

		makeLuaSprite('TIMEICON', 'UItime', 480, 620)
		setObjectCamera('TIMEICON', 'hud')
		local timeiconscale = 0.7
		setProperty('TIMEICON.scale.x', timeiconscale)
		setProperty('TIMEICON.scale.y', timeiconscale)
		addLuaSprite('TIMEICON', true)
		setObjectOrder('TIMEICON', getObjectOrder('dadGroup') - 1)

		makeLuaText('TIMECOUNTER', ' 0', 700, 595, 653)
		setTextBorder('TIMECOUNTER', 5, '000000')
		setTextColor('TIMECOUNTER', 'ffffff')
		setTextAlignment('TIMECOUNTER', 'left')
		setTextSize('TIMECOUNTER', 45)
		setTextFont('TIMECOUNTER', 'TestDrive.ttf')
		addLuaText('TIMECOUNTER', true)
		setObjectOrder('TIMECOUNTER', getObjectOrder('dadGroup') - 1)
		setProperty('timeTxt.visible', false)
    else -- upscroll
		makeLuaSprite('RINGUI1','UIring', 1100, 600)
		setObjectCamera('RINGUI1', 'hud')
		addLuaSprite('RINGUI1')
		setObjectOrder('RINGUI1', getObjectOrder('dadGroup') - 1)
	
		makeLuaSprite('RINGUI2','UIring', 150, 600)
		setObjectCamera('RINGUI2', 'hud')
		addLuaSprite('RINGUI2')
		setObjectOrder('RINGUI2', getObjectOrder('dadGroup') - 1)
	
	
		makeLuaText('SCOREUI', 'SCORE:', 1260, 0, 80)
		setTextSize('SCOREUI', 30)
		setTextBorder('SCOREUI', 4, '000000')
		setTextColor('SCOREUI', 'ffce5c')
		setTextFont('SCOREUI', 'TestDrive.ttf')
		addLuaText('SCOREUI', true)
		setObjectOrder('SCOREUI', getObjectOrder('dadGroup') - 1)
	
		makeLuaText('MISSESUI', 'MISSES:', 1260, 0, 588)
		setTextSize('MISSESUI', 30)
		setTextBorder('MISSESUI', 4, '000000')
		setTextColor('MISSESUI', 'ffce5c')
		setTextFont('MISSESUI', 'TestDrive.ttf')
		addLuaText('MISSESUI', true)
		setObjectOrder('MISSESUI', getObjectOrder('dadGroup') - 1)
	
		makeLuaText('ratingTxt', '0% (?)', 700, 280, 620)
		setTextBorder('ratingTxt', 5, '000000')
		setTextColor('ratingTxt', 'ffffff')
		setTextAlignment('ratingTxt', 'center')
		setTextSize('ratingTxt', 45)
		setTextFont('ratingTxt', 'TestDrive.ttf')
		addLuaText('ratingTxt', true)
		setObjectOrder('ratingTxt', getObjectOrder('dadGroup') - 1)

		makeLuaText('ratingTxt2', '0% (?)', 700, 280, 665)
		setTextBorder('ratingTxt2', 4, '000000')
		setTextColor('ratingTxt2', 'ffffff')
		setTextAlignment('ratingTxt2', 'center')
		setTextSize('ratingTxt2', 30)
		setTextFont('ratingTxt2', 'TestDrive.ttf')
		addLuaText('ratingTxt2', true)
		setObjectOrder('ratingTxt2', getObjectOrder('dadGroup') - 1)
	
		makeLuaText('scoreTxt2', '0', 700, 280, 108)
		setTextBorder('scoreTxt2', 5, '000000')
		setTextColor('scoreTxt2', 'ffffff')
		setTextAlignment('scoreTxt2', 'center')
		setTextSize('scoreTxt2', 45)
		setTextFont('scoreTxt2', 'TestDrive.ttf')
		addLuaText('scoreTxt2', true)
		setObjectOrder('scoreTxt2', getObjectOrder('dadGroup') - 1)

	    makeLuaSprite('TIMEICON', 'UItime', 480, -10)
		setObjectCamera('TIMEICON', 'hud')
		local timeiconscale = 0.7
		setProperty('TIMEICON.scale.x', timeiconscale)
		setProperty('TIMEICON.scale.y', timeiconscale)
		addLuaSprite('TIMEICON', true)
		setObjectOrder('TIMEICON', getObjectOrder('dadGroup') - 1)

		makeLuaText('TIMECOUNTER', ' 0', 700, 595, 24)
		setTextBorder('TIMECOUNTER', 5, '000000')
		setTextColor('TIMECOUNTER', 'ffffff')
		setTextAlignment('TIMECOUNTER', 'left')
		setTextSize('TIMECOUNTER', 45)
		setTextFont('TIMECOUNTER', 'TestDrive.ttf')
		addLuaText('TIMECOUNTER', true)
		setObjectOrder('TIMECOUNTER', getObjectOrder('dadGroup') - 1)
		setProperty('timeTxt.visible', false)
	end

	setTextFont('botplayTxt', 'TestDrive.ttf')

	setProperty('botplayTxt.visible', false)
    setProperty('scoreTxt.visible', false)
    setProperty('timeBar.visible', false)
    setProperty('healthBar.bg.visible', false)
    setProperty('healthBar.visible', false)
end

function onUpdatePost(elapsed)
	--timer stuff
	timecountermultiplier = getProperty('countermultiplier.x')
	if timecounteractive then
		timertime = timertime + elapsed * timecountermultiplier
		local milliseconds = math.floor(timertime * 100)


		while timertime >= 1 do
		    secondcounter = secondcounter + 1
		    timertime = timertime - 1
		end

		if secondcounter >= 60 then
		    secondcounter = 0
			minutecounter = minutecounter + 1
		end
		if secondcounter < 10 then
			formattedseconds = '0'..secondcounter
		else
			formattedseconds = secondcounter
		end
		if milliseconds < 10 then
            formattedmilliseconds = '0' .. milliseconds
        else
            formattedmilliseconds = milliseconds
        end

    	setTextString('TIMECOUNTER', minutecounter..':'..formattedseconds..':'..formattedmilliseconds)
	end
	if getProperty('resultsscreen.x') == 1 then
		timecounteractive = false
	end
	--
	local formattedAccuracy = string.format("%.2f", newaccuracy) 
    

	setTextString('combocounter', combocounterNEW)
	setProperty('newaccthing.x', formattedAccuracy)
	setTextString('scoreTxt2', score)
	setTextString('ratingTxt', misses)
	setTextString('ratingTxt2', getProperty('newaccthing.x')..'%')

	setProperty('iconP1.x', 980)
	setProperty('iconP2.x', 30)

	if getProperty('sickhitindicator.x') ~= 0 then
		ratingAnim()
	    playAnim('ratingsNEW', 'cool', true)
		setTextColor('combocounter', '4e80cc')
		numnoteshit = numnoteshit + 1
        sickCount = sickCount + 1
        updateAccuracy()
		setProperty('sickhitindicator.x', 0)
	end
	if getProperty('goodhitindicator.x') ~= 0 then
		ratingAnim()
	    playAnim('ratingsNEW', 'good', true)
		setTextColor('combocounter', '32a376')
		numnoteshit = numnoteshit + 1
        goodCount = goodCount + 1
        updateAccuracy()
		setProperty('goodhitindicator.x', 0)
	end
	if getProperty('shithitindicator.x') ~= 0 then
		combocounterNEW = 0
        missCount = missCount + 1
        numnoteshit = numnoteshit + 1
        updateAccuracy()
		setProperty('shithitindicator.x', 0)
	end
end

function goodNoteHit(i)
    if not getProperty('notes.members['..i..'].isSustainNote') then
        local rating = getProperty('notes.members['..i..'].rating')
        registerNoteHit(rating)
    end
end

function noteMiss(i)
	combocounterNEW = 0
    if not getProperty('notes.members['..i..'].isSustainNote') then
        missCount = missCount + 1
        numnoteshit = numnoteshit + 1

        updateAccuracy()
    end
end

function registerNoteHit(rating)
    numnoteshit = numnoteshit + 1

    if rating == 'sick' then
		ratingAnim()
	    playAnim('ratingsNEW', 'cool', true)
		setTextColor('combocounter', '4e80cc')
        sickCount = sickCount + 1
    elseif rating == 'good' then
		ratingAnim()
	    playAnim('ratingsNEW', 'good', true)
		setTextColor('combocounter', '32a376')
        goodCount = goodCount + 1
    elseif rating == 'bad' then
		ratingAnim()
	    playAnim('ratingsNEW', 'ehh', true)
		setTextColor('combocounter', '7449bf')
        badCount = badCount + 1
    elseif rating == 'shit' then
		ratingAnim()
	    playAnim('ratingsNEW', 'ouch', true)
		setTextColor('combocounter', '9d0b77')
        shitCount = shitCount + 1
    end

    updateAccuracy()
end

function updateAccuracy()
    if numnoteshit > 0 then
        newaccuracy = ((sickCount * 100) + (goodCount * 67) + (badCount * 34) + (shitCount * 0) + (missCount * 0)) / numnoteshit
    else
        newaccuracy = 0
    end
end

function onEndSong()
	runTimer('resultsTimerSUI', 1)
end

function onTimerCompleted(tag)
	if tag == 'resultsTimerSUI' then
		setProperty('TIMEICON.visible', false)
		setProperty('TIMECOUNTER.visible', false)
		setProperty('SCOREUI.visible', false)
		setProperty('MISSESUI.visible', false)
		setProperty('ratingTxt.visible', false)
		setProperty('ratingTxt2.visible', false)
		setProperty('scoreTxt2.visible', false)
		setProperty('timeTxt.visible', false)
		setProperty('RINGUI1.visible', false)
		setProperty('RINGUI2.visible', false)
	end
	if tag == 'ratingfadeout' then
		doTweenAlpha('ratingalpha', 'ratingsNEW', 0, 1)
		doTweenAlpha('combocounteralpha', 'combocounter', 0, 1)
	end
end

function ratingAnim()
	combocounterNEW = combocounterNEW + 1
	runTimer('ratingfadeout', 1)
	cancelTween('ratingalpha')
	cancelTween('combocounteralpha')
	setProperty('ratingsNEW.alpha', 1)
	setProperty('combocounter.y', ccY + 20)
	doTweenY('combocounterin', 'combocounter', ccY, 0.5, 'cubeOut')
	if bouncevertical then
		setProperty('combocounter.alpha', 1)
		bouncevertical = false
		setProperty('ratingsNEW.angle', getRandomInt(-10, 10))
		doTweenAngle('ratingsNEWANGLE', 'ratingsNEW', 0, 0.5, 'cubeOut')
		setProperty('ratingsNEW.origin.x',100)
		setProperty('ratingsNEW.scale.x', 0.9)
		doTweenX('ratingsNEWTWEEN', 'ratingsNEW.scale', 1, 0.5, 'cubeOut')
		setProperty('ratingsNEW.origin.y',50)
		setProperty('ratingsNEW.scale.y', 1.1)
		doTweenY('ratingsNEWTWEEN2', 'ratingsNEW.scale', 1, 0.5, 'cubeOut')
	elseif not bouncevertical then
		setProperty('combocounter.alpha', 1)
		bouncevertical = true
		setProperty('ratingsNEW.angle', getRandomInt(-10, 10))
		doTweenAngle('ratingsNEWANGLE', 'ratingsNEW', 0, 0.5, 'cubeOut')
		setProperty('ratingsNEW.origin.x',100)
		setProperty('ratingsNEW.scale.x', 1.1)
		doTweenX('ratingsNEWTWEEN', 'ratingsNEW.scale', 1, 0.5, 'cubeOut')
		setProperty('ratingsNEW.origin.y',50)
		setProperty('ratingsNEW.scale.y', 0.9)
		doTweenY('ratingsNEWTWEEN2', 'ratingsNEW.scale', 1, 0.5, 'cubeOut')
	end
end



