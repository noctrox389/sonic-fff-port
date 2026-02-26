flashingtime = 0.15
bombtimertime = (60 / curBpm) * 2
bombSpeed = 1500

bombdownpos = 500
bombuppos = 0

bombHitboxShrink = 50

bfHitOffsetX = 40
bfHitOffsetY = 40
bfHitWidthOffset = 250
bfHitHeightOffset = 150

ringHitOffsetX = 20
ringHitOffsetY = 20
ringHitWidthOffset = 40
ringHitHeightOffset = 40

showDebugHitboxes = false

bombs = {}
bombUID = 0

rings = {}
ringzUID = 0

debugHitboxes = {}

function getBombByID(id)
    for _, b in ipairs(bombs) do
        if b.id == id then return b end
    end
    return nil
end

function getRingByID(id)
    for _, r in ipairs(rings) do
        if r.id == id then return r end
    end
    return nil
end

function spawnBomb(pos)
    bombUID = bombUID + 1
    local id = bombUID
    local bomb = 'BOMB_' .. id
    local warn = 'WARN_' .. id

    makeAnimatedLuaSprite(bomb, 'bomb', 1800, pos)
    addAnimationByPrefix(bomb, 'bomb', 'bomb', 24, false)
    addAnimationByPrefix(bomb, 'explosion', 'explosion', 24, false)
    setProperty(bomb .. '.visible', false)
    scaleObject(bomb, 2,2)
    addLuaSprite(bomb, false)

    makeAnimatedLuaSprite(warn, 'warning', 1200, pos)
    addAnimationByPrefix(warn, 'bombwarn', 'warning bomb', 24, false)
    addLuaSprite(warn, true)
    playAnim(warn, 'bombwarn', true)
    setProperty(warn .. '.visible', true)

    playSound('warning')

    table.insert(bombs, { id = id, bomb = bomb, warn = warn })

    runTimer('warnFlash_' .. id, flashingtime)
    runTimer('spawnBomb_' .. id, bombtimertime)
end

function spawnRingz(pos, amount)
    if not amount or amount == '' then return end
    local count = tonumber(amount) or 1
    local separation = 140

    local warnID = ringzUID + 1
    local ringwarn = 'RINGZWARN_' .. warnID
    if pos ~= bombdownpos then
        makeAnimatedLuaSprite(ringwarn, 'warning', 920, pos - 60)
    else
        makeAnimatedLuaSprite(ringwarn, 'warning', 920, pos)
    end
    addAnimationByPrefix(ringwarn, 'ringzwarn', 'warning ring', 24, false)
    addLuaSprite(ringwarn, true)
    playAnim(ringwarn, 'ringzwarn', true)
    setProperty(ringwarn .. '.visible', true)
    runTimer('ringzWarnFlash_' .. warnID, flashingtime)

    for i = 1, count do
        ringzUID = ringzUID + 1
        local id = ringzUID
        local ringz = 'RINGZ_' .. id
        local spawnX = 1800 + ((i - 1) * separation)

        makeAnimatedLuaSprite(ringz, 'ringSPRITE', spawnX, pos)
        addAnimationByPrefix(ringz, 'ringz', 'ring', 24, true)
        addAnimationByPrefix(ringz, 'sparkles', 'sparkles', 24, false)
        setProperty(ringz .. '.visible', false)
        addLuaSprite(ringz, false)

        table.insert(rings, { id = id, ringz = ringz, warn = ringwarn })
        runTimer('spawnRingz_' .. id, bombtimertime)
    end
end

function collectRingz(ringz)
    ringSound()
    setProperty('ringcountindicator.x', getProperty('ringcountindicator.x') + 1)
    playAnim(ringz, 'sparkles', false)
end

function onEvent(name, value1, value2)
    if getProperty('eventsindicator.x') == 1 or getProperty('eventsindicator.x') == nil then
        if name == 'Bomb' then
            local pos = (value1 == 'down') and bombdownpos or bombuppos
            if value2 == '' then
                spawnBomb(pos)
            else
                if value1 == 'up' then
                    spawnRingz(pos + 60, value2)
                elseif value1 == 'down' then
                    spawnRingz(pos, value2)
                end
            end
        end
    end
end

function onTimerCompleted(tag)
    if tag == 'removeDebugHitbox' then
        for _, h in ipairs(debugHitboxes) do removeLuaSprite(h, true) end
        debugHitboxes = {}
    end

    local id = tonumber(tag:match('_(%d+)$'))
    if not id then return end

    local b = getBombByID(id)
    if b then
        if tag == 'warnFlash_' .. id and getProperty(b.warn .. '.visible') then
            setProperty(b.warn .. '.alpha', getProperty(b.warn .. '.alpha') == 1 and 0 or 1)
            runTimer(tag, flashingtime)
        end
        if tag == 'spawnBomb_' .. id then
            setProperty(b.warn .. '.visible', false)
            setProperty(b.bomb .. '.visible', true)
            playAnim(b.bomb, 'bomb', false)
        end
    end

    local r = getRingByID(id)
    if r then
        if tag == 'ringzWarnFlash_' .. id and getProperty(r.warn .. '.visible') then
            setProperty(r.warn .. '.alpha', getProperty(r.warn .. '.alpha') == 1 and 0 or 1)
            runTimer(tag, flashingtime)
        end
        if tag == 'spawnRingz_' .. id then
            setProperty(r.warn .. '.visible', false)
            setProperty(r.ringz .. '.visible', true)
            playAnim(r.ringz, 'ringz', true)
        end
    end
end

