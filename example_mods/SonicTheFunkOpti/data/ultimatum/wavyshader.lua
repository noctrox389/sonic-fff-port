local shaderName = "graywavy"
local shaderActive = false
local currentIntensity = 0
local targetIntensity = 0
local transitionSpeed = 1.5

local stageSprites = {"tube", "floor", "window", "space"}

function onEvent(name, value1, value2)
    if name == "shadowshader" then
        shaderActive = not shaderActive

        if shaderActive then
            setProperty('blendOverlay.visible', true)
            setProperty('blendOverlay.alpha', 0)
            doTweenAlpha('overlayIN', 'blendOverlay', 1, transitionSpeed)
        else
            doTweenAlpha('overlayOUT', 'blendOverlay', 0, transitionSpeed)
        end
    end
end

function onCreate()
    makeLuaSprite("blendOverlay", nil, -250, -200)
    makeGraphic("blendOverlay", screenWidth + 480, screenHeight + 400, "0xff9188a8") -- #493b6e as ARGB
    setObjectCamera("blendOverlay", "camGame")
    setScrollFactor("blendOverlay", 0, 0)
    setProperty("blendOverlay.alpha", 1)
    setBlendMode("blendOverlay", "multiply")
    setProperty("blendOverlay.visible", false)

    addLuaSprite("blendOverlay", false)

    shaderCoordFix()

    makeLuaSprite("tempShader")
    addLuaSprite("tempShader")
    setProperty('tempShader.visible', false)

    runHaxeCode([[ 
        var shaderName = "]] .. shaderName .. [[";
        game.initLuaShader(shaderName);
        var shader = game.createRuntimeShader(shaderName);
        game.getLuaObject("tempShader").shader = shader;
    ]])
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
        runHaxeCode([[ FlxG.signals.gameResized.remove(fixShaderCoordFix); ]])
        if temp then temp() end
    end
end

function onUpdatePost(elapsed)
    local time = getSongPosition() / 1000
    targetIntensity = shaderActive and 1 or 0

    if math.abs(currentIntensity - targetIntensity) > 0.01 then
        currentIntensity = currentIntensity + (targetIntensity - currentIntensity) * transitionSpeed * elapsed
    else
        currentIntensity = targetIntensity
    end

    runHaxeCode([[ 
        var shader = game.getLuaObject("tempShader").shader;
        shader.setFloat("iTime", ]] .. time .. [[);
        shader.setFloat("intensity", ]] .. currentIntensity .. [[);
    ]])

    for _, spriteName in ipairs(stageSprites) do
        if currentIntensity > 0.01 then
            runHaxeCode([[ 
                var spr = game.getLuaObject("]] .. spriteName .. [[");

                if (spr != null) spr.shader = game.getLuaObject("tempShader").shader;
            ]])
        else
            runHaxeCode([[ 
                var spr = game.getLuaObject("]] .. spriteName .. [[");

                if (spr != null) spr.shader = null;
            ]])
        end
    end
end
