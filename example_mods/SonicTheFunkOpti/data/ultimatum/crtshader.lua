local shaderName = "CRT"
local shaderEnabled = false
local blend = 0
local targetBlend = 0
local blendSpeed = 1.5 -- Speed of blend transition
local timePassed = 0 -- For animation

function onCreate()
    shaderCoordFix()
    makeLuaSprite("tempShader0")

    runHaxeCode([[
        var shaderName = "]] .. shaderName .. [[";
        game.initLuaShader(shaderName);
        var shader0 = game.createRuntimeShader(shaderName);
        game.getLuaObject("tempShader0").shader = shader0;
        game.camGame.setFilters([new ShaderFilter(shader0)]);
    ]])
end

function onUpdate(elapsed)
    -- Advance shader animation time
    timePassed = timePassed + elapsed

    -- Animate blend value smoothly
    if shaderEnabled and blend < targetBlend then
        blend = math.min(blend + elapsed * blendSpeed, 1)
    elseif not shaderEnabled and blend > targetBlend then
        blend = math.max(blend - elapsed * blendSpeed, 0)
    end

    setShaderFloat("tempShader0", "iTime", timePassed)
    setShaderFloat("tempShader0", "blend", blend)

    -- Remove shader when blend is 0
    if blend <= 0 and not shaderEnabled then
        runHaxeCode("game.camGame.setFilters([]);")
    end
end

function toggleShader(state)
    shaderEnabled = state
    targetBlend = state and 1 or 0

    if state then
        runHaxeCode("game.camGame.setFilters([new ShaderFilter(game.getLuaObject('tempShader0').shader)]);")
    end
end

function onEvent(name, value1, value2)
    if name == "shadowshader" then
        toggleShader(not shaderEnabled)
    end
end

function shaderCoordFix()
    runHaxeCode([[
        resetCamCache = function(?spr) {
            if (spr == null || spr.filters == null) return;
            spr.__cacheBitmap = null;
            spr.__cacheBitmapData = null;
        }

        fixShaderCoordFix = function(?_) {
            resetCamCache(game.camGame.flashSprite);
            resetCamCache(game.camHUD.flashSprite);
            resetCamCache(game.camOther.flashSprite);
        }

        FlxG.signals.gameResized.add(fixShaderCoordFix);
        fixShaderCoordFix();
    ]])

    local temp = onDestroy
    function onDestroy()
        runHaxeCode("FlxG.signals.gameResized.remove(fixShaderCoordFix);")
        if temp then temp() end
    end
end
