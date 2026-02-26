--placeholder values

rings = {}
ringUID = 0
despawnringtime = 4

hurtcooldown = false

function onCreatePost()
    makeLuaSprite('deployringindicator')
    makeGraphic('deployringindicator', 1, 1, 'ffffff')
    setProperty('deployringindicator.alpha', 0)
    addLuaSprite('deployringindicator', false)
    setObjectCamera('deployringindicator', 'hud')
    setProperty('deployringindicator.x', 0)

    floorRingsX = getProperty('BFBALL.x')
    floorRingsY = getProperty('BFBALL.y') - 30
end

function onSongStart()
    floorRingsX = getProperty('BFBALL.x')
    floorRingsY = getProperty('BFBALL.y') - 30
end

function deployRings(count)
    setProperty('health', 1)
    setProperty('ringcountindicator.x', getProperty('ringcountindicator.x') - lostRings)

    if getProperty('canbehurt.x') == 1 then
        count = count or 1
        if count > 0 then
            bfInvis = true
            runTimer('bfInvincibilityflash', 0.01)
            runTimer('bfInvincibility', 3)

            if boyfriendName ~= 'sketchhog' then
                playSound('loserings', 1)
            else
                playSound('loseringssketchhog', 1)
            end
        end

        for n = 1, count do
            ringUID = ringUID + 1
            local id = ringUID
            local ring = 'RING_' .. id
    
            if boyfriendName ~= 'sketchhog' then
            makeAnimatedLuaSprite(
                ring,
                'ringSPRITE',
                getProperty('BFBALL.x') + getRandomInt(0, 250),
                getProperty('BFBALL.y') + getRandomInt(0, 100)
            )
    
            addAnimationByPrefix(ring, 'ring', 'ring', 24, true)
            addAnimationByPrefix(ring, 'sparkles', 'sparkles', 24, false)
            else
            makeAnimatedLuaSprite(
                ring,
                'paper ring',
                getProperty('BFBALL.x') + getRandomInt(0, 250),
                getProperty('BFBALL.y') + getRandomInt(0, 100)
            )
    
            addAnimationByPrefix(ring, 'ring', 'paper ring', 24, true)
            addAnimationByPrefix(ring, 'sparkles', 'paper sparkle', 24, false)
            end
            addLuaSprite(ring, true)
            setObjectCamera(ring, 'camGame')

            setProperty(ring .. '.alpha', 0)
            playAnim(ring, 'ring', true)
            updateHitbox(ring)
            setProperty(ring .. '.alpha', 1)

    
            doTweenY('RING_FALL_' .. id, ring,
                getProperty('BFBALL.y') - getRandomInt(130, 250),
                0.5,
                'quadOut'
            )

            if luaSpriteExists('scrollingspeedway') then
            else
                doTweenX('RING_SLIDE_' .. id, ring,
                    floorRingsY + getRandomInt(0, 550),
                    1,
                    'quadOut'
                )
            end
    
            table.insert(rings, {
                id = id,
                sprite = ring,
                collected = false,
                dead = false
            })
    
            runTimer('despawnRing_' .. id, despawnringtime)
        end
    end
end

function onTimerCompleted(tag)
    local id = tonumber(tag:match('_(%d+)$'))
    if not id then return end

    if tag == 'despawnRing_' .. id then
        doTweenAlpha('ringalpha_' .. id, 'RING_' .. id, 0, 0.5)
    end
end

function onTweenCompleted(tag)
    local id = tonumber(tag:match('_(%d+)$'))
    if not id then return end

    if tag == 'ringalpha_' .. id then
        removeLuaSprite('RING_' .. id, true)

        for i = #rings, 1, -1 do
            if rings[i].id == id then
                table.remove(rings, i)
                break
            end
        end

    elseif tag == 'RING_FALL_' .. id then
        if luaSpriteExists('RING_' .. id) then
            if boyfriendName ~= 'sketchhog' then
            doTweenY(
                'RING_FALL2_' .. id,
                'RING_' .. id,
                floorRingsY + getRandomInt(200, 250),
                getRandomFloat(1, 2),
                'bounceOut'
            )
            else
            doTweenY(
                'RING_FALL2_' .. id,
                'RING_' .. id,
                floorRingsY - 200 + getRandomInt(300, 350),
                getRandomFloat(1, 2),
                'bounceOut'
            )
            end
        end
    end
end

function onUpdatePost(elapsed)

    if getProperty('deployringindicator.x') == 1 then
        setProperty('deployringindicator.x', 0)

        lostRings = math.ceil(getProperty('ringcountindicator.x') / 1.8)

        local spawnCount = lostRings
        if spawnCount >= 10 then
            spawnCount = 10
        end

        deployRings(spawnCount)
    end
    if getProperty('deployringindicator.x') == 2 then
        setProperty('deployringindicator.x', 0)

        lostRings = getProperty('ringcountindicator.x')

        local spawnCount = lostRings
        if spawnCount >= 10 then
            spawnCount = 10
        end

        deployRings(spawnCount)
    end

    for i = #rings, 1, -1 do
        local r = rings[i]
        local ring = r.sprite

        if luaSpriteExists('scrollingspeedway')
        and getProperty('scrollingspeedway.x') == 1
        and luaSpriteExists(ring) then

            local PRESENTspeed = 1500
            local PRESENTspeedmultiplier = 1

            setProperty(
                ring .. '.x',
                getProperty(ring .. '.x')
                - (PRESENTspeed * PRESENTspeedmultiplier * elapsed)
            )
        end

        if luaSpriteExists(ring) then
            if not r.collected
            and callMethodFromClass(
                'flixel.FlxG',
                'mouse.overlaps',
                { instanceArg(ring), instanceArg('camGame') }
            )
            and mouseClicked() then

                r.collected = true
                cancelTimer('despawnRing_' .. r.id)
                cancelTween('ringalpha_' .. r.id)
                setProperty(ring .. '.alpha', 1)

                cancelTween('RING_FALL_'..r.id)
                cancelTween('RING_FALL2_'..r.id)
                cancelTween('RING_SLIDE_'..r.id)

                playAnim(ring, 'sparkles', true)
                ringSound()

                setProperty(
                    'ringcountindicator.x',
                    getProperty('ringcountindicator.x') + 1
                )
            end
        end

        if getProperty(ring .. '.animation.curAnim.name') == 'sparkles'
        and getProperty(ring .. '.animation.curAnim.finished') then
            removeLuaSprite(ring, true)
            table.remove(rings, i)
        end
    end
end

ringdir = 'right'
ringvolume = 1

function ringSound()
    if ringdir == 'right' then
        if boyfriendName ~= 'sketchhog' then
            playSound('ringright', ringvolume)
        else
            playSound('ringsketchhogright', ringvolume)
        end
        ringdir = 'left'

    elseif ringdir == 'left' then
        if boyfriendName ~= 'sketchhog' then
            playSound('ringleft', ringvolume)
        else
            playSound('ringsketchhogleft', ringvolume)
        end
        ringdir = 'right'
    end
end
