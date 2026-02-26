function onCreatePost()
    for i = 0, getProperty('unspawnNotes.length') - 1 do
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'IgnoreNote' and not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
            setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true)
            setPropertyFromGroup('unspawnNotes', i, 'blockHit', true)
        end
    end
end

function onUpdatePost()
    for i = 0, getProperty('notes.length') - 1 do
        if getProperty('notes.members['..i..'].noteType') == 'IgnoreNote' then
            local strumTime = getProperty('notes.members['..i..'].strumTime')
            local noteData = getProperty('notes.members['..i..'].noteData')
            local ignore = getProperty('notes.members['..i..'].ignoreNote')
            local block = getProperty('notes.members['..i..'].blockHit')

            if getSongPosition() >= strumTime and ignore and block then
                playAnim('dad', getProperty('singAnimations['..noteData..']'), true)
                setProperty('dad.holdTimer', 0)
                setProperty('notes.members['..i..'].blockHit', true)
            end
        end
    end
end