function onUpdatePost(elapsed)
    -- Cachear valores que se usan múltiples veces
    local scrolling = getProperty('scrollingspeedway.x') == 1
    local bfX = getProperty('BFBALL.x')
    local bfY = getProperty('BFBALL.y')
    local bfW = getProperty('BFBALL.width')
    local bfH = getProperty('BFBALL.height')
    
    -- Hitbox del player (cacheada)
    local px = bfX + bfHitOffsetX
    local py = bfY + bfHitOffsetY
    local pw = bfW - bfHitWidthOffset
    local ph = bfH - bfHitHeightOffset

    -- Procesar bombas
    for i = #bombs, 1, -1 do
        local b = bombs[i]
        local bomb = b.bomb
        if getProperty(bomb .. '.visible') then
            local bombX = getProperty(bomb .. '.x')
            
            if scrolling then
                setProperty(bomb .. '.x', bombX - bombSpeed * elapsed)
                bombX = bombX - bombSpeed * elapsed
            end
            
            local animName = getProperty(bomb .. '.animation.curAnim.name')
            
            if animName == 'bomb' then
                -- Hitbox de bomba (cacheada)
                local bx = bombX + bombHitboxShrink / 20
                local by = getProperty(bomb .. '.y') + bombHitboxShrink
                local bw = getProperty(bomb .. '.width') - bombHitboxShrink * 2
                local bh = getProperty(bomb .. '.height') - bombHitboxShrink * 2
                
                if checkCollision(bx, by, bw, bh, px, py, pw, ph) then
                    playerHurtAnim()
                    playAnim(bomb, 'explosion', false)
                end
            elseif animName == 'explosion' and getProperty(bomb .. '.animation.curAnim.finished') then
                removeLuaSprite(b.bomb, true)
                removeLuaSprite(b.warn, true)
                table.remove(bombs, i)
            end
            
            if bombX < -900 then
                removeLuaSprite(b.bomb, true)
                removeLuaSprite(b.warn, true)
                table.remove(bombs, i)
            end
        end
    end

    -- Procesar rings
    for i = #rings, 1, -1 do
        local r = rings[i]
        local ringz = r.ringz
        if getProperty(ringz .. '.visible') then
            local ringX = getProperty(ringz .. '.x')
            local animName = getProperty(ringz .. '.animation.curAnim.name')
            
            if animName == 'ringz' then
                -- Hitbox de ring (cacheada)
                local rx = ringX + ringHitOffsetX
                local ry = getProperty(ringz .. '.y') + ringHitOffsetY
                local rw = getProperty(ringz .. '.width') - ringHitWidthOffset
                local rh = getProperty(ringz .. '.height') - ringHitHeightOffset
                
                if checkCollision(rx, ry, rw, rh, px, py, pw, ph) then
                    collectRingz(ringz)
                end
            end
            
            if scrolling then
                setProperty(ringz .. '.x', ringX - bombSpeed * elapsed)
                ringX = ringX - bombSpeed * elapsed
            end
            
            if animName == 'sparkles' and getProperty(ringz .. '.animation.curAnim.finished') then
                removeLuaSprite(r.ringz, true)
                removeLuaSprite(r.warn, true)
                table.remove(rings, i)
            elseif ringX < -900 and animName ~= 'sparkles' then
                removeLuaSprite(r.ringz, true)
                removeLuaSprite(r.warn, true)
                table.remove(rings, i)
            end
        end
    end

    -- Debug hitboxes (solo si está activado)
    if showDebugHitboxes then
        -- Limpiar hitboxes anteriores
        for _, h in ipairs(debugHitboxes) do removeLuaSprite(h, true) end
        debugHitboxes = {}

        -- Hitbox del player
        drawHitbox(px, py, pw, ph, 'FF0000')

        -- Hitboxes de bombas
        for _, b in ipairs(bombs) do
            if getProperty(b.bomb .. '.visible') then
                local bx = getProperty(b.bomb .. '.x') + bombHitboxShrink / 20
                local by = getProperty(b.bomb .. '.y') + bombHitboxShrink
                local bw = getProperty(b.bomb .. '.width') - bombHitboxShrink * 2
                local bh = getProperty(b.bomb .. '.height') - bombHitboxShrink * 2
                drawHitbox(bx, by, bw, bh, '00FF00')
            end
        end

        -- Hitboxes de rings
        for _, r in ipairs(rings) do
            if getProperty(r.ringz .. '.visible') then
                local rx = getProperty(r.ringz .. '.x') + ringHitOffsetX
                local ry = getProperty(r.ringz .. '.y') + ringHitOffsetY
                local rw = getProperty(r.ringz .. '.width') - ringHitWidthOffset
                local rh = getProperty(r.ringz .. '.height') - ringHitHeightOffset
                drawHitbox(rx, ry, rw, rh, '0000FF')
            end
        end
    end
end

function playerHurtAnim()
    setProperty('shithitindicator.x', 1)
    addMisses(1)
    addScore(-600)
    if not getProperty('cpuControlled') then setProperty('hurtRing.x', 1) end
    if getProperty('ringcountindicator.x') ~= 0 then playAnim('boyfriend', 'hurt') end
    setProperty('boyfriend.specialAnim', true)
    playSound('damage', 0.8)
end

function drawHitbox(x, y, w, h, color)
    local id = 'debugHitbox' .. #debugHitboxes + 1
    makeLuaSprite(id, '', x, y)
    makeGraphic(id, w, h, color)
    setObjectCamera(id, 'game')
    addLuaSprite(id, true)
    table.insert(debugHitboxes, id)
end

function removeAllDebugHitboxes()
    for _, h in ipairs(debugHitboxes) do removeLuaSprite(h, true) end
    debugHitboxes = {}
end

function checkCollision(aX,aY,aW,aH,bX,bY,bW,bH)
    return aX < bX + bW and aX + aW > bX and aY < bY + bH and aY + aH > bY
end

-- Ya no necesitamos bombHit() y ringzHit() separadas porque la lógica está integrada

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