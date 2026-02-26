spotlightspeed = 2
plat2offset = 50
function onCreate()
    setProperty('gf.visible', false)
    
	makeLuaSprite('sky', 'bgs/starlight/bg-sky', -500, -221)
	setScrollFactor('sky', 0.2, 0.2)
    scaleObject('sky',2,2)
	addLuaSprite('sky', false)

	makeLuaSprite('buildings', 'bgs/starlight/bg-buildings', -565, 332)
	setScrollFactor('buildings', 0.3, 0.4)
    scaleObject('buildings',2,2)
	addLuaSprite('buildings', false)

	makeLuaSprite('spotlight1', 'bgs/starlight/bg-spotlight', 84, 0)
	setScrollFactor('spotlight1', 0.3, 0.4)
	addLuaSprite('spotlight1', false)
    setBlendMode('spotlight1', 'add')
    setProperty('spotlight1.origin.y', 700)
    scaleObject('spotlight1',2,2)
    doTweenAngle('spotlight1move1', 'spotlight1', 70, spotlightspeed, 'quadInOut')


	makeLuaSprite('spotlight2', 'bgs/starlight/bg-spotlight', 800, 0)
	setScrollFactor('spotlight2', 0.3, 0.4)
    scaleObject('spotlight2',2,2)
	addLuaSprite('spotlight2', false)
    setBlendMode('spotlight2', 'add')
    setProperty('spotlight2.origin.y', 700)
    doTweenAngle('spotlight2move1', 'spotlight2', -60, spotlightspeed, 'quadInOut')

	makeLuaSprite('platform1', 'bgs/starlight/bg-platform1', -597, 108)
	setScrollFactor('platform1', 0.5, 0.7)
    scaleObject('platform1',2,2)
	addLuaSprite('platform1', false)

	makeLuaSprite('platform2', 'bgs/starlight/bg-platform2', 936 + plat2offset, 323)
	setScrollFactor('platform2', 0.5, 0.7)
    scaleObject('platform2',2,2)
	addLuaSprite('platform2', false)

	makeLuaSprite('platform3', 'bgs/starlight/bg-platform3', 1349, -101)
	setScrollFactor('platform3', 0.5, 0.7)
    scaleObject('platform3',2,2)
	addLuaSprite('platform3', false)

	makeAnimatedLuaSprite('bgring1', 'bgs/starlight/bg-ring', 1277 + plat2offset, 429)
	addAnimationByPrefix('bgring1', 'ring', 'ring', 24, true)
	addLuaSprite('bgring1', false)
    scaleObject('bgring1',2,2)
	setScrollFactor('bgring1', 0.5, 0.7)

	makeAnimatedLuaSprite('bgring2', 'bgs/starlight/bg-ring', 1247 + plat2offset, 509)
	addAnimationByPrefix('bgring2', 'ring', 'ring', 24, true)
	addLuaSprite('bgring2', false)
    scaleObject('bgring2',2,2)
	setScrollFactor('bgring2', 0.5, 0.7)

	makeAnimatedLuaSprite('bgring3', 'bgs/starlight/bg-ring', 1182 + plat2offset, 564)
	addAnimationByPrefix('bgring3', 'ring', 'ring', 24, true)
	addLuaSprite('bgring3', false)
    scaleObject('bgring3',2,2)
	setScrollFactor('bgring3', 0.5, 0.7)

	makeAnimatedLuaSprite('bgring4', 'bgs/starlight/bg-ring', 1102 + plat2offset, 584)
	addAnimationByPrefix('bgring4', 'ring', 'ring', 24, true)
	addLuaSprite('bgring4', false)
    scaleObject('bgring4',2,2)
	setScrollFactor('bgring4', 0.5, 0.7)

	makeLuaSprite('seesaw1', 'bgs/starlight/seesaw', 900, 250)
	addLuaSprite('seesaw1', false)
    scaleObject('seesaw1',2,2)
	setScrollFactor('seesaw1', 0.5, 0.7)
    setProperty('seesaw1.flipX', true)

	makeLuaSprite('seesaw2', 'bgs/starlight/seesaw', 350, 350)
	addLuaSprite('seesaw2', false)
    scaleObject('seesaw2',2,2)
	setScrollFactor('seesaw2', 0.5, 0.7)

	makeLuaSprite('floor', 'bgs/starlight/floor', -1111, 700)
	addLuaSprite('floor', false)
    scaleObject('floor',2,2)

    -- Floor lights 
    makeAnimatedLuaSprite('floorlight1', 'bgs/starlight/floor-lights',  823, 1009)
    addAnimationByPrefix('floorlight1', 'floorlight', 'floor light', 24, true)
    addLuaSprite('floorlight1', true)

    makeAnimatedLuaSprite('floorlight2', 'bgs/starlight/floor-lights',  593, 1009)
    addAnimationByPrefix('floorlight2', 'floorlight', 'floor light', 24, true)
    addLuaSprite('floorlight2', true)

    makeAnimatedLuaSprite('floorlight3', 'bgs/starlight/floor-lights',  348, 1009)
    addAnimationByPrefix('floorlight3', 'floorlight', 'floor light', 24, true)
    addLuaSprite('floorlight3', true)

    makeAnimatedLuaSprite('floorlight4', 'bgs/starlight/floor-lights',  203, 1009)
    addAnimationByPrefix('floorlight4', 'floorlight', 'floor light', 24, true)
    addLuaSprite('floorlight4', true)

    makeAnimatedLuaSprite('floorlight5', 'bgs/starlight/floor-lights',  -37, 1009)
    addAnimationByPrefix('floorlight5', 'floorlight', 'floor light', 24, true)
    addLuaSprite('floorlight5', true)

    makeAnimatedLuaSprite('floorlight6', 'bgs/starlight/floor-lights', -297, 1009)
    addAnimationByPrefix('floorlight6', 'floorlight', 'floor light', 24, true)
    addLuaSprite('floorlight6', true)

    makeAnimatedLuaSprite('floorlight7', 'bgs/starlight/floor-lights', -437, 1009)
    addAnimationByPrefix('floorlight7', 'floorlight', 'floor light', 24, true)
    addLuaSprite('floorlight7', true)

    makeAnimatedLuaSprite('floorlight8', 'bgs/starlight/floor-lights', -697, 1009)
    addAnimationByPrefix('floorlight8', 'floorlight', 'floor light', 24, true)
    addLuaSprite('floorlight8', true)

    makeAnimatedLuaSprite('floorlight9', 'bgs/starlight/floor-lights',  963, 1009)
    addAnimationByPrefix('floorlight9', 'floorlight', 'floor light', 24, true)
    addLuaSprite('floorlight9', true)

    makeAnimatedLuaSprite('floorlight10','bgs/starlight/floor-lights', 1203, 1009)
    addAnimationByPrefix('floorlight10', 'floorlight', 'floor light', 24, true)
    addLuaSprite('floorlight10', true)

    makeAnimatedLuaSprite('floorlight11','bgs/starlight/floor-lights', 1443, 1009)
    addAnimationByPrefix('floorlight11', 'floorlight', 'floor light', 24, true)
    addLuaSprite('floorlight11', true)

    makeAnimatedLuaSprite('floorlight12','bgs/starlight/floor-lights', 1583, 1009)
    addAnimationByPrefix('floorlight12', 'floorlight', 'floor light', 24, true)
    addLuaSprite('floorlight12', true)

    makeAnimatedLuaSprite('floorlight13','bgs/starlight/floor-lights', 1823, 1009)
    addAnimationByPrefix('floorlight13', 'floorlight', 'floor light', 24, true)
    addLuaSprite('floorlight13', true)

    makeAnimatedLuaSprite('floorlight14','bgs/starlight/floor-lights', 2083, 1009)
    addAnimationByPrefix('floorlight14', 'floorlight', 'floor light', 24, true)
    addLuaSprite('floorlight14', true)

    scaleObject('floorlight1',2,2)
    scaleObject('floorlight2',2,2)
    scaleObject('floorlight3',2,2)
    scaleObject('floorlight4',2,2)
    scaleObject('floorlight5',2,2)
    scaleObject('floorlight6',2,2)
    scaleObject('floorlight7',2,2)
    scaleObject('floorlight8',2,2)
    scaleObject('floorlight9',2,2)
    scaleObject('floorlight10',2,2)
    scaleObject('floorlight11',2,2)
    scaleObject('floorlight12',2,2)
    scaleObject('floorlight13',2,2)
    scaleObject('floorlight14',2,2)
    --

	makeLuaSprite('bush', 'bgs/starlight/bush', 550, 509)
    scaleObject('bush',2,2)
	addLuaSprite('bush', false)

	makeLuaSprite('fan', 'bgs/starlight/fan', 1635, 504)
    scaleObject('fan',2,2)
	addLuaSprite('fan', false)

	makeLuaSprite('streetsign', 'bgs/starlight/streetsign', -451, 484)
	addLuaSprite('streetsign', false)
    scaleObject('streetsign',2,2)

	makeAnimatedLuaSprite('lamppost1', 'bgs/starlight/lamppost', 143, 3)
	addAnimationByPrefix('lamppost1', 'lamppost', 'lamp post', 24, true)
    scaleObject('lamppost1',2,2)
	addLuaSprite('lamppost1', false)

	makeAnimatedLuaSprite('lamppost2', 'bgs/starlight/lamppost', 1343, 3)
	addAnimationByPrefix('lamppost2', 'lamppost', 'lamp post', 24, true)
    scaleObject('lamppost2',2,2)
	addLuaSprite('lamppost2', false)

	makeLuaSprite('fg-bush', 'bgs/starlight/fg-bush', 2300, 929)
	setScrollFactor('fg-bush', 1.8, 1.3)
    scaleObject('fg-bush',2,2)
	addLuaSprite('fg-bush', true)

	makeLuaSprite('fg-bars', 'bgs/starlight/fg-bars', -485, 787)
	setScrollFactor('fg-bars', 1.8, 1.3)
    scaleObject('fg-bars',2,2)
	addLuaSprite('fg-bars', true)
end


    function onTweenCompleted(tag)
        if tag == 'spotlight1move1' then
            doTweenAngle('spotlight1move2', 'spotlight1', -60, 2, 'quadInOut')
        end
        if tag == 'spotlight1move2' then
            doTweenAngle('spotlight1move1', 'spotlight1', 70, 2, 'quadInOut')
        end
        if tag == 'spotlight2move1' then
            doTweenAngle('spotlight2move2', 'spotlight2', 70, 2, 'quadInOut')
        end
        if tag == 'spotlight2move2' then
            doTweenAngle('spotlight2move1', 'spotlight2', -60, 2, 'quadInOut')
        end
    end