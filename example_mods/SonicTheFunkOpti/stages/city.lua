local boppinz2 = true
function onCreate()
	--setProperty('gf.visible', false)
	--setProperty('dad.visible', false)
	--setProperty('boyfriend.visible', false)
	makeLuaSprite('sky', 'bgs/city/sky', -600, -400);
	setScrollFactor('sky', 0.5, 0.1);
	scaleObject('sky', 2,2)

	makeLuaSprite('bgbuildings','bgs/city/bg buildings',-720, -235)
	setScrollFactor('bgbuildings', 0.7, 0.6)
	scaleObject('bgbuildings', 2,2)

	makeLuaSprite('floor','bgs/city/street',-850, -200)
	setScrollFactor('floor', 0.9, 0.9);
	scaleObject('floor', 2,2)

	setScrollFactor('gf', 0.9, 0.9);
	setScrollFactor('dad', 0.9, 0.9);
	setScrollFactor('boyfriend', 0.9, 0.9);
	
	makeLuaSprite('gradient','bgs/city/gradient',-600, -50)
	setScrollFactor('gradient', 0.7, 0.7)
	setProperty('gradient.alpha', 0.5)
	scaleObject('gradient', 2,2)
	setBlendMode('gradient', 'add')

	addLuaSprite('sky', false);
	addLuaSprite('bgbuildings', false);
	addLuaSprite('floor', false);
	addLuaSprite('gradient', true);
	
	close(true); 
end