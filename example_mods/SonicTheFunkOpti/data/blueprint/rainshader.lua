local rainTimeScale = 0
local rainEnabled = false
local rainIntensity = 0.3
local rainShaderExists = false

if lowQuality then
    function onCreate() close(true) end
    return
end


function createRain()
    if rainShaderExists then return end
    rainShaderExists = true
    createInstance('rainShader', 'shaders.RainShader', {})
    setProperty('rainShader.scale', screenHeight / 200)
    setProperty('rainShader.intensity', rainIntensity)

    runHaxeCode([[
        game.camGame.filters = [new ShaderFilter(getVar('rainShader'))];
    ]])
end

function destroyRain()
    if not rainShaderExists then return end
    rainShaderExists = false

    -- Remove shader from camGame
    runHaxeCode([[
        game.camGame.filters = [];
    ]])

    removeLuaSprite('rainShader', true)
end

function onUpdate(e)
    if getProperty('bgscene.x') == 4 then
        if not rainShaderExists then
            createRain()
        end
        rainEnabled = true
    else
        if rainShaderExists then
            destroyRain()
        end
        rainEnabled = false
    end

    if rainEnabled then
        callMethod('rainShader.updateViewInfo', {screenWidth, screenHeight, instanceArg('camGame')})
        callMethod('rainShader.update', {e * rainTimeScale * 8})

        rainTimeScale = lerp(0.02, math.min(1, rainTimeScale), exp(-e / (1 / 3)))
    end
end

function lerp(a, b, t)
    return a + (b - a) * t
end

function exp(x)
    local result = math.pow(math.exp(1), x)
    return math.max(result, 0.001)
end
