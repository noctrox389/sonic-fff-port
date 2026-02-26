function onCreatePost()
    bfFRAMERATE = getProperty('boyfriend.animation.curAnim.frameRate')
    dadFRAMERATE = getProperty('dad.animation.curAnim.frameRate')
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if boyfriendName ~= 'sonic_run' then
        if isSustainNote then
            setProperty('boyfriend.animation.curAnim.frameRate', 1)
            runTimer('BFholdanimtimer', 0.2)
        else
            setProperty('boyfriend.animation.curAnim.frameRate', bfFRAMERATE)
        end
    
        local noteAnimName = getPropertyFromGroup('notes', id, 'animation.name') or ""
    
        function endsWith(str, ending)
            return str:sub(-#ending) == ending
        end
    
        if endsWith(noteAnimName, 'end') then
            setProperty('boyfriend.animation.curAnim.frameRate', bfFRAMERATE)
        end
    else
        if isSustainNote then
            playAnim('boyfriend', getProperty('boyfriend.animation.curAnim.name') .. '-hold', true)
        else
            --
        end
    
        local noteAnimName = getPropertyFromGroup('notes', id, 'animation.name') or ""
    
        function endsWith(str, ending)
            return str:sub(-#ending) == ending
        end
    
        if endsWith(noteAnimName, 'end') then
            playAnim('boyfriend', string.gsub(getProperty('boyfriend.animation.curAnim.name'), '-hold$', ''), true)
        end
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if isSustainNote then
        setProperty('dad.animation.curAnim.frameRate', 1)
        runTimer('DADholdanimtimer', 0.2)
    else
        setProperty('dad.animation.curAnim.frameRate', dadFRAMERATE)
    end

    local noteAnimName = getPropertyFromGroup('notes', id, 'animation.name') or ""

    function endsWith(str, ending)
        return str:sub(-#ending) == ending
    end

    if endsWith(noteAnimName, 'end') then
        setProperty('dad.animation.curAnim.frameRate', dadFRAMERATE)
    end
end


function onTimerCompleted(tag)
    if tag == 'BFholdanimtimer' then
        setProperty('boyfriend.animation.curAnim.frameRate', bfFRAMERATE)
    end
    if tag == 'DADholdanimtimer' then
        setProperty('dad.animation.curAnim.frameRate', dadFRAMERATE)
    end
end