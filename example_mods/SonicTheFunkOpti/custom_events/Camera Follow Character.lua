function onCreatePost()
end

function onEvent(name, value1, value2)
    if name == 'Camera Follow Character' then
        cameraSetTarget(value1)
    end
end