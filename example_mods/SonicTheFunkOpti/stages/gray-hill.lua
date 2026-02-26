local boppinz2 = true
function onCreate()
	setProperty('gf.visible', false)
	setProperty('gf.visible', false)
	--setProperty('dad.visible', false)
	--setProperty('boyfriend.visible', false)
	makeLuaSprite('sky', 'bgs/gray hill/sky', -700, -300);
	scaleObject('sky', 2,2)
	setScrollFactor('sky', 0.1, 0.1);

	makeLuaSprite('bgwater','bgs/gray hill/water',-600, 180)
	setScrollFactor('bgwater', 0.3, 0.2);
	scaleObject('bgwater', 2,2)

	makeLuaSprite('flowingwater1','bgs/gray hill/waterflow',-800, 460)
	setScrollFactor('flowingwater1', 0.3, 0.2);
	scaleObject('flowingwater1', 2,2)
	fw1 = getProperty('flowingwater1.x')

	makeLuaSprite('flowingwater2','bgs/gray hill/waterflow',-800, 490)
	setScrollFactor('flowingwater2', 0.3, 0.2);
	scaleObject('flowingwater2', 2,2)
	fw2 = getProperty('flowingwater2.x')
	
	makeLuaSprite('flowingwater3','bgs/gray hill/waterflow',-800, 520)
	setScrollFactor('flowingwater3', 0.3, 0.2);
	scaleObject('flowingwater3', 2,2)
	fw3 = getProperty('flowingwater3.x')

	makeLuaSprite('flowingwater4','bgs/gray hill/waterflow',-800, 550)
	setScrollFactor('flowingwater4', 0.3, 0.2);
	scaleObject('flowingwater4', 2,2)
	fw4 = getProperty('flowingwater4.x')

	makeAnimatedLuaSprite('waterfall1','bgs/gray hill/waterfall',-375, 350)
	addAnimationByPrefix('waterfall1', 'waterfall', 'waterfall', 24, true)
	setScrollFactor('waterfall1', 0.3, 0.2);
	scaleObject('waterfall1', 2,2)
	playAnim('waterfall1', 'waterfall')

	makeAnimatedLuaSprite('waterfall2','bgs/gray hill/waterfall',40, 350)
	addAnimationByPrefix('waterfall2', 'waterfall', 'waterfall', 24, true)
	setScrollFactor('waterfall2', 0.3, 0.2);
	scaleObject('waterfall2', 2,2)
	playAnim('waterfall2', 'waterfall')
	
	makeAnimatedLuaSprite('waterfall3','bgs/gray hill/waterfall',450, 350)
	addAnimationByPrefix('waterfall3', 'waterfall', 'waterfall', 24, true)
	setScrollFactor('waterfall3', 0.3, 0.2);
	scaleObject('waterfall3', 2,2)
	playAnim('waterfall3', 'waterfall')

	makeAnimatedLuaSprite('waterfall4','bgs/gray hill/waterfall',870, 350)
	addAnimationByPrefix('waterfall4', 'waterfall', 'waterfall', 24, true)
	setScrollFactor('waterfall4', 0.3, 0.2);
	scaleObject('waterfall4', 2,2)
	playAnim('waterfall4', 'waterfall')

	makeLuaSprite('bg1','bgs/gray hill/bg1',50,220)
	setScrollFactor('bg1', 0.5, 0.4);
	scaleObject('bg1', 2,2)

	makeLuaSprite('platform','bgs/gray hill/floating platform',200,300)
	setScrollFactor('platform', 0.5, 0.5);
	scaleObject('platform', 2,2)

	doTweenY('platformfloating1', 'platform', 450, 3, 'cubeInOut')


	makeLuaSprite('bg2','bgs/gray hill/bg2',-500,-50)
	setScrollFactor('bg2', 0.9, 0.8);
	scaleObject('bg2', 2,2)

	makeLuaSprite('floor','bgs/gray hill/floor',-850,650)
	setScrollFactor('floor', 1, 1);
	scaleObject('floor', 2,2)

	makeAnimatedLuaSprite('flower','bgs/gray hill/flower1',-480,500)
	addAnimationByPrefix('flower', 'flowerUp', 'flower1', 24, false)
	addOffset('flower', 'flowerUp', 0, 0)
	addAnimationByPrefix('flower','flowerDown','floweR12',24,false)
	addOffset('flower', 'flowerDown', 0, -29)
	scaleObject('flower', 2,2)
	setScrollFactor('flower', 1, 1);
	playAnim('flower', 'flowerUp', true)

	makeAnimatedLuaSprite('sunflower','bgs/gray hill/sunflower',1150,390)
	addAnimationByPrefix('sunflower', 'sunflower', 'flower2', 24, false)
	setScrollFactor('sunflower', 1, 1);
	scaleObject('sunflower', 2,2)

	addLuaSprite('sky', false);
	addLuaSprite('bgwater', false);
	addLuaSprite('flowingwater1', false);
	addLuaSprite('flowingwater2', false);
	addLuaSprite('flowingwater3', false);
	addLuaSprite('flowingwater4', false);
	addLuaSprite('waterfall1', false);
	addLuaSprite('waterfall2', false);
	addLuaSprite('waterfall3', false);
	addLuaSprite('waterfall4', false);
	addLuaSprite('bg1', false);
	addLuaSprite('platform', false);
	addLuaSprite('bg2', false);
	addLuaSprite('floor', false);
	addLuaSprite('flower', true);
	addLuaSprite('sunflower', true);
	doTweenX('flowing1', 'flowingwater1', fw1 + 185, 5)
	doTweenX('flowing2', 'flowingwater2', fw2 + 185, 4)
	doTweenX('flowing3', 'flowingwater3', fw3 + 185, 3)
	doTweenX('flowing4', 'flowingwater4', fw4 + 185, 2)
	
	--close(true); 
end

function onTweenCompleted(tag)
	if tag == 'flowing1' then
		setProperty('flowingwater1.x', fw1)
		doTweenX('flowing1', 'flowingwater1', fw1 + 185, 5)
	end
	if tag == 'flowing2' then
		setProperty('flowingwater2.x', fw2)
		doTweenX('flowing2', 'flowingwater2', fw2 + 185, 4)
	end
	if tag == 'flowing3' then
		setProperty('flowingwater3.x', fw2)
		doTweenX('flowing3', 'flowingwater3', fw3 + 185, 3)
	end
	if tag == 'flowing4' then
		setProperty('flowingwater4.x', fw2)
		doTweenX('flowing4', 'flowingwater4', fw4 + 185, 2)
	end

	if tag == 'platformfloating2' then
		doTweenY('platformfloating1', 'platform', 450, 3, 'quadInOut')
	end
	if tag == 'platformfloating1' then
		doTweenY('platformfloating2', 'platform', 300, 3, 'quadInOut')
	end
end


function onStepHit()
    if curStep % 4 == 0 then
		runTimer('boptimer', 0.5)
	end
end

function onTimerCompleted(tag)
	if tag == 'boptimer' then
		if boppinz2 then
			boppinz2 = false
			playAnim('flower', 'flowerUp', true)
			playAnim('sunflower', 'sunflower', true)
		else
			boppinz2 = true
			playAnim('flower', 'flowerDown', true)
		end
	end
end
