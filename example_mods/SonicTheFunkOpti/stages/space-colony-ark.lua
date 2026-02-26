local shaderName = "rimlight"

function onCreate()
    -- Background setup
    setProperty('gf.visible', false)

    makeLuaSprite('space', 'bgs/space colony ark/space', -435, -435)
    scaleObject('space', 1.9, 1.9)
    setScrollFactor('space', 0.15, 0.15)
    setProperty('space.antialiasing', true)
    setProperty('space.alpha', 1)
    addLuaSprite('space', false)

    makeLuaSprite('window', 'bgs/space colony ark/windows', -1066, -147)
    scaleObject('window', 2,2)
    setScrollFactor('window', 0.85, 1)
    setProperty('window.antialiasing', true)
    setProperty('window.alpha', 1)
    addLuaSprite('window', false)

    makeLuaSprite('floor', 'bgs/space colony ark/floor', -650, 749)
    scaleObject('floor', 2,2)
    setScrollFactor('floor', 1, 1)
    setProperty('floor.antialiasing', true)
    setProperty('floor.alpha', 1)
    addLuaSprite('floor', false)

    makeLuaSprite('tube', 'bgs/space colony ark/tube', -617, 673)
    scaleObject('tube', 2,2)
    setScrollFactor('tube', 0.95, 1)
    setProperty('tube.antialiasing', true)
    setProperty('tube.alpha', 1)
    addLuaSprite('tube', false)

    makeLuaSprite('gradient', 'bgs/space colony ark/gradient', -910, -185)
    scaleObject('gradient', 2,2)
    setScrollFactor('gradient', 1, 1)
    setProperty('gradient.antialiasing', true)
    setProperty('gradient.alpha', 0.5)
    addLuaSprite('gradient', false)
    setBlendMode('gradient', 'multiply')
end

function onCreatePost()
    -- Shader setup
    initLuaShader(shaderName)

    local targets = {'dad', 'boyfriend', 'BFBALL'}

    local rimColor = {0.5, 0.96, 1.0, 1.0}
    local distance = 10.0

    local angles = {
        dad = math.rad(320),
        boyfriend = math.rad(320),
        BFBALL = math.rad(320)
    }

    for _, obj in ipairs(targets) do
        setSpriteShader(obj, shaderName)
        setShaderFloatArray(obj, 'rimColor', rimColor)
        setShaderFloat(obj, 'rimAngle', angles[obj] or math.pi / 4)
        setShaderFloat(obj, 'rimDistance', distance)
    end
end
