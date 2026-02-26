local finalSpeed = 2.0
function onCreate()
    initSaveData('globalsave')
local diffselection = getDataFromSave('globalsave', 'lastDifficulty')
if diffselection ~= '-easy' then
    close(true)
    return
end
end


function onCreatePost()
    if songName == 'rock-solid' then
        finalSpeed = 2.0
    elseif songName == 'unbound' then
        finalSpeed = 2.2
    elseif songName == 'break-down' or songName == 'Break Down' then
        finalSpeed = 1.9
    elseif songName == 'ultimatum' or songName == 'Ultimatum' then
        finalSpeed = 2.4
    elseif songName == 'blueprint' or songName == 'Blueprint' then
        finalSpeed = 2.8
    end
    local songSpeed = getProperty('songSpeed')
    local mult = finalSpeed / songSpeed
    for i = 0, getProperty('unspawnNotes.length') - 1 do
        local isPlayer = getPropertyFromGroup('unspawnNotes', i, 'mustPress')
        if not isPlayer then
            setPropertyFromGroup('unspawnNotes', i, 'multSpeed', mult)
        end
    end
    
end

function onSpawnNote(id, data, type, sustain)
    local isPlayer = getPropertyFromGroup('notes', id, 'mustPress')
    if not isPlayer then
        local songSpeed = getProperty('songSpeed')
        local mult = finalSpeed / songSpeed
        setPropertyFromGroup('notes', id, 'multSpeed', mult)
    end
end
