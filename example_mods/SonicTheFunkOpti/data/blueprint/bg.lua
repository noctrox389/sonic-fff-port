local shaderName  = "flagWaveScroll"
local shaderName2 = "flagWave"
local shaderName3 = "waterScroll"

local intensity = 1
local scrollSpeed = 0.1

local timeTravelSprites  = { "timetravelbg" }
local timeTravelSprites2 = { "timetravelray1", "timetravelray2", "timetravelray3", "timetravelray4" }
local waterSprites = { "PASTbg11", "PASTbg12", "PASTbg13" }

local shaderReady  = false
local shaderReady2 = false
local shaderReady3 = false

local tempShaderScroll, tempShaderStatic, tempShaderWater

if lowQuality then
    function onCreate() close(true) end
    return
end

function onCreatePost()
    shaderCoordFix()
end

function createShader(luaName, shaderFile)
    makeLuaSprite(luaName)
    addLuaSprite(luaName)
    setProperty(luaName .. ".visible", false)

    runHaxeCode([[
        if (game.getLuaObject("]] .. luaName .. [[") != null) {
            game.initLuaShader("]] .. shaderFile .. [[");
            var shader = game.createRuntimeShader("]] .. shaderFile .. [[");
            game.getLuaObject("]] .. luaName .. [[").shader = shader;
        }
    ]])
end

function destroyShader(luaName)
    runHaxeCode([[
        var spr = game.getLuaObject("]] .. luaName .. [[");
        if (spr != null) {
            spr.shader = null;
            spr.kill();
            game.remove(spr);
        }
    ]])
end

function onUpdatePost(elapsed)
    local time = getSongPosition() / 1000
    local scrollVisible = false
    for _, s in ipairs(timeTravelSprites) do
        if getProperty(s .. ".visible") then scrollVisible = true break end
    end

    if scrollVisible and not shaderReady then
        createShader("tempShaderScroll", shaderName)
        shaderReady = true
    elseif not scrollVisible and shaderReady then
        destroyShader("tempShaderScroll")
        shaderReady = false
    end

    local staticVisible = false
    for _, s in ipairs(timeTravelSprites2) do
        if getProperty(s .. ".visible") then staticVisible = true break end
    end

    if staticVisible and not shaderReady2 then
        createShader("tempShaderStatic", shaderName2)
        shaderReady2 = true
    elseif not staticVisible and shaderReady2 then
        destroyShader("tempShaderStatic")
        shaderReady2 = false
    end

    local waterVisible = false
    for _, s in ipairs(waterSprites) do
        if getProperty(s .. ".visible") then waterVisible = true break end
    end

    if waterVisible and not shaderReady3 then
        createShader("tempShaderWater", shaderName3)
        shaderReady3 = true
    elseif not waterVisible and shaderReady3 then
        destroyShader("tempShaderWater")
        shaderReady3 = false
    end

    if shaderReady then
        for _, s in ipairs(timeTravelSprites) do
            if getProperty(s .. ".visible") then
                runHaxeCode([[
                    var spr = game.getLuaObject("]] .. s .. [[");
                    if (spr != null) {
                        var shader = game.getLuaObject("tempShaderScroll").shader;
                        spr.shader = shader;
                        shader.setFloat("iTime", ]] .. tostring(time) .. [[);
                        shader.setFloat("intensity", ]] .. tostring(intensity) .. [[);
                        shader.setFloat("scrollSpeed", ]] .. tostring(scrollSpeed) .. [[);
                    }
                ]])
            end
        end
    end

    if shaderReady2 then
        for _, s in ipairs(timeTravelSprites2) do
            if getProperty(s .. ".visible") then
                runHaxeCode([[
                    var spr = game.getLuaObject("]] .. s .. [[");
                    if (spr != null) {
                        var shader = game.getLuaObject("tempShaderStatic").shader;
                        spr.shader = shader;
                        shader.setFloat("iTime", ]] .. tostring(time) .. [[);
                        shader.setFloat("intensity", ]] .. tostring(intensity) .. [[);
                    }
                ]])
            end
        end
    end

    if shaderReady3 then
        for _, s in ipairs(waterSprites) do
            if getProperty(s .. ".visible") then
                runHaxeCode([[
                    var spr = game.getLuaObject("]] .. s .. [[");
                    if (spr != null) {
                        var shader = game.getLuaObject("tempShaderWater").shader;
                        spr.shader = shader;
                        shader.setFloat("iTime", ]] .. tostring(time) .. [[);
                        shader.setFloat("intensity", ]] .. tostring(intensity) .. [[);
                        shader.setFloat("scrollSpeed", ]] .. tostring(scrollSpeed) .. [[);
                    }
                ]])
            end
        end
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
end
