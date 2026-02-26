-- Variables para las barras de cine
local barsVisible = false
local barHeight = 100
local tweentime = 1.2
local tweenType = 'quartOut'
local cinemaTop = 'cinemaTop'
local cinemaBottom = 'cinemaBottom'

function onCreate()
    -- Barra superior
    makeLuaSprite(cinemaTop, '', 0, -barHeight)
    makeGraphic(cinemaTop, screenWidth, barHeight, '000000')
    setObjectCamera(cinemaTop, 'camHUD')
    addLuaSprite(cinemaTop, true)
    setObjectOrder(cinemaTop, 0)

    -- Barra inferior
    makeLuaSprite(cinemaBottom, '', 0, screenHeight)
    makeGraphic(cinemaBottom, screenWidth, barHeight, '000000')
    setObjectCamera(cinemaBottom, 'camHUD')
    addLuaSprite(cinemaBottom, true)
    setObjectOrder(cinemaBottom, 0)
end

function onEvent(name, v1, v2)
    -- Solo procesar si los eventos están habilitados
    if getProperty('eventsindicator.x') ~= 1 and getProperty('eventsindicator.x') ~= nil then
        return
    end
    
    if name == 'cinema' then
        barsVisible = not barsVisible

        if barsVisible then
            -- Mostrar barras
            doTweenY('cinemaTopIn', cinemaTop, 0, tweentime, tweenType)
            doTweenY('cinemaBottomIn', cinemaBottom, screenHeight - barHeight, tweentime, tweenType)
        else
            -- Ocultar barras
            doTweenY('cinemaTopOut', cinemaTop, -barHeight, tweentime, tweenType)
            doTweenY('cinemaBottomOut', cinemaBottom, screenHeight + barHeight, tweentime, tweenType)
        end
    end
end