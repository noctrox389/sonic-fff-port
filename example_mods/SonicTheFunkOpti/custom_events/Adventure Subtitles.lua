function onCreatePost()
    makeLuaText('subtitle', 'ding dong', 800, 240, 550)
    setTextSize('subtitle', 40)
    addLuaText('subtitle')
    setTextAlignment('subtitle', 'center')
    setTextBorder('subtitle', 0, 'ffffff')
    setProperty('subtitle.alpha', 0)
    setObjectCamera('subtitle', 'camHUD')

    makeLuaSprite('subtitlesbg')
    makeGraphic('subtitlesbg', 1, 1, '000000')
    scaleObject('subtitlesbg', 800, 100)
    setProperty('subtitlesbg.alpha', 0)
    addLuaSprite('subtitlesbg', false)
    setProperty('subtitlesbg.x', 240)
    setProperty('subtitlesbg.y', 550)
    setProperty('subtitlesbg.camera', instanceArg('camHUD'), false, true)
    setObjectOrder('subtitlesbg', getObjectOrder('subtitle') - 1)
    setObjectCamera('subtitlesbg', 'camHUD')

    setObjectOrder('subtitle', getObjectOrder('subtitlesbg') + 1)
end

function onEvent(name, value1, value2)
    if name == 'Adventure Subtitles' then
    dasub = value1
        if value1 ~= '' then
            doTweenAlpha('subbgalpha', 'subtitlesbg', 0.6, 0.5)
            if getProperty('subtitle.alpha') == 1 then
                doTweenAlpha('subalpha1', 'subtitle', 0, 0.3)
            else
                doTweenAlpha('subalpha2', 'subtitle', 1, 0.3)
                setTextString('subtitle', value1)
            end
            scaleObject('subtitle', 1, 1)
        end
        if value1 == '' then
            doTweenAlpha('subalphabye', 'subtitle', 0, 0.5)
        end

        if value2 ~= '' then
            setTextFont('subtitle', value2)
        else
            setTextFont('subtitle', 'impress.ttf')
        end
    end
end

function onTweenCompleted(tag, value1)
    if tag == 'subalphabye' then
        doTweenAlpha('subbgalphabye', 'subtitlesbg', 0, 0.5)
    end
    if tag == 'subalpha1' then
    doTweenAlpha('subalpha2', 'subtitle', 1, 0.3)
    setTextString('subtitle', dasub)
    end
end