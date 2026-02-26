function onCreatePost()
    if boyfriendName == 'sonic_run' then
    
        makeAnimatedLuaSprite('soniclegs', 'peelout', offsetlegsX, offsetlegsY)
        addAnimationByPrefix('soniclegs', 'PEELOUT', 'loop feet', 24, true)
        addAnimationByPrefix('soniclegs', 'RUN', 'loop legs2', 24, true)
        addAnimationByPrefix('soniclegs', 'RUN2', 'loop legS2darker', 24, true)
        addAnimationByPrefix('soniclegs', 'INVIS', 'loop invisible', 24, true)
        addLuaSprite('soniclegs', true)
        playAnim('soniclegs', 'PEELOUT', true)
        addOffset('soniclegs', 'RUN', -70, 0)
        addOffset('soniclegs', 'PEELOUT', 0, 0)
        setObjectOrder('soniclegs', getObjectOrder('boyfriendGroup') + 1)

        makeAnimatedLuaSprite('soniclegs2', 'peelout', offsetlegsX, offsetlegsY)
        addAnimationByPrefix('soniclegs2', 'PEELOUT', 'loop feet', 24, true)
        addAnimationByPrefix('soniclegs2', 'RUN', 'loop legs2', 24, true)
        addAnimationByPrefix('soniclegs2', 'RUN2', 'loop legS2darker', 24, true)
        addAnimationByPrefix('soniclegs2', 'INVIS', 'loop invisible', 24, true)
        addLuaSprite('soniclegs2', false)
        playAnim('soniclegs2', 'INVIS', true)
        addOffset('soniclegs2', 'RUN2', -70, 0)
        addOffset('soniclegs2', 'PEELOUT', 0, 0)
        setObjectOrder('soniclegs2', getObjectOrder('boyfriendGroup') - 1)
    else
        close(true)
    end
end

local forbiddenanims = {
    'idle-ready',
    'die'
}

local secondlegvisible = false

function onUpdatePost()
    if boyfriendName == 'sonic_run' then
        offsetlegsX = getProperty('boyfriend.x') -160
        offsetlegsY = getProperty('boyfriend.y') +100
        if getProperty('boyfriend.animation.curAnim.name') ~= forbiddenanims then
            setProperty('soniclegs.x', offsetlegsX)
            setProperty('soniclegs.y', offsetlegsY)
            setProperty('soniclegs.visible', getProperty('boyfriend.visible'))
            setProperty('soniclegs.alpha', getProperty('boyfriend.alpha'))
            
            setProperty('soniclegs2.x', offsetlegsX)
            setProperty('soniclegs2.y', offsetlegsY)
            if getProperty('boyfriend.idleSuffix') == '-alt' then
                setProperty('soniclegs2.visible', getProperty('boyfriend.visible'))
                setProperty('soniclegs2.alpha', getProperty('boyfriend.alpha'))
            elseif getProperty('boyfriend.idleSuffix') == '' then
                setProperty('soniclegs2.visible', false)
                setProperty('soniclegs2.alpha', 0)
            end
        end
        if getProperty('boyfriend.idleSuffix') == '-alt' then
            if getProperty('soniclegs.animation.curAnim.name') ~= 'RUN' then
                playAnim('soniclegs', 'RUN', true)
            end
            if getProperty('soniclegs2.animation.curAnim.name') ~= 'RUN2' then
                playAnim('soniclegs2', 'RUN2', true)
            end
        elseif getProperty('boyfriend.idleSuffix') == '-ready' or getProperty('boyfriend.animation.curAnim.name') == 'die' then
            setProperty('soniclegs.visible', false)
            setProperty('soniclegs.alpha', 0)
            setProperty('soniclegs2.visible', false)
            setProperty('soniclegs2.alpha', 0)
        elseif getProperty('boyfriend.idleSuffix') == '' then
            if getProperty('soniclegs.animation.curAnim.name') ~= 'PEELOUT' then
                playAnim('soniclegs', 'PEELOUT', true)
            end
            if getProperty('soniclegs2.animation.curAnim.name') ~= 'PEELOUT' then
                playAnim('soniclegs2', 'PEELOUT', true)
            end
        end
    else
        close(true)
    end
end